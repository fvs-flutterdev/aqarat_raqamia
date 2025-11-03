abstract class ProviderRegisterState {}

class InitialProviderRegisterState extends ProviderRegisterState {}

class ChangeLicenceProviderRegisterState extends ProviderRegisterState {}

class PickImageProviderRegisterState extends ProviderRegisterState {}

class AddImageToListProviderRegisterState extends ProviderRegisterState {}

class ClearImageFromListProviderRegisterState extends ProviderRegisterState {}

class GetEntityProviderLoadingState extends ProviderRegisterState {}

class GetEntityProviderSuccessState extends ProviderRegisterState {}

class GetEntityProviderErrorState extends ProviderRegisterState {
  final String error;

  GetEntityProviderErrorState({required this.error});
}

class ProviderRegisterLoadingState extends ProviderRegisterState {}

class ProviderRegisterSuccessState extends ProviderRegisterState {}

class ProviderRegisterErrorState extends ProviderRegisterState {
  final String error;

  ProviderRegisterErrorState({required this.error});
}

class GetInterestsRegisterLoadingState extends ProviderRegisterState {}

class GetInterestsRegisterSuccessState extends ProviderRegisterState {}

class GetInterestsRegisterErrorState extends ProviderRegisterState {
  final String error;

  GetInterestsRegisterErrorState({required this.error});
}

class VerifyProviderRegisterLoadingState extends ProviderRegisterState {}

class VerifyProviderRegisterSuccessState extends ProviderRegisterState {}

class VerifyProviderRegisterErrorState extends ProviderRegisterState {
  final String error;

  VerifyProviderRegisterErrorState({required this.error});
}

class SendFcmTokenLoadingState extends ProviderRegisterState {}

class SendFcmTokenSuccessState extends ProviderRegisterState {}

class SendFcmTokenErrorState extends ProviderRegisterState {
  final String error;

  SendFcmTokenErrorState({required this.error});
}

class GetSubServicesByIdLoadingState extends ProviderRegisterState {}

class GetSubServicesByIdSuccessState extends ProviderRegisterState {}

class GetSubServicesByIdErrorState extends ProviderRegisterState {
  final String error;

  GetSubServicesByIdErrorState({required this.error});
}


class UpgradeProfileLoadingState extends ProviderRegisterState {}

class UpgradeProfileSuccessState extends ProviderRegisterState {}

class UpgradeProfileErrorState extends ProviderRegisterState {
  final String error;

  UpgradeProfileErrorState({required this.error});
}


class UpdateServicesOfProviderLoadingState extends ProviderRegisterState {}

class UpdateServicesOfProviderSuccessState extends ProviderRegisterState {}

class UpdateServicesOfProviderErrorState extends ProviderRegisterState {
  final String error;

  UpdateServicesOfProviderErrorState({required this.error});
}

class OnChangeServiceValueFilterState extends ProviderRegisterState {}
class AddSubServiceIdToListState  extends ProviderRegisterState {}
