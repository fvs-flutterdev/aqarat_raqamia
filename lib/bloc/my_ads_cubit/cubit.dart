import 'package:aqarat_raqamia/bloc/my_ads_cubit/state.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_app/restart_app.dart';

import '../../model/dynamic_model/my_ads_model.dart';
import '../../paginations/my_ads/repository.dart';
import '../../utils/app_constant.dart';

class MyAdsCubit extends Cubit<MyAdsState> {
  MyAdsCubit(//this.repository
      )
      : super(InitialMyAdsState());

  // getMyAdsData() {
  //  // emit(GetMyAdsLoadingState());
  //   DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.GetMyAds, token: token)
  //       .then((value) {
  //     print(value.data);
  //     myAdsModel = MyAdsModel.fromJson(value.data);
  //     emit(GetMyAdsSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(GetMyAdsErrorState(error: error.toString()));
  //   });
  // }

  // List<MyAdsData> myAds = [];
  // bool isMyAdsGet = false;
  // int page = 1;
  // final MyAdsRepository repository;
  //
  // loadedMyAds() {
  //   if (state is GetMyAdsLoadingState) return;
  //   final currentState = state;
  //   var oldMyAdsModel = <MyAdsData>[];
  //   if (currentState is GetMyAdsLoadedState) {
  //     oldMyAdsModel = currentState.myAdsPagination;
  //     print('${oldMyAdsModel.length} 00000000000000000000000111');
  //   }
  //   emit(GetMyAdsLoadingState(oldMyAdsModel, isFirstFetch: page == 1));
  //   repository.getMyAds(page: page).then((newAds) {
  //     print(newAds);
  //     page++;
  //     print(page);
  //     myAds = (state as GetMyAdsLoadingState).oldMyAds;
  //     myAds.addAll(newAds?.data ?? []);
  //     emit(GetMyAdsLoadedState(myAds));
  //     print('myAds.length ${myAds.length}');
  //     // if(newAds==null)
  //     //   emit(GetMyAdsErrorState());
  //   }).catchError((error){
  //     print('<<<<<<<<<<<<<<<<<<<<<$error>>>>>>>>>>>>>>>>>>>>>');
  //     emit(GetMyAdsErrorState());
  //   });
  //
  //
  //
  // }
  late MyAdsModel getMyAdsPaginationModel;

  bool isMyAdsGet = false;

  loadedMyAds({required int page, bool firstLoad = false}) {
    isMyAdsGet = false;
    DioHelper.getData(
            url: BaseUrl.baseUrl + BaseUrl.GetMyAds, token: token, page: page)
        .then((value) {
      if (page == 1) {
        getMyAdsPaginationModel = MyAdsModel.fromJson(value.data);
      } else {
        getMyAdsPaginationModel.meta?.currentPage =
            MyAdsModel.fromJson(value.data).meta?.currentPage;
        getMyAdsPaginationModel.meta?.lastPage =
            MyAdsModel.fromJson(value.data).meta?.lastPage;
        getMyAdsPaginationModel.meta?.total =
            MyAdsModel.fromJson(value.data).meta?.total;
        getMyAdsPaginationModel.meta?.perPage =
            MyAdsModel.fromJson(value.data).meta?.perPage;
        getMyAdsPaginationModel.data
            ?.addAll(MyAdsModel.fromJson(value.data).data ?? []);
      }
      emit(GetMyAdsSuccessState());
      isMyAdsGet = true;
    }).catchError((error) {
      isMyAdsGet = true;
      print(error.toString());
      emit(GetMyAdsErrorState(error: error.toString()));
    });
  }

  int selectedIndex = 0;

  changeIndexCarousel(index) {
    selectedIndex = index;
    emit(ChangeSelectedIndexState());
  }

  changeCarouselAdditional(int index) {
    selectedIndex = (selectedIndex + 1) % index;
    emit(ChangeSelectedIndexState());
  }

  deleteAd({required int adId}) {
    emit(DeleteMyAdsLoadingState());
    DioHelper.postData(
            url: BaseUrl.baseUrl + '/api/ads/deleted/$adId', token: token)
        .then((value) async{
      debugPrint(value.data.toString());
      emit(DeleteMyAdsSuccessState());
    await  Restart.restartApp().then((value) => navigateAndRemove(SplashScreen()));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(DeleteMyAdsErrorState(error: error.toString()));
    });
  }
}
