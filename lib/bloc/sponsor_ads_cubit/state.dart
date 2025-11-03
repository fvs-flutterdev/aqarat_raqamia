abstract class SponsorAdsState {}

class InitialSponsorAdsState extends SponsorAdsState {}
class GetSponsorAdsSuccessState extends SponsorAdsState {}

class GetSponsorAdsErrorState extends SponsorAdsState {
  final String error;

  GetSponsorAdsErrorState({required this.error});
}
class ChangeFavouriteState extends SponsorAdsState {}
class AddSponsorToFavouriteSuccessState extends SponsorAdsState {}
class AddSponsorToFavouriteErrorState extends SponsorAdsState {
  final String error;
  AddSponsorToFavouriteErrorState({required this.error});
}
class ChangeSearchModeState extends SponsorAdsState {}
