abstract class ContactUsState{}
class InitialContactUsState extends ContactUsState{}
class GetContactUsDataLoadingState extends ContactUsState{}
class GetContactUsDataSuccessState extends ContactUsState{}
class GetContactUsDataErrorState extends ContactUsState{
  final String error;
  GetContactUsDataErrorState({required this.error});
}
class SetLanguageARState extends ContactUsState{}
class SetLanguageENState extends ContactUsState{}

class ChangeBioMetricsState extends ContactUsState{}
class SaveBioMetricsValueLoadingState extends ContactUsState{}
class SaveBioMetricsValueSuccessState extends ContactUsState{}