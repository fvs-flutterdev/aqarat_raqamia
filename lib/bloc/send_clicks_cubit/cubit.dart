import 'dart:developer';

import 'package:aqarat_raqamia/bloc/send_clicks_cubit/state.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/app_constant.dart';

class SendClicksCubit extends Cubit<SendClickState> {
  SendClicksCubit() : super(InitialSendClicksState());

  sendClickSponsorAds({required int id}) {
    emit(SendClicksLoadingState());
    DioHelper.postData(
            url: BaseUrl.baseUrl + '${BaseUrl.SendClick}/$id')
        .then((val) {
      print(val.data.toString());
      emit(SendClicksSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(SendClicksErrorState(error: error.toString()));
    });
  }
}
