abstract class ClientCurrentOrderState {}

class InitialClientCurrentOrderState extends ClientCurrentOrderState {}

class GetClientCurrentOrderErrorState extends ClientCurrentOrderState {
  final String error;
  GetClientCurrentOrderErrorState({required this.error});
}

class GetClientCurrentOrderSuccessState extends ClientCurrentOrderState {}


class AddRateProviderLoadingState extends ClientCurrentOrderState {}
class AddRateProviderSuccessState extends ClientCurrentOrderState {}
class AddRateProviderErrorState extends ClientCurrentOrderState {
  final String error;

  AddRateProviderErrorState({required this.error});
}
