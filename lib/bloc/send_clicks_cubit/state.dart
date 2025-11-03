abstract class SendClickState {}

class InitialSendClicksState extends SendClickState {}
class SendClicksLoadingState extends SendClickState {}
class SendClicksSuccessState extends SendClickState {}

class SendClicksErrorState extends SendClickState {
  final String error;

  SendClicksErrorState({required this.error});
}
