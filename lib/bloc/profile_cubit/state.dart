abstract class ProfileState {}

class InitialProfileState extends ProfileState {}

class GetProfileLoadingState extends ProfileState {}

class GetProfileSuccessState extends ProfileState {}

class GetProfileErrorState extends ProfileState {
  final String error;

//  final int statusCode;
  GetProfileErrorState({required this.error});
}

class PickImageFromCameraState extends ProfileState {}

class PickImageFromGalleryState extends ProfileState {}

class UpdateProfileLoadingState extends ProfileState {}

class UpdateProfileSuccessState extends ProfileState {}

class UpdateProfileErrorState extends ProfileState {
  final String error;

  // final int statusCode;
  UpdateProfileErrorState({required this.error});
}

class DeleteProfileLoadingState extends ProfileState {}

class DeleteProfileSuccessState extends ProfileState {}

class DeleteProfileErrorState extends ProfileState {
  final String error;

  // final int statusCode;
  DeleteProfileErrorState({required this.error});
}

class LoopAchievementsImagesInListUpdateProfileState extends ProfileState {}

class AddPickedAchievementsImagesInListUpdateProfileState
    extends ProfileState {}

class ClearImageInPickAchievementsState extends ProfileState {}

class LoopProjectsImagesInListUpdateProfileState extends ProfileState {}

class AddPickedProjectsImagesInListUpdateProfileState extends ProfileState {}

class ClearImageInAchievementsState extends ProfileState {}

class LoopAlbumImagesInListUpdateProfileState extends ProfileState {}

class AddPickedAlbumImagesInListUpdateProfileState extends ProfileState {}

class ClearImageInAlbumImagesState extends ProfileState {}

class ClearImageInProjectsState extends ProfileState {}

class GetInterestsRegisterLoadingState extends ProfileState {}

class GetInterestsRegisterSuccessState extends ProfileState {}

class GetInterestsRegisterErrorState extends ProfileState {
  final String error;

  GetInterestsRegisterErrorState({required this.error});
}

class ConvertedAdListImagesState extends ProfileState {}
class RemoveProjectFromListState extends ProfileState {}
class RemoveAchievementsFromListState extends ProfileState {}
class RemoveAlbumFromListState extends ProfileState {}
class DeleteAchievementsIndexState extends ProfileState {}
