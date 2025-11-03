abstract class SubscribeState {}

class InitialSubscribeState extends SubscribeState {}

class GetSubscribeDataSuccessState extends SubscribeState {}

class GetSubscribeDataErrorState extends SubscribeState {
  final String error;

  GetSubscribeDataErrorState({required this.error});
}

class ChangeSubscribeState extends SubscribeState {}
class ChangeDialogState extends SubscribeState {}



class PaySubscribeDataLoadingState extends SubscribeState {}
class PaySubscribeDataSuccessState extends SubscribeState {}

class PaySubscribeDataErrorState extends SubscribeState {
  final String error;

  PaySubscribeDataErrorState({required this.error});
}
class HandlePaymentResponseState extends SubscribeState {}
class HandlePaymentResponseErrorState extends SubscribeState {
  final String error;
  HandlePaymentResponseErrorState({required this.error});
}