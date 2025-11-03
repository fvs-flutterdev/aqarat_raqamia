abstract class TermsAndConditionState{}
class InitialTermsAndConditionState extends TermsAndConditionState{}
class GetTermsAndConditionLoadingState extends TermsAndConditionState{}
class GetTermsAndConditionSuccessState extends TermsAndConditionState{}
class GetTermsAndConditionErrorState extends TermsAndConditionState{
  final String error;
  GetTermsAndConditionErrorState({required this.error});
}