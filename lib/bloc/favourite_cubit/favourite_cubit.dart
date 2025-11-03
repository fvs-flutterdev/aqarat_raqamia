import 'package:aqarat_raqamia/bloc/favourite_cubit/favourite_state.dart';
import 'package:aqarat_raqamia/model/dynamic_model/favourite_model.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../translation/locale_keys.g.dart';
import '../../view/base/show_toast.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(InitialFavouriteState());

  late FavouriteModel favouriteModel;
  bool isGetFav=false;

  getFavouriteData({required int page}) {
   // emit(GetFavouriteDataLoadingState());
    isGetFav=false;
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.GetFavourite, token: token,page: page)
        .then((value) {
          if(page==1){
            printLongString(value.data.toString());
            favouriteModel = FavouriteModel.fromJson(value.data);
          }else{
            favouriteModel.meta?.currentPage =
                FavouriteModel.fromJson(value.data).meta?.currentPage;
            favouriteModel.meta?.lastPage =
                FavouriteModel.fromJson(value.data).meta?.lastPage;
            favouriteModel.meta?.total =
                FavouriteModel.fromJson(value.data).meta?.total;
            favouriteModel.meta?.perPage =
                FavouriteModel.fromJson(value.data).meta?.perPage;
            favouriteModel.data
                ?.addAll(FavouriteModel.fromJson(value.data).data ?? []);
          }
          isGetFav=true;
      emit(GetFavouriteDataSuccessState());

    }).catchError((error) {
      isGetFav=true;
      print(error.toString());
      emit(GetFavouriteDataErrorState(error: error.toString()));
    });
  }
  removeFavourite(int index, String adId) {
    favouriteModel.data![index].ads!.isFavorite =
    !favouriteModel.data![index].ads!.isFavorite!;
    emit(ChangeFavouriteState());
    DioHelper.postData(
      url: '${BaseUrl.baseUrl + BaseUrl.RemoveFavourite}/$adId',
      token: token,).then((value) {
      print(value.data);
      favouriteModel.data![index].ads!.isFavorite = false;
      favouriteModel.data?.removeAt(index);
      emit(AddCategoryToFavouriteSuccessState());
      showCustomSnackBar(message:LocaleKeys.removeFavourite.tr(),
          state: ToastState.SUCCESS,
          // isError: false,
          // title: 'تم إزالة الإعلان من المفضله لديك'
      );
    }).catchError((error) {
      print(error.toString());
      emit(AddCategoryToFavouriteErrorState(error: error.toString()));
    });
  }

  addFavourite(int index, String adId,bool? isFavourite) {
    isFavourite= ! isFavourite!;
    // searchResultModel.data![index].isFavourite =
    // !searchResultModel.data![index].isFavourite!;
    emit(ChangeFavouriteState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.AddFavourite,
        token: token,
        data: {
          "ads_id": adId,
        }).then((value) {
      print(value.data);
      isFavourite=true;
     // searchResultModel.data![index].isFavourite = true;
      emit(AddCategoryToFavouriteSuccessState());
      showCustomSnackBar(message: LocaleKeys.addFavourite.tr(),
          state: ToastState.SUCCESS,
          // isError: false,
          // title: 'تم اضافه الإعلان في المفضله لديك'
      );
    }).catchError((error) {
      print(error.toString());
      emit(AddCategoryToFavouriteErrorState(error: error.toString()));
    });
    // isFavourite=! isFavourite;
  }


}
