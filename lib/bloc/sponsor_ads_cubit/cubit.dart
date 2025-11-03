import 'package:aqarat_raqamia/bloc/sponsor_ads_cubit/state.dart';
import 'package:aqarat_raqamia/model/dynamic_model/sponsor_ads_model.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../translation/locale_keys.g.dart';
import '../../view/base/show_toast.dart';

class SponsorAdsCubit extends Cubit<SponsorAdsState> {
  SponsorAdsCubit() : super(InitialSponsorAdsState());

  late SponsorAdsModel sponsorAdsModel;
  bool isGetSponsorAds = false;


  getSponsorAds({int? page,
    //String? search
  }) {
    isGetSponsorAds = false;
    DioHelper.getData(
            url: BaseUrl.baseUrl + BaseUrl.GetSponsoredAd,
          token: token,
           // search:search ,
            page: page)
        .then((value) {
      print(value.data);
      if (page == 1) {
        sponsorAdsModel = SponsorAdsModel.fromJson(value.data);
      } else {
        sponsorAdsModel.meta?.currentPage =
            SponsorAdsModel.fromJson(value.data).meta?.currentPage;
        sponsorAdsModel.meta?.lastPage =
            SponsorAdsModel.fromJson(value.data).meta?.lastPage;
        sponsorAdsModel.meta?.total =
            SponsorAdsModel.fromJson(value.data).meta?.total;
        sponsorAdsModel.meta?.perPage =
            SponsorAdsModel.fromJson(value.data).meta?.perPage;
        sponsorAdsModel.data
            ?.addAll(SponsorAdsModel.fromJson(value.data).data ?? []);
      }
      isGetSponsorAds = true;
      emit(GetSponsorAdsSuccessState());
    }).catchError((error) {
      isGetSponsorAds = true;
      print(error.toString());
      emit(GetSponsorAdsErrorState(error: error.toString()));
    });
  }

  changeSearchMode() {
    isSearchMode = !isSearchMode;
    emit(ChangeSearchModeState());
  }

  removeFavourite({required int index, required String adId, required BuildContext context}) {
    sponsorAdsModel.data![index].isFavorite=!sponsorAdsModel.data![index].isFavorite!;
    emit(ChangeFavouriteState());
    DioHelper.postData(
      url: '${BaseUrl.baseUrl + BaseUrl.RemoveFavourite}/$adId',
      token: token,).then((value) {
      print(value.data);
      // isFavourite=false;
      sponsorAdsModel.data![index].isFavorite = false;
      // favourite=false;
      //  context.read<FavouriteCubit>().getFavouriteData();
      // favouriteModel.data?.removeAt(index);
      emit(AddSponsorToFavouriteSuccessState());
      showCustomSnackBar(
          message: LocaleKeys.removeFavourite.tr(),
          state: ToastState.SUCCESS,
          // isError: false,
          // title: 'تم إزالة الإعلان من المفضله لديك'
      );
    }).catchError((error) {
      print(error.toString());
      emit(AddSponsorToFavouriteErrorState(error: error.toString()));
    });
  }

  addFavourite(int index, String adId,BuildContext context) {
    sponsorAdsModel.data![index].isFavorite=!sponsorAdsModel.data![index].isFavorite!;
    emit(ChangeFavouriteState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.AddFavourite,
        token: token,
        data: {
          "ads_id": adId,
        }).then((value) {
      print(value.data);
      //  isFavourite=true;
      sponsorAdsModel.data![index].isFavorite = true;
      emit(AddSponsorToFavouriteSuccessState());
      //   context.read<FavouriteCubit>().getFavouriteData();
      showCustomSnackBar(message: LocaleKeys.addFavourite.tr(),
          state: ToastState.SUCCESS,
          // isError: false,
          // title: 'تم اضافه الإعلان في المفضله لديك'
      );
    }).catchError((error) {
      print(error.toString());
      emit(AddSponsorToFavouriteErrorState(error: error.toString()));
    });
    // isFavourite=! isFavourite;
  }
}
