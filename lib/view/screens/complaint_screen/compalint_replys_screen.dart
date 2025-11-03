import 'dart:ui';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/media_query_value.dart';
import '../../../view/base/chat_widget/time_division.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../bloc/setting_cubit/complaint_cubit/cubit.dart';
import '../../../bloc/setting_cubit/complaint_cubit/state.dart';
import '../../../utils/text_style.dart';
import '../../base/auth_header.dart';
import '../../base/text_chat_field.dart';

class ReplayComplaintScreen extends StatefulWidget {
  final int index;

  ReplayComplaintScreen({super.key, required this.index});

  @override
  State<ReplayComplaintScreen> createState() => _ReplayComplaintScreenState();
}

class _ReplayComplaintScreenState extends State<ReplayComplaintScreen> {
  EdgeInsets _viewInsets = EdgeInsets.zero;
  SingletonFlutterWindow? window;
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
    };
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var complaintCubit = context.read<ComplaintCubit>();
    return BlocBuilder<ComplaintCubit, ComplaintState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            // appBar: AuthHeader(
            //     title:
            //         '${LocaleKeys.complaintNo.tr()}#${complaintCubit.myComplaintsModel.complaints?[widget.index].id}'),
            body: Column(
              children: [
                Container(
                  height: context.height * 0.17.h,
                  margin: EdgeInsets.zero,
                  child: AuthHeader(
                      title:
                          '${LocaleKeys.complaintNo.tr()}#${complaintCubit.myComplaintsModel.complaints?[widget.index].id}'),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: complaintCubit.myComplaintsModel
                          .complaints?[widget.index].responses?.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(complaintCubit
                                .myComplaintsModel
                                .complaints?[widget.index]
                                .responses?[index]
                                .createdAt ??
                            '');
                        String time =
                            "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
                        final String? dateString = complaintCubit
                                .myComplaintsModel
                                .complaints?[widget.index]
                                .responses?[index]
                                .createdAt ??
                            '';
                        final DateTime dates = DateTime.parse(dateString ?? '');
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              complaintCubit
                                          .myComplaintsModel
                                          .complaints?[widget.index]
                                          .responses?[index]
                                          .userId ==
                                      userId
                                  ? Align(
                                      alignment: AlignmentDirectional.topStart,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadiusDirectional.only(
                                                bottomEnd:
                                                    Radius.circular(15.sp),
                                                bottomStart:
                                                    Radius.circular(15.sp),
                                                topEnd: Radius.circular(15.sp),
                                              ),
                                            ),
                                            elevation: 1,
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      context.width / 2.w),
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                      start: 10.sp, end: 10.sp),
                                              decoration: BoxDecoration(
                                                color: whiteColor,
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .only(
                                                  bottomEnd:
                                                      Radius.circular(15.sp),
                                                  bottomStart:
                                                      Radius.circular(15.sp),
                                                  topEnd:
                                                      Radius.circular(15.sp),
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .only(
                                                                end: 18.w,
                                                                start: 10.w),
                                                    child: Text(
                                                      complaintCubit
                                                              .myComplaintsModel
                                                              .complaints?[
                                                                  widget.index]
                                                              .responses?[index]
                                                              .response ??
                                                          '',
                                                      style: TextStyle(
                                                          color: darkGreyColor),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${time}',
                                                    textAlign: TextAlign.end,
                                                    style: openSansRegular
                                                        .copyWith(
                                                            fontSize: 10,
                                                            color: goldColor),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Text(
                                            dates.formatDate(),
                                            style: openSansRegular.copyWith(
                                                color: goldColor,
                                                fontSize:
                                                    context.height * 0.01),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Align(
                                      alignment: AlignmentDirectional.topEnd,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadiusDirectional.only(
                                                bottomEnd:
                                                    Radius.circular(15.sp),
                                                bottomStart:
                                                    Radius.circular(15.sp),
                                                topStart:
                                                    Radius.circular(15.sp),
                                              ),
                                            ),
                                            elevation: 1,
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      context.width / 2.w),
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                      end: 10.sp, start: 10.sp),
                                              decoration: BoxDecoration(
                                                color: lightGrey,
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .only(
                                                  bottomEnd:
                                                      Radius.circular(15.sp),
                                                  bottomStart:
                                                      Radius.circular(15.sp),
                                                  topStart:
                                                      Radius.circular(15.sp),
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .only(
                                                                end: 18.w,
                                                                start: 10.w),
                                                    child: Text(
                                                      complaintCubit
                                                              .myComplaintsModel
                                                              .complaints?[
                                                                  widget.index]
                                                              .responses?[index]
                                                              .response ??
                                                          '',
                                                      style: TextStyle(
                                                          color: darkGreyColor),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${time}',
                                                    textAlign: TextAlign.end,
                                                    style: openSansRegular
                                                        .copyWith(
                                                            fontSize: 10,
                                                            color: goldColor),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Text(
                                            dates.formatDate(),
                                            style: openSansRegular.copyWith(
                                                color: goldColor,
                                                fontSize:
                                                    context.height * 0.01),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        );
                      }),
                )),
                TextFieldChat(
                  // isChatSupport: true,
                  //  pickImage: () {
                  //  //  chatCubit.pickImageFromGallery();
                  //    // setState(() {
                  //    //   // chatWithSupportCubit.imageUrl = null;
                  //    //   // chatWithSupportCubit.isPickImage = false;
                  //    // });
                  //    //  chatWithSupportCubit.pickImageFromGallery();
                  //  },
                  controller: messageController,
                  onTap: () {
                    // chatCubit.arabicTextField(
                    //     controller: messageController);
                  },
                  sendMessage: () {
                    complaintCubit.replayComplaint(
                        complaintId: complaintCubit
                            .myComplaintsModel.complaints![widget.index].id!,
                        index: widget.index,
                        response: messageController.text);
                    messageController.clear();
                    // if (chatCubit.isPickImage == false &&
                    //     messageController.text.isEmpty) {
                    //   print('no Send Data');
                    // }
                    // // else if(messageController.text.isEmpty && chatCubit.isPickImage == false){
                    // //   print('object');
                    // // }
                    // else if (chatCubit.isPickImage == true) {
                    //   chatCubit.addMessageToList();
                    //   chatCubit.sendMessage(
                    //     id: chatCubit.getAllMessageModel.chat!.id!,
                    //   );
                    //
                    //   // messageController.clear();
                    // } else {
                    //   chatCubit.sendMessage(
                    //       id: chatCubit.getAllMessageModel.chat!.id!,
                    //       message: messageController.text);
                    //   chatCubit.addMessageToList(
                    //       message: messageController.text);
                    //   messageController.clear();
                    // }
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
            ),
          ),
        );
      },
    );
  }
}
