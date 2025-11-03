import 'dart:developer';

import 'package:aqarat_raqamia/bloc/ads_by_id_cubit/state.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../model/dynamic_model/ads_by_id_model.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/app_constant.dart';
import '../../view/base/show_toast.dart';

class AdyByIdCubit extends Cubit<AdsByIdState> {
  AdyByIdCubit() : super(InitialAdsByIdState());

  late AdsByIdModel adsByIdModel;
  bool? isGetAdsById;

  getAdById({required int id}) {
    isGetAdsById = false;
    emit(GetAdByIdLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + '/api/ads/show/$id', token: token)
        .then((value) {
      log(value.data.toString());
      adsByIdModel = AdsByIdModel.fromJson(value.data);
      isGetAdsById = true;
      emit(GetAdByIdSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAdByIdErrorState(error: error.toString()));
    });
  }

  addFavourite({required int adId}) {
    adsByIdModel.data!.isFavorite = !adsByIdModel.data!.isFavorite!;
    emit(ChangeFavouriteState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.AddFavourite,
        token: token,
        data: {
          "ads_id": adId,
        }).then((value) {
      log(value.data.toString());
      adsByIdModel.data!.isFavorite = true;
      emit(AddCategoryToFavouriteSuccessState());
      showCustomSnackBar(
        message: LocaleKeys.addFavourite.tr(),
        state: ToastState.SUCCESS,
        // isError: false,
        // title: 'تم اضافه الإعلان في المفضله لديك'
      );
    }).catchError((error) {
      log(error.toString());
      emit(AddCategoryToFavouriteErrorState(error: error.toString()));
    });
    //.=!.;
  }

  removeFavourite({required int adId}) {
    adsByIdModel.data!.isFavorite = !adsByIdModel.data!.isFavorite!;
    emit(ChangeFavouriteState());
    DioHelper.postData(
      url: '${BaseUrl.baseUrl + BaseUrl.RemoveFavourite}/$adId',
      token: token,
    ).then((value) {
      log(value.data.toString());
      adsByIdModel.data!.isFavorite = false;
      emit(AddCategoryToFavouriteSuccessState());
      showCustomSnackBar(
        message: LocaleKeys.removeFavourite.tr(),
        state: ToastState.SUCCESS,
        // isError: false,
      );
    }).catchError((error) {
      log(error.toString());
      emit(AddCategoryToFavouriteErrorState(error: error.toString()));
    });
  }

  reportAd({required int adId, required String desc,required BuildContext context}) {
    emit(ReportAdLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + '/api/reports/create/$adId',
        token: token,
        data: {
          "description": desc,
        }).then((value) {
          Navigator.pop(context);
      showCustomSnackBar(
          message: LocaleKeys.reportAddedSuccessfully.tr(), state: ToastState.SUCCESS);
      emit(ReportAdSuccessState());

    }).catchError((error) {
      log(error.toString());
      emit(ReportAdErrorState(error: error.toString()));
    });
  }
}
