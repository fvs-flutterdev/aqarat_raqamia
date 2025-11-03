import '../../model/dynamic_model/my_ads_model.dart';

abstract class MyAdsState{}
class InitialMyAdsState extends MyAdsState{}
//class GetMyAdsLoadingState extends MyAdsState{}
class GetMyAdsSuccessState extends MyAdsState{}
class GetMyAdsErrorState extends MyAdsState{
  final String? error;
  GetMyAdsErrorState({ this.error});
}
class ChangeSelectedIndexState extends MyAdsState{}

class DeleteMyAdsLoadingState extends MyAdsState{}
class DeleteMyAdsSuccessState extends MyAdsState{}
class DeleteMyAdsErrorState extends MyAdsState{
  final String? error;
  DeleteMyAdsErrorState({ this.error});
}


// class GetMyAdsLoadedState extends MyAdsState {
//   final List<MyAdsData> myAdsPagination;
//
//   GetMyAdsLoadedState(this.myAdsPagination);
// }
//
// class GetMyAdsLoadingState extends MyAdsState {
//   final List<MyAdsData> oldMyAds;
//   final bool isFirstFetch;
//
//   GetMyAdsLoadingState(this.oldMyAds, {this.isFirstFetch = false});
// }