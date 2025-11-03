abstract class CommentsState {}

class InitialCommentsState extends CommentsState {}

class PostRateCommentsLoadingState extends CommentsState {}

class PostRateCommentsSuccessState extends CommentsState {}

class PostRateCommentsErrorState extends CommentsState {
  final String error;

  PostRateCommentsErrorState({required this.error});
}


class PostCommentsLoadingState extends CommentsState {}

class PostCommentsSuccessState extends CommentsState {}

class PostCommentsErrorState extends CommentsState {
  final String error;

  PostCommentsErrorState({required this.error});
}
