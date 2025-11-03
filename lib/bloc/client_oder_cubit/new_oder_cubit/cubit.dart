import 'dart:developer';

import 'package:aqarat_raqamia/bloc/client_oder_cubit/new_oder_cubit/state.dart';
import 'package:aqarat_raqamia/model/dynamic_model/subscribtion_callback_model.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/base/show_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/dynamic_model/orders_client/new_order_model.dart';
import '../../../model/dynamic_model/orders_client/order_by_id_model.dart';
import '../../../model/dynamic_model/orders_client/price_offer_model.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../view/screens/bottom_navigation/main_screen.dart';
import '../../../view/screens/subscribtion_screen/web_view_pay/web_view.dart';

class NewOrdersClientCubit extends Cubit<NewOrdersClientState> {
  NewOrdersClientCubit() : super(InitialNewOrderClientState());

  int indexTabClient = 0;

  changeTabBarIndexClient({required var value}) {
    indexTabClient = value;
    log('//////////////////${indexTabClient.toString()}');
    emit(ChangeTabBarState());
  }

  late NewOrderClientModel newOrderClientModel;

  bool isGetNewOrders = false;

  getNewClientOrders({required int page}) {
    isGetNewOrders = false;
    DioHelper.getData(
            url: BaseUrl.baseUrl + BaseUrl.GetServiceClient,
            token: token,
            page: page,
            status: 'pending')
        .then((value) {
      if (page == 1) {
        newOrderClientModel = NewOrderClientModel.fromJson(value.data);
      } else {
        newOrderClientModel.meta?.currentPage =
            NewOrderClientModel.fromJson(value.data).meta?.currentPage;
        newOrderClientModel.meta?.lastPage =
            NewOrderClientModel.fromJson(value.data).meta?.lastPage;
        newOrderClientModel.meta?.total =
            NewOrderClientModel.fromJson(value.data).meta?.total;
        newOrderClientModel.meta?.perPage =
            NewOrderClientModel.fromJson(value.data).meta?.perPage;
        newOrderClientModel.data
            ?.addAll(NewOrderClientModel.fromJson(value.data).data ?? []);
      }
      isGetNewOrders = true;
      emit(GetNewOrderClientSuccessState());
    }).catchError((error) {
      isGetNewOrders = true;
      //  isGetNewOrders = false;
      log(error.toString());
      emit(GetNewOrderClientErrorState(error: error.toString()));
    });
  }

  late PriceOfferModel priceOfferModel;
  bool isPricesOffer = false;

  getPricesOfferList({required String orderId, required int page}) {
    isPricesOffer = false;
    DioHelper.getData(
            url:
                "https://dashboard.redd.sa/api/price-offer/requested-service-price-offer/$orderId",
            token: token,
            page: page)
        .then((value) async {
      await getOrderById(id: orderId);
      log(value.data.toString());
      if (page == 1) {
        priceOfferModel = PriceOfferModel.fromJson(value.data);

        //  isPricesOffer = true;
      } else {
        priceOfferModel.meta?.currentPage =
            PriceOfferModel.fromJson(value.data).meta?.currentPage;
        priceOfferModel.meta?.lastPage =
            PriceOfferModel.fromJson(value.data).meta?.lastPage;
        priceOfferModel.meta?.total =
            PriceOfferModel.fromJson(value.data).meta?.total;
        priceOfferModel.meta?.perPage =
            PriceOfferModel.fromJson(value.data).meta?.perPage;
        priceOfferModel.data
            ?.addAll(PriceOfferModel.fromJson(value.data).data ?? []);
      }

      emit(GetPricesOfferClientSuccessState());
      isPricesOffer = true;
    }).catchError((error) {
      isPricesOffer = true;
      log(error.toString());
      emit(GetPricesOfferClientErrorState(error: error.toString()));
    });
  }

  int selectedIndex = 0;

  changeIndexCarousel(index) {
    selectedIndex = index;
    emit(ChangeCarouselState());
  }

