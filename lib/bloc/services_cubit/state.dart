abstract class ServicesState {}

class InitialServicesState extends ServicesState {}

class GetServicesLoadingState extends ServicesState {}

class GetServicesSuccessState extends ServicesState {}

class GetServicesErrorState extends ServicesState {
  final String error;

  GetServicesErrorState({required this.error});
}

class RequestServicesLoadingState extends ServicesState {}

class RequestServicesSuccessState extends ServicesState {}

class RequestServicesErrorState extends ServicesState {
  final String error;

  RequestServicesErrorState({required this.error});
}

class ClearImageInUploadRequestState extends ServicesState {}
class AddPickedImagesInListUploadRequestState extends ServicesState {}
class DDDDDDDDDState extends ServicesState {}
class CCCCCState extends ServicesState {}
class AAAAState extends ServicesState {}
class BBBState extends ServicesState {}
class LoopImagesInListUploadRequestState extends ServicesState {}
class OnchangeCustomServiceState extends ServicesState{}
class OnchangeCustomSubServiceState extends ServicesState{}
