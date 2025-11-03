import 'dart:developer';

import 'package:aqarat_raqamia/bloc/setting_cubit/terms_cubit/state.dart';
import 'package:aqarat_raqamia/model/dynamic_model/terms_condition_model.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TermsAndConditionCubit extends Cubit<TermsAndConditionState> {
  TermsAndConditionCubit() : super(InitialTermsAndConditionState());
  late TermsAndConditionModel termsAndConditionModel;

  getTermsAndCondition() {
    emit(GetTermsAndConditionLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.GetTermsAndCondition)
        .then((value) {
      debugPrint(value.data.toString());
      termsAndConditionModel = TermsAndConditionModel.fromJson(value.data);
      emit(GetTermsAndConditionSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetTermsAndConditionErrorState(error: error.toString()));
    });
  }
}
