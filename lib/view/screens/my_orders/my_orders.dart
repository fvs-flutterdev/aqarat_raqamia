import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/view/base/guest_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../bloc/client_oder_cubit/current_order_cubit/state.dart';
import '../../../bloc/client_oder_cubit/finished_order_cubit/state.dart';
import '../../../bloc/client_oder_cubit/new_oder_cubit/state.dart';
import '../../../utils/media_query_value.dart';
import '../../../view/screens/my_orders/tabs_screen/current_orders.dart';
import '../../../view/screens/my_orders/tabs_screen/new_order.dart';
import '../../../view/screens/my_orders/tabs_screen/previous_order.dart';
import '../../../bloc/client_oder_cubit/current_order_cubit/cubit.dart';
import '../../../bloc/client_oder_cubit/finished_order_cubit/cubit.dart';
import '../../../bloc/client_oder_cubit/new_oder_cubit/cubit.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/text_style.dart';
import '../../base/auth_header.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders>
    with SingleTickerProviderStateMixin {
  // var navController=Get.find<NavBarController>();
//  var navController=NavbarCubit.get(context);
  late TabController tabController;

  // NewOrdersClientCubit? newOrdersClientCubit;
  void setTabActive() {
    context
        .read<NewOrdersClientCubit>()
        .changeTabBarIndexClient(value: tabController.index);
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: 3,
        vsync: this,
        initialIndex: context.read<NewOrdersClientCubit>().indexTabClient);
    tabController.addListener(setTabActive);
  }

  @override
  void didChangeDependencies() {
    // newOrdersClientCubit = BlocProvider.of<PackagesCubit>(context);
    // newOrdersClientCubit= context.read<NewOrdersClientCubit>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var newOrdersClientCubit = context.read<NewOrdersClientCubit>();
    var clientCurrentOrderCubit = context.read<ClientCurrentOrderCubit>();
    var clientFinishedOrder = context.read<ClientFinishedOrderCubit>();
    if(token==null){
      return LoginFirst();
    }else{
      return BlocBuilder<NewOrdersClientCubit, NewOrdersClientState>(
        builder: (context, state) {
          return BlocBuilder<ClientCurrentOrderCubit, ClientCurrentOrderState>(
            builder: (context, state) {
              return BlocBuilder<ClientFinishedOrderCubit,
                  ClientFinishedOrderState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Container(
                        height: context.height * 0.17.sp,
                        child: AuthHeader(
                          isCanBack: false,
                          title: LocaleKeys.myOrders.tr(),
                        ),
                        margin: EdgeInsets.only(bottom: context.height * 0.01.sp),
                      ),
                      Container(
                        //  height: context.height * 0.09.sp,
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: lightYellowColor,
                          borderRadius: BorderRadius.circular(15.sp),
                        ),
                        child: TabBar(
                          controller: tabController,
                          indicatorPadding: EdgeInsets.all(8.sp),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: goldColor,
                          unselectedLabelColor: goldColor,
                          indicatorColor: whiteColor,
                          dividerColor: transparentColor,
                          labelPadding: EdgeInsets.all(9.sp),
                          // unselectedLabelColor: darkGreyColor,
                          indicator: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(15.sp),
                              color: whiteColor),
                          // labelColor: goldColor,
                          // indicatorColor: whiteColor,
                          tabs: [
                            Tab(
                              iconMargin:
                              EdgeInsetsDirectional.only(bottom: 0.sp),
                              icon: Text(LocaleKeys.New.tr()),
                              text: newOrdersClientCubit.isGetNewOrders == false
                                  ? ""
                                  : "(${newOrdersClientCubit.newOrderClientModel.meta!.total.toString()})",
                            ),
                            Tab(
                              iconMargin:
                              EdgeInsetsDirectional.only(bottom: 0.sp),
                              icon: Text(LocaleKeys.current.tr()),
                              text: clientCurrentOrderCubit.isGetCurrentOrder ==
                                  false
                                  ? ""
                                  : "(${clientCurrentOrderCubit.currentOrderClientModel.meta!.total.toString()})",
                            ),
                            Tab(
                              iconMargin:
                              EdgeInsetsDirectional.only(bottom: 0.sp),
                              icon: Text(LocaleKeys.previous.tr()),
                              text: clientFinishedOrder.isGetFinishedOrder ==
                                  false
                                  ? ""
                                  : "(${clientFinishedOrder.finishedOrderClientModel.meta!.total.toString()})",
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            NewOrdersScreen(),
                            CurrentOrdersScreen(),
                            PreviousOrdersScreen(),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      );
    }

  }
}
