import 'dart:developer';

import 'package:aqarat_raqamia/bloc/auth_cubit/auth_client/state.dart';
import 'package:aqarat_raqamia/model/dynamic_model/profile_model.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:aqarat_raqamia/utils/shared_pref.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../view/screens/auth/client_auth/verify_screen.dart';
import '../../../view/screens/bottom_navigation/main_screen.dart';

class ClientAuthCubit extends Cubit<ClientAuthState> {
  ClientAuthCubit() : super(InitialClientAuthState());

  static ClientAuthCubit get(context) => BlocProvider.of(context);

  ///Login
  ClientSendOtpLogin({
    required String phoneNumber,
  }) async {
    emit(SendOtpLoginLoadingState());
    DioHelper.postData(
            url: BaseUrl.baseUrl + BaseUrl.login,
            data: {"phone": "$phoneNumber", "status": AppConstant.account_type})
        .then((value) {
      log(value.data.toString());

      emit(SendOtpLoginSuccessState());
      navigateForward(VerificationScreen(phone: phoneNumber));
      // response=value.statusCode.;
    }).catchError((error) {
      log(error.toString());
      emit(SendOtpLoginErrorState(error: error.toString()));
    });
  }

  late ProfileModel profileModel;

  checkOtpLogin({required String phoneNumber, required String otp}) {
    emit(CheckOtpLoginLoadingState());
    DioHelper.authPostData(url: BaseUrl.baseUrl + BaseUrl.checkOtpLogin, data: {
      "phone": "$phoneNumber",
      "code": otp,
      "fcm_token": CacheHelper.getData(key: 'fcmToken')
    }).then((value) {
      log(value.toString());
      profileModel = ProfileModel.fromJson(value.data);
      token =
          CacheHelper.saveData(key: 'token', value: value.data['access_token']);
      accountType = CacheHelper.saveData(
          key: 'status', value: value.data['user']['status']);
      accountType = CacheHelper.getData(key: 'status');
      token = CacheHelper.getData(key: 'token');
      emit(CheckOtpLoginSuccessState(profileModel: profileModel));
      sendFcmToken();

      log('<<<<<<<<<<<<<${token.toString()}>>>>>>>>>>>>>');
      log('<<<<<<<<<<<<<${accountType.toString()}>>>>>>>>>>>>>');
      navigateAndRemove(MainScreenNavigation());
      //  navigateForward(MainScreenNavigation());
    }).catchError((error) {
      log(error.toString());
      emit(CheckOtpLoginErrorState(error: error.toString()));
    });
  }

  ///Register
  // var value;
  // DioError? dioError;
  clientRegister(
      {required String name,
      required String phone,
      required String location,
      required String city,
      required String lat,
      required List<int?> interestsList,
      required String lng}) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: BaseUrl.baseUrl + BaseUrl.register, data: {
      "name": name,
      "country_code": "966",
      "phone": phone,
      "status": 'service_applicant',
      "location": location,
      "country": city,
      "interest_ids": interestsList,
      "lan": lng.toString(),
      "lat": lat.toString(),
    }).then((value) {
//501678160
      log(value.data.toString());
      emit(RegisterSuccessState());
      navigateForward(VerificationScreen(phone: phone));
    }).catchError((error) {
      log(error.toString());
      emit(RegisterErrorState(error: error.toString()));
    });
  }

  sendFcmToken() {
    emit(SendFcmTokenLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.sendFcmToken,
        token: token,
        data: {"fcm_token": CacheHelper.getData(key: 'fcmToken')}).then((value) {
      log(value.toString());
      emit(SendFcmTokenSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(SendFcmTokenErrorState(error: error.toString()));
    });
  }
}
