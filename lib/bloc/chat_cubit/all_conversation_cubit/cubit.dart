import 'dart:developer';

import 'package:aqarat_raqamia/bloc/chat_cubit/all_conversation_cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/dynamic_model/all_chat_model.dart';
import '../../../model/dynamic_model/new_conversation_model.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/base_url.dart';
import '../../../utils/dio.dart';

class AllConversationCubit extends Cubit<AllConversationsState> {
  AllConversationCubit() : super(InitialAllConversationsState());

  late AllConversationsModel allConversationsModel;
  bool isGetAllConversationsData = false;
  final getChatMessageUrl = BaseUrl.baseUrl + BaseUrl.get_chat_message;

  getAllConversationsDataUser({required int page, bool firstLoad = false}) {
    isGetAllConversationsData = false;
    DioHelper.getData(
            url: BaseUrl.baseUrl + BaseUrl.Get_All_Conversations,
            token: token,
            page: page)
        .then((value) {
      if (page == 1) {
        allConversationsModel = AllConversationsModel.fromJson(value.data);
      } else {
        allConversationsModel.meta?.currentPage =
            AllConversationsModel.fromJson(value.data).meta?.currentPage;
        allConversationsModel.meta?.lastPage =
            AllConversationsModel.fromJson(value.data).meta?.lastPage;
        allConversationsModel.meta?.total =
            AllConversationsModel.fromJson(value.data).meta?.total;
        allConversationsModel.meta?.perPage =
            AllConversationsModel.fromJson(value.data).meta?.perPage;
        allConversationsModel.allConversationsData?.addAll(
            AllConversationsModel.fromJson(value.data).allConversationsData ??
                []);
      }
      emit(GetAllConversationsSuccessState());
      isGetAllConversationsData = true;
    }).catchError((error) {
      isGetAllConversationsData = true;
      log(error.toString());
      emit(GetAllConversationsErrorState(error: error.toString()));
    });
  }

  late NewConversationModel newConversationModel;

  handelNewMessage(Map<String, dynamic> data) {
    newConversationModel = NewConversationModel.fromJson(data);
    emit(HandleLastMessageState());
    log('Model Message ${newConversationModel.data?.id.toString()}');
    allConversationsModel.allConversationsData!
        .indexOf(AllConversationsDataModel(
      lastMessage: LastMessage(
        messageType: newConversationModel.data?.messageType,
        type: newConversationModel.data?.type,
        body: newConversationModel.data?.body,
        id: newConversationModel.data?.id,
        chatId: int.tryParse(newConversationModel.data?.chatId ?? ''),
        createDatesLastMessage: CreateDatesLastMessage(),
        isTabbedLastMessage: newConversationModel.data?.istabbed,
        senderLastMessage: SenderLastMessage(
          id: newConversationModel.data?.sender?.id,
          name: newConversationModel.data?.sender?.name,
          photo: newConversationModel.data?.sender?.photo,
        ),
        updateDatesLastMessage: UpdateDatesLastMessage(),
      ),
    ));
    emit(HandleLastMessageState());
  }
}
