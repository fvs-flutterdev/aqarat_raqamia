import 'package:aqarat_raqamia/bloc/provider_orders_cubit/provider_current_orders/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/dynamic_model/order_provider/all_current_provider.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/base_url.dart';
import '../../../utils/dio.dart';

class CurrentProviderOrdersCubit extends Cubit<CurrentProviderOrdersState> {
  CurrentProviderOrdersCubit(// this.currentOrdersProvidersRepository
      )
      : super(InitialCurrentProviderOrdersState());


  late AllCurrentOrdersProvider getCurrentOrdersProviderPaginationModel;
  bool isCurrentOrdersGet = false;

  loadedCurrentOrdersProvider({required int page, bool firstLoad = false}) {
    isCurrentOrdersGet = false;
    DioHelper.getData(
            url: BaseUrl.baseUrl + BaseUrl.current_orders_provider,
            token: token,
            page: page)
        .then((value) {
      if (page == 1) {
        getCurrentOrdersProviderPaginationModel =
            AllCurrentOrdersProvider.fromJson(value.data);
      } else {
        getCurrentOrdersProviderPaginationModel.meta?.currentPage =
            AllCurrentOrdersProvider.fromJson(value.data).meta?.currentPage;
        getCurrentOrdersProviderPaginationModel.meta?.lastPage =
            AllCurrentOrdersProvider.fromJson(value.data).meta?.lastPage;
        getCurrentOrdersProviderPaginationModel.meta?.total =
            AllCurrentOrdersProvider.fromJson(value.data).meta?.total;
        getCurrentOrdersProviderPaginationModel.meta?.perPage =
            AllCurrentOrdersProvider.fromJson(value.data).meta?.perPage;
        getCurrentOrdersProviderPaginationModel.data
            ?.addAll(AllCurrentOrdersProvider.fromJson(value.data).data ?? []);
      }
      emit(GetCurrentOrdersProviderSuccessState());
      isCurrentOrdersGet = true;
    }).catchError((error) {
      print(error.toString());
      emit(GetCurrentOrdersProviderErrorState(error: error.toString()));
    });
  }

  int selectedIndex = 0;

  changeIndexCarousel(index) {
    selectedIndex = index;
    emit(ChangeSelectedIndexState());
  }
}
