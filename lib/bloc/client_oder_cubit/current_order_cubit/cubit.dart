import 'dart:developer';

import 'package:aqarat_raqamia/bloc/client_oder_cubit/current_order_cubit/state.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/dynamic_model/orders_client/current_order_model.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/app_constant.dart';
import '../../../view/base/show_toast.dart';

class ClientCurrentOrderCubit extends Cubit<ClientCurrentOrderState> {
  ClientCurrentOrderCubit() : super(InitialClientCurrentOrderState());

  late CurrentOrderClientModel currentOrderClientModel;
  bool isGetCurrentOrder = false;

  getCurrentOrderClientModel({required int page}) {
    isGetCurrentOrder = false;
    DioHelper.getData(
            url: BaseUrl.baseUrl + BaseUrl.GetServiceClient,
            page: page,
            token: token,
            status: 'accepted')
        .then((value) {
      if (page == 1) {
        currentOrderClientModel = CurrentOrderClientModel.fromJson(value.data);
      } else {
        currentOrderClientModel.meta?.currentPage =
            CurrentOrderClientModel.fromJson(value.data).meta?.currentPage;
        currentOrderClientModel.meta?.lastPage =
            CurrentOrderClientModel.fromJson(value.data).meta?.lastPage;
        currentOrderClientModel.meta?.total =
            CurrentOrderClientModel.fromJson(value.data).meta?.total;
        currentOrderClientModel.meta?.perPage =
            CurrentOrderClientModel.fromJson(value.data).meta?.perPage;
        currentOrderClientModel.data
            ?.addAll(CurrentOrderClientModel.fromJson(value.data).data ?? []);
      }
      emit(GetClientCurrentOrderSuccessState());
      isGetCurrentOrder = true;
    }).catchError((error) {
      isGetCurrentOrder = true;
      log(error.toString());
      emit(GetClientCurrentOrderErrorState(error: error.toString()));
    });
  }
  TextEditingController rateNotesController = TextEditingController();
  addProviderRate({required int providerId,
   // required String notes,
    required BuildContext context})
  {
    emit(AddRateProviderLoadingState());
    DioHelper.postData(url: BaseUrl.baseUrl+BaseUrl.AddRateProvider, token: token, data: {
      "provider_id" : providerId,
      "rate" : ratingCount,
      "notes" : rateNotesController.text
    })
        .then((value) {
      log(value.data.toString());
      Navigator.pop(context);
      rateNotesController.clear();
      //  Get.back();
      showCustomSnackBar(
        message:  LocaleKeys.addRateSuccess.tr(),
        state: ToastState.SUCCESS,
        // isError: false,
        // title: 'إرسال عرض سعر'
      );
      emit(AddRateProviderSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(AddRateProviderErrorState(error: error.toString()));
    });
  }

}
