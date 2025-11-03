import 'package:aqarat_raqamia/bloc/similar_ads_cubit/state.dart';
import 'package:aqarat_raqamia/model/dynamic_model/similar_ads_model.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/app_constant.dart';
import '../../utils/text_style.dart';
import '../../view/base/show_toast.dart';

class SimilarAdsCubit extends Cubit<SimilarAdsState> {
  SimilarAdsCubit() : super(InitialSimilarAdsState());

  late SimilarAdsModel similarAdsModel;
  getSimilarAdsData({required String categoryId}) {
    emit(GetSimilarAdsLoadingState());
    DioHelper.getData(
            url: BaseUrl.baseUrl + BaseUrl.GetSimilarAds,
            categoryId: categoryId,
            token: token,

    )
        .then((value) {
      print(value.data);
      printLongString(value.data.toString());
      similarAdsModel = SimilarAdsModel.fromJson(value.data);
      emit(GetSimilarAdsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSimilarAdsErrorState(error: error.toString()));
    });
  }

  int selectedIndex = 0;

  changeIndexCarousel(index) {
    selectedIndex = index;
    emit(ChangeSelectedIndexState());
  }

  removeFavourite(int index, String adId, BuildContext context) {
    similarAdsModel.data![index].isFavorite =
        !similarAdsModel.data![index].isFavorite!;
    emit(ChangeFavouriteState());
    DioHelper.postData(
      url: '${BaseUrl.baseUrl + BaseUrl.RemoveFavourite}/$adId',
      token: token,
    ).then((value) {
      print(value.data);
      similarAdsModel.data![index].isFavorite = false;
      emit(AddSimilarToFavouriteSuccessState());
      showCustomSnackBar(
        message: LocaleKeys.removeFavourite.tr(),
        state: ToastState.SUCCESS,
      );
    }).catchError((error) {
      print(error.toString());
      emit(AddSimilarToFavouriteErrorState(error: error.toString()));
    });
  }

  addFavourite(int index, String adId, BuildContext context) {
    similarAdsModel.data![index].isFavorite =
        !similarAdsModel.data![index].isFavorite!;
    emit(ChangeFavouriteState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.AddFavourite,
        token: token,
        data: {
          "ads_id": adId,
        }).then((value) {
      print(value.data);
      similarAdsModel.data![index].isFavorite = true;
      emit(AddSimilarToFavouriteSuccessState());
      showCustomSnackBar(
        message: LocaleKeys.addFavourite.tr(),
        state: ToastState.SUCCESS,
      );
    }).catchError((error) {
      print(error.toString());
      emit(AddSimilarToFavouriteErrorState(error: error.toString()));
    });
  }
}
