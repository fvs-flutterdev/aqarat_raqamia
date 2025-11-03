import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/media_query_value.dart';
import '../../../../../../view/base/lunch_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../../bloc/provider_orders_cubit/provider_current_orders/cubit.dart';
import '../../../../../bloc/provider_orders_cubit/provider_current_orders/state.dart';
import '../../../../../translation/locale_keys.g.dart';
import '../../../../../utils/app_constant.dart';
import '../../../../base/pagination_view.dart';
import '../../../../base/shimmer/ads_shimmer.dart';
import '../../../../error_widget/error_widget.dart';
import '../../../my_orders/order_details_screen.dart';
import '../../../my_orders/widget/order_container.dart';
import '../providers_order_details.dart';

class CurrentOrdersProviderScreen extends StatefulWidget {
  CurrentOrdersProviderScreen({super.key});

  @override
  State<CurrentOrdersProviderScreen> createState() =>
      _CurrentOrdersProviderScreenState();
}

class _CurrentOrdersProviderScreenState extends State<CurrentOrdersProviderScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    context
        .read<CurrentProviderOrdersCubit>()
        .loadedCurrentOrdersProvider(page: 1);
    super.initState();
  }

  // void setupScrollController(context) {
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.atEdge) {
  //       if (_scrollController.position.pixels != 0) {
  //         // context.read<MyAdsCubit>().;
  //         BlocProvider.of<CurrentProviderOrdersCubit>(context)
  //             .loadedPreviousOrdersProvider();
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var currentOrdersProviders = context.read<CurrentProviderOrdersCubit>();
    // setupScrollController(context);
    // currentOrdersProviders.loadedPreviousOrdersProvider();
    // print(currentOrdersProviders.currentOrdersProvider.length);
    return BlocBuilder<CurrentProviderOrdersCubit, CurrentProviderOrdersState>(
      builder: (context, state) {
        if (currentOrdersProviders.isCurrentOrdersGet == false) {
          return AdsShimmer();
        }
        // List<CurrentOrdersProviders> currentOrdersProviderData = [];
        // if (state is GetCurrentOrdersProviderLoadingState) {
        //   currentOrdersProviderData = state.oldCurrentOrdersProvider;
        // } else if (state is GetCurrentOrdersProviderLoadedState) {
        //   currentOrdersProviderData = state.previousOrdersProviderPagination;
        //   print(currentOrdersProviderData.length);
        // }
        return state is GetCurrentOrdersProviderErrorState
            ? CustomErrorWidget(reload: () {
                currentOrdersProviders.loadedCurrentOrdersProvider(page: 1);
              })
            : currentOrdersProviders
                    .getCurrentOrdersProviderPaginationModel.data!.isEmpty
                ? Center(
                    child: Text(LocaleKeys.noData.tr()),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await Future.delayed(const Duration(seconds: 1));
                            return currentOrdersProviders
                                .loadedCurrentOrdersProvider(page: 1);
                          },
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: PaginatedListView(
                              last: currentOrdersProviders
                                  .getCurrentOrdersProviderPaginationModel
                                  .meta!
                                  .lastPage!,
                              offset: currentOrdersProviders
                                  .getCurrentOrdersProviderPaginationModel
                                  .meta!
                                  .currentPage!,
                              onPaginate: (int offset) async {
                                print(offset);
                                await currentOrdersProviders
                                    .loadedCurrentOrdersProvider(
                                  page: offset,
                                );
                              },
                              scrollController: _scrollController,
                              totalSize: currentOrdersProviders
                                      .getCurrentOrdersProviderPaginationModel
                                      .meta
                                      ?.to ??
                                  15,
                              // reverse: true,
                              enabledPagination: true,
                              productView: AnimationLimiter(
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    //  controller: _scrollController,
                                    itemBuilder: (context, index) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                              position: index,
                                              duration:
                                                  Duration(milliseconds: 370),
                                              child: SlideAnimation(
                                                verticalOffset: 50,
                                                child: FadeInAnimation(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      currentOrdersProviders
                                                                  .getCurrentOrdersProviderPaginationModel
                                                                  .data?[index]
                                                                  .userRequestServices
                                                                  ?.id ==
                                                              userId
                                                          ? navigateForward(
                                                              ClientOrderDetailsScreen(
                                                              // isUser: true,
                                                              // index: index,

                                                              orderId: currentOrdersProviders
                                                                  .getCurrentOrdersProviderPaginationModel
                                                                  .data?[index]
                                                                  .id
                                                                  .toString(),
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
                                                          : navigateForward(
                                                              OrderDetailsProvidersScreen(
                                                              //    isUser: true,
                                                              // userId:  currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?[index].userRequestServices?.id,
                                                              // index: index,
                                                              orderId: currentOrdersProviders
                                                                  .getCurrentOrdersProviderPaginationModel
                                                                  .data?[index]
                                                                  .id
                                                                  .toString(),
                                                              // orderStatus: 1,
                                                              // price:
                                                              // currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?[index]
                                                              //     .acceptedPriceOffers
                                                              //     ?.price
                                                              //     .toString(),
                                                              // commission:
                                                              // currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?[index]
                                                              //     .acceptedPriceOffers
                                                              //     ?.commission
                                                              //     .toString(),
                                                              // isSent: currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?[index].isSent,
                                                              // lat:
                                                              // currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?[index]
                                                              //     .lat,
                                                              // lng:
                                                              // currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?[index]
                                                              //     .lan,
                                                              // location:
                                                              // currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?[index]
                                                              //     .locations,
                                                              // name:
                                                              // currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?[index]
                                                              //     .userRequestServices
                                                              //     ?.name ??
                                                              //     '',
                                                              // note:
                                                              // currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?[index]
                                                              //     .notes,
                                                              // photo:
                                                              // currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?[index]
                                                              //     .userRequestServices
                                                              //     ?.photo ??
                                                              //     '',
                                                              // photos:
                                                              // currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?[index]
                                                              //     .photos,
                                                              // serviceId:
                                                              // currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?[index]
                                                              //     .servicesId
                                                              //     ?.id
                                                              //     .toString(),
                                                              // serviceName:
                                                              // currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?[index]
                                                              //     .servicesId
                                                              //     ?.name,
                                                              // subServiceName:
                                                              // currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?[index]
                                                              //     .subServicesId
                                                              //     ?.name,
                                                              //  ordersProvider: currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?,
                                                            ));
                                                    },
                                                    child: OrderWidget(
                                                        providerName: currentOrdersProviders
                                                            .getCurrentOrdersProviderPaginationModel.data?[index].acceptedPriceOffers?.provider?.name??'',
                                                        isFromSponsor:
                                                            currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?[index].orderType == "public"
                                                                ? false
                                                                : true,
                                                        isCurrent: currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?[index].userRequestServices?.id == userId
                                                            ? true
                                                            : false,
                                                        providerRate: currentOrdersProviders
                                                            .getCurrentOrdersProviderPaginationModel
                                                            .data?[index]
                                                            .acceptedPriceOffers
                                                            ?.provider
                                                            ?.rate
                                                            ?.toStringAsFixed(
                                                                1),
                                                        isMyOrder:
                                                            currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?[index].userRequestServices?.id == userId
                                                                ? true
                                                                : false,
                                                        orderDate: currentOrdersProviders
                                                            .getCurrentOrdersProviderPaginationModel
                                                            .data?[index]
                                                            .date,

                                                        orderNumber: currentOrdersProviders
                                                            .getCurrentOrdersProviderPaginationModel
                                                            .data?[index]
                                                            .id
                                                            .toString(),
                                                        orderStatus: LocaleKeys.currentOrder.tr(),
                                                        index: 1,
                                                        name: currentOrdersProviders
                                                            .getCurrentOrdersProviderPaginationModel
                                                            .data?[index].userRequestServices?.name??'',
                                                        orderTitle: currentOrdersProviders.getCurrentOrdersProviderPaginationModel.data?[index].subServicesId?.name ?? ''
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
                                    itemCount: currentOrdersProviders
                                        .getCurrentOrdersProviderPaginationModel
                                        .data!
                                        .length),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.height * 0.04.h,
                      ),
                    ],
                  );
      },
    );
  }
}
