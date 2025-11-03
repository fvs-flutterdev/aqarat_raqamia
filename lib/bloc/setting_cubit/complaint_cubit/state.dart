abstract class ComplaintState {}

class InitialComplaintState extends ComplaintState {}

class PostComplaintLoadingState extends ComplaintState {}

class PostComplaintSuccessState extends ComplaintState {}

class PostComplaintErrorState extends ComplaintState {
  final String error;

  PostComplaintErrorState({required this.error});
}

class GetMyComplaintsLoadingState extends ComplaintState {}

class GetMyComplaintsSuccessState extends ComplaintState {}

class GetMyComplaintsErrorState extends ComplaintState {
  final String error;

  GetMyComplaintsErrorState({required this.error});
}

class ReplayMyComplaintLoadingState extends ComplaintState {}

class ReplayMyComplaintSuccessState extends ComplaintState {}

class ReplayMyComplaintErrorState extends ComplaintState {
  final String error;

  ReplayMyComplaintErrorState({required this.error});
}
