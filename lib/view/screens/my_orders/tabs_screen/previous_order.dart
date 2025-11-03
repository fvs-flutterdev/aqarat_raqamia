import 'package:flutter/cupertino.dart';

import '../../../../bloc/client_oder_cubit/finished_order_cubit/cubit.dart';
import '../../../../bloc/client_oder_cubit/finished_order_cubit/state.dart';
import '../../../../utils/media_query_value.dart';
import '../../../../view/base/lunch_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/app_constant.dart';
import '../../../base/guest_widget.dart';
import '../../../base/pagination_view.dart';
import '../../../base/shimmer/ads_shimmer.dart';
import '../../../error_widget/error_widget.dart';
import '../order_details_screen.dart';
import '../widget/order_container.dart';

class PreviousOrdersScreen extends StatefulWidget {
  const PreviousOrdersScreen({super.key});

  @override
  State<PreviousOrdersScreen> createState() => _PreviousOrdersScreenState();
}

class _PreviousOrdersScreenState extends State<PreviousOrdersScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    context
        .read<ClientFinishedOrderCubit>()
        .getFinishedClientOrderState(page: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var finishedOrderClient = context.read<ClientFinishedOrderCubit>();
    return BlocBuilder<ClientFinishedOrderCubit, ClientFinishedOrderState>(
      // listener: (context,state){},
      builder: (context, state) {
        if (token == null) {
          return LoginFirst();
        } else if (finishedOrderClient.isGetFinishedOrder == false) {
          return AdsShimmer();
        } else if (finishedOrderClient.finishedOrderClientModel.data?.isEmpty ==
            true) {
          return Center(
            child: Text(LocaleKeys.noData.tr()),
          );
        } else if (state is GetClientFinishedOrderErrorState) {
          return CustomErrorWidget(reload: () {
            finishedOrderClient.getFinishedClientOrderState(page: 1);
          });
        } else {
          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    // Replace this delay with the code to be executed during refresh
                    // and return a Future when code finishes execution.
                    await Future.delayed(const Duration(seconds: 1));
                    // context.read<SponsorAdsCubit>().getSponsorAds(page:1);
                    return finishedOrderClient.getFinishedClientOrderState(page: 1,);
                  },
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: PaginatedListView(
                      last:
                          finishedOrderClient.finishedOrderClientModel.meta?.lastPage ??
                              1,
                      offset: finishedOrderClient
                              .finishedOrderClientModel.meta?.currentPage ??
                          1,
                      onPaginate: (int offset) async {
                        print(offset);
                        await finishedOrderClient.getFinishedClientOrderState(
                          page: offset,
                        );
                      },
                      scrollController: _scrollController,
                      totalSize:
                          finishedOrderClient.finishedOrderClientModel.meta?.to ?? 15,
                      // reverse: true,
                      enabledPagination: true,
                      productView: AnimationLimiter(
                        child: ListView.separated(
                            padding: EdgeInsetsDirectional.only(bottom: 56.0.h),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            //   controller: _scrollController,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration:const Duration(milliseconds: 370),
                                  child: SlideAnimation(
                                    verticalOffset: 50,
                                    child: FadeInAnimation(
                                      child: GestureDetector(
                                        onTap: () {
                                          navigateForward(ClientOrderDetailsScreen(
                                            // price: finishedOrderClient
                                            //     .finishedOrderClientModel
                                            //     .data?[index]
                                            //     .acceptedPriceOffers?.price.toString() ??
                                            //     '',
                                            // serviceStatus: finishedOrderClient
                                            //     .finishedOrderClientModel
                                            //     .data?[index]
                                            //     .status ??
                                            //     '',
                                            // index: index,
                                            orderId: finishedOrderClient
                                                    .finishedOrderClientModel
                                                    .data?[index]
                                                    .id.toString(),
                                            // orderStatus: 2,
                                            // lat: finishedOrderClient
                                            //     .finishedOrderClientModel
                                            //     .data?[index]
                                            //     .lat,
                                            // lng: finishedOrderClient
                                            //     .finishedOrderClientModel
                                            //     .data?[index]
                                            //     .lan,
                                            // location: finishedOrderClient
                                            //     .finishedOrderClientModel
                                            //     .data?[index]
                                            //     .locations,
                                            // name: finishedOrderClient
                                            //     .finishedOrderClientModel
                                            //     .data?[index]
                                            //     .userRequestServices
                                            //     ?.name ??
                                            //     '',
                                            // note: finishedOrderClient
                                            //     .finishedOrderClientModel
                                            //     .data?[index]
                                            //     .notes,
                                            // photo: finishedOrderClient
                                            //     .finishedOrderClientModel
                                            //     .data?[index]
                                            //     .userRequestServices
                                            //     ?.photo ??
                                            //     '',
                                            // photos: finishedOrderClient
                                            //     .finishedOrderClientModel
                                            //     .data?[index]
                                            //     .photos,
                                            // serviceId: finishedOrderClient
                                            //     .finishedOrderClientModel
                                            //     .data?[index]
                                            //     .servicesId
                                            //     ?.id
                                            //     .toString(),
                                            // serviceName: finishedOrderClient
                                            //     .finishedOrderClientModel
                                            //     .data?[index]
                                            //     .servicesId
                                            //     ?.name,
                                            // subServiceName: finishedOrderClient
                                            //     .finishedOrderClientModel
                                            //     .data?[index]
                                            //     .subServicesId
                                            //     ?.name,
                                          ));
                                        },
                                        child: OrderWidget(
                                          orderDate: finishedOrderClient
                                              .finishedOrderClientModel
                                              .data?[index]
                                              .date,
                                          providerName: finishedOrderClient
                                              .finishedOrderClientModel.data?[index].acceptedPriceOffers?.provider?.name??'',
                                        //  city: finishedOrderClient.finishedOrderClientModel.data?[index].locations?.padLeft(width),
                                          city:"${finishedOrderClient.finishedOrderClientModel.data?[index].country},${finishedOrderClient.finishedOrderClientModel.data?[index].cityName}",
                                          orderNumber: finishedOrderClient
                                              .finishedOrderClientModel.data?[index].id
                                              .toString(),
                                          orderStatus: LocaleKeys.previousOrder.tr(),
                                          index: 0,
                                          orderTitle: finishedOrderClient
                                                  .finishedOrderClientModel
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
                                height: context.width * 0.05.h,
                              );
                            },
                            itemCount: finishedOrderClient
                                .finishedOrderClientModel.data!.length),
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
        }
      },
    );
  }
}
