abstract class ClientFinishedOrderState {}

class InitialClientFinishedOrderState extends ClientFinishedOrderState {}

class GetClientFinishedOrderErrorState extends ClientFinishedOrderState {
  final String error;
  GetClientFinishedOrderErrorState({required this.error});
}

class GetClientFinishedOrderSuccessState extends ClientFinishedOrderState {}

// class AddRateProviderErrorState extends ClientFinishedOrderState {
//   final String error;
//   AddRateProviderErrorState({required this.error});
// }
//
// class AddRateProviderSuccessState extends ClientFinishedOrderState {}
// class AddRateProviderLoadingState extends ClientFinishedOrderState {}
