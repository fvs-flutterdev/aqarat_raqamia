import '../../model/dynamic_model/order_provider/all_pending_orders.dart';

abstract class ProviderOrdersState {}

class InitialProviderOrdersState extends ProviderOrdersState {}

// class GetPendingOrdersProviderLoadedState extends ProviderOrdersState {
//   final List<PendingOrdersProvider> pendingOrdersProviderPagination;
//
//   GetPendingOrdersProviderLoadedState(this.pendingOrdersProviderPagination);
// }

// class GetPendingOrdersProviderLoadingState extends ProviderOrdersState {
//   final List<PendingOrdersProvider> oldPendingOrdersProvider;
//   final bool isFirstFetch;
//
//   GetPendingOrdersProviderLoadingState(this.oldPendingOrdersProvider,
//       {this.isFirstFetch = false});
// }
class GetPendingOrdersProviderSuccessState extends ProviderOrdersState {}

class GetPendingOrdersProviderErrorState extends ProviderOrdersState {
  final String? error;

  GetPendingOrdersProviderErrorState({this.error});
}
class ChangeTabBarState extends ProviderOrdersState {}
class ChangeSelectedIndexState extends ProviderOrdersState {}

class ChangeDaysState extends ProviderOrdersState {}


class FinishOrderLoadingState extends ProviderOrdersState {}
class FinishOrderSuccessState extends ProviderOrdersState {}
class FinishOrderErrorState extends ProviderOrdersState {
  final String error;
  FinishOrderErrorState({required this.error});
}
class GetOrderByIdProviderLoadingState extends ProviderOrdersState {}

class GetOrderByIdProviderSuccessState extends ProviderOrdersState {}

class GetOrderByIdProviderErrorState extends ProviderOrdersState {
  final String error;

  GetOrderByIdProviderErrorState({required this.error});
}
// class GetAllRegionsLoadingState extends ProviderOrdersState {}
//
// class GetAllRegionsSuccessState extends ProviderOrdersState {}
//
// class GetAllRegionsErrorState extends ProviderOrdersState {
//   final String error;
//
//   GetAllRegionsErrorState({required this.error});
// }
//
// class GetAllCitiesByRegionIdLoadingState extends ProviderOrdersState {}
//
// class GetAllCitiesByRegionIdSuccessState extends ProviderOrdersState {}
//
// class GetAllCitiesByRegionIdErrorState extends ProviderOrdersState {
//   final String error;
//
//   GetAllCitiesByRegionIdErrorState({required this.error});
// }
//
//
//
// class OnChangeRegionValueState extends ProviderOrdersState {}
//
//
// class ClearCityListState extends ProviderOrdersState {}
