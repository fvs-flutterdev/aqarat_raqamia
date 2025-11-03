abstract class LogoutState {}

class InitialLogOutState extends LogoutState {}

class LogOutLoadingState extends LogoutState {}

class LogOutSuccessState extends LogoutState {}

class LogOutErrorState extends LogoutState {
  final String error;

  LogOutErrorState({required this.error});
}
