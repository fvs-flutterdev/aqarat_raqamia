abstract class FavouriteState{}
class InitialFavouriteState extends FavouriteState{}
class GetFavouriteDataLoadingState extends FavouriteState{}
class GetFavouriteDataSuccessState extends FavouriteState{}
class GetFavouriteDataErrorState extends FavouriteState{
  final String error;
  GetFavouriteDataErrorState({required this.error});
}
class ChangeFavouriteState extends FavouriteState{}
class AddCategoryToFavouriteSuccessState extends FavouriteState{}
class AddCategoryToFavouriteErrorState extends FavouriteState{
  final String error;
  AddCategoryToFavouriteErrorState({required this.error});
}



