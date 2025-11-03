abstract class RegionState{}
class InitialRegionsState extends RegionState{}

class GetAllRegionsLoadingState extends RegionState {}

class GetAllRegionsSuccessState extends RegionState {}

class GetAllRegionsErrorState extends RegionState {
  final String error;

  GetAllRegionsErrorState({required this.error});
}

class GetAllCitiesByRegionIdLoadingState extends RegionState {}

class GetAllCitiesByRegionIdSuccessState extends RegionState {}

class GetAllCitiesByRegionIdErrorState extends RegionState {
  final String error;

  GetAllCitiesByRegionIdErrorState({required this.error});
}



class OnChangeRegionValueState extends RegionState {}
class OnChangeRegionValueFilterState extends RegionState {}
class OnChangeCityValueState extends RegionState {}


class ClearCityListState extends RegionState {}
class ChangeCityValueState  extends RegionState {}