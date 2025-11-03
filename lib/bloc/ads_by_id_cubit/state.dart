abstract class AdsByIdState {}

class InitialAdsByIdState extends AdsByIdState {}

class GetAdByIdLoadingState extends AdsByIdState {}

class GetAdByIdSuccessState extends AdsByIdState {}

class GetAdByIdErrorState extends AdsByIdState {
  final String error;

  GetAdByIdErrorState({required this.error});
}

class ChangeFavouriteState extends AdsByIdState {}

class AddCategoryToFavouriteSuccessState extends AdsByIdState {}

class AddCategoryToFavouriteErrorState extends AdsByIdState {
  final String error;

  AddCategoryToFavouriteErrorState({required this.error});
}

class ReportAdLoadingState extends AdsByIdState {}

class ReportAdSuccessState extends AdsByIdState {}

class ReportAdErrorState extends AdsByIdState {
  final String error;

  ReportAdErrorState({required this.error});
}
