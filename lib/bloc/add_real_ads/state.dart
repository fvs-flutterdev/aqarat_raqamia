abstract class AddRealAdsState {}

class InitialAddRealAdsState extends AddRealAdsState {}

class GetFeatureForCreateAdsLoadingState extends AddRealAdsState {}

class GetFeatureForCreateAdsSuccessState extends AddRealAdsState {}

class GetFeatureForCreateAdsErrorsState extends AddRealAdsState {
  final String error;

  GetFeatureForCreateAdsErrorsState({required this.error});
}

class ChooseVerifyWayAddRealAdsState extends AddRealAdsState {}

class ChangeVisionStatusAddRealAdsState extends AddRealAdsState {}

class ChangeBathCountAddRealAdsState extends AddRealAdsState {}

class ChangeLivingRoomsCountAddRealAdsState extends AddRealAdsState {}

class ChangeRoomsCountAddRealAdsState extends AddRealAdsState {}

class OnChangeCategoryValueFilterState extends AddRealAdsState {}

class ChooseFeatureRealAdsState extends AddRealAdsState {}

class ChangeIsParkingAddRealAdsState extends AddRealAdsState {}

class ChangeTypeOfAqarFilterSearchAdsStatee extends AddRealAdsState {}

class ChangePurposeStatusFilterSearchAdsState extends AddRealAdsState {}

class AdTypeReturnState extends AddRealAdsState {}

class AdPurposeReturnState extends AddRealAdsState {}

class AdVisionReturnState extends AddRealAdsState {}

class AdRoomCountReturnState extends AddRealAdsState {}

class AdToiletCountState extends AddRealAdsState {}

class GetFeatureListLoadingState extends AddRealAdsState {}

class GetFeatureListSuccessState extends AddRealAdsState {}

class GetFeatureListErrorState extends AddRealAdsState {
  final String error;

  GetFeatureListErrorState({required this.error});
}
