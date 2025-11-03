
import 'package:aqarat_raqamia/bloc/provider_rate_cubit/state.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/dynamic_model/provider_rate_model.dart';
import '../../utils/app_constant.dart';

class ProviderRatesCubit extends Cubit<ProviderRatesState> {
  ProviderRatesCubit() : super(InitialProviderRatesState());
  late ProviderRatesModel providerRatesModel;

  getProvidersRates() {
    emit(GetProviderRatesLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + '/api/rates/provider/$userId')
        .then((value) {
      print(value.data);
      providerRatesModel = ProviderRatesModel.fromJson(value.data);
      emit(GetProviderRatesSuccessState());
    }).catchError((error) {
      emit(GetProviderRatesErrorState(error: error.toString()));
    });
  }
}
