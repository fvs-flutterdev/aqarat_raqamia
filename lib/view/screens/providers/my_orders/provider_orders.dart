import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../bloc/provider_orders_cubit/provider_current_orders/state.dart';
import '../../../../../bloc/provider_orders_cubit/provider_old_orders_cubit/state.dart';
import '../../../../../bloc/region_cubit/cubit.dart';
import '../../../../../bloc/region_cubit/state.dart';
import '../../../../../utils/media_query_value.dart';
import '../../../../../view/screens/providers/my_orders/tabs_screen/current.dart';
import '../../../../../view/screens/providers/my_orders/tabs_screen/new.dart';
import '../../../../../view/screens/providers/my_orders/tabs_screen/previous.dart';
import '../../../../bloc/auth_cubit/auth_provider/cubit.dart';
import '../../../../bloc/provider_orders_cubit/cubit.dart';
import '../../../../bloc/provider_orders_cubit/provider_current_orders/cubit.dart';
import '../../../../bloc/provider_orders_cubit/provider_old_orders_cubit/cubit.dart';
import '../../../../bloc/provider_orders_cubit/state.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/text_style.dart';
import '../../../base/auth_header.dart';
import '../../../base/custom_bottom_sheet.dart';
import '../../../base/custom_drop_down.dart';

class MyOrdersProviders extends StatefulWidget {
  const MyOrdersProviders({super.key});

  @override
  State<MyOrdersProviders> createState() => _MyOrdersProvidersState();
}

