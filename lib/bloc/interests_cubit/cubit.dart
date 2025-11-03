import 'dart:developer';

import 'package:aqarat_raqamia/bloc/interests_cubit/state.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../model/dynamic_model/intestes_model.dart';

class InterestsCubit extends Cubit<InterestsState> {
  InterestsCubit() : super(InitialInterestsState());
  late InterestsModel interestsModel;
  bool? isGetInterest;

  getInterestsData() {
    isGetInterest=false;
    emit(GetInterestsLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl+BaseUrl.GetInterests).then((value) {
      debugPrint(value.data.toString());
      interestsModel = InterestsModel.fromJson(value.data);
      isGetInterest=true;
      emit(GetInterestsSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetInterestsErrorState(error: error.toString()));
    });
  }

  List<int?> interestsList = [];
  onChangeInterestsList(List<int?> onChange) {
    interestsList = onChange;
    emit(state);
    print('///////////////////${interestsList}');
  }


}
