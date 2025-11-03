abstract class AboutUsState{}
class InitialAboutUsState extends AboutUsState{}
class GetAboutUsLoadingState extends AboutUsState{}
class GetAboutUsSuccessState extends AboutUsState{}
class GetAboutUsErrorState extends AboutUsState{
  final String error;
  GetAboutUsErrorState({required this.error});
}