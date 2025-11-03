import 'package:aqarat_raqamia/model/dynamic_model/profile_model.dart';

import '../../../model/dynamic_model/profile_model2.dart';

abstract class ClientAuthState{}
class InitialClientAuthState extends ClientAuthState{}
class SendOtpLoginLoadingState extends ClientAuthState{}
class SendOtpLoginSuccessState extends ClientAuthState{}
class SendOtpLoginErrorState extends ClientAuthState{
  final String error;
  SendOtpLoginErrorState({required this.error});
}
class CheckOtpLoginLoadingState extends ClientAuthState{}
class CheckOtpLoginSuccessState extends ClientAuthState{
   ProfileModel profileModel;
  CheckOtpLoginSuccessState({required this.profileModel});
}
class CheckOtpLoginErrorState extends ClientAuthState{
  final String error;
  CheckOtpLoginErrorState({required this.error});
}
class RegisterLoadingState extends ClientAuthState{}
class RegisterSuccessState extends ClientAuthState{
  // ProfileModel profileModel;
  // RegisterSuccessState({required this.profileModel});
}
class RegisterErrorState extends ClientAuthState{
  final String error;
//  final int statusCode;
  RegisterErrorState({required this.error,
   // required this.statusCode
  });
}


class SendFcmTokenLoadingState extends ClientAuthState{}
class SendFcmTokenSuccessState extends ClientAuthState{
  // ProfileModel profileModel;
  // SendFcmTokenSuccessState({required this.profileModel});
}
class SendFcmTokenErrorState extends ClientAuthState{
  final String error;
//  final int statusCode;
  SendFcmTokenErrorState({required this.error,
    // required this.statusCode
  });
}