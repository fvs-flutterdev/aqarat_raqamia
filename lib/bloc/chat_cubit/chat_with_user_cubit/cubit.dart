import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:aqarat_raqamia/bloc/chat_cubit/chat_with_user_cubit/state.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../../../model/dynamic_model/get_chat_model.dart';
import '../../../model/dynamic_model/message_model.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/base_url.dart';

class ChatMessageCubit extends Cubit<GetChatMessageState> {
  ChatMessageCubit(// this.chatRepository
      )
      : super(InitialGetChatMessageState());

  // List<ChatData> listChatMessageData = [];
  // bool isChatDataGet = false;
  // int page = 1;
  // final GetAllMessageRepository chatRepository;
  //
  // // bool isFirstLoaded=false;
  // loadedPendingOrdersProvider(String? id) {
  //   if (state is GetChatMessageLoadingState) return;
  //   final currentState = state;
  //   var oldChatDataModel = <ChatData>[];
  //   if (currentState is GetChatMessageLoadedState) {
  //     oldChatDataModel = currentState.chatMessagePagination;
  //     print('${oldChatDataModel.length} 00000000000000000000000111');
  //   }
  //   emit(GetChatMessageLoadingState(oldChatDataModel, isFirstFetch: page == 1));
  //   chatRepository.getAllMessageDataService(page: page, id: id).then((newAds) {
  //     print(newAds);
  //     page++;
  //     print(page);
  //     listChatMessageData =
  //         (state as GetChatMessageLoadingState).oldChatMessageData;
  //     listChatMessageData.addAll(newAds?.data ?? []);
  //     emit(GetChatMessageLoadedState(listChatMessageData));
  //     print('myAds.length ${listChatMessageData.length}');
  //     // if(newAds==null)
  //     //   emit(GetMyAdsErrorState());
  //   }).catchError((error) {
  //     print('<<<<<<<<<<<<<<<<<<<<<$error>>>>>>>>>>>>>>>>>>>>>');
  //     emit(GetChatMessageErrorState(error: error.toString()));
  //   });
  // }

  ///

  late GetAllMessageModel getAllMessageModel;
  bool isGet = false;

  // print('###################${dateNow == dates.formatDate()}>>>>>>>>>>>>>>>>>>>>>>');

  // GetAllMessageModel get messageModel => getAllMessageModel;
  final getChatMessageUrl = BaseUrl.baseUrl + BaseUrl.get_chat_message;

  getChatMessage({required int page, required String id, bool firstLoad = false}) {
    isGet = false;
    //  emit(GetChatMessagePaginationLoadingState());
    DioHelper.getData(url: '$getChatMessageUrl/$id', token: token, page: page)
        .then((value) {
      if (page == 1) {
        getAllMessageModel = GetAllMessageModel.fromJson(value.data);
        // getAllMessageModel.data!.forEach((element) {
        // DateTime dateTime =DateTime.parse(element.createDates?.createdAt??'') ;
        // String date =
        // "${dateTime.year}-${dateTime.month
        //     .toString().padLeft(2, '0')}-${dateTime.day
        //     .toString().padLeft(2, '0')}";
        // String time =
        // "${dateTime.hour.toString().padLeft(
        // 2, '0')}:${dateTime.minute.toString()
        //     .padLeft(2, '0')}";
        // bool isSameDate = true;
        // final String? dateString =element
        //     .createDates
        //     ?.createdAt ??
        // '';
        // final DateTime dates =
        // DateTime.parse(dateString ?? '');
        // DateTime now = DateTime.now();
        // String dateNow = DateFormat('MMMM dd, y', 'ar').format(now);
        // String dateYesterday = DateFormat('MMMM dd, y', 'ar').format(
        // now.subtract(const Duration(days: 1)));
        // if
        //
        // (index==0) {
        //   isSameDate = false;
        // } else {
        //   final String? prevDateString =
        //       chatCubit.getAllMessageModel.data?[index-1]
        //           .createDates
        //           ?.createdAt ??
        //           '';
        //   print('object   $prevDateString');
        //   final DateTime prevDate = DateTime.parse(prevDateString ?? '');
        //   isSameDate = dates.isSameDate(prevDate);
        //
        // }
        // });
      } else {
        getAllMessageModel.meta?.currentPage =
            GetAllMessageModel.fromJson(value.data).meta?.currentPage;
        getAllMessageModel.meta?.lastPage =
            GetAllMessageModel.fromJson(value.data).meta?.lastPage;
        getAllMessageModel.meta?.total =
            GetAllMessageModel.fromJson(value.data).meta?.total;
        getAllMessageModel.meta?.perPage =
            GetAllMessageModel.fromJson(value.data).meta?.perPage;
        getAllMessageModel.data
            ?.addAll(GetAllMessageModel.fromJson(value.data).data ?? []);
      }
      emit(GetChatMessagePaginationSuccessState());
      isGet = true;
    }).catchError((error) {
      log(error.toString());
      emit(GetChatMessageErrorState(error: error.toString()));
    });
  }

