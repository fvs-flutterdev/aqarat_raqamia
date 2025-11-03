abstract class SimilarAdsState {}

class InitialSimilarAdsState extends SimilarAdsState {}

class GetSimilarAdsLoadingState extends SimilarAdsState {}

class GetSimilarAdsSuccessState extends SimilarAdsState {}

class GetSimilarAdsErrorState extends SimilarAdsState {
  final String error;

  GetSimilarAdsErrorState({required this.error});
}

class ChangeSelectedIndexState extends SimilarAdsState {}

class ChangeFavouriteState extends SimilarAdsState {}

class RemoveSimilarToFavouriteSuccessState extends SimilarAdsState {}

class RemoveSimilarToFavouriteErrorState extends SimilarAdsState {
  final String error;

  RemoveSimilarToFavouriteErrorState({required this.error});
}

class AddSimilarToFavouriteSuccessState extends SimilarAdsState {}

class AddSimilarToFavouriteErrorState extends SimilarAdsState {
  final String error;

  AddSimilarToFavouriteErrorState({required this.error});
}
