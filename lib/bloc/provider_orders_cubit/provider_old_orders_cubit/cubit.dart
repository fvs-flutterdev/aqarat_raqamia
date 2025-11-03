import 'package:aqarat_raqamia/bloc/provider_orders_cubit/provider_old_orders_cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/dynamic_model/order_provider/all_old_orders.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/base_url.dart';
import '../../../utils/dio.dart';
import '../../../view/base/show_toast.dart';

class OldProviderOrdersCubit extends Cubit<OldProviderOrdersState> {
  OldProviderOrdersCubit() : super(InitialOldProviderOrdersState());

  ///Old Orders

  late AllOldOrdersProvider getOldOrdersProviderPaginationModel;

  bool isOldOrdersGet = false;

  loadedPreviousOrdersProvider({required int page, bool firstLoad = false}) {
    isOldOrdersGet = false;
    DioHelper.getData(
            url: BaseUrl.baseUrl + BaseUrl.old_orders_provider,
            token: token,
            page: page)
        .then((value) {
      if (page == 1) {
        getOldOrdersProviderPaginationModel =
            AllOldOrdersProvider.fromJson(value.data);
      } else {
        getOldOrdersProviderPaginationModel.meta?.currentPage =
            AllOldOrdersProvider.fromJson(value.data).meta?.currentPage;
        getOldOrdersProviderPaginationModel.meta?.lastPage =
            AllOldOrdersProvider.fromJson(value.data).meta?.lastPage;
        getOldOrdersProviderPaginationModel.meta?.total =
            AllOldOrdersProvider.fromJson(value.data).meta?.total;
        getOldOrdersProviderPaginationModel.meta?.perPage =
            AllOldOrdersProvider.fromJson(value.data).meta?.perPage;
        getOldOrdersProviderPaginationModel.data
            ?.addAll(AllOldOrdersProvider.fromJson(value.data).data ?? []);
      }
      emit(GetPreviousOrdersProviderSuccessState());
      isOldOrdersGet = true;
    }).catchError((error) {
      print(error.toString());
      emit(GetPreviousOrdersProviderErrorState(error: error.toString()));
    });
  }

  int selectedIndex = 0;

  changeIndexCarousel(index) {
    selectedIndex = index;
    emit(ChangeSelectedIndexState());
  }

  TextEditingController rateNotesController = TextEditingController();
  rateClient(
      {required String clientId,
      // required String description,
      required BuildContext context}) {
    emit(RateClientLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.rate_client,
        token: token,
        data: {
          "applicant_id": clientId,
          "rate": ratingCount,
          "notes": rateNotesController.text
        }).then((value) {
      print(value.data);
      Navigator.pop(context);
      rateNotesController.clear();
      //  rateNotesController.dispose();
      print('<<<<<<<<<<<$ratingCount>>>>>>>>>>>');
      showCustomSnackBar(
        message: LocaleKeys.addRateSuccess.tr(),
        state: ToastState.SUCCESS,
      );
      emit(RateClientSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RateClientErrorState(error: error.toString()));
    });
  }
}
