import 'dart:developer';

import 'package:aqarat_raqamia/bloc/client_oder_cubit/finished_order_cubit/state.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/dynamic_model/orders_client/finished_order_model.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../view/base/show_toast.dart';

class ClientFinishedOrderCubit extends Cubit<ClientFinishedOrderState> {
  ClientFinishedOrderCubit() : super(InitialClientFinishedOrderState());

  late FinishedOrderClientModel finishedOrderClientModel;
  bool isGetFinishedOrder = false;

  getFinishedClientOrderState({required int page}) {
    isGetFinishedOrder = false;
    DioHelper.getData(
            url: BaseUrl.baseUrl + BaseUrl.GetServiceClient,
            token: token,
            page: page,
            status: 'finished')
        .then((value) {
      log(value.data.toString());
      if (page == 1) {
        finishedOrderClientModel =
            FinishedOrderClientModel.fromJson(value.data);
      } else {
        finishedOrderClientModel.meta?.currentPage =
            FinishedOrderClientModel.fromJson(value.data).meta?.currentPage;
        finishedOrderClientModel.meta?.lastPage =
            FinishedOrderClientModel.fromJson(value.data).meta?.lastPage;
        finishedOrderClientModel.meta?.total =
            FinishedOrderClientModel.fromJson(value.data).meta?.total;
        finishedOrderClientModel.meta?.perPage =
            FinishedOrderClientModel.fromJson(value.data).meta?.perPage;
        finishedOrderClientModel.data
            ?.addAll(FinishedOrderClientModel.fromJson(value.data).data ?? []);
      }
      isGetFinishedOrder = true;
      emit(GetClientFinishedOrderSuccessState());
    }).catchError((error) {
      isGetFinishedOrder = true;
      log(error.toString());
      emit(GetClientFinishedOrderErrorState(error: error.toString()));
    });
  }

  // addProviderRate({required int providerId,required String notes,required BuildContext context})
  // {
  //   emit(AddRateProviderLoadingState());
  //   DioHelper.postData(url: BaseUrl.baseUrl+BaseUrl.AddRateProvider, token: token, data: {
  //     "provider_id" : providerId,
  //     "rate" : ratingCount,
  //     "notes" : notes
  //   })
  //       .then((value) {
  //     print(value.data);
  //     Navigator.pop(context);
  //     //  Get.back();
  //     showCustomSnackBar(
  //       message:  LocaleKeys.addRateSuccess.tr(),
  //       state: ToastState.SUCCESS,
  //       // isError: false,
  //       // title: 'إرسال عرض سعر'
  //     );
  //     emit(AddRateProviderSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(AddRateProviderErrorState(error: error.toString()));
  //   });
  // }
}
