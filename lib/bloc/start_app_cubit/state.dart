abstract class StartAppState {}

class InitialStartAppState extends StartAppState {}

class GetBoardingDataLoadingState extends StartAppState {}

class GetBoardingDataSuccessState extends StartAppState {}

class GetBoardingDataErrorState extends StartAppState {
  final String error;

  GetBoardingDataErrorState({required this.error});
}

class GetAccountTypeDataLoadingState extends StartAppState {}

class GetAccountTypeDataSuccessState extends StartAppState {}

class GetAccountTypeDataErrorState extends StartAppState {
  final String error;

  GetAccountTypeDataErrorState({required this.error});
}
class ChangeLanguageState extends StartAppState {}