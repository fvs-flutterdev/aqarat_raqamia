import 'package:aqarat_raqamia/bloc/location_cubit/cubit.dart';
import 'package:aqarat_raqamia/bloc/region_cubit/state.dart';
import 'package:aqarat_raqamia/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/dynamic_model/regions/city_model.dart';
import '../../model/dynamic_model/regions/regions_model.dart';
import '../../utils/base_url.dart';
import '../../utils/dio.dart';

class RegionsCubit extends Cubit<RegionState> {
  RegionsCubit() : super(InitialRegionsState());



  late AllRegionsModel allRegionsModel;
  bool? isGetRegion;

  getAllRegions() {
    isGetRegion = false;
    emit(GetAllRegionsLoadingState());
    DioHelper.getData(
      url: BaseUrl.baseUrl + BaseUrl.GetRegions,
    ).then((value) {
      allRegionsModel = AllRegionsModel.fromJson(value.data);
      allRegionsModel.data?.insert(
          0,
          RegionData(
              regionId: 0, istabbed: false, name: LocaleKeys.allRegions.tr()));
      isGetRegion = true;
      emit(GetAllRegionsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllRegionsErrorState(error: error.toString()));
    });
  }

  int? regionId;



  onChangeRegionId(int value) {
    regionId = value;
    print('////////////$regionId');
    emit(OnChangeRegionValueState());
  }

  int? regionIdFilter;

  onChangeRegionIdFilter(onChange) {
    regionIdFilter = onChange;
    print('<<<<<<<<<<<<<<<<<${regionIdFilter}>>>>>>>>>>>>>>>>>');
    emit(OnChangeRegionValueFilterState());
  }

  List<int?> regionsList = [];
  onChangeRegionsList(List<int?> onChange) {
    regionsList = onChange;
    emit(state);
    print('///////////////////${regionsList}');
  }


  int? cityId;

  onChangeCityId(int value) {
    cityId = value;
    print('////////////$regionId');
    emit(OnChangeCityValueState());
  }

  // int page = 1;
  late CityByRegionIdModel cityByRegionIdModel;
  bool? isGetCities;

  Future getCitiesByRegionId(
      {required BuildContext context,
      required int page,
        required int regionId,
      bool isNotPaginate = false}) async {
    isGetCities = false;
    //  emit(GetAllCitiesByRegionIdLoadingState());
    DioHelper.getData(
      url: '${BaseUrl.baseUrl}${BaseUrl.GetCities}/$regionId',
      isPaginate: isNotPaginate ? 0 : 1,
      page: page,
    ).then((value) {
      if (page == 1) {
        cityByRegionIdModel = CityByRegionIdModel.fromJson(value.data);

        cityByRegionIdModel.data?.insert(
            0,
            CityData(
                cityId: 0, istabbed: false, name:LocaleKeys.allCities.tr()));
        // isPendingOrderGet = true;
      } else {
        cityByRegionIdModel.meta?.currentPage =
            CityByRegionIdModel.fromJson(value.data).meta?.currentPage;
        cityByRegionIdModel.meta?.lastPage =
            CityByRegionIdModel.fromJson(value.data).meta?.lastPage;
        cityByRegionIdModel.meta?.total =
            CityByRegionIdModel.fromJson(value.data).meta?.total;
        cityByRegionIdModel.meta?.perPage =
            CityByRegionIdModel.fromJson(value.data).meta?.perPage;
        cityByRegionIdModel.data
            ?.addAll(CityByRegionIdModel.fromJson(value.data).data ?? []);

      }
      isGetCities = true;
      print('//////////////////////$isGetCities');
      emit(GetAllCitiesByRegionIdSuccessState());
    }).catchError((error) {
      print(error.toString());
      isGetCities = false;
      emit(GetAllCitiesByRegionIdErrorState(error: error.toString()));
    });
  }

  List<int> cities = [];

  onChangeCity({required int i, required bool val}) {
    if(cityByRegionIdModel.data![i].cityId==0){
      val = !val;
      cityByRegionIdModel.data![i].istabbed = !cityByRegionIdModel.data![i].istabbed!;
      cities=[];
      print('<<<<<<<<<<<<<<${cityByRegionIdModel.data![i].istabbed}>>>>>>>>>>>>>>');
      print('<<<cities<<<<<<<<$cities>>>>>>>>>>>');
      // cityByRegionIdModel.data!.forEach((element) {
      //   element.istabbed==true;
      // });
      print('./////....');
      val=true;
      emit(ChangeCityValueState());

    }else{
      val = !val;
      cityByRegionIdModel.data![i].istabbed =
      !cityByRegionIdModel.data![i].istabbed!;
      print('////////////$regionId');
      if (val == true) {
        cities.remove(cityByRegionIdModel.data![i].cityId);
      } else {
        cities.add(cityByRegionIdModel.data![i].cityId!);
      }
      print('/////////2222222222222////////${cities.length}');
      print('/////////2222222222222////////${cities}');
    }

    emit(OnChangeRegionValueState());
  }

  clearCitiesList() {
    cities.clear();
    cityByRegionIdModel.data?.forEach((element) {
      element.istabbed = false;
    });
    emit(ClearCityListState());
  }
}
