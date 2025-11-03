import '../../../../bloc/client_oder_cubit/current_order_cubit/cubit.dart';
import '../../../../bloc/client_oder_cubit/current_order_cubit/state.dart';
import '../../../../utils/app_constant.dart';
import '../../../../utils/media_query_value.dart';
import '../../../../view/base/lunch_widget.dart';
import '../../../../view/screens/my_orders/order_details_screen.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../base/guest_widget.dart';
import '../../../base/pagination_view.dart';
import '../../../base/shimmer/ads_shimmer.dart';
import '../../../error_widget/error_widget.dart';
import '../widget/order_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CurrentOrdersScreen extends StatefulWidget {
  const CurrentOrdersScreen({super.key});

  @override
  State<CurrentOrdersScreen> createState() => _CurrentOrdersScreenState();
}

class _CurrentOrdersScreenState extends State<CurrentOrdersScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    context.read<ClientCurrentOrderCubit>().getCurrentOrderClientModel(page: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentOrdersClientCubit = context.read<ClientCurrentOrderCubit>();
    return BlocBuilder<ClientCurrentOrderCubit, ClientCurrentOrderState>(
      builder: (context, state) {
        if(token==null) {
          return LoginFirst();
        }
        if (currentOrdersClientCubit.isGetCurrentOrder == false) {
          return AdsShimmer();
        }
        else if (currentOrdersClientCubit.currentOrderClientModel.data?.isEmpty==true) {
          return Center(
            child: Text(LocaleKeys.noData.tr()),
          );
        }
        else if (state is GetClientCurrentOrderErrorState) {
          return CustomErrorWidget(reload: () {
            currentOrdersClientCubit.getCurrentOrderClientModel(page: 1);
          });
        }
        else {
          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    // Replace this delay with the code to be executed during refresh
                    // and return a Future when code finishes execution.
                    await Future.delayed(const Duration(seconds: 1));
                    // context.read<SponsorAdsCubit>().getSponsorAds(page:1);
                    return currentOrdersClientCubit.getCurrentOrderClientModel(page: 1,);
                  },
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: PaginatedListView(
                      last: currentOrdersClientCubit
                          .currentOrderClientModel.meta?.lastPage??1,
                      offset: currentOrdersClientCubit
                              .currentOrderClientModel.meta?.currentPage??1,
                      onPaginate: (int offset) async {
                        print(offset);
                        await currentOrdersClientCubit.getCurrentOrderClientModel(
                          page: offset,
                        );
                      },
                      scrollController: _scrollController,
                      totalSize: currentOrdersClientCubit
                              .currentOrderClientModel.meta?.to ??
                          15,
                    //  reverse: true,
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
                                            // price: currentOrdersClientCubit
                                            //     .currentOrderClientModel
                                            //     .data?[index]
                                            //     .acceptedPriceOffers
                                            //     ?.price
                                            //     .toString() ??
                                            //     '',
                                            // serviceStatus: currentOrdersClientCubit
                                            //     .currentOrderClientModel
                                            //     .data?[index]
                                            //     .status ??
                                            //     '',
                                           // index: index,
                                            orderId: currentOrdersClientCubit
                                                .currentOrderClientModel
                                                .data?[index]
                                                .id.toString(),
                                            // orderStatus: 1,
                                            // lat: currentOrdersClientCubit
                                            //     .currentOrderClientModel
                                            //     .data?[index]
                                            //     .lat,
                                            // lng: currentOrdersClientCubit
                                            //     .currentOrderClientModel
                                            //     .data?[index]
                                            //     .lan,
                                            // location: currentOrdersClientCubit
                                            //     .currentOrderClientModel
                                            //     .data?[index]
                                            //     .locations,
                                            // name: currentOrdersClientCubit
                                            //     .currentOrderClientModel
                                            //     .data?[index]
                                            //     .userRequestServices
                                            //     ?.name ??
                                            //     '',
                                            // note: currentOrdersClientCubit
                                            //     .currentOrderClientModel
                                            //     .data?[index]
                                            //     .notes,
                                            // photo: currentOrdersClientCubit
                                            //     .currentOrderClientModel
                                            //     .data?[index]
                                            //     .userRequestServices
                                            //     ?.photo ??
                                            //     '',
                                            // photos: currentOrdersClientCubit
                                            //     .currentOrderClientModel
                                            //     .data?[index]
                                            //     .photos,
                                            // serviceId: currentOrdersClientCubit
                                            //     .currentOrderClientModel
                                            //     .data?[index]
                                            //     .servicesId
                                            //     ?.id
                                            //     .toString(),
                                            // serviceName: currentOrdersClientCubit
                                            //     .currentOrderClientModel
                                            //     .data?[index]
                                            //     .servicesId
                                            //     ?.name,
                                            // subServiceName: currentOrdersClientCubit
                                            //     .currentOrderClientModel
                                            //     .data?[index]
                                            //     .subServicesId
                                            //     ?.name,
                                          ));

                                        },
                                        child: OrderWidget(
                                          providerName: currentOrdersClientCubit
                                              .currentOrderClientModel.data?[index].acceptedPriceOffers?.provider?.name??'',
                                          providerRate: currentOrdersClientCubit
                                              .currentOrderClientModel.data?[index].acceptedPriceOffers?.providerRate.toString(),
                                          orderDate: currentOrdersClientCubit
                                              .currentOrderClientModel
                                              .data?[index]
                                              .date,
                                          orderNumber: currentOrdersClientCubit
                                              .currentOrderClientModel.data?[index].id
                                              .toString(),
                                          name: currentOrdersClientCubit
                                              .currentOrderClientModel.data?[index].userRequestServices?.name??'',
                                          orderStatus:LocaleKeys.currentOrder.tr() ,
                                          index: 0,
                                          orderTitle: currentOrdersClientCubit.currentOrderClientModel
                                                  .data?[index]
                                              .subServicesId?.name??''
                                              '' '',
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
                            itemCount: currentOrdersClientCubit.currentOrderClientModel.data!.length
                        ),
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
