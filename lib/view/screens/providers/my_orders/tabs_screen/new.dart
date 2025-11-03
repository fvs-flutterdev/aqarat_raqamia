import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:aqarat_raqamia/view/base/main_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/media_query_value.dart';
import '../../../../../../view/base/lunch_widget.dart';
import '../../../../../../view/base/pagination_view.dart';
import '../../../../../../view/screens/my_orders/widget/order_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../../bloc/profile_cubit/cubit.dart';
import '../../../../../bloc/provider_orders_cubit/cubit.dart';
import '../../../../../bloc/provider_orders_cubit/state.dart';
import '../../../../../translation/locale_keys.g.dart';
import '../../../../../utils/app_constant.dart';
import '../../../../base/shimmer/ads_shimmer.dart';
import '../../../../error_widget/error_widget.dart';
import '../../../my_orders/order_details_screen.dart';
import '../providers_order_details.dart';

class NewOrdersProviderScreen extends StatefulWidget {
  NewOrdersProviderScreen({super.key});

  @override
  State<NewOrdersProviderScreen> createState() =>
      _NewOrdersProviderScreenState();
}

class _NewOrdersProviderScreenState extends State<NewOrdersProviderScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    context.read<OrdersProviderCubit>().getPendingOrdersProvider(page: 1,context: context);
    super.initState();
  }

//  List<String> _locations = ['A', 'B', 'C', 'D'];
  @override
  Widget build(BuildContext context) {
    var ordersProviderCubit = context.read<OrdersProviderCubit>();
    return BlocConsumer<OrdersProviderCubit, ProviderOrdersState>(
      listener: (context,state){

      },
      builder: (context, state) {
        if (ordersProviderCubit.isPendingOrderGet == false) {
          return AdsShimmer();
        } else if (state is GetPendingOrdersProviderErrorState) {
          return CustomErrorWidget(reload: () {
            ordersProviderCubit.getPendingOrdersProvider(page: 1,context: context);
          });
        } else if (ordersProviderCubit.getPendingOrdersProviderPaginationModel.data!.isEmpty) {
          return Center(
            child: Text(LocaleKeys.noData.tr()),
          );
        } else {
          return Column(
            children: [
              // FilterDropDown(
              //   fct: (onChange) {
              //     print('??????????????????$onChange');
              //   },
              //   hint: 'جميع المناطق',
              //   isFlag: false,
              //   items: _locations
              //       .map((e) => DropdownMenuItem(
              //             child: Text(e),
              //             value: e,
              //           ))
              //       .toList(),
              // ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    // Replace this delay with the code to be executed during refresh
                    // and return a Future when code finishes execution.
                    await Future.delayed(const Duration(seconds: 1));
                    // context.read<SponsorAdsCubit>().getSponsorAds(page:1);
                    return  ordersProviderCubit.getPendingOrdersProvider(page: 1, context: context);
                  },

                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: PaginatedListView(
                      last: ordersProviderCubit.getPendingOrdersProviderPaginationModel.meta!.currentPage!,
                      offset: ordersProviderCubit.getPendingOrdersProviderPaginationModel.meta!.currentPage!,
                      onPaginate: (int offset) async {
                        print(offset);
                        await ordersProviderCubit.getPendingOrdersProvider(
                          context: context,
                          page: offset,
                        );
                      },
                      scrollController: _scrollController,
                      totalSize: ordersProviderCubit
                              .getPendingOrdersProviderPaginationModel
                              .meta
                              ?.to ??
                          15,
                     // reverse: true,
                      enabledPagination: true,
                      productView: AnimationLimiter(
                        child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            //   controller: _scrollController,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: Duration(milliseconds: 370),
                                  child: SlideAnimation(
                                    verticalOffset: 50,
                                    child: FadeInAnimation(
                                      child: GestureDetector(
                                        onTap: () {
                                          ordersProviderCubit
                                              .getPendingOrdersProviderPaginationModel
                                              .data?[index].userRequestServices?.id==userId?
                                          navigateForward(ClientOrderDetailsScreen(
                                            // isUser: true,
                                            // index: index,

                                            orderId: ordersProviderCubit
                                                .getPendingOrdersProviderPaginationModel
                                                .data?[index]
                                                .id.toString(),
                                            // orderStatus: 0,
                                            // isSent: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .isSent,
                                            // lat: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .lat,
                                            // lng: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .lan,
                                            // location: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .locations,
                                            // name: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .userRequestServices
                                            //     ?.name ??
                                            //     '',
                                            // note: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .notes,
                                            // photo: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .userRequestServices
                                            //     ?.photo ??
                                            //     '',
                                            // photos: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .photos,
                                            // serviceId: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .servicesId
                                            //     ?.id
                                            //     .toString(),
                                            // serviceName: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .servicesId
                                            //     ?.name,
                                            // subServiceName:
                                            // ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .subServicesId
                                            //     ?.name,
                                            //  ordersProvider: ordersProviderCubit.getPendingOrdersProviderPaginationModel.data?,
                                          ))
                                              :     navigateForward(OrderDetailsProvidersScreen(
                                            // isUser: true,
                                            // index: index,

                                            orderId: ordersProviderCubit
                                                .getPendingOrdersProviderPaginationModel
                                                .data?[index]
                                                .id.toString(),
                                            // orderStatus: 0,
                                            // isSent: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .isSent,
                                            // lat: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .lat,
                                            // lng: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .lan,
                                            // location: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .locations,
                                            // name: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .userRequestServices
                                            //     ?.name ??
                                            //     '',
                                            // note: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .notes,
                                            // photo: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .userRequestServices
                                            //     ?.photo ??
                                            //     '',
                                            // photos: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .photos,
                                            // serviceId: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .servicesId
                                            //     ?.id
                                            //     .toString(),
                                            // serviceName: ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .servicesId
                                            //     ?.name,
                                            // subServiceName:
                                            // ordersProviderCubit
                                            //     .getPendingOrdersProviderPaginationModel
                                            //     .data?[index]
                                            //     .subServicesId
                                            //     ?.name,
                                            //  ordersProvider: ordersProviderCubit.getPendingOrdersProviderPaginationModel.data?,
                                          ));
                                          // Get.to(
                                          //     () => );
                                        },
                                        child: OrderWidget(
                                            isFromSponsor: ordersProviderCubit
                                                .getPendingOrdersProviderPaginationModel.data?[index].orderType=="public"?false:true,
                                          isSentPriceOffer: ordersProviderCubit
                                              .getPendingOrdersProviderPaginationModel.data?[index].isSent,
                                          isCurrent: false,
                                          isMyOrder:  ordersProviderCubit
                                              .getPendingOrdersProviderPaginationModel
                                              .data?[index].userRequestServices?.id==userId?true:false,
                                          orderDate: ordersProviderCubit
                                              .getPendingOrdersProviderPaginationModel
                                              .data?[index]
                                              .date,
                                          orderNumber: ordersProviderCubit
                                              .getPendingOrdersProviderPaginationModel
                                              .data?[index]
                                              .id
                                              .toString(),
                                          orderStatus:LocaleKeys.newOrder.tr(),
                                          index: 0,
                                          orderTitle: ordersProviderCubit
                                                  .getPendingOrdersProviderPaginationModel
                                                  .data?[index]
                                              .subServicesId?.name??''
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
                            itemCount: ordersProviderCubit
                                .getPendingOrdersProviderPaginationModel
                                .data!
                                .length),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height:context.height * 0.04.h,),
            ],
          );
        }
      },
    );
  }
}
