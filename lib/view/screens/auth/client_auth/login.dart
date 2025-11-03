import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../bloc/auth_cubit/auth_client/cubit.dart';
import '../../../../bloc/auth_cubit/auth_client/state.dart';
import '../../../../bloc/auth_cubit/auth_provider/cubit.dart';
import '../../../../utils/app_constant.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/media_query_value.dart';
import '../../../../utils/shared_pref.dart';
import '../../../../utils/text_style.dart';
import '../../../../view/base/adaptive_dialog_loader.dart';
import '../../../../view/base/auth_header.dart';
import '../../../../view/base/custom_text_field.dart';
import '../../../../view/base/lunch_widget.dart';
import '../../../../view/base/main_button.dart';
import '../../../../view/screens/auth/client_auth/register.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/images.dart';
import '../provider_auth/first_register_provider.dart';

//ignore: must_be_immutable
class ClientLogin extends StatelessWidget {
  final int id;

  ClientLogin({required this.id});

  TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppConstant.account_type = CacheHelper.getData(key: 'accountType');
    print(AppConstant.account_type);
    var authCubit = context.read<ClientAuthCubit>();

    var providerAuthCubit = context.read<RegisterProviderCubit>();
    return BlocConsumer<ClientAuthCubit, ClientAuthState>(
      listener: (context, state) {
        if (state is SendOtpLoginLoadingState) {
          adaptiveDialogLoader(context: context);
        } else if (state is SendOtpLoginErrorState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            //  appBar: AuthHeader(),
              body: Column(
                children: [
                  Container(
                    height: context.height * 0.17.h,
                    margin: EdgeInsets.zero,
                    child:AuthHeader(
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(
                          context.height * 0.01,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                LocaleKeys.loginNow.tr(),
                                style:
                                    openSansExtraBold.copyWith(color: darkGreyColor),
                              ),
                              Text(
                                LocaleKeys.helloAgain.tr(),
                                style: openSansRegular.copyWith(color: darkGreyColor),
                              ),
                              SizedBox(
                                height: context.height * 0.05,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: context.height * 0.01,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: CustomTextField(
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return LocaleKeys.pleaseEnterPhone.tr();
                                            }
                                          },
                                          length: 9,
                                          controller: phoneNumberController,
                                          keyboardType: TextInputType.phone,
                                          labelText: LocaleKeys.phone.tr(),
                                          maxHeight: context.width * 0.2,
                                          minHeight: context.width * 0.15,
                                          onSubmit: (val) {
                                            authCubit.ClientSendOtpLogin(
                                                phoneNumber:
                                                    phoneNumberController.text);
                                          },
                                          suffixIcon: Padding(
                                            padding:
                                                EdgeInsetsDirectional.only(end: 10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.only(
                                                      end: 10),
                                                  child: Text(
                                                    '966+',
                                                    style: openSansRegular.copyWith(
                                                        color: darkGreyColor),
                                                  ),
                                                ),
                                                Image.asset(Images.Saudia_FLAG)
                                              ],
                                            ),
                                          ),
                                        )),
                                        // const SizedBox(
                                        //   width: Dimensions.PADDING_SIZE_DEFAULT,
                                        // ),
                                        // const FlagTextField(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: context.height * 0.04,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                                    ),
                                    child:
                                        // state is SendOtpLoginLoadingState
                                        //     ? adaptiveDialogLoader(context: context)
                                        //     :
                                        CustomButton(
                                      textButton: LocaleKeys.verify.tr(),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          authCubit.ClientSendOtpLogin(
                                              phoneNumber:
                                                  phoneNumberController.text);
                                          //     .then((value) {
                                          //   if (state is SendOtpLoginSuccessState) {
                                          //
                                          //   }
                                          // });
                                        }
                                      },
                                      color: darkGreyColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        id == 1
                                            ? navigateForward(
                                                FirstRegisterProviderScreen())
                                            : navigateForward(ClientRegister());
                                      },
                                      child: Text(
                                        id == 1
                                            ? LocaleKeys.newServiceProvider.tr()
                                            : LocaleKeys.newClient.tr(),
                                        textAlign: TextAlign.center,
                                        style: openSansBold.copyWith(
                                          color: goldColor,
                                          decoration: TextDecoration.underline,
                                          //  fontFamily: 'OpenSans',
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
