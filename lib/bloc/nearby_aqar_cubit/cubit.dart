import 'package:aqarat_raqamia/bloc/nearby_aqar_cubit/state.dart';
import 'package:aqarat_raqamia/model/dynamic_model/nearby_aqa_model.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/base_url.dart';
import '../../view/base/show_toast.dart';
import '../location_cubit/cubit.dart';

class NearbyAqarCubit extends Cubit<NearbyAqarState> {
  NearbyAqarCubit() : super(InitialNearbyAqarState());

  late NearbyAqarModel nearbyAqarModel;
  bool isNearbyAqar = false;

  getNearbyAqarData({required BuildContext context, int? page, String? search,String? district,String? city}) {
    isNearbyAqar = false;

    //  emit(state);
    DioHelper.getData(
      url: BaseUrl.baseUrl + BaseUrl.SearchAds,
      token: token,
      page: page,
      search: search,
      district: district,
      city: city,
      // lng:context.read<LocationCubit>().position?.longitude.toString(),
      // lat:context.read<LocationCubit>().position?.latitude.toString()
    ).then((value) {
      if (page == 1) {
        nearbyAqarModel = NearbyAqarModel.fromJson(value.data);
        print('/////////////////////////////////////////${value.data}');
        print('${nearbyAqarModel.data?.length}//////////////////////////');
        //  isNearbyAqar = true;
        emit(GetNearbyAqarSuccessState());
      }
      else {
        nearbyAqarModel.meta?.currentPage =
            NearbyAqarModel.fromJson(value.data).meta?.currentPage;
        nearbyAqarModel.meta?.lastPage =
            NearbyAqarModel.fromJson(value.data).meta?.lastPage;
        nearbyAqarModel.meta?.total =
            NearbyAqarModel.fromJson(value.data).meta?.total;
        nearbyAqarModel.meta?.perPage =
            NearbyAqarModel.fromJson(value.data).meta?.perPage;
        nearbyAqarModel.links = NearbyAqarModel.fromJson(value.data).links;
        nearbyAqarModel.data
            ?.addAll(NearbyAqarModel.fromJson(value.data).data ?? []);
        print(
            '/////////////////////////////////////////22222222222222222222222');
        print('${nearbyAqarModel.data?.length}//////////////////////////');
        emit(GetNearbyAqarSuccessState());
        // isNearbyAqar = true;
      }
      emit(GetNearbyAqarSuccessState());
      isNearbyAqar = true;
    }).catchError((error) {
      print(error.toString());
      emit(GetNearbyAqarErrorState(error: error.toString()));
    });
  }


  changeSearchMode() {
    isSearchMode = !isSearchMode;
    emit(ChangeSearchModeState());
  }

  removeFavourite(int index, String adId, BuildContext context) {
    nearbyAqarModel.data![index].isFavorite =
        !nearbyAqarModel.data![index].isFavorite!;
    emit(ChangeFavouriteState());
    DioHelper.postData(
      url: '${BaseUrl.baseUrl + BaseUrl.RemoveFavourite}/$adId',
      token: token,
    ).then((value) {
      print(value.data);
      nearbyAqarModel.data![index].isFavorite = false;
      emit(AddNearbyToFavouriteSuccessState());
      showCustomSnackBar(
        message: LocaleKeys.removeFavourite.tr(),
        state: ToastState.SUCCESS,
      );
    }).catchError((error) {
      print(error.toString());
      emit(AddNearbyToFavouriteErrorState(error: error.toString()));
    });
  }

  addFavourite(int index, String adId, BuildContext context) {
    nearbyAqarModel.data![index].isFavorite =
        !nearbyAqarModel.data![index].isFavorite!;
    emit(ChangeFavouriteState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.AddFavourite,
        token: token,
        data: {
          "ads_id": adId,
        }).then((value) {
      print(value.data);
      nearbyAqarModel.data![index].isFavorite = true;
      emit(AddNearbyToFavouriteSuccessState());
      showCustomSnackBar(
        message: LocaleKeys.addFavourite.tr(),
        state: ToastState.SUCCESS,
      );
    }).catchError((error) {
      print(error.toString());
      emit(AddNearbyToFavouriteErrorState(error: error.toString()));
    });
  }
}
