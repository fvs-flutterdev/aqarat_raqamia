abstract class LocationState {}

class InitialLocationState extends LocationState {}

class GetCurrentLocationState extends LocationState {}

class GetPlaceLocationState extends LocationState {}

class GetLocationFromMapState extends LocationState {}

class GetStringLocationFromMapState extends LocationState {}

class UpdatePositionLocationState extends LocationState {}

class GetServiceStreamLocationState extends LocationState {}

class SetLocationFromMapLoadingState extends LocationState {}

class GetAllCitiesByRegionIdLoadingState extends LocationState {}

class GetAllCitiesByRegionIdSuccessState extends LocationState {}

class GetAllCitiesByRegionIdErrorState extends LocationState {
  final String error;

  GetAllCitiesByRegionIdErrorState({required this.error});
}

class GetAllRegionsLoadingState extends LocationState {}

class GetAllRegionsSuccessState extends LocationState {}

class GetAllRegionsErrorState extends LocationState {
  final String error;

  GetAllRegionsErrorState({required this.error});
}
