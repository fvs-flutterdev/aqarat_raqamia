abstract class SendPriceOfferState{}
class InitialSendPriceOfferState extends SendPriceOfferState{}
class SendPriceOfferLoadingState extends SendPriceOfferState{}
class SendPriceOfferSuccessState extends SendPriceOfferState{}
class SendPriceOfferErrorState extends SendPriceOfferState{
  final String error;
  SendPriceOfferErrorState({required this.error});
}
class ChangeDaysState  extends SendPriceOfferState{}
class ChangeSelectedIndexState extends SendPriceOfferState{}
class DisposeControllerState extends SendPriceOfferState{}
