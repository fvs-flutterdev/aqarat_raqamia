import 'dart:developer';

import 'package:aqarat_raqamia/bloc/coupons_cubit/state.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/dynamic_model/coupons_model.dart';

class CouponsCubit extends Cubit<CouponsState> {
  CouponsCubit() : super(InitialCouponsState());

  late CouponsModel couponsModel;

  getCoupons() {
    emit(GetCouponsLoadingState());
    DioHelper.getData(
        url: BaseUrl.baseUrl + BaseUrl.Coupons
    ).then((value) {
      log(value.data.toString());
      couponsModel = CouponsModel.fromJson(value.data);
      emit(GetCouponsSuccessState());
    }).catchError((error) {
      emit(GetCouponsErrorState(error: error.toString()));
    });
  }
}
