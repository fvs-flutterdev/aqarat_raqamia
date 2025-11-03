import '../../../model/dynamic_model/order_provider/all_current_provider.dart';

abstract class CurrentProviderOrdersState{}

class InitialCurrentProviderOrdersState extends CurrentProviderOrdersState{}


// class GetCurrentOrdersProviderLoadedState extends CurrentProviderOrdersState {
//   final List<CurrentOrdersProviders> previousOrdersProviderPagination;
//
//   GetCurrentOrdersProviderLoadedState(this.previousOrdersProviderPagination);
// }
//
// class GetCurrentOrdersProviderLoadingState extends CurrentProviderOrdersState {
//   final List<CurrentOrdersProviders> oldCurrentOrdersProvider;
//   final bool isFirstFetch;
//
//   GetCurrentOrdersProviderLoadingState(this.oldCurrentOrdersProvider,
//       {this.isFirstFetch = false});
// }
class GetCurrentOrdersProviderSuccessState extends CurrentProviderOrdersState {}
class GetCurrentOrdersProviderErrorState extends CurrentProviderOrdersState {
  final String? error;

  GetCurrentOrdersProviderErrorState({this.error});
}

class ChangeSelectedIndexState extends CurrentProviderOrdersState{}