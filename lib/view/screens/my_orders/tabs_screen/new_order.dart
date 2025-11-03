import 'package:flutter/cupertino.dart';

import '../../../../utils/media_query_value.dart';
import '../../../../view/base/lunch_widget.dart';
import '../../../../view/screens/my_orders/widget/order_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../bloc/client_oder_cubit/new_oder_cubit/cubit.dart';
import '../../../../bloc/client_oder_cubit/new_oder_cubit/state.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/app_constant.dart';
import '../../../base/guest_widget.dart';
import '../../../base/pagination_view.dart';
import '../../../base/shimmer/ads_shimmer.dart';
import '../../../error_widget/error_widget.dart';
import '../order_details_screen.dart';

class NewOrdersScreen extends StatefulWidget {
  const NewOrdersScreen({super.key});

  @override
  State<NewOrdersScreen> createState() => _NewOrdersScreenState();
}

class _NewOrdersScreenState extends State<NewOrdersScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    context.read<NewOrdersClientCubit>().getNewClientOrders(page: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var newOrdersClientCubit = context.read<NewOrdersClientCubit>();
    return BlocBuilder<NewOrdersClientCubit, NewOrdersClientState>(
      builder: (context, state) {
        if (token == null) {
          return LoginFirst();
        } else if (newOrdersClientCubit.isGetNewOrders == false) {
          return AdsShimmer();
        } else if (state is GetNewOrderClientErrorState) {
          return CustomErrorWidget(reload: () {
            newOrdersClientCubit.getNewClientOrders(page: 1);
          });
        } else if (newOrdersClientCubit.newOrderClientModel.data?.isEmpty ==
            true) {
          return Center(
            child: Text(LocaleKeys.noData.tr()),
          );
        } else {
          return
              // Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // children: [
              //   Container(
              //       width: double.infinity,
              //       decoration: BoxDecoration(color: redColor),child: Text(
              //       'إجمالي عدد الطلبات الجديدة : ${newOrdersClientCubit.newOrderClientModel.meta?.total.toString()}',
              //     textAlign: TextAlign.center,
              //     style: openSansBold.copyWith(color: whiteColor),)),
              //   Expanded(
              //     child:
              Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    // Replace this delay with the code to be executed during refresh
                    // and return a Future when code finishes execution.
                    await Future.delayed(const Duration(seconds: 1));
                    // context.read<SponsorAdsCubit>().getSponsorAds(page:1);
                    return newOrdersClientCubit.getNewClientOrders(
                      page: 1,
                    );
                  },
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: PaginatedListView(
                      last: newOrdersClientCubit
                              .newOrderClientModel.meta?.lastPage ??
                          1,
                      offset: newOrdersClientCubit
                              .newOrderClientModel.meta?.currentPage ??
                          1,
                      onPaginate: (int offset) async {
                        print(offset);
                        await newOrdersClientCubit.getNewClientOrders(
                          page: offset,
                        );
                      },
                      scrollController: _scrollController,
                      totalSize:
                          newOrdersClientCubit.newOrderClientModel.meta?.to ??
                              15,
                      //  reverse: true,
                      enabledPagination: true,
                      productView: AnimationLimiter(
                        child:
                            //     CustomScrollView(
                            //       physics: NeverScrollableScrollPhysics(),
                            //   shrinkWrap: true,
                            //
                            //   slivers: [
                            //
                            //     SliverList.separated(
                            //
                            //       separatorBuilder: (context,index){
                            //               return SizedBox(
                            //                 height:newOrdersClientCubit.newOrderClientModel.data!.last==true?56.0.h: context.width * 0.05.h,
                            //               );
                            //       },
                            //       itemCount: newOrdersClientCubit.newOrderClientModel.data!.length,
                            //
                            //       itemBuilder: (context, index) {
                            //         return AnimationConfiguration.staggeredList(
                            //             position: index,
                            //
                            //             duration: Duration(milliseconds: 370),
                            //             child: SlideAnimation(
                            //               verticalOffset: 50,
                            //               child: FadeInAnimation(
                            //                 child: GestureDetector(
                            //                   onTap: () {
                            //                     navigateForward(ClientOrderDetailsScreen(
                            //                       // serviceStatus: newOrdersClientCubit
                            //                       //     .newOrderClientModel
                            //                       //     .data?[index]
                            //                       //     .status ??
                            //                       //     '',
                            //                       // index: index,
                            //                       orderId: newOrdersClientCubit
                            //                               .newOrderClientModel
                            //                               .data?[index]
                            //                               .id ??
                            //                           0,
                            //                       // orderStatus: 0,
                            //                       // lat: newOrdersClientCubit
                            //                       //     .newOrderClientModel
                            //                       //     .data?[index]
                            //                       //     .lat,
                            //                       // lng: newOrdersClientCubit
                            //                       //     .newOrderClientModel
                            //                       //     .data?[index]
                            //                       //     .lan,
                            //                       // location: newOrdersClientCubit
                            //                       //     .newOrderClientModel
                            //                       //     .data?[index]
                            //                       //     .locations,
                            //                       // name: newOrdersClientCubit
                            //                       //     .newOrderClientModel
                            //                       //     .data?[index]
                            //                       //     .userRequestServices
                            //                       //     ?.name ??
                            //                       //     '',
                            //                       // note: newOrdersClientCubit
                            //                       //     .newOrderClientModel
                            //                       //     .data?[index]
                            //                       //     .notes,
                            //                       // photo: newOrdersClientCubit
                            //                       //     .newOrderClientModel
                            //                       //     .data?[index]
                            //                       //     .userRequestServices
                            //                       //     ?.photo ??
                            //                       //     '',
                            //                       // photos: newOrdersClientCubit
                            //                       //     .newOrderClientModel
                            //                       //     .data?[index]
                            //                       //     .photos,
                            //                       // serviceId: newOrdersClientCubit
                            //                       //     .newOrderClientModel
                            //                       //     .data?[index]
                            //                       //     .servicesId
                            //                       //     ?.id
                            //                       //     .toString(),
                            //                       // serviceName: newOrdersClientCubit
                            //                       //     .newOrderClientModel
                            //                       //     .data?[index]
                            //                       //     .servicesId
                            //                       //     ?.name,
                            //                       // subServiceName: newOrdersClientCubit
                            //                       //     .newOrderClientModel
                            //                       //     .data?[index]
                            //                       //     .subServicesId
                            //                       //     ?.name,
                            //                     ));
                            //                   },
                            //                   child: OrderWidget(
                            //                     orderDate: newOrdersClientCubit
                            //                         .newOrderClientModel.data?[index].date,
                            //                     orderNumber: newOrdersClientCubit
                            //                         .newOrderClientModel.data?[index].id
                            //                         .toString(),
                            //                     orderStatus: LocaleKeys.newOrder.tr(),
                            //                     index: 0,
                            //                     orderTitle: newOrdersClientCubit
                            //                             .newOrderClientModel
                            //                             .data?[index]
                            //                             .servicesId
                            //                             ?.name ??
                            //                         '' '',
                            //                   ),
                            //                 ),
                            //               ),
                            //             ));
                            //       },
                            //     ),
                            //
                            //   ],
                            // )
                            ///
                            ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding:
                                    EdgeInsetsDirectional.only(bottom: 56.0.h),
                                //   controller: _scrollController,
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 370),
                                      child: SlideAnimation(
                                        verticalOffset: 50,
                                        child: FadeInAnimation(
                                          child: GestureDetector(
                                            onTap: () {
                                              navigateForward(
                                                  ClientOrderDetailsScreen(
                                                // serviceStatus: newOrdersClientCubit
                                                //     .newOrderClientModel
                                                //     .data?[index]
                                                //     .status ??
                                                //     '',
                                                // index: index,
                                                orderId: newOrdersClientCubit
                                                    .newOrderClientModel
                                                    .data?[index]
                                                    .id
                                                    .toString(),
                                                // orderStatus: 0,
                                                // lat: newOrdersClientCubit
                                                //     .newOrderClientModel
                                                //     .data?[index]
                                                //     .lat,
                                                // lng: newOrdersClientCubit
                                                //     .newOrderClientModel
                                                //     .data?[index]
                                                //     .lan,
                                                // location: newOrdersClientCubit
                                                //     .newOrderClientModel
                                                //     .data?[index]
                                                //     .locations,
                                                // name: newOrdersClientCubit
                                                //     .newOrderClientModel
                                                //     .data?[index]
                                                //     .userRequestServices
                                                //     ?.name ??
                                                //     '',
                                                // note: newOrdersClientCubit
                                                //     .newOrderClientModel
                                                //     .data?[index]
                                                //     .notes,
                                                // photo: newOrdersClientCubit
                                                //     .newOrderClientModel
                                                //     .data?[index]
                                                //     .userRequestServices
                                                //     ?.photo ??
                                                //     '',
                                                // photos: newOrdersClientCubit
                                                //     .newOrderClientModel
                                                //     .data?[index]
                                                //     .photos,
                                                // serviceId: newOrdersClientCubit
                                                //     .newOrderClientModel
                                                //     .data?[index]
                                                //     .servicesId
                                                //     ?.id
                                                //     .toString(),
                                                // serviceName: newOrdersClientCubit
                                                //     .newOrderClientModel
                                                //     .data?[index]
                                                //     .servicesId
                                                //     ?.name,
                                                // subServiceName: newOrdersClientCubit
                                                //     .newOrderClientModel
                                                //     .data?[index]
                                                //     .subServicesId
                                                //     ?.name,
                                              ));
                                            },
                                            child: OrderWidget(
                                              orderDate: newOrdersClientCubit
                                                  .newOrderClientModel
                                                  .data?[index]
                                                  .date,
                                              orderNumber: newOrdersClientCubit
                                                  .newOrderClientModel
                                                  .data?[index]
                                                  .id
                                                  .toString(),
                                              orderStatus:
                                                  LocaleKeys.newOrder.tr(),
                                              index: 0,
                                              orderTitle: newOrdersClientCubit
                                                      .newOrderClientModel
                                                      .data?[index].subServicesId?.name??''
                                                      // .servicesId
                                                      // ?.name ??
                                                 // '' '',
                                            ),
                                          ),
                                        ),
                                      ));
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: context.width * 0.05,
                                  );
                                },
                                itemCount: newOrdersClientCubit
                                    .newOrderClientModel.data!.length),
                      ),
                    ),
                    // ),
                    //   ),
                    // ],
                  ),
                ),
              ),
              SizedBox(
                height: context.height * 0.04.h,
              ),
            ],
          );
        }
      },
    );
  }
}
