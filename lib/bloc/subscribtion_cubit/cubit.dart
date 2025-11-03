import 'package:aqarat_raqamia/bloc/subscribtion_cubit/state.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/dynamic_model/all_package_subscription_model.dart';
import '../../model/dynamic_model/payment_ads_model.dart';
import '../../model/dynamic_model/payment_response_model.dart';
import '../../model/dynamic_model/subscribtion_callback_model.dart';
import '../../model/payment_price_service_model.dart';
import '../../model/static_model/suscribe_model.dart';
import '../../view/screens/subscribtion_screen/wallet/complete_pay_with_wallet.dart';
import '../../view/screens/subscribtion_screen/web_view_pay/web_view.dart';

class SubscribeCubit extends Cubit<SubscribeState> {
  SubscribeCubit() : super(InitialSubscribeState());

  late AllPackageSubscription allPackageSubscription;
  bool isGet = false;

  getPackagesSubscription({required int page}) {
    isGet = false;
    DioHelper.getData(
            url: BaseUrl.baseUrl + BaseUrl.get_Packages_Subscription,
            page: page,
            token: token)
        .then((value) {
      if (page == 1) {
        allPackageSubscription = AllPackageSubscription.fromJson(value.data);
      } else {
        allPackageSubscription.meta?.currentPage =
            AllPackageSubscription.fromJson(value.data).meta?.currentPage;
        allPackageSubscription.meta?.lastPage =
            AllPackageSubscription.fromJson(value.data).meta?.lastPage;
        allPackageSubscription.meta?.total =
            AllPackageSubscription.fromJson(value.data).meta?.total;
        allPackageSubscription.meta?.perPage =
            AllPackageSubscription.fromJson(value.data).meta?.perPage;
        allPackageSubscription.data
            ?.addAll(AllPackageSubscription.fromJson(value.data).data ?? []);
      }
      emit(GetSubscribeDataSuccessState());
      isGet = true;
    }).catchError((error) {
      print('<<<<<<<<<<<<<<<<<<<${error.toString()}>>>>>>>>>>>>>>>>>>>');
      emit(GetSubscribeDataErrorState(error: error.toString()));
    });
  }

  int? subscribeId;
  String? price;


  changeSubscribeState(int i) {
    allPackageSubscription.data!.forEach((element) {
      element.istabbed = false;
    });
    allPackageSubscription.data![i].istabbed =
        !allPackageSubscription.data![i].istabbed!;
    subscribeId = allPackageSubscription.data![i].id;
    price = allPackageSubscription.data![i].price;
    print('<<<<<<<<<<<<<<<<<<<<<<<$subscribeId>>>>>>>>>>>>>>>>>>');
    emit(ChangeSubscribeState());
  }

  changePaymentValueState(int i) {
    subscribeModel.forEach((element) {
      element.isTabbed = false;
    });
    subscribeModel[i].isTabbed = !subscribeModel[i].isTabbed;
    // subscribeId = allPackageSubscription.data![i].id;
    // price = allPackageSubscription.data![i].price;



  //  subscribeModel[0].isTabbed =!subscribeModel[1].isTabbed;
    emit(ChangeSubscribeState());
    print('<<<<<<<<<<<<<<<<<<<<<<<${subscribeModel[i].isTabbed}>>>>>>>>>>>>>>>>>>');
  }



  late SubscriptionCallBackModel subscriptionCallBackModel;

  payForSubscription({
    required BuildContext context,
    String? promoCode,
    required bool isWallet,
  }) {
    emit(PaySubscribeDataLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.Pay_For_Subscription,
        token: token,
        data: {
          "subscription_id": subscribeId,
          "coupon_code": promoCode,
          "payment_method": isWallet == true ? "wallet" : "electronic"
          //wallet,electronic
        }).then((value) {
      if (isWallet == true) {
        print('///////////////////////333333333333333');
        navigateAndRemove(CompletePayWithWallet(
          withDrawAmount: value.data['withdrawn_amount'],
          remainingValue: value.data['remaining_balance'],
        ));
      } else {
        subscriptionCallBackModel =
            SubscriptionCallBackModel.fromJson(value.data);
        print(subscriptionCallBackModel.id.toString());
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

      emit(PaySubscribeDataSuccessState());
    }).catchError((e) {
      debugPrint('<<<<<<<<<<${e}>>>>>>>>>>');
      emit(PaySubscribeDataErrorState(error: e.toString()));
    });
  }

  bool isDialog = true;

  changeDialogAppear({required bool dialog}) {
    isDialog = dialog;
    emit(ChangeDialogState());
  }

  bool loading = true;
  bool loadingError = false;
  late PaymentResponseModel paymentResponseModel;

  handelResponsePayment(Map<String, dynamic> data) {
    try {
      loading = true;
      paymentResponseModel = PaymentResponseModel.fromJson(data);
      emit(HandlePaymentResponseState());
      loading = false;
      print('Model Message ${paymentResponseModel.paymentDetails}');
    } catch (e) {
      loadingError = true;
      emit(HandlePaymentResponseErrorState(error: e.toString()));
    }
  }

  late AdsPaymentsModel adsPaymentsModel;

  handelAdsResponsePayment(Map<String, dynamic> data) {
    try {
      loading = true;
      adsPaymentsModel = AdsPaymentsModel.fromJson(data);
      emit(HandlePaymentResponseState());
      loading = false;
      print('Model Message ${adsPaymentsModel.paymentDetails}');
    } catch (e) {
      loadingError = true;
      emit(HandlePaymentResponseErrorState(error: e.toString()));
    }
  }

  late PaymentPriceServiceModel paymentPriceServiceModel;

  handelPriceOfferResponsePayment(Map<String, dynamic> data) {
    try {
      loading = true;
      paymentPriceServiceModel = PaymentPriceServiceModel.fromJson(data);
      emit(HandlePaymentResponseState());
      loading = false;
      print('Model Message ${adsPaymentsModel.paymentDetails}');
    } catch (e) {
      loadingError = true;
      emit(HandlePaymentResponseErrorState(error: e.toString()));
    }
  }
}
