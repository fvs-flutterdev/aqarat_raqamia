abstract class PartnerSponsorState {}

class InitialPartnerSponsorState extends PartnerSponsorState {}

class GetPartnerSponsorLoadingState extends PartnerSponsorState {}

class GetPartnerSponsorSuccessState extends PartnerSponsorState {}

class GetPartnerSponsorErrorState extends PartnerSponsorState {
  final String error;

  GetPartnerSponsorErrorState({required this.error});
}

class PlayVideoSponsorSuccessState extends PartnerSponsorState {}
