abstract class CarouselBannersState {}

class InitialCarouselBannersState extends CarouselBannersState {}

class GetCarouselBannersLoadingState extends CarouselBannersState {}

class GetCarouselBannersSuccessState extends CarouselBannersState {}

class GetCarouselBannersErrorState extends CarouselBannersState {
  final String error;

  GetCarouselBannersErrorState({required this.error});
}
