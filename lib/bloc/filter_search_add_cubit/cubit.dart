import 'package:aqarat_raqamia/bloc/filter_search_add_cubit/state.dart';
import 'package:aqarat_raqamia/model/dynamic_model/search_result_model.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/dynamic_model/price_range_model.dart';
import '../../translation/locale_keys.g.dart';
import '../../view/base/show_toast.dart';

class FilterSearchAdsCubit extends Cubit<FilterSearchAdsState> {
  FilterSearchAdsCubit() : super(InitialFilterSearchAdsState());

  static FilterSearchAdsCubit get(context) => BlocProvider.of(context);
  PriceRangeModel? priceRangeModel;
  RangeValues? values;

  getPriceRange() {
    emit(GetPriceRangeLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.PriceRange)
        .then((val) async {
      print("///////////////////////${val.toString()}");
      priceRangeModel = PriceRangeModel.fromJson(val.data);
      emit(GetPriceRangeSuccessState());
      await Future.delayed(Duration.zero);
      final data = priceRangeModel?.data;
      if (data?.minPrice != null && data?.maxPrice != null) {
        values =
            RangeValues(data!.minPrice!.toDouble(), data.maxPrice!.toDouble());
      }
    }).catchError((error) {
      emit(GetPriceRangeErrorState(error: error.toString()));
    });
  }

  //RangeValues values = RangeValues(priceRangeModel?.data!.minPrice!, priceRangeModel.data!.maxPrice);
  String? startVal;
  String? endVal;

  changeValueRange(val) {
    values = val;
    startVal = values?.start.toString();
    endVal = values?.end.toString();
    emit(ChangeRangeValueOfFilterSearchAdsState());
    print('??????????$startVal');
    print('??????????$endVal');

    // update();
  }

  changeSearchMode() {
    isSearchMode = !isSearchMode;
    emit(ChangeSearchModeState());
  }

//  String? selectedAre;

  // changeAreaStatus({required int index}) {
  //   areaModel.forEach((element) {
  //     element.isTabbed = false;
  //   });
  //   areaModel[index].isTabbed = !areaModel[index].isTabbed;
  //   selectedAre = areaModel[index].title;
  //   emit(ChangeAreaStatusFilterSearchAdsState());
  //   // update();
  // }

  late SearchResultModel searchResultModel;
  bool? isGetFilter = false;
  String? categoryId;

  searchAdsById(
      {String? categoryId,
      String? adsType,
      String? space,
      String? search,
      int? page,
      required BuildContext context}) {
    isGetFilter = false;
    // emit(SearchAdsByIdLoadingState());
    DioHelper.getData(
            url: BaseUrl.baseUrl + BaseUrl.SearchAds,
            token: token,
            categoryId: categoryId ?? '',
            page: page,
            search: search ?? '',
            //  lat: context.read<LocationCubit>().position?.latitude.toString(),
            // lng: context.read<LocationCubit>().position?.longitude.toString(),
            space: space ?? '',
            maxPrice: endVal ?? '',
            minPrice: startVal ?? '',
            typeId: adsType)
        .then((value) {
      if (page == 1) {
        searchResultModel = SearchResultModel.fromJson(value.data);
        print('/////////////////123123////////////////////////${value.data}');
        print('${searchResultModel.data?.length}//////////////////////////');
        isGetFilter = true;
        emit(SearchAdsByIdSuccessState());
      } else {
        searchResultModel.meta?.currentPage =
            SearchResultModel.fromJson(value.data).meta?.currentPage;
        searchResultModel.meta?.lastPage =
            SearchResultModel.fromJson(value.data).meta?.lastPage;
        searchResultModel.meta?.total =
            SearchResultModel.fromJson(value.data).meta?.total;
        searchResultModel.meta?.perPage =
            SearchResultModel.fromJson(value.data).meta?.perPage;
        searchResultModel.links = SearchResultModel.fromJson(value.data).links;
        searchResultModel.data
            ?.addAll(SearchResultModel.fromJson(value.data).data ?? []);
        print(
            '/////////////////////////////////////////22222222222222222222222');
        print('${searchResultModel.data?.length}//////////////////////////');
        emit(SearchAdsByIdSuccessState());
        // isNearbyAqar = true;
      }
      emit(SearchAdsByIdSuccessState());
      isGetFilter = true;
    }).catchError((error) {
      print(error.toString());
      //  isGetFilter = true;
      emit(SearchAdsByIdErrorState(error: error.toString()));
    });
  }

  // bool isFavourite=false;
  addFavourite(int index, String adId) {
    searchResultModel.data![index].isFavorite =
        !searchResultModel.data![index].isFavorite!;
    emit(ChangeFavouriteState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.AddFavourite,
        token: token,
        data: {
          "ads_id": adId,
        }).then((value) {
      print(value.data);
      searchResultModel.data![index].isFavorite = true;
      emit(AddCategoryToFavouriteSuccessState());
      showCustomSnackBar(
        message: LocaleKeys.addFavourite.tr(),
        state: ToastState.SUCCESS,
        // isError: false,
        // title: 'تم اضافه الإعلان في المفضله لديك'
      );
    }).catchError((error) {
      print(error.toString());
      emit(AddCategoryToFavouriteErrorState(error: error.toString()));
    });
    //.=!.;
  }

  removeFavourite(int index, String adId) {
    searchResultModel.data![index].isFavorite =
        !searchResultModel.data![index].isFavorite!;
    emit(ChangeFavouriteState());
    DioHelper.postData(
      url: '${BaseUrl.baseUrl + BaseUrl.RemoveFavourite}/$adId',
      token: token,
    ).then((value) {
      print(value.data);
      searchResultModel.data![index].isFavorite = false;
      emit(AddCategoryToFavouriteSuccessState());
      showCustomSnackBar(
        message: LocaleKeys.removeFavourite.tr(),
        state: ToastState.SUCCESS,
        // isError: false,
      );
    }).catchError((error) {
      print(error.toString());
      emit(AddCategoryToFavouriteErrorState(error: error.toString()));
    });
  }

  int selectedIndex = 0;

  changeIndexCarousel(index) {
    selectedIndex = index;
    emit(ChangeSelectedIndexState());
  }

  returnRangeValueDefault() {
    final data = priceRangeModel?.data;
    if (data?.minPrice != null && data?.maxPrice != null) {
      values =
          RangeValues(data!.minPrice!.toDouble(), data.maxPrice!.toDouble());
    }
    startVal = null;
    endVal = null;
    emit(AddCategoryToFavouriteSuccessState());
  }
}
