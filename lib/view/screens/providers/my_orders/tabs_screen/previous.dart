import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../../../utils/media_query_value.dart';
import '../../../../../../view/base/lunch_widget.dart';
import '../../../../../bloc/provider_orders_cubit/provider_old_orders_cubit/cubit.dart';
import '../../../../../bloc/provider_orders_cubit/provider_old_orders_cubit/state.dart';
import '../../../../../translation/locale_keys.g.dart';
import '../../../../../utils/app_constant.dart';
import '../../../../base/pagination_view.dart';
import '../../../../base/shimmer/ads_shimmer.dart';
import '../../../../error_widget/error_widget.dart';
import '../../../my_orders/order_details_screen.dart';
import '../../../my_orders/widget/order_container.dart';
import '../providers_order_details.dart';

class PreviousOrdersProviderScreen extends StatefulWidget {
  PreviousOrdersProviderScreen({super.key});

  @override
  State<PreviousOrdersProviderScreen> createState() =>
      _PreviousOrdersProviderScreenState();
}

class _PreviousOrdersProviderScreenState
    extends State<PreviousOrdersProviderScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    context
        .read<OldProviderOrdersCubit>()
        .loadedPreviousOrdersProvider(page: 1);
    super.initState();
  }

  // void setupScrollController(context) {
  @override
  Widget build(BuildContext context) {
    var oldOrdersProviderCubit = context.read<OldProviderOrdersCubit>();
    // setupScrollController(context);
    // oldOrdersProviderCubit.loadedPreviousOrdersProvider();
    return BlocBuilder<OldProviderOrdersCubit, OldProviderOrdersState>(
      builder: (context, state) {
        if (oldOrdersProviderCubit.isOldOrdersGet == false) {
          return AdsShimmer();
        }
        if (oldOrdersProviderCubit
            .getOldOrdersProviderPaginationModel.data!.isEmpty) {
          return Center(child: Text(LocaleKeys.noData.tr()));
        }

        // List<OldOrdersProviders> oldOrdersProviderData = [];
        // if (state is GetPreviousOrdersProviderLoadingState) {
        //   oldOrdersProviderData = state.oldPreviousOrdersProvider;
        // } else if (state is GetPreviousOrdersProviderLoadedState) {
        //   oldOrdersProviderData = state.previousOrdersProviderPagination;
        //   print(oldOrdersProviderData.length);
        // }

        return state is GetPreviousOrdersProviderErrorState
            ? CustomErrorWidget(reload: () {
                oldOrdersProviderCubit.loadedPreviousOrdersProvider(page: 1);
              })
            : Column(
                children: [
                  Expanded(
                    child:RefreshIndicator(
                      onRefresh: () async {
                        // Replace this delay with the code to be executed during refresh
                        // and return a Future when code finishes execution.
                        await Future.delayed(const Duration(seconds: 1));
                        // context.read<SponsorAdsCubit>().getSponsorAds(page:1);
                        return oldOrdersProviderCubit.loadedPreviousOrdersProvider(page: 1,);
                      },
                      child: SingleChildScrollView(
                        child: PaginatedListView(
                          last: oldOrdersProviderCubit
                              .getOldOrdersProviderPaginationModel
                              .meta!
                              .lastPage!,
                          offset: oldOrdersProviderCubit
                                  .getOldOrdersProviderPaginationModel
                                  .meta
                                  ?.currentPage ??
                              1,
                          onPaginate: (int offset) async {
                            print(offset);
                            await oldOrdersProviderCubit
                                .loadedPreviousOrdersProvider(
                              page: offset,
                            );
                          },
                          scrollController: _scrollController,
                          totalSize: oldOrdersProviderCubit
                                  .getOldOrdersProviderPaginationModel.meta?.to ??
                              15,
                          //  reverse: true,
                          enabledPagination: true,
                          productView: AnimationLimiter(
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                // controller: _scrollController,
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: Duration(milliseconds: 370),
                                    child: SlideAnimation(
                                      verticalOffset: 50,
                                      child: FadeInAnimation(
                                        child: GestureDetector(
                                          onTap: () {
                                            oldOrdersProviderCubit
                                                        .getOldOrdersProviderPaginationModel
                                                        .data?[index]
                                                        .userRequestServices
                                                        ?.id ==
                                                    userId
                                                ? navigateForward(
                                                    ClientOrderDetailsScreen(
                                                    // isUser: true,
                                                    // index: index,

                                                    orderId: oldOrdersProviderCubit
                                                            .getOldOrdersProviderPaginationModel
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
                                                : navigateForward(
                                                    OrderDetailsProvidersScreen(
                                                    // isUser: true,
                                                    // index: index,
                                                    orderId: oldOrdersProviderCubit
                                                            .getOldOrdersProviderPaginationModel
                                                            .data?[index]
                                                            .id.toString(),
                                                    // orderStatus: 2,
                                                    // // isSent: oldOrdersProviderData[index].isSent,
                                                    // lat: oldOrdersProviderCubit
                                                    //     .getOldOrdersProviderPaginationModel.data?[index].lat,
                                                    // lng: oldOrdersProviderCubit
                                                    //     .getOldOrdersProviderPaginationModel.data?[index].lan,
                                                    // location: oldOrdersProviderCubit
                                                    //     .getOldOrdersProviderPaginationModel.data?[index]
                                                    //     .locations,
                                                    // name: oldOrdersProviderCubit
                                                    //     .getOldOrdersProviderPaginationModel.data?[index]
                                                    //     .userRequestServices
                                                    //     ?.name ??
                                                    //     '',
                                                    // note:
                                                    // oldOrdersProviderCubit
                                                    //     .getOldOrdersProviderPaginationModel.data?[index].notes,
                                                    // photo: oldOrdersProviderCubit
                                                    //     .getOldOrdersProviderPaginationModel.data?[index]
                                                    //     .userRequestServices
                                                    //     ?.photo ??
                                                    //     '',
                                                    // photos:
                                                    // oldOrdersProviderCubit
                                                    //     .getOldOrdersProviderPaginationModel.data?[index].photos,
                                                    // serviceId: oldOrdersProviderCubit
                                                    //     .getOldOrdersProviderPaginationModel.data?[index]
                                                    //     .servicesId
                                                    //     ?.id
                                                    //     .toString(),
                                                    // serviceName:
                                                    // oldOrdersProviderCubit
                                                    //     .getOldOrdersProviderPaginationModel.data?[index]
                                                    //     .servicesId
                                                    //     ?.name,
                                                    // subServiceName:
                                                    // oldOrdersProviderCubit
                                                    //     .getOldOrdersProviderPaginationModel.data?[index]
                                                    //     .subServicesId
                                                    //     ?.name,
                                                    // userId: oldOrdersProviderCubit
                                                    //     .getOldOrdersProviderPaginationModel.data?[index]
                                                    //     .userRequestServices
                                                    //     ?.id,
                                                    //  ordersProvider: pendingOrdersProviderData,
                                                  ));
                                          },
                                          child: OrderWidget(
                                              isFromSponsor: oldOrdersProviderCubit
                                                  .getOldOrdersProviderPaginationModel.data?[index].orderType=="public"?false:true,
                                            isCurrent: false,
                                            isMyOrder:   oldOrdersProviderCubit
                                                .getOldOrdersProviderPaginationModel
                                                .data?[index].userRequestServices?.id==userId?true:false,
                                            orderDate: oldOrdersProviderCubit
                                                .getOldOrdersProviderPaginationModel
                                                .data?[index]
                                                .date,

                                            orderNumber: oldOrdersProviderCubit
                                                .getOldOrdersProviderPaginationModel
                                                .data?[index]
                                                .id
                                                .toString(),
                                            name: oldOrdersProviderCubit
                                                .getOldOrdersProviderPaginationModel
                                                .data?[index].userRequestServices?.name??'',

                                            city: "${oldOrdersProviderCubit.getOldOrdersProviderPaginationModel.data?[index].country} , ${oldOrdersProviderCubit.getOldOrdersProviderPaginationModel.data?[index].cityName}",
                                              providerName:oldOrdersProviderCubit
                                                  .getOldOrdersProviderPaginationModel
                                                  .data?[index].acceptedPriceOffers?.provider?.name??'',
                                            orderStatus:
                                                LocaleKeys.previousOrder.tr(),
                                            index: 2,
                                            orderTitle: oldOrdersProviderCubit
                                                    .getOldOrdersProviderPaginationModel
                                                    .data?[index].subServicesId?.name??''
                                                //     .servicesId
                                                //     ?.name ??
                                                // '' '',
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: context.width * 0.05,
                                  );
                                },
                                itemCount: oldOrdersProviderCubit
                                    .getOldOrdersProviderPaginationModel
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
