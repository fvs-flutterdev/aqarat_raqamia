import 'package:aqarat_raqamia/bloc/setting_cubit/about_us_cubit/state.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/dynamic_model/about_us_model.dart';

class AboutUsCubit extends Cubit<AboutUsState> {
  AboutUsCubit() : super(InitialAboutUsState());
  late AboutUsModel aboutUsModel;

  getAboutUsData() {
    emit(GetAboutUsLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.GetAboutUs).then((value) {
      print(value.data);
      aboutUsModel = AboutUsModel.fromJson(value.data);
      emit(GetAboutUsSuccessState());
    }).catchError((error) {
      print(error);
      emit(GetAboutUsErrorState(error: error.toString()));
    });
  }
}
