abstract class EditAdsImagesState {}

class InitialEditAdsImagesState extends EditAdsImagesState {}

class ConvertedAdListImagesState extends EditAdsImagesState {}

class RemoveImageFromListState extends EditAdsImagesState {}

class UploadEditedAdImagesLoadingState extends EditAdsImagesState {}

class UploadEditedAdImagesSuccessState extends EditAdsImagesState {}

class UploadEditedAdImagesErrorState extends EditAdsImagesState {
  final String error;

  UploadEditedAdImagesErrorState({required this.error});
}

class AddPickedImagesInListEditRequestState extends EditAdsImagesState {}

class LoopImagesInListEditRequestState extends EditAdsImagesState {}
class PickMainImageFrAdState extends EditAdsImagesState {}



class UpdateMainAdImagesLoadingState extends EditAdsImagesState {}

class UpdateMainAdImagesSuccessState extends EditAdsImagesState {}

class UpdateMainAdImagesErrorState extends EditAdsImagesState {
  final String error;

  UpdateMainAdImagesErrorState({required this.error});
}