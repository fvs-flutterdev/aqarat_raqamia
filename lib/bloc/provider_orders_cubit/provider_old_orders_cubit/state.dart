import '../../../model/dynamic_model/order_provider/all_old_orders.dart';

abstract class OldProviderOrdersState {}

class InitialOldProviderOrdersState extends OldProviderOrdersState {}

class GetPreviousOrdersProviderSuccessState extends OldProviderOrdersState {}

class GetPreviousOrdersProviderErrorState extends OldProviderOrdersState {
  final String? error;

  GetPreviousOrdersProviderErrorState({this.error});
}

class ChangeSelectedIndexState extends OldProviderOrdersState {}

class RateClientLoadingState extends OldProviderOrdersState {}

class RateClientSuccessState extends OldProviderOrdersState {}

class RateClientErrorState extends OldProviderOrdersState {
  final String error;

  RateClientErrorState({required this.error});
}
