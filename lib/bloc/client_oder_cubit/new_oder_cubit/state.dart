abstract class NewOrdersClientState {}

class InitialNewOrderClientState extends NewOrdersClientState {}

class GetNewOrderClientSuccessState extends NewOrdersClientState {}

class GetNewOrderClientErrorState extends NewOrdersClientState {
  final String error;

  GetNewOrderClientErrorState({required this.error});
}
class ChangeTabBarState extends NewOrdersClientState {}
class GetPricesOfferClientSuccessState extends NewOrdersClientState {}

class GetPricesOfferClientErrorState extends NewOrdersClientState {
  final String error;

  GetPricesOfferClientErrorState({required this.error});
}

class ChangeCarouselState extends NewOrdersClientState {}

class AcceptOfferPriceClientLoadingState extends NewOrdersClientState {}

class AcceptOfferPriceClientSuccessState extends NewOrdersClientState {}

class AcceptOfferPriceClientErrorState extends NewOrdersClientState {
  final String error;

  AcceptOfferPriceClientErrorState({required this.error});
}

class DeclinedOfferPriceClientLoadingState extends NewOrdersClientState {}

class DeclinedOfferPriceClientSuccessState extends NewOrdersClientState {}

class DeclinedOfferPriceClientErrorState extends NewOrdersClientState {
  final String error;

  DeclinedOfferPriceClientErrorState({required this.error});
}

class PayOfferPriceClientLoadingState extends NewOrdersClientState {}

class PayOfferPriceClientSuccessState extends NewOrdersClientState {}

class PayOfferPriceClientErrorState extends NewOrdersClientState {
  final String error;

  PayOfferPriceClientErrorState({required this.error});
}

class GetOrderByIdClientLoadingState extends NewOrdersClientState {}

class GetOrderByIdClientSuccessState extends NewOrdersClientState {}

class GetOrderByIdClientErrorState extends NewOrdersClientState {
  final String error;

  GetOrderByIdClientErrorState({required this.error});
}
class DeleteOrderByIdClientLoadingState extends NewOrdersClientState {}
class DeleteOrderByIdClientSuccessState extends NewOrdersClientState {}

class DeleteOrderByIdClientErrorState extends NewOrdersClientState {
  final String error;

  DeleteOrderByIdClientErrorState({required this.error});
}

