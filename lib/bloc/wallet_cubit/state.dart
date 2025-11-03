abstract class WalletState {}

class InitialWalletState extends WalletState {}

class ChargeWalletLoadingState extends WalletState {}

class ChargeWalletSuccessState extends WalletState {}

class ChargeWalletErrorState extends WalletState {
  final String error;

  ChargeWalletErrorState({required this.error});
}

class HandleChargeWalletResponseState extends WalletState {}

class HandleChargeWalletResponseErrorState extends WalletState {
  final String error;
  HandleChargeWalletResponseErrorState({required this.error});
}
