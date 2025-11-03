abstract class AllConversationsState {}

class InitialAllConversationsState extends AllConversationsState {}

class GetAllConversationsLoadingState extends AllConversationsState {}

class GetAllConversationsSuccessState extends AllConversationsState {}

class GetAllConversationsErrorState extends AllConversationsState {
  final String error;

  GetAllConversationsErrorState({required this.error});
}
class HandleLastMessageState extends AllConversationsState {}
