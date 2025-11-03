import 'dart:developer';
import 'package:aqarat_raqamia/bloc/promoted_services_cubit/state.dart';
import 'package:aqarat_raqamia/model/dynamic_model/subscribtion_callback_model.dart';
import 'package:aqarat_raqamia/translation/locale_keys.g.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:aqarat_raqamia/view/base/show_toast.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/dynamic_model/intestes_model.dart';
import '../../model/dynamic_model/promote_my_acc_model.dart';
import '../../model/dynamic_model/promoted_services_model.dart';
import '../../model/dynamic_model/promotion_details_model.dart';
import '../../model/dynamic_model/provider_promotion_model.dart';
import '../../view/base/lunch_widget.dart';
import '../../view/screens/subscribtion_screen/wallet/complete_pay_with_wallet.dart';
import '../../view/screens/subscribtion_screen/web_view_pay/web_view.dart';

class PromotedServicesCubit extends Cubit<PromotedServicesState> {
  PromotedServicesCubit() : super(InitialPromotedServicesState());
  late PromotionServicesModel promotionServicesModel;
  bool? isGetData;

  getPromotedServices() {
    isGetData = false;
    emit(GetPromotedServicesLoadingState());
    DioHelper.getData(
      url: BaseUrl.baseUrl + BaseUrl.getPromotedService,
    ).then((value) {
      print(value.data);
      print('/////////////////////////////');
      promotionServicesModel = PromotionServicesModel.fromJson(value.data);
      isGetData = true;
      emit(GetPromotedServicesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetPromotedServicesErrorState(error: error.toString()));
    });
  }

  bool? isGetPromotedProviders;
  late ServiceProviderPromoted serviceProviderPromoted;

  getProviderPromotion() {
    isGetPromotedProviders = false;
    emit(GetServiceProviderPromotedLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.getProvidersPromoted)
        .then((value) {
      print(value.data);
      serviceProviderPromoted = ServiceProviderPromoted.fromJson(value.data);
      isGetPromotedProviders = true;
      emit(GetServiceProviderPromotedSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetServiceProviderPromotedErrorState(error: error.toString()));
    });
  }

  late PromotionDetailsModel promotionDetailsModel;
  bool? isGetPromotionDetails;

  getPromotionDetails() {
    isGetPromotionDetails = false;
    emit(GetPromotedDetailsLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.getPromotedDetails)
        .then((value) {
      print(value.data);
      promotionDetailsModel = PromotionDetailsModel.fromJson(value.data);
      isGetPromotionDetails = true;
      emit(GetPromotedDetailsSuccessState());
    }).catchError((e) {
      isGetPromotionDetails = false;
      print(e.toString());
      emit(GetPromotedDetailsErrorState(error: e.toString()));
    });
  }

  late SubscriptionCallBackModel subscriptionCallBackModel;

  payForPromotionMyAcc({
    String? promoCode,
    required bool isWallet,
    required List<int?>categoryIds,
    required List<int?> regionId,
  }) {
    emit(PayForPromotedMyAccLoadingState());
    DioHelper.postData(
      url: BaseUrl.baseUrl + BaseUrl.PayForPromotedMyAcc,
      token: token,
      showToast: false,
      data: {
        "coupon_code": promoCode,
        "category_id[]":categoryIds,
        "region_id":regionId,
        "payment_method": isWallet == true ? "wallet" : "electronic",
      },
    ).then((value) {
      if (isWallet == true) {
        navigateAndRemove(CompletePayWithWallet(
          withDrawAmount: value.data['withdrawn_amount'],
          remainingValue: value.data['remaining_balance'],
        ));
      } else {
        print(value.data);
        subscriptionCallBackModel =
            SubscriptionCallBackModel.fromJson(value.data);
        navigateForward(PaymentWebView(
          subscriptionCallBackModel: subscriptionCallBackModel,
          url: subscriptionCallBackModel.callbackUrl!,
          redirectUrl: subscriptionCallBackModel.url!,
          onError: (error) {
            print('$error /////////////////');
          },
          onSuccess: (param) {
            print('//////////////$param');
          },
        ));
      }
      emit(PayForPromotedMyAccSuccessState());
    }).catchError((
      error,
    ) {
      // print("${error.data['message']}000000000000000000000000");
   //   if (isWallet == true) {
        showCustomSnackBar(
            message:LocaleKeys.error.tr(), state: ToastState.ERROR);
      // } else {
      //   print('object');
      // }
      emit(PayForPromotedMyAccErrorState(error: error.toString()));
    });
  }

  bool loading = true;
  bool loadingError = false;
  late PromotedServiceProviderModel promotedServiceProviderModel;
  DateTime? dateTime;

  // String date =
  //     "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  String? time;

  bool isSameDate = true;
  String? dateString;
  DateTime? dates;

  handelResponsePayment(Map<String, dynamic> data) {
    try {
      loading = true;
      promotedServiceProviderModel =
          PromotedServiceProviderModel.fromJson(data);
      dateTime = DateTime.parse(promotedServiceProviderModel
              .paymentDetails?.data?.promotionBidDuration ??
          '');
      // String date =
      //     "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
      time =
          "${dateTime?.hour.toString().padLeft(2, '0')}:${dateTime?.minute.toString().padLeft(2, '0')}";
      isSameDate = true;
      dateString = promotedServiceProviderModel
              .paymentDetails?.data?.promotionBidDuration ??
          '';
      dates = DateTime.parse(dateString ?? '');
      emit(HandlePromotionPaymentResponseState());
      loading = false;
      print('Model Message ${promotedServiceProviderModel.paymentDetails}');
    } catch (e) {
      loadingError = true;
      emit(HandlePromotionPaymentResponseErrorState(error: e.toString()));
    }
  }

//  InterestsModel? interestsModel;
}
