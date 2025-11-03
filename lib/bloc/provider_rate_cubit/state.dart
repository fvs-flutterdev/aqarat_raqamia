abstract class ProviderRatesState {}

class InitialProviderRatesState extends ProviderRatesState {}

class GetProviderRatesLoadingState extends ProviderRatesState {}

class GetProviderRatesSuccessState extends ProviderRatesState {}

class GetProviderRatesErrorState extends ProviderRatesState {
  final String error;

  GetProviderRatesErrorState({required this.error});
}
