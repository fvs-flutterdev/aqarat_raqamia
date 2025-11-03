import 'dart:convert';
import 'package:flutter/cupertino.dart';

import '../../../pusher_config/pusher.dart';
import '../../../utils/media_query_value.dart';
import '../../../view/base/auth_header.dart';
import '../../../view/base/guest_widget.dart';
import '../../../view/base/lunch_widget.dart';
import '../../../view/base/shimmer/ads_shimmer.dart';
import '../../../view/error_widget/error_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pusher_client/pusher_client.dart';
import '../../../bloc/chat_cubit/all_conversation_cubit/cubit.dart';
import '../../../bloc/chat_cubit/all_conversation_cubit/state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/images.dart';
import '../../../utils/text_style.dart';
import '../../base/chat_widget/setup_container.dart';
import '../../base/pagination_view.dart';
import 'chat_with_client.dart';

class MyConversationScreen extends StatefulWidget {
  @override
  State<MyConversationScreen> createState() => _MyConversationScreenState();
}

class _MyConversationScreenState extends State<MyConversationScreen> {
//  const MyConversationScreen({super.key});
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<AllConversationCubit>().getAllConversationsDataUser(page: 1);
  }

  void listenChatChannel() {
    LaravelEcho.instance.channel('chat-${userId}').listen('.new-message', (e) {
      if (e is PusherEvent) {
        if (e.data != null) {
          jsonDecode(e.data!);
          printLongString(
              '/////////////${jsonDecode(e.data!).toString()}////////////');
          printLongString('e.dataxxxx ${e.data!.toString()}');
          context
              .read<AllConversationCubit>()
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
    var allConversationsData = context.read<AllConversationCubit>();
    return StartUpContainer(
      onInit: () {
        LaravelEcho.init(token: token);
        listenChatChannel();
      },
      onDisposed: () {
        LaravelEcho.instance.disconnect();
        leaveChannel();
      },
      child: Scaffold(
          // appBar: AuthHeader(
          //     title: LocaleKeys.MyConversations.tr(), isCanBack: true),
          body: Column(
            children: [
              Container(
                height: context.height * 0.17.h,
                margin: EdgeInsets.zero,
                child:AuthHeader(
                  isCanBack: true,
                  title:LocaleKeys.MyConversations.tr(),
                ),
              ),
              Expanded(
                child: BlocBuilder<AllConversationCubit, AllConversationsState>(
                  builder: (context, state) {
                    if (token == null) {
                      return LoginFirst();
                    } else if (allConversationsData.isGetAllConversationsData ==
                        false) {
                      return AdsShimmer();
                    } else if (state is GetAllConversationsErrorState) {
                      return CustomErrorWidget(reload: () {
                        context
                            .read<AllConversationCubit>()
                            .getAllConversationsDataUser(page: 1);
                      });
                    } else if (allConversationsData
                        .allConversationsModel.allConversationsData!.isEmpty) {
                      return Center(
                        child: Text(
                          LocaleKeys.noConversations.tr(),
                          style: openSansBold,
                        ),
                      );
                    }
                    return PaginatedListView(
                      last:
                          allConversationsData.allConversationsModel.meta!.lastPage!,
                      offset: allConversationsData
                          .allConversationsModel.meta!.currentPage!,
                      onPaginate: (int offset) async {
                        print(offset);
                        await allConversationsData.getAllConversationsDataUser(
                            page: offset);
                      },
                      scrollController: _controller,
                      totalSize:
                          allConversationsData.allConversationsModel.meta?.to ?? 15,
                      // reverse: true,
                      enabledPagination: true,
                      productView: ListView.separated(
                          shrinkWrap: true,
                          // reverse: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: allConversationsData
                              .allConversationsModel.allConversationsData!.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: context.width * 0.04.sp,
                              child: Divider(
                                color: darkGreyColor,
                                endIndent: context.width * 0.03.sp,
                                indent: context.width * 0.03.sp,
                                thickness: 1.2,
                              ),
                            );
                          },
                          itemBuilder: (context, index) {
                            return Container(
                              child: ListTile(
                                onTap: () {
                                  LaravelEcho.init(
                                      token: allConversationsData
                                          .allConversationsModel
                                          .allConversationsData![index]
                                          .receiver!
                                          .id
                                          .toString());
                                  navigateForward(ChatWithCustomerScreen(
                                    channelId: allConversationsData
                                            .allConversationsModel
                                            .allConversationsData![index]
                                            .receiver
                                            !.id.toString(),
                                    name: allConversationsData
                                            .allConversationsModel
                                            .allConversationsData![index]
                                            .receiver
                                            ?.name ??
                                        '',
                                  ));
                                },
                                leading: CircleAvatar(
                                  backgroundColor: transparentColor,
                                  radius: context.width * 0.1,
                                  backgroundImage: NetworkImage(allConversationsData
                                          .allConversationsModel
                                          .allConversationsData![index]
                                          .receiver
                                          ?.photo ??
                                      ''),
                                ),
                                title: Text(
                                  allConversationsData
                                          .allConversationsModel
                                          .allConversationsData![index]
                                          .receiver
                                          ?.name ??
                                      '',
                                  style: openSansBold.copyWith(color: darkGreyColor),
                                ),
                                subtitle: allConversationsData
                                            .allConversationsModel
                                            .allConversationsData![index]
                                            .lastMessage
                                            ?.messageType ==
                                        "media"
                                    ? Row(
                                        children: [
                                          SvgPicture.asset(Images.IMAGE_CHAT),
                                          SizedBox(
                                            width: context.width * 0.02,
                                          ),
                                          Text(
                                            LocaleKeys.image.tr(),
                                            style: openSansRegular.copyWith(
                                                color: darkGreyColor),
                                          )
                                        ],
                                      )
                                    : Text(
                                        allConversationsData
                                                .allConversationsModel
                                                .allConversationsData![index]
                                                .lastMessage
                                                ?.body ??
                                            '',
                                        style: openSansRegular.copyWith(
                                            color: darkGreyColor),
                                      ),
                                trailing: Text(
                                  allConversationsData
                                          .allConversationsModel
                                          .allConversationsData![index]
                                          .lastMessage
                                          ?.createDatesLastMessage
                                          ?.createdAtHuman ??
                                      '',
                                  style: openSansRegular.copyWith(color: goldColor),
                                ),
                              ),
                            );
                          }),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