  late MessageProvider messageProvider;

  handelNewMessage(Map<String, dynamic> data) {
    // setState(() {
    messageProvider = MessageProvider.fromJson(data);
    emit(HandleNewMessageState());
    log('Model Message ${messageProvider.data?.body}');
    getAllMessageModel.data?.insert(
        0,
        ChatData(
            id: messageProvider.data?.id,
            body: messageProvider.data?.body,
            createDates: CreateDatesMessage(
              createdAt: DateTime.now().toString(),
              createdAtHuman: DateTime.now().toString(),
            ),
            istabbed: messageProvider.data?.istabbed,
            updateDates: UpdateDatesMessage(
              updatedAt: DateTime.now().toString(),
              updatedAtHuman: DateTime.now().toString(),
            ),
            messageType: messageProvider.data?.messageType,
            type: messageProvider.data?.type,

        ));
  }

  void arabicTextField({required TextEditingController controller}) {
    if (controller.selection ==
        TextSelection.fromPosition(
            TextPosition(offset: controller.text.length - 1))) {
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
      emit(ArabicTextFieldAuthState());
    }
  }

  File? file;
  bool isPickImage = false;
  String? base64Image;
  String? imageFinal64;

  Future pickImageFromGallery() async {
    final XFile? pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    file = (File(pickedFile!.path));
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(file!.path);
    final savedImage = await file?.copy('${appDir.path}/$fileName');
    var result = await FlutterImageCompress.compressWithFile(
      savedImage!.absolute.path,
      minWidth: 1920,
      minHeight: 1080,
      quality: 50,

      //  rotate: 90,
    );
   /// String base64String = base64Encode(result!);
    //  final savedImage = await image.copy('/$fileName');
    //  List<int> Image64=await image.readAsBytes();
    // List<int> imageBytes = await savedImage.readAsBytesSync();
  ///  List<int> imageBytes = await savedImage.readAsBytesSync();
    base64Image =base64Encode(result!);
    imageFinal64='data:image/jpeg;base64,$base64Image';

    isPickImage = true;
    uploadImage();
    log('IS PICK IMAGE ${isPickImage.toString()} ');
    log('FILE IMAGE${file.toString()}');
    log('BASE 64 ${base64Image.toString()}');
    log(imageFinal64.toString());

    emit(PickImageFromGalleryInChatState());
  }

  String? imageUrl;

  Future uploadImage() async {
    String fileName = Uuid().v1();
    var ref = FirebaseStorage.instance.ref('images').child('$fileName.jpg');
    var uploadTask = await ref.putFile(file!);
    imageUrl = await uploadTask.ref.getDownloadURL();
    log(imageUrl.toString());
    emit(ConvertImageToUrlState());
  }


  bool isGetImage = false;

  sendMessage({required int id,  String? message}) async {
    String apiUrl = '${BaseUrl.baseUrl}/api/chats/messages/create/$id';
    isGetImage = true;

    emit(SendMessageLoadingState());
    DioHelper.postData(url: apiUrl,token: token,data: {
            'body': isPickImage ?imageFinal64: message,
            'message_type': isPickImage ?'media':'text',
    }).then((value) {
      log(value.data.toString());
      imageUrl=null;
      isPickImage=false;
      emit(SendMessageSuccessState());
    }).catchError((error){
      log(error.toString());
   emit(SendMessageErrorState(error: error.toString()));
    });
  }
  bool isSentMessage = false;

  addMessageToList({String? message}) {
    // isPickImage = false;
    getAllMessageModel.data?.insert(
        0,
        ChatData(
          body:isPickImage?imageUrl: message,
          type: accountType,
          messageType: isPickImage?'media':'text',
          sender: Sender(
            id: userId,
          ),
          createDates: CreateDatesMessage(
              createdAt: DateTime.now().toString(),
              createdAtHuman: DateTime.now().toString()),
        ));
    isSentMessage = true;
    emit(SendTextMessageState());
  }
  clearImage(){
    isPickImage = false;
    imageUrl = null;
    emit(ClearImageState());
  }
}
