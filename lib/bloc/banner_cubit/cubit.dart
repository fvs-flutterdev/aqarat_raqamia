import 'dart:developer';
import 'package:aqarat_raqamia/bloc/banner_cubit/state.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/dynamic_model/carousel_banners.dart';

class BannersCarouselCubit extends Cubit<CarouselBannersState> {
  BannersCarouselCubit() : super(InitialCarouselBannersState());

  late CarouselBannerModel carouselBannerModel;

  getBanners() {
    emit(GetCarouselBannersLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.banners).then((value) {
      log(value.data.toString());
      carouselBannerModel = CarouselBannerModel.fromJson(value.data);
      emit(GetCarouselBannersSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetCarouselBannersErrorState(error: error.toString()));
    });
  }
}
