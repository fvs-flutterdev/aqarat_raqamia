abstract class CouponsState {}

class InitialCouponsState extends CouponsState {}

class GetCouponsLoadingState extends CouponsState {}

class GetCouponsSuccessState extends CouponsState {}

class GetCouponsErrorState extends CouponsState {
  final String error;

  GetCouponsErrorState({required this.error});
}
