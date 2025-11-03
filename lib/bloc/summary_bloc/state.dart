abstract class SummaryState {}

class InitialSummaryState extends SummaryState {}

class GetSummaryLoadingState extends SummaryState {}

class GetSummarySuccessState extends SummaryState {}

class GetSummaryErrorState extends SummaryState {
  final String error;

  GetSummaryErrorState({required this.error});
}
