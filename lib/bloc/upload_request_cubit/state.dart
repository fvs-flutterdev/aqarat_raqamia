abstract class UploadRequestState {}

class InitialUploadRequestState extends UploadRequestState {}

class ClearImageInUploadRequestState extends UploadRequestState {}

class AddPickedImagesInListUploadRequestState extends UploadRequestState {}

class LoopImagesInListUploadRequestState extends UploadRequestState {}

class CreateAdsLoadingState extends UploadRequestState {}

class CreateAdsSuccessState extends UploadRequestState {}

class CreateAdsErrorState extends UploadRequestState {
  final String error;

  CreateAdsErrorState({required this.error});
}

class CreateSponsoredAdLoadingState extends UploadRequestState {}

class CreateSponsoredAdSuccessState extends UploadRequestState {}

class CreateSponsoredAdErrorState extends UploadRequestState {
  final String error;

  CreateSponsoredAdErrorState({required this.error});
}

class ChangeSpecialAdsState extends UploadRequestState {}

class GetSponsorAdsDetailsLoadingState extends UploadRequestState {}

class GetSponsorAdsDetailsSuccessState extends UploadRequestState {}

class GetSponsorAdsDetailsErrorState extends UploadRequestState {
  final String error;

  GetSponsorAdsDetailsErrorState({required this.error});
}

class PickMainImageFromGalleryState extends UploadRequestState {}

class PromoteAdFromWalletLoadingState extends UploadRequestState {}

class PromoteAdFromWalletSuccessState extends UploadRequestState {}

class PromoteAdFromWalletErrorState extends UploadRequestState {
  final String error;

  PromoteAdFromWalletErrorState({required this.error});
}
