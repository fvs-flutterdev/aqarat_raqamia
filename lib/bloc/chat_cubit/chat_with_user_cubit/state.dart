import '../../../model/dynamic_model/get_chat_model.dart';

abstract class GetChatMessageState {}

class InitialGetChatMessageState extends GetChatMessageState {}

class GetChatMessageLoadedState extends GetChatMessageState {
  final List<ChatData> chatMessagePagination;

  GetChatMessageLoadedState(this.chatMessagePagination);
}

class GetChatMessageLoadingState extends GetChatMessageState {
  final List<ChatData> oldChatMessageData;
  final bool isFirstFetch;

  GetChatMessageLoadingState(this.oldChatMessageData,
      {this.isFirstFetch = false});
}

class GetChatMessagePaginationLoadingState extends GetChatMessageState{}

class GetChatMessagePaginationSuccessState extends GetChatMessageState{}

class GetChatMessageErrorState extends GetChatMessageState {
  final String? error;

  GetChatMessageErrorState({this.error});
}

class ArabicTextFieldAuthState extends GetChatMessageState{}
class SendMessageLoadingState extends  GetChatMessageState{}
class SendMessageSuccessState extends  GetChatMessageState{}
class SendMessageErrorState extends  GetChatMessageState{
  final String error;
  SendMessageErrorState({required this.error});
}
class SendTextMessageState extends GetChatMessageState{}

class HandleNewMessageState extends GetChatMessageState{}
class PickImageFromGalleryInChatState extends GetChatMessageState{}
class ConvertImageToUrlState extends GetChatMessageState{}
class ClearImageState extends GetChatMessageState{}