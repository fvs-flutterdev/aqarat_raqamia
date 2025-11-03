abstract class PromotedServicesState {}

class InitialPromotedServicesState extends PromotedServicesState {}

class GetPromotedServicesLoadingState extends PromotedServicesState {}

class GetPromotedServicesSuccessState extends PromotedServicesState {}

class GetPromotedServicesErrorState extends PromotedServicesState {
  final String error;

  GetPromotedServicesErrorState({required this.error});
}

class GetPromotedDetailsLoadingState extends PromotedServicesState {}

class GetPromotedDetailsSuccessState extends PromotedServicesState {}

class GetPromotedDetailsErrorState extends PromotedServicesState {
  final String error;

  GetPromotedDetailsErrorState({required this.error});
}

class PayForPromotedMyAccLoadingState extends PromotedServicesState {}

class PayForPromotedMyAccSuccessState extends PromotedServicesState {}

class PayForPromotedMyAccErrorState extends PromotedServicesState {
  final String error;

  PayForPromotedMyAccErrorState({required this.error});
}

class GetServiceProviderPromotedLoadingState extends PromotedServicesState {}

class GetServiceProviderPromotedSuccessState extends PromotedServicesState {}

class GetServiceProviderPromotedErrorState extends PromotedServicesState {
  final String error;

  GetServiceProviderPromotedErrorState({required this.error});
}

class HandlePromotionPaymentResponseState extends PromotedServicesState {}
class HandlePromotionPaymentResponseErrorState  extends PromotedServicesState {
  final String error;
  HandlePromotionPaymentResponseErrorState({required this.error});
}
