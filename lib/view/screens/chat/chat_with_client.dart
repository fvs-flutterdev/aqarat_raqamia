import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';

import '../../../utils/media_query_value.dart';
import '../../../utils/text_style.dart';
import '../../../view/base/chat_widget/time_division.dart';
import '../../../view/base/full_screen_image/full_screen_image.dart';
import '../../../view/base/lunch_widget.dart';
import '../../../view/base/pagination_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pusher_client/pusher_client.dart';
import '../../../bloc/chat_cubit/chat_with_user_cubit/cubit.dart';
import '../../../bloc/chat_cubit/chat_with_user_cubit/state.dart';
import '../../../pusher_config/pusher.dart';
import '../../../utils/app_constant.dart';
import '../../base/auth_header.dart';
import '../../base/chat_widget/setup_container.dart';
import '../../base/shimmer/card_shimmer.dart';
import '../../base/shimmer/chat_shimmer.dart';
import '../../base/text_chat_field.dart';

class ChatWithCustomerScreen extends StatefulWidget {
  dynamic channelId;
  final String name;

  ChatWithCustomerScreen({required this.channelId, required this.name});

  @override
  State<ChatWithCustomerScreen> createState() => _ChatWithGuidesScreenState();
}

class _ChatWithGuidesScreenState extends State<ChatWithCustomerScreen> {
  EdgeInsets _viewInsets = EdgeInsets.zero;
  SingletonFlutterWindow? window;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    print('HERE IS CHAT ${widget.channelId}');
    super.initState();
    context
        .read<ChatMessageCubit>()
        .getChatMessage(page: 1, id: widget.channelId );

