

import 'package:aqarat_raqamia/bloc/provider_orders_cubit/price_offer_cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/base_url.dart';
import '../../../utils/dio.dart';
import '../../../view/base/show_toast.dart';

class SendOfferPriceCubit extends Cubit<SendPriceOfferState>{
  SendOfferPriceCubit():super(InitialSendPriceOfferState());



  int selectedIndex = 0;

  changeIndexCarousel(index) {
    selectedIndex = index;
    emit(ChangeSelectedIndexState());
  }


  int? serviceDays;

  changeServiceDay(int day) {
    serviceDays = day;
    print(serviceDays);
    emit(ChangeDaysState());
  }


  TextEditingController orderDetailsController = TextEditingController();
  TextEditingController orderPriceController = TextEditingController();
  // void dispose(){
  //   orderDetailsController.dispose();
  //   orderPriceController.dispose();
  //   emit(DisposeControllerState());
  // }

  sendPriceOffer({
    required String orderId,
    // required String orderDetails,
    // required String price,
    required BuildContext context
  }) {
    emit(SendPriceOfferLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.Send_Price_provider,
        token: token,
        data: {
          "request_service_id": orderId,
          "service_details": orderDetailsController.text,
          "price": orderPriceController.text,
          "days": serviceDays.toString()
        }).then((value) {
      print(value.data);
     Navigator.pop(context);
    //  Get.back();
      showCustomSnackBar(
          message:  LocaleKeys.priceOfferSent.tr(),
          state: ToastState.SUCCESS,
          // isError: false,
          // title: 'إرسال عرض سعر'
      );
      serviceDays=null;
      orderDetailsController.clear();
      orderPriceController.clear();
      emit(SendPriceOfferSuccessState());
      //isFirstLoaded=true;
    //  loadedPendingOrdersProvider();
    }).catchError((error) {
      print(error.toString());
      emit(SendPriceOfferErrorState(error: error.toString()));
    });
  }

}