import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../bloc/notification_cubit/cubit.dart';
import '../../../../../bloc/notification_cubit/state.dart';
import '../../../../../utils/media_query_value.dart';
import '../../../../../utils/text_style.dart';
import '../../../../../view/base/auth_header.dart';
import '../../../../../view/base/pagination_view.dart';
import '../../../../../view/base/shimmer/ads_shimmer.dart';
import '../../../../../view/error_widget/error_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/images.dart';
import '../../base/guest_widget.dart';
import '../chat/chat_with_client.dart';
import '../my_orders/order_details_screen.dart';
import '../providers/my_orders/providers_order_details.dart';

class NotificationScreen extends StatelessWidget {
  // const NotificationScreen({super.key});
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var notificationCubit = context.read<NotificationCubit>();
    return Scaffold(
     // appBar: AuthHeader(title: LocaleKeys.notifications.tr()),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(title: LocaleKeys.notifications.tr()),
          ),
          Expanded(
            child: BlocConsumer<NotificationCubit, NotificationState>(
              bloc: notificationCubit.getNotificationData(page: 1),
              listener: (context, state) {},
              builder: (context, state) {
                if (token == null) {
                  return LoginFirst();
                } else if (notificationCubit.isGetNotification == false) {
                  return AdsShimmer();
                } else if (state is GetNotificationErrorState) {
                  return CustomErrorWidget(reload: () {
                    notificationCubit.getNotificationData(page: 1);
                  });
                } else if (notificationCubit.notificationsModel.data!.isEmpty) {
                  return Center(
                    child: Text(LocaleKeys.noData.tr()),
                  );
                } else {
                  return SingleChildScrollView(
                    controller: _scrollController,
                    child: PaginatedListView(
                      last: notificationCubit.notificationsModel.meta!.lastPage!,
                      scrollController: _scrollController,
                      onPaginate: (int offset) async {
                        await notificationCubit.getNotificationData(page: offset);
                      },
                      totalSize: notificationCubit.notificationsModel.meta?.to ?? 15,
                      enabledPagination: true,
                      offset: notificationCubit.notificationsModel.meta!.currentPage!,
                      productView: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                if (notificationCubit
                                    .notificationsModel.data!.isNotEmpty) {
                                  if (notificationCubit.notificationsModel.data?[index].payLoadData?.notificationType ==
                                      "message") {
                                    navigateForward(ChatWithCustomerScreen(
                                      channelId: notificationCubit.notificationsModel
                                          .data?[index].payLoadData?.senderId,
                                      name: notificationCubit.notificationsModel
                                              .data?[index].payLoadData?.senderName ??
                                          '',
                                    ));
                                  } else if (notificationCubit
                                          .notificationsModel
                                          .data?[index]
                                          .payLoadData
                                          ?.notificationType ==
                                      "offer") {
                                    if (notificationCubit.notificationsModel
                                            .data?[index].payLoadData?.receiverId ==
                                        userId.toString()) {
                                      navigateForward(ClientOrderDetailsScreen(
                                        orderId: notificationCubit.notificationsModel
                                            .data?[index].payLoadData?.chatRoomId,
                                      ));
                                    } else if (notificationCubit.notificationsModel
                                            .data?[index].payLoadData?.receiverId !=
                                        userId.toString()) {
                                      navigateForward(OrderDetailsProvidersScreen(
                                        orderId: notificationCubit.notificationsModel
                                            .data?[index].payLoadData?.chatRoomId,
                                      ));
                                    }
                                  } else {
                                    navigateForward(NotificationScreen());
                                  }
                                  // if(notificationCubit.notificationsModel.data?[index].payLoadData?.requestedService?.userId==userId&&accountType=="service_provider"){
                                  //   navigateForward(ClientOrderDetailsScreen(
                                  //     orderId: notificationCubit.notificationsModel
                                  //         .data![index].payLoadData?.requestServiceId,
                                  //   ));
                                  // }else if(accountType=="service_provider"&&notificationCubit.notificationsModel.data?[index].payLoadData?.requestedService?.userId!=userId){
                                  //   navigateForward(ClientOrderDetailsScreen(
                                  //     orderId: notificationCubit.notificationsModel
                                  //         .data![index].payLoadData?.requestServiceId.toString(),
                                  //   ));
                                  // }else {
                                  //   navigateForward(OrderDetailsProvidersScreen(
                                  //     orderId: notificationCubit.notificationsModel
                                  //         .data![index].payLoadData?.requestServiceId,
                                  //   ));
                                  // }
                                } else {
                                  debugPrint('');
                                }

                                // ?
                                // : debugPrint('');
                              },
                              child: Container(
                                height: context.height * 0.12,
                                child: ListTile(
                                  leading: SvgPicture.asset(Images.NOTIFICATIONS_SVG),
                                  title: Text(
                                    notificationCubit
                                            .notificationsModel.data![index].title ??
                                        '',
                                    maxLines: 1,
                                    style:
                                        openSansBlack.copyWith(color: darkGreyColor),
                                  ),
                                  subtitle: Text(
                                    notificationCubit
                                            .notificationsModel.data![index].body ??
                                        '',
                                    maxLines: 1,
                                    style:
                                        openSansBlack.copyWith(color: darkGreyColor),
                                  ),
                                  trailing: Text(
                                    notificationCubit.notificationsModel.data![index]
                                            .createDates?.createdAtHuman ??
                                        '',
                                    style: openSansMedium.copyWith(
                                        color: whiteGreyColor),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount:
                              notificationCubit.notificationsModel.data!.length),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
