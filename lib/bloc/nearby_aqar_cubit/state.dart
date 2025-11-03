abstract class NearbyAqarState{}
 class InitialNearbyAqarState extends NearbyAqarState{}
class GetNearbyAqarLoadingState extends NearbyAqarState{}
class GetNearbyAqarSuccessState extends NearbyAqarState{}
class GetNearbyAqarErrorState extends NearbyAqarState{
  final String error;
  GetNearbyAqarErrorState({required this.error});
}
class ChangeFavouriteState extends NearbyAqarState{}
class RemoveNearbyToFavouriteSuccessState extends NearbyAqarState{}
class RemoveNearbyToFavouriteErrorState extends NearbyAqarState{
  final String error;
  RemoveNearbyToFavouriteErrorState({required this.error});
}
class AddNearbyToFavouriteSuccessState extends NearbyAqarState{}
class AddNearbyToFavouriteErrorState extends NearbyAqarState{
  final String error;
  AddNearbyToFavouriteErrorState({required this.error});
}
class ChangeSearchModeState extends NearbyAqarState{}
