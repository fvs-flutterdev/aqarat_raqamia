abstract class EditAdInfoState {}

class InitialEditAdInfoState extends EditAdInfoState {}

class EditAdInfoLoadingState extends EditAdInfoState {}

class EditAdInfoSuccessState extends EditAdInfoState {}

class EditAdInfoErrorState extends EditAdInfoState {
  final String error;
  EditAdInfoErrorState({required this.error});
}

class GetAdByIdLoadingState extends EditAdInfoState {}

class GetAdByIdSuccessState extends EditAdInfoState {}

class GetAdByIdErrorState extends EditAdInfoState {
  final String error;

  GetAdByIdErrorState({required this.error});
}

class GetFeatureForEditAdsLoadingState extends EditAdInfoState {}

class GetFeatureForEditAdsSuccessState extends EditAdInfoState {}

class GetFeatureForEditAdsErrorState extends EditAdInfoState {
  final String error;

  GetFeatureForEditAdsErrorState({required this.error});
}

class ChangeTypeOfCategoryEditAdState extends EditAdInfoState {}

class ChangeVisionStatusEditAdsState extends EditAdInfoState {}

class ChangePurposeStatusForEditAdState extends EditAdInfoState {}

class GetFeatureListForEditLoadingState extends EditAdInfoState {}

class GetFeatureListForEditSuccessState extends EditAdInfoState {}

class GetFeatureListForEditErrorState extends EditAdInfoState {
  final String error;

  GetFeatureListForEditErrorState({required this.error});
}

class ChooseFeatureForEditState extends EditAdInfoState {}
class GetAdFeatureForEditState extends EditAdInfoState {}
class UpdateFeatureAdState extends EditAdInfoState {}
class SamePurposeState extends EditAdInfoState {}
class SameVersionState extends EditAdInfoState {}
class SameCategoryState extends EditAdInfoState {}
