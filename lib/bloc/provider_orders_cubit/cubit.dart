import 'package:aqarat_raqamia/bloc/provider_orders_cubit/state.dart';
import 'package:aqarat_raqamia/bloc/region_cubit/cubit.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/dynamic_model/order_provider/all_pending_orders.dart';
import '../../model/dynamic_model/orders_client/order_by_id_model.dart';
import '../../translation/locale_keys.g.dart';
import '../../view/base/show_toast.dart';
import '../../view/screens/bottom_navigation/main_screen.dart';

class OrdersProviderCubit extends Cubit<ProviderOrdersState> {
  OrdersProviderCubit() : super(InitialProviderOrdersState());

  /// New Orders
  late AllPendingOrdersProviders getPendingOrdersProviderPaginationModel;

  bool isPendingOrderGet = false;

  getPendingOrdersProvider(
      {required int page,
      bool firstLoad = false,
        List<int>? cityId,
        int? regionId,
      required BuildContext context}) {
    isPendingOrderGet = false;
    // print('@@@@@@@@@@@@@@@@@@@@${context.read<RegionsCubit>().cities}^^^^^^^^^^^^^^^^^^^^^');
    DioHelper.getDataFilter(
      // url: BaseUrl.baseUrl + BaseUrl.pending_orders_provider,
      url: 'https://dashboard.redd.sa/api/request_services/provider-reference',
      token: token,
      cities:cityId?? context.read<RegionsCubit>().cities,
      regionId:regionId??  context.read<RegionsCubit>().regionId,

      page: page,
    ).then((value) {
      if (page == 1) {
        getPendingOrdersProviderPaginationModel =
            AllPendingOrdersProviders.fromJson(value.data);
        isPendingOrderGet = true;
        context.read<RegionsCubit>().cities.clear();
      } else {
        getPendingOrdersProviderPaginationModel.meta?.currentPage =
            AllPendingOrdersProviders.fromJson(value.data).meta?.currentPage;
        getPendingOrdersProviderPaginationModel.meta?.lastPage =
            AllPendingOrdersProviders.fromJson(value.data).meta?.lastPage;
        getPendingOrdersProviderPaginationModel.meta?.total =
            AllPendingOrdersProviders.fromJson(value.data).meta?.total;
        getPendingOrdersProviderPaginationModel.meta?.perPage =
            AllPendingOrdersProviders.fromJson(value.data).meta?.perPage;
        getPendingOrdersProviderPaginationModel.data
            ?.addAll(AllPendingOrdersProviders.fromJson(value.data).data ?? []);
        context.read<RegionsCubit>().cities.clear();
      }
      isPendingOrderGet = true;
      context.read<RegionsCubit>().cities.clear();
      emit(GetPendingOrdersProviderSuccessState());
    }).catchError((error) {
      print(error.toString());
      print('//////////////////////////////////');
      emit(GetPendingOrdersProviderErrorState(error: error.toString()));
    });
  }

  finishOrder({required int orderId, required BuildContext context}) {
    emit(FinishOrderLoadingState());
    DioHelper.postData(
            url: BaseUrl.baseUrl + BaseUrl.FinishOrder,
            token: token,
            data: {"request_service_id": orderId, "status": "finished"})
        .then((value) {
      print(value.data);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainScreenNavigation()),
            (route) => false,
      );
      emit(FinishOrderSuccessState());
      showCustomSnackBar(
        message: '${value.data['message']}${LocaleKeys.finishService.tr()}',
        state: ToastState.SUCCESS,
      );
    }).catchError((error) {
      print(error);
      emit(FinishOrderErrorState(error: error.toString()));
    });
  }

  bool isGetOrderById = false;
  late OrderByIdModel orderByIdModel;

  getOrderById({required dynamic id}) {
    isGetOrderById = false;
    emit(GetOrderByIdProviderLoadingState());

    DioHelper.getData(
        url: BaseUrl.baseUrl + '/api/request_services/details/$id',
        token: token)
        .then((value) {
      debugPrint(value.data.toString());
      print('/////////////////!!!!!!!!!!!!!!!!!!!!!!!!!');
      orderByIdModel = OrderByIdModel.fromJson(value.data);
      isGetOrderById = true;
      emit(GetOrderByIdProviderSuccessState());

    }).catchError((error) {
      print(error.toString());
      emit(GetOrderByIdProviderErrorState(error: error.toString()));
    });
  }


  int indexTabProvider = 0;

  changeTabBarIndexProvider({required var value}) {
    indexTabProvider = value;
    print('//////////////////$indexTabProvider');
    emit(ChangeTabBarState());
  }
}
