import 'dart:async';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../bloc/auth_cubit/auth_client/cubit.dart';
import '../../../../bloc/auth_cubit/auth_client/state.dart';
import '../../../../bloc/auth_cubit/auth_provider/cubit.dart';
import '../../../../bloc/auth_cubit/auth_provider/state.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/text_style.dart';
import '../../../../view/base/adaptive_dialog_loader.dart';
import '../../../../view/base/auth_header.dart';
import '../../../../view/base/main_button.dart';
import '../../../../view/base/show_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/app_constant.dart';

class VerificationScreen extends StatefulWidget {
  final String phone;

  // bool sendOtp;

  const VerificationScreen({
    super.key,
    required this.phone,
    //   this.sendOtp=false
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //int start=60;
  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();

    _startTimer();
    // if(widget.sendOtp==true){
    //   accountType=="service_provider"?context.read<RegisterProviderCubit>().send:
    // }
  }

  void _startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds = _seconds - 1;
      if (_seconds == 0) {
        timer.cancel();
        _timer?.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    //   otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(AppConstant.account_type);
    var authCubit = context.read<ClientAuthCubit>();
    var providerAuth = context.read<RegisterProviderCubit>();
    return Scaffold(
    //  appBar: AuthHeader(isCanBack: false),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(isCanBack: false),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Form(
                key: _formKey,
                child:
                    BlocConsumer<RegisterProviderCubit, ProviderRegisterState>(
                  listener: (context, state) {
                    if (state is VerifyProviderRegisterLoadingState) {
                      adaptiveDialogLoader(context: context);
                    }
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return BlocConsumer<ClientAuthCubit, ClientAuthState>(
                      listener: (context, state) {
                        if (state is CheckOtpLoginLoadingState) {
                          adaptiveDialogLoader(context: context);
                        } else if (state is CheckOtpLoginErrorState) {
                          Navigator.pop(context);
                          showCustomSnackBar(
                              message: LocaleKeys.invalidOtp.tr(),
                              state: ToastState.ERROR);
                        }
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.enterCodeVerification.tr(),
                              style: openSansExtraBold.copyWith(
                                  color: darkGreyColor),
                            ),
                            Text(
                              '${LocaleKeys.otpSentTo.tr()}${widget.phone}+',
                              style: openSansRegular.copyWith(
                                  color: darkGreyColor),
                            ),
                            Align(
                                alignment: AlignmentDirectional.topEnd,
                                child: Text(
                                  '0:$_seconds ${LocaleKeys.seconds.tr()} ',
                                  style: openSansRegular.copyWith(
                                      color: darkGreyColor),
                                )),
                            const SizedBox(
                              height: 30,
                            ),
                            PinCodeTextField(
                              length: 5,
                              appContext: context,
                              controller: otpController,
                              // obscureText: true,
                              keyboardType: TextInputType.number,
                              animationType: AnimationType.slide,
                              pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  fieldHeight: 56,
                                  fieldWidth: 56,
                                  borderWidth: 1,
                                  borderRadius: BorderRadius.circular(12),
                                  inactiveFillColor: Color(0xfff2f2f2),
                                  activeFillColor: Color(0xfff2f2f2),
                                  selectedFillColor: Colors.white,
                                  selectedColor: Color(0xfff2f2f2),
                                  disabledColor: Color(0xfff2f2f2),
                                  activeColor: Color(0xfff2f2f2),
                                  inactiveColor: Color(0xfff2f2f2),
                                  errorBorderColor: Colors.white),
                              animationDuration: Duration(milliseconds: 300),
                              backgroundColor: Colors.transparent,
                              enableActiveFill: true,
                              onCompleted: (onCompelete) {
                                if (AppConstant.account_type ==
                                    'service_provider') {
                                  if (_formKey.currentState!.validate()) {
                                    providerAuth.verifyProvider(
                                        // context: context,
                                        phone: widget.phone,
                                        otp: otpController.text);
                                  }
                                } else {
                                  if (_formKey.currentState!.validate()) {
                                    authCubit.checkOtpLogin(
                                      phoneNumber: widget.phone,
                                      otp: otpController.text,
                                    );
                                  }
                                }
                              },
                              // onChanged: authController.updateVerificationCode,
                              beforeTextPaste: (text) => true,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                  onPressed: _seconds == 0
                                      ? () {
                                          debugPrint('galal');
                                        }
                                      : null,
                                  child: Text(
                                    LocaleKeys.resend.tr(),
                                    style: openSansExtraBold.copyWith(
                                        color: goldColor,
                                        decoration: TextDecoration.underline),
                                  )),
                            ),
                            VerificationButton(onPressed: () {
                              if (AppConstant.account_type ==
                                  'service_provider') {
                                if (_formKey.currentState!.validate()) {
                                  providerAuth.verifyProvider(
                                      // context: context,
                                      phone: widget.phone,
                                      otp: otpController.text);
                                }
                              } else {
                                if (_formKey.currentState!.validate()) {
                                  authCubit.checkOtpLogin(
                                    phoneNumber: widget.phone,
                                    otp: otpController.text,
                                  );
                                }
                              }
                            }),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