    window = WidgetsBinding.instance.window;
    window?.onMetricsChanged = () {
      if (mounted) {
        setState(() {
          final window = this.window;
          if (window != null) {
            _viewInsets = EdgeInsets.fromWindowPadding(
              window.viewInsets,
              window.devicePixelRatio,
            ).add(EdgeInsets.fromWindowPadding(
              window.padding,
              window.devicePixelRatio,
            )) as EdgeInsets;
          }
        });
      }
      ;

    };
  }

  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void listenChatChannel() {
    LaravelEcho.instance
        .channel('chat-${userId}')
        .listen('.new-message-${userId}${widget.channelId}', (e) {
      if (e is PusherEvent) {

        if (e.data != null) {
          jsonDecode(e.data!);
          print(jsonDecode(e.data!));
          print('e.dataxxxx ${e.data!}');
          context
              .read<ChatMessageCubit>()
              .handelNewMessage(jsonDecode(e.data!));
        }
        print('????${jsonDecode(e.data!)}');
      }
    }).error((error) {
      print('error x $error');
    });
  }

  void leaveChannel() {
    try {
      LaravelEcho.instance.leave('chat-${userId}');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var chatCubit = context.read<ChatMessageCubit>();
    // chatCubit.loadedPendingOrdersProvider(widget.channelId.toString());
    // chatWithSupportCubit.imageUrl = null;
    // chatWithSupportCubit.isPickImage = false;
    return BlocBuilder<ChatMessageCubit, GetChatMessageState>(
      builder: (context, state) {
        return StartUpContainer(
          onInit: () {

            LaravelEcho.init(token: token);
            listenChatChannel();
            // chatCubit
            //     .getChatMessage(page: 1, id: widget.channelId );
          },
          onDisposed: () {
            LaravelEcho.instance.disconnect();
            leaveChannel();
          },
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              // appBar: AuthHeader(
              //   title: widget.name,
              // ),
              body: Column(
                children: [
                  Container(
                    height: context.height * 0.17.h,
                    margin: EdgeInsets.zero,
                    child:AuthHeader(
                      title:widget.name,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: chatCubit.isGet == false
                                ? ChatShimmer()
                                : SingleChildScrollView(
                                    controller: _controller,
                                    reverse: true,
                                    child: chatCubit.getAllMessageModel.data!.isEmpty
                                        ? Container()
                                        : PaginatedListView(
                                      last: chatCubit.getAllMessageModel.meta!.lastPage!,
                                            offset: chatCubit.getAllMessageModel.meta
                                                    ?.currentPage ??
                                                1,
                                            onPaginate: (int offset) async {
                                              print(offset);
                                              await chatCubit.getChatMessage(page: offset, id: widget.channelId);
                                            },
                                            scrollController: _controller,
                                            totalSize: chatCubit
                                                    .getAllMessageModel.meta?.to ??
                                                15,
                                            reverse: true,
                                            enabledPagination: true,
                                            productView: ListView.builder(
                                                reverse: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                padding:const EdgeInsets.all(5),
                                                itemCount: chatCubit
                                                    .getAllMessageModel.data?.length,
                                                itemBuilder: (context, index) {
                                                  DateTime dateTime = DateTime.parse(
                                                      chatCubit
                                                              .getAllMessageModel
                                                              .data?[index]
                                                              .createDates
                                                              ?.createdAt ??
                                                          '');
                                                  // String date =
                                                  //     "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
                                                  String time =
                                                      "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
                                                  // bool isSameDate = true;
                                                  final String? dateString = chatCubit
                                                          .getAllMessageModel
                                                          .data?[index]
                                                          .createDates
                                                          ?.createdAt ??
                                                      '';
                                                  final DateTime dates =
                                                      DateTime.parse(
                                                          dateString ?? '');

                                                  // DateTime now = DateTime.now();
                                                  // String dateNow =
                                                  //     DateFormat('MMMM dd, y', 'ar')
                                                  //         .format(now);
                                                  // String dateYesterday = DateFormat(
                                                  //         'MMMM dd, y', 'ar')
                                                  //     .format(now.subtract(
                                                  //         const Duration(days: 1)));

                                                  ///
                                                  return Column(
                                                      children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(8.0),
                                                      child: chatCubit
                                                                  .getAllMessageModel
                                                                  .data?[index]
                                                                  .sender?.id !=userId
                                                              //accountType
                                                          //  "App\\Models\\Provider"
                                                          ? Column(
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional
                                                                          .topEnd,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Card(
                                                                        shape:
                                                                        const  RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadiusDirectional
                                                                                  .only(
                                                                            bottomEnd:
                                                                                Radius.circular(
                                                                                    15),
                                                                            bottomStart:
                                                                                Radius.circular(
                                                                                    15),
                                                                            topStart:
                                                                                Radius.circular(
                                                                                    15),
                                                                          ),
                                                                        ),
                                                                        elevation: 1,
                                                                        child:

                                                                            Container(
                                                                          constraints:
                                                                              BoxConstraints(
                                                                                  maxWidth:
                                                                                      context.width / 2),
                                                                          padding:const EdgeInsetsDirectional
                                                                              .only(
                                                                                  end:
                                                                                      10),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                lightGrey,
                                                                            borderRadius:
                                                                            const  BorderRadiusDirectional
                                                                                    .only(
                                                                              bottomEnd:
                                                                                  Radius.circular(15),
                                                                              bottomStart:
                                                                                  Radius.circular(15),
                                                                              topStart:
                                                                                  Radius.circular(15),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment
                                                                                    .end,
                                                                            children: [
                                                                              Padding(
                                                                                padding:const EdgeInsetsDirectional.only(
                                                                                    end: 18,
                                                                                    start: 10),
                                                                                child: chatCubit.getAllMessageModel.data?[index].messageType == 'media'
                                                                                    ? GestureDetector(
                                                                                  onTap:(){
                                                                                    navigateForward(FullImageScreen(image: chatCubit.getAllMessageModel.data?[index].body ?? ''));
                                                                                  },
                                                                                      child: Image.network(
                                                                                          chatCubit.getAllMessageModel.data?[index].body ?? '',
                                                                                        ),
                                                                                    )
                                                                                    : Text(
                                                                                        chatCubit.getAllMessageModel.data?[index].body ?? '',
                                                                                        style: TextStyle(color: darkGreyColor),
                                                                                      ),
                                                                              ),
                                                                              Text(
                                                                                '${time}',
                                                                                textAlign:
                                                                                    TextAlign.end,
                                                                                style: openSansRegular.copyWith(
                                                                                    fontSize: 10,
                                                                                    color: goldColor),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        dates
                                                                            .formatDate(),
                                                                        style: openSansRegular.copyWith(
                                                                            color:
                                                                                goldColor,
                                                                            fontSize:
                                                                                context.height *
                                                                                    0.01),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Align(
                                                              alignment:
                                                                  AlignmentDirectional
                                                                      .topStart,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Card(
                                                                    //  color:whiteColor,
                                                                    shape:
                                                                    const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadiusDirectional
                                                                              .only(
                                                                        bottomEnd: Radius
                                                                            .circular(
                                                                                15),
                                                                        bottomStart: Radius
                                                                            .circular(
                                                                                15),
                                                                        topEnd: Radius
                                                                            .circular(
                                                                                15),
                                                                      ),
                                                                    ),
                                                                    elevation: 3,
                                                                    child: Container(
                                                                        padding:const EdgeInsetsDirectional
                                                                            .only(
                                                                                start:
                                                                                    10),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              whiteColor,
                                                                          borderRadius:
                                                                             BorderRadiusDirectional
                                                                                  .only(
                                                                            bottomEnd:
                                                                                Radius.circular(
                                                                                    15.sp),
                                                                            bottomStart:
                                                                                Radius.circular(
                                                                                    15.sp),
                                                                            topEnd: Radius
                                                                                .circular(
                                                                                    15.sp),
                                                                          ),
                                                                        ),
                                                                        constraints: BoxConstraints(
                                                                            maxWidth:context.width / 2),
                                                                        // child: Column(
                                                                        //   crossAxisAlignment:
                                                                        //       CrossAxisAlignment
                                                                        //           .start,
                                                                        //   children: [
                                                                        //     Padding(
                                                                        //       padding:
                                                                        //           EdgeInsetsDirectional
                                                                        //               .only(
                                                                        //                   start:
                                                                        //                       18,
                                                                        //                   end:
                                                                        //                       10),
                                                                        //       child: Text(
                                                                        //         chatWithSupportCubit
                                                                        //                 .getMessageFromProvider
                                                                        //                 ?.messages![
                                                                        //                     index]
                                                                        //                 .message ??
                                                                        //             '',
                                                                        //         style: TextStyle(
                                                                        //             color:
                                                                        //                 blackColor),
                                                                        //       ),
                                                                        //     ),
                                                                        //     Text(
                                                                        //       time,
                                                                        //       textAlign:
                                                                        //           TextAlign.end,
                                                                        //       style: cairoRegular
                                                                        //           .copyWith(
                                                                        //               fontSize:
                                                                        //                   10,
                                                                        //               color:
                                                                        //                   greyColor),
                                                                        //     )
                                                                        //   ],
                                                                        // ),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment
                                                                                  .start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.only(
                                                                                  end:
                                                                                      18.sp,
                                                                                  start:
                                                                                      10.sp),
                                                                              child: chatCubit.getAllMessageModel.data?[index].messageType ==
                                                                                      'media'
                                                                                  ? GestureDetector(
                                                                                onTap:(){
                                                                                  navigateForward(FullImageScreen(image:  chatCubit.getAllMessageModel.data?[index].body ?? '',));
                                                                                },
                                                                                    child: Image.network(
                                                                                        chatCubit.getAllMessageModel.data?[index].body ?? '',
                                                                                      ),
                                                                                  )
                                                                                  : Text(
                                                                                      chatCubit.getAllMessageModel.data?[index].body ?? '',
                                                                                      style: TextStyle(color: darkGreyColor),
                                                                                    ),
                                                                              //
                                                                              // Text(
                                                                              //   chatCubit
                                                                              //           .getAllMessageModel
                                                                              //           .data?[index]
                                                                              //           .body ??
                                                                              //       '',
                                                                              //   style: TextStyle(
                                                                              //       color:
                                                                              //           darkGreyColor),
                                                                              // ),
                                                                            ),
                                                                            Text(
                                                                              '${time}',
                                                                              textAlign:
                                                                                  TextAlign.start,
                                                                              style: openSansRegular.copyWith(
                                                                                  fontSize:
                                                                                      10,
                                                                                  color:
                                                                                      goldColor),
                                                                            )
                                                                          ],
                                                                        )
                                                                        //:
                                                                        //  :
                                                                        ///
                                                                        //     : messageController.text.isEmpty &&
                                                                        //     chatWithSupportCubit.isPickImage ==true?
                                                                        // Column(
                                                                        //   crossAxisAlignment: CrossAxisAlignment.end,
                                                                        //   children: [
                                                                        //     Padding(
                                                                        //       padding: EdgeInsetsDirectional.only(end: 18, start: 10),
                                                                        //       child: Image.network(
                                                                        //         chatWithSupportCubit.getMessageCustomerService?.messages![index].attachment ?? '',
                                                                        //         // style: TextStyle(
                                                                        //         //     color:
                                                                        //         //     darkMainColor),
                                                                        //       ),
                                                                        //     ),
                                                                        //     Text(
                                                                        //       chatWithSupportCubit.getMessageCustomerService?.messages![index].message ?? '',
                                                                        //       style: TextStyle(color: darkMainColor),
                                                                        //     ),
                                                                        //     Text(
                                                                        //       '$time',
                                                                        //       textAlign: TextAlign.end,
                                                                        //       style: cairoRegular.copyWith(fontSize: 10, color: greyColor),
                                                                        //     )
                                                                        //   ],
                                                                        // )
                                                                        //     :
                                                                        ///
                                                                        // GestureDetector(
                                                                        //     onTap: () {
                                                                        //       navigateForward(
                                                                        //           FullImageScreen(
                                                                        //         image: chatWithSupportCubit.getMessageFromProvider?.messages?[index].attachment ??
                                                                        //             '',
                                                                        //       ));
                                                                        //     },
                                                                        //     child:
                                                                        //         Column(
                                                                        //       crossAxisAlignment:
                                                                        //           CrossAxisAlignment
                                                                        //               .start,
                                                                        //       children: [
                                                                        //         Padding(
                                                                        //           padding: EdgeInsetsDirectional.only(
                                                                        //               end: 18,
                                                                        //               start: 10),
                                                                        //           child:
                                                                        //               Image.network(
                                                                        //             chatWithSupportCubit.getMessageFromProvider?.messages![index].attachment ??
                                                                        //                 '',
                                                                        //             // style: TextStyle(
                                                                        //             //     color:
                                                                        //             //     darkMainColor),
                                                                        //           ),
                                                                        //         ),
                                                                        //         Text(
                                                                        //           '$time',
                                                                        //           textAlign:
                                                                        //               TextAlign.end,
                                                                        //           style: cairoRegular.copyWith(
                                                                        //               fontSize: 10,
                                                                        //               color: greyColor),
                                                                        //         )
                                                                        //       ],
                                                                        //     ),
                                                                        //   ),
                                                                        ),
                                                                  ),
                                                                  Text(
                                                                    dates
                                                                        .formatDate(),
                                                                    style: openSansRegular.copyWith(
                                                                        color:
                                                                            darkGreyColor,
                                                                        fontSize:
                                                                            context.height *
                                                                                0.01),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                    )
                                                  ]);
                                                }),
                                          ),
                                  ),
                          ),
                          Column(
                            children: [
                              chatCubit.isPickImage
                                  ? chatCubit.imageUrl == null
                                      ? CardShimmer()
                                      : SizedBox(
                                          height: context.width * 0.4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            //  alignment: AlignmentDirectional.topEnd,

                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    chatCubit.clearImage();
                                                    print('object');
                                                  },
                                                  icon: Icon(
                                                    Icons.close_rounded,
                                                    color: redColor,
                                                    size: 35,
                                                  )),
                                              Container(
                                                alignment:
                                                    AlignmentDirectional.topStart,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 25.sp),
                                                height: context.width * 0.2,
                                                constraints: BoxConstraints(
                                                    maxHeight: 100, minHeight: 100),
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: FileImage(
                                                          chatCubit.file!,
                                                        ),
                                                        fit: BoxFit.fitHeight)),
                                                // child: Image.file(
                                                //     chatWithSupportCubit
                                                //         .file!,fit: BoxFit.fitWidth,),
                                              ),
                                            ],
                                          ),
                                        )
                                  :const SizedBox(),
                              TextFieldChat(
                                isChatSupport: true,
                                pickImage: () {
                                  chatCubit.pickImageFromGallery();
                                  // setState(() {
                                  //   // chatWithSupportCubit.imageUrl = null;
                                  //   // chatWithSupportCubit.isPickImage = false;
                                  // });
                                  //  chatWithSupportCubit.pickImageFromGallery();
                                },
                                controller: messageController,
                                onTap: () {
                                  chatCubit.arabicTextField(
                                      controller: messageController);
                                },
                                sendMessage: () {
                                  if (chatCubit.isPickImage == false &&
                                      messageController.text.isEmpty) {
                                    print('no Send Data');
                                  }
                                  // else if(messageController.text.isEmpty && chatCubit.isPickImage == false){
                                  //   print('object');
                                  // }
                                  else if (chatCubit.isPickImage == true) {
                                    chatCubit.addMessageToList();
                                    chatCubit.sendMessage(
                                      id: chatCubit.getAllMessageModel.chat!.id!,
                                    );

                                    // messageController.clear();
                                  } else {
                                    chatCubit.sendMessage(
                                        id: chatCubit.getAllMessageModel.chat!.id!,
                                        message: messageController.text);
                                    chatCubit.addMessageToList(
                                        message: messageController.text);
                                    messageController.clear();
                                  }
                                  // if (messageController.text.isEmpty &&
                                  //     chatWithSupportCubit.isPickImage == false) {
                                  //   debugPrint('galal');
                                  // } else {
                                  //   chatWithSupportCubit.sendMessage(
                                  //     message: messageController.text,
                                  //     id: widget.channelName,
                                  //   );
                                  //   chatWithSupportCubit
                                  //       .addMessageToList(messageController.text);
                                  //   messageController.clear();
                                  // }
                                  // setState(() {
                                  //
                                  // });
                                },
                                paddingBottom: _viewInsets.bottom,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