  declineOfferPrice(
      {
      // required BuildContext context,
      required int orderId}) {
    emit(DeclinedOfferPriceClientLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.declineOfferPrice,
        token: token,
        data: {"id": orderId, "status": "declined"}).then((value) {
      log(value.dat.toString());
      navigateAndRemove(MainScreenNavigation());
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => MainScreenNavigation()),
      //   (route) => false,
      // );
      emit(DeclinedOfferPriceClientSuccessState());
      showCustomSnackBar(
        message: '${value.data['message']}${LocaleKeys.refusePriceOffer.tr()}',
        state: ToastState.SUCCESS,
      );
    }).catchError((error) {
      log(error.toString());
      emit(DeclinedOfferPriceClientErrorState(error: error.toString()));
    });
  }

  acceptOfferPrice({
    required int orderId,
    // required BuildContext context
  }) {
    emit(AcceptOfferPriceClientLoadingState());
    // DioHelper.postData(url: BaseUrl.baseUrl+BaseUrl.ChangeOrderStatus,token: token,data: {
    //   "request_service_id":orderId,
    //   "status":"accepted"
    // }).then((value) {
    // //  print(value.data);
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => MainScreenNavigation()),
    //         (route) => false,
    //   );
    //   emit(AcceptOfferPriceClientSuccessState());
    //   showCustomSnackBar(
    //     message: '${value.data['message']}${LocaleKeys.priceOfferAccepted.tr()}',
    //     state: ToastState.SUCCESS,
    //     // title: 'تمت الموافقه على عرض السعر بنجاح',
    //     // isError: false
    //   );
    // }).catchError((error){
    //   print(error.toString());
    //   emit(AcceptOfferPriceClientErrorState(error: error.toString()));
    //   showCustomSnackBar(message: error.toString(), state: ToastState.ERROR);
    // });
    DioHelper.postData(
            url: 'https://dashboard.redd.sa/api/price-offer/accept/$orderId',
            token: token)
        .then((value) {
      log(value.data.toString());
      navigateAndRemove(MainScreenNavigation());
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => MainScreenNavigation()),
      //   (route) => false,
      // );
      emit(AcceptOfferPriceClientSuccessState());
      showCustomSnackBar(
        message:
            '${value.data['message']}${LocaleKeys.priceOfferAccepted.tr()}',
        state: ToastState.SUCCESS,
        // title: 'تمت الموافقه على عرض السعر بنجاح',
        // isError: false
      );
    }).catchError((error) {
      log(error.toString());
      emit(AcceptOfferPriceClientErrorState(error: error.toString()));
      showCustomSnackBar(message: error.toString(), state: ToastState.ERROR);
    });
  }

  late SubscriptionCallBackModel subscriptionCallBackModel;

  payOfferPrice({required int offerId}) {
    emit(PayOfferPriceClientLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.PayPriceOffer,
        token: token,
        data: {
          "offer_id": offerId,
        }).then((value) {
      log(value.data.toString());
      subscriptionCallBackModel =
          SubscriptionCallBackModel.fromJson(value.data);
      navigateForward(
        PaymentWebView(
          subscriptionCallBackModel: subscriptionCallBackModel,
          url: subscriptionCallBackModel.callbackUrl!,
          redirectUrl: subscriptionCallBackModel.url!,
          onError: (error) {
            print('$error /////////////////');
          },
          onSuccess: (param) {
            print('//////////////$param');
          },
        ),
      );
      emit(PayOfferPriceClientSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(PayOfferPriceClientErrorState(error: error.toString()));
    });
  }

  bool isGetOrderById = false;
  late OrderByIdModel orderByIdModel;

  getOrderById({required String id}) {
    isGetOrderById = false;
    emit(GetOrderByIdClientLoadingState());

    DioHelper.getData(
            url: BaseUrl.baseUrl + '/api/request_services/details/$id',
            token: token)
        .then((value) {
      log(value.data.toString());
      print('/////////////////!!!!!!!!!!!!!!!!!!!!!!!!!');
      orderByIdModel = OrderByIdModel.fromJson(value.data);
      isGetOrderById = true;
      emit(GetOrderByIdClientSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetOrderByIdClientErrorState(error: error.toString()));
    });
  }

  deleteOrder(int orderId) {
    emit(DeleteOrderByIdClientLoadingState());
    DioHelper.deleteData(
            url: BaseUrl.baseUrl + '/api/request_services/delete/$orderId',token: token)
        .then((value) {
      print(value.data);
      showCustomSnackBar(
          message: value.statusMessage.toString(), state: ToastState.SUCCESS);
      navigateAndRemove(MainScreenNavigation());
      emit(DeleteOrderByIdClientSuccessState());
    }).catchError((error) {
      log(error.toString());

      emit(DeleteOrderByIdClientErrorState(error: error.toString()));
    });
  }
}
