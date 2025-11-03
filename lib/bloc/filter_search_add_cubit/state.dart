abstract class FilterSearchAdsState {}

class InitialFilterSearchAdsState extends FilterSearchAdsState {}

class ChangeTypeOfAqarFilterSearchAdsState extends FilterSearchAdsState {}

class ChangeRangeValueOfFilterSearchAdsState extends FilterSearchAdsState {}

class ChangeAreaStatusFilterSearchAdsState extends FilterSearchAdsState {}

class ChangePurposeStatusFilterSearchAdsState extends FilterSearchAdsState {}

class SearchAdsByIdLoadingState extends FilterSearchAdsState {}

class SearchAdsByIdSuccessState extends FilterSearchAdsState {}

class SearchAdsByIdErrorState extends FilterSearchAdsState {
  final String error;

  SearchAdsByIdErrorState({required this.error});
}

class ChangeFavouriteState extends FilterSearchAdsState {}

class ChangeSelectedIndexState extends FilterSearchAdsState {}

class AddCategoryToFavouriteSuccessState extends FilterSearchAdsState {}

class AddCategoryToFavouriteErrorState extends FilterSearchAdsState {
  final String error;

  AddCategoryToFavouriteErrorState({required this.error});
}

class ChangeSearchModeState extends FilterSearchAdsState {}

class GetPriceRangeLoadingState extends FilterSearchAdsState {}

class GetPriceRangeSuccessState extends FilterSearchAdsState {}

class GetPriceRangeErrorState extends FilterSearchAdsState {
  final String error;

  GetPriceRangeErrorState({required this.error});
}
