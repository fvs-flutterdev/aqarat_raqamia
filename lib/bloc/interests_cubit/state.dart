abstract class InterestsState {}

class InitialInterestsState extends InterestsState {}

class GetInterestsLoadingState extends InterestsState {}

class GetInterestsSuccessState extends InterestsState {}

class GetInterestsErrorState extends InterestsState {
  final String error;

  GetInterestsErrorState({required this.error});
}