class _MyOrdersProvidersState extends State<MyOrdersProviders>
    with SingleTickerProviderStateMixin {
  // var navController=Get.find<NavBarController>();
  late TabController tabController;

  void setTabActive() {
    context
        .read<OrdersProviderCubit>()
        .changeTabBarIndexProvider(value: tabController.index);
    // navController.changeTabBarIndex(value: tabController.index);
  }

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: 3,
        vsync: this,
        initialIndex: context.read<OrdersProviderCubit>().indexTabProvider);
    tabController.addListener(setTabActive);
  }

  @override
  Widget build(BuildContext context) {
    var orderProviderCubit = context.read<OrdersProviderCubit>();
    var registerCubit = context.read<RegisterProviderCubit>();
    var currentOrdersProviders = context.read<CurrentProviderOrdersCubit>();
    var oldOrdersProviderCubit = context.read<OldProviderOrdersCubit>();
    var regionCubit = context.read<RegionsCubit>();
    //  regionCubit.regionIdFilter=null;
    return BlocBuilder<OrdersProviderCubit, ProviderOrdersState>(
      builder: (context, state) {
        return BlocBuilder<CurrentProviderOrdersCubit,
            CurrentProviderOrdersState>(
          builder: (context, state) {
            return BlocBuilder<OldProviderOrdersCubit, OldProviderOrdersState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Container(
                        margin:
                            EdgeInsets.only(bottom: context.height * 0.01.sp),
                        height: context.height * 0.17.sp,
                        child: AuthHeader(
                          isCanBack: false,
                          title: LocaleKeys.myOrders.tr(),
                        )),
                    orderProviderCubit.indexTabProvider == 0
                        ? regionCubit.isGetRegion == true
                            ? Padding(
                                padding: EdgeInsetsDirectional.only(
                                    start: context.width * 0.02,
                                    end: context.width * 0.02),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: BlocBuilder<RegionsCubit,
                                          RegionState>(
                                        // listener: (context, state) {},
                                        builder: (context, state) {
                                          return CustomDropDown(
                                              topPadding: 0.0,
                                              items: regionCubit
                                                  .allRegionsModel.data!
                                                  .map((e) {
                                                return DropdownMenuItem(
                                                  child: Text(e.name ?? ''),
                                                  value: e.regionId,
                                                );
                                              }).toList(),
                                              value: regionCubit.regionIdFilter,
                                              fct: (onChange) {
                                                regionCubit
                                                    .onChangeRegionIdFilter(
                                                        onChange);
                                                regionCubit.regionIdFilter == 0
                                                    ? context
                                                        .read<
                                                            OrdersProviderCubit>()
                                                        .getPendingOrdersProvider(
                                                            page: 1,
                                                            context: context,
                                                            cityId: [])
                                                    : regionCubit
                                                        .getCitiesByRegionId(
                                                            context: context,
                                                            page: 1,
                                                            regionId: regionCubit
                                                                    .regionIdFilter ??
                                                                0)
                                                        .then((value) {
                                                        if (regionCubit
                                                                .regionIdFilter ==
                                                            0) {
                                                          // setState(() {
                                                          //   context.read<RegionsCubit>().cities=[];
                                                          // });
                                                          // print(
                                                          //     '<<<<<<<<<${context.read<RegionsCubit>().cities}>>>asdasdasdasdas>>>>>>');
                                                          // regionCubit.
                                                          context
                                                              .read<
                                                                  OrdersProviderCubit>()
                                                              .getPendingOrdersProvider(
                                                                  page: 1,
                                                                  context:
                                                                      context,
                                                                  cityId: []);
                                                        } else {
                                                          CustomBottomSheet(
                                                              context: context,
                                                              regionFilter:
                                                                  regionCubit
                                                                          .regionIdFilter ??
                                                                      0,
                                                              controller:
                                                                  _scrollController,
                                                              confirm: () {
                                                                Navigator.pop(
                                                                    context);
                                                                print(
                                                                    '<<<<<<<<<<<<${regionCubit.cities.isEmpty}>>>>>>>>>>>>');
                                                                if (regionCubit
                                                                        .cities
                                                                        .isEmpty ==
                                                                    true) {
                                                                  orderProviderCubit.getPendingOrdersProvider(
                                                                      page: 1,
                                                                      context:
                                                                          context,
                                                                      regionId:
                                                                          regionCubit
                                                                              .regionIdFilter,
                                                                      cityId: regionCubit
                                                                          .cities);
                                                                } else {
                                                                  orderProviderCubit.getPendingOrdersProvider(
                                                                      regionId:
                                                                          regionCubit
                                                                              .regionIdFilter,
                                                                      cityId: regionCubit
                                                                          .cities,
                                                                      page: 1,
                                                                      context:
                                                                          context);
                                                                }
                                                              });
                                                        }
                                                      });
                                                print(onChange);
                                              },
                                              hint: LocaleKeys.region.tr());
                                        },
                                      ),
                                    ),
                                    // SizedBox(width: context.width*0.02,),
                                    // registerCubit.isGetServices==false|| registerCubit.isGetServices==null?SizedBox():
                                    // Expanded(
                                    //   child: BlocBuilder<RegisterProviderCubit, ProviderRegisterState>(
                                    //     // listener: (context, state) {},
                                    //     builder: (context, state) {
                                    //       return CustomDropDown(
                                    //           topPadding: 0.0,
                                    //           items: registerCubit
                                    //               .providerRegisterEntityModel.services!
                                    //               .map((e) {
                                    //             return DropdownMenuItem(
                                    //               child: Text(e.name ?? ''),
                                    //               value: e.id,
                                    //             );
                                    //           }).toList(),
                                    //           value: registerCubit.serviceIdFilter,
                                    //           fct: (onChange) {
                                    //             registerCubit
                                    //                 .onChangeServiceIdFilter(
                                    //                 onChange);
                                    //
                                    //               //}
                                    //
                                    //             print(onChange);
                                    //           },
                                    //           hint: LocaleKeys.services.tr());
                                    //       // return FilterDropDown(
                                    //       //   fct: (onChange) async {
                                    //       //     regionCubit.onChangeRegionId(onChange);
                                    //       //     print(
                                    //       //         '??????????????????${regionCubit.regionId}');
                                    //       //     regionCubit.regionId == 0
                                    //       //         ? context
                                    //       //         .read<OrdersProviderCubit>()
                                    //       //         .getPendingOrdersProvider(
                                    //       //         page: 1, context: context)
                                    //       //         : regionCubit
                                    //       //         .getCitiesByRegionId(
                                    //       //         regionId: regionCubit.regionId!,
                                    //       //         page: 1, context: context)
                                    //       //         .then((value) {
                                    //       //       // if(regionCubit.regionId == 0){
                                    //       //       //   context.read<OrdersProviderCubit>().getPendingOrdersProvider(page: 1,context: context);
                                    //       //       // }else {
                                    //       //       CustomBottomSheet(
                                    //       //           context: context,
                                    //       //           controller: _scrollController,
                                    //       //           confirm: () {
                                    //       //             Navigator.pop(context);
                                    //       //             orderProviderCubit
                                    //       //                 .getPendingOrdersProvider(
                                    //       //                 page: 1,
                                    //       //                 context: context);
                                    //       //           });
                                    //       //       //}
                                    //       //     });
                                    //       //   },
                                    //       //   hint: LocaleKeys.allCity.tr(),
                                    //       //   isFlag: false,
                                    //       //   items: regionCubit.allRegionsModel.data!
                                    //       //       .map((e) => DropdownMenuItem(
                                    //       //     child: Text(e.name.toString()),
                                    //       //     value: e.regionId,
                                    //       //   ))
                                    //       //       .toList(),
                                    //       // );
                                    //     },
                                    //   ),
                                    // ),
                                  ],
                                ),
                              )
                            : const SizedBox()
                        : const SizedBox(),
                    // orderProviderCubit.regionId == null
                    //     ? SizedBox()
                    //     : FilterDropDown(
                    //         fct: (onChange) {
                    //          // orderProviderCubit.onChangeRegionId(onChange);
                    //           print('??????????????????${onChange}');
                    //         },
                    //         hint: 'جميع المناطق',
                    //         isFlag: false,
                    //         items: orderProviderCubit.cityByRegionIdModel.data!
                    //             .map((e) => DropdownMenuItem(
                    //                   child: Text(e.name??'جميع المناطق'),
                    //                   value: e.cityId??'جميع المناطق',
                    //                 ))
                    //             .toList(),
                    //       ),
                    Container(
                      height: context.height * 0.09,
                      decoration: BoxDecoration(
                        color: lightYellowColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TabBar(
                          controller: tabController,
                          indicatorPadding: EdgeInsets.all(8),
                          labelStyle: openSansMedium,
                          // unselectedLabelColor: darkGreyColor,
                          indicator: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(15),
                              color: whiteColor),
                          labelColor: goldColor,
                          indicatorColor: whiteColor,
                          tabs: [
                            Tab(
                              iconMargin:
                                  EdgeInsetsDirectional.only(bottom: 0.sp),
                              icon: Text(LocaleKeys.New.tr()),
                              text: orderProviderCubit.isPendingOrderGet ==
                                      false
                                  ? ""
                                  : "(${orderProviderCubit.getPendingOrdersProviderPaginationModel.meta!.total.toString()})",
                            ),
                            Tab(
                              iconMargin:
                                  EdgeInsetsDirectional.only(bottom: 0.sp),
                              icon: Text(LocaleKeys.current.tr()),
                              text: currentOrdersProviders.isCurrentOrdersGet ==
                                      false
                                  ? ""
                                  : "(${currentOrdersProviders.getCurrentOrdersProviderPaginationModel.meta!.total.toString()})",
                            ),
                            Tab(
                              iconMargin:
                                  EdgeInsetsDirectional.only(bottom: 0.sp),
                              icon: Text(LocaleKeys.previous.tr()),
                              text: oldOrdersProviderCubit.isOldOrdersGet ==
                                      false
                                  ? ""
                                  : "(${oldOrdersProviderCubit.getOldOrdersProviderPaginationModel.meta!.total.toString()})",
                            )
                          ]),
                    ),

                    Expanded(
                        child: TabBarView(
                      controller: tabController,
                      children: [
                        NewOrdersProviderScreen(),
                        CurrentOrdersProviderScreen(),
                        PreviousOrdersProviderScreen(),
                      ],
                    ))
                  ],
                );
                //   BlocConsumer<NavbarCubit, BottomNavbarState>(
                //   listener: (context, state) {
                //     // TODO: implement listener
                //   },
                //   builder: (context, state) {
                //     return
                //   },
                // );
              },
            );
          },
        );
      },
    );
  }
}
