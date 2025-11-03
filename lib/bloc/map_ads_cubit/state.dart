abstract class AdsOnMapState {}

class InitialMapAdsState extends AdsOnMapState {}

class FullMarkListAdsState extends AdsOnMapState {}

class ChangeTabbedMarkerState extends AdsOnMapState {}

//class GetAllAdsMapLadingState extends AdsOnMapState {}

class GetAllAdsMapSuccessState extends AdsOnMapState {}

class GetAllAdsMapErrorState extends AdsOnMapState {
  final String error;

  GetAllAdsMapErrorState({required this.error});
}
class ChangeFavouriteState extends AdsOnMapState {}
class AddAqarInMapFavouriteSuccessState extends AdsOnMapState {}
class AddAqarInMapFavouriteErrorState extends AdsOnMapState {
  final String error;
  AddAqarInMapFavouriteErrorState({required this.error});
}
class RemoveAqarInMapFavouriteSuccessState extends AdsOnMapState {}
class RemoveAqarInMapFavouriteErrorState extends AdsOnMapState {
  final String error;
  RemoveAqarInMapFavouriteErrorState({required this.error});
}
class ChangeSelectedIndexState extends  AdsOnMapState{}

