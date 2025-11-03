import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import '../../../bloc/setting_cubit/contact_us_cubit/state.dart';
import '../../../view/base/custom_text_field.dart';
import '../../../view/base/main_button.dart';
import '../../../view/base/show_toast.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/dimention.dart';
import '../../../utils/media_query_value.dart';
import '../../../utils/text_style.dart';
import '../../../view/base/auth_header.dart';
import '../../../bloc/setting_cubit/contact_us_cubit/cubit.dart';
import '../../../translation/locale_keys.g.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController controller = TextEditingController();

  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (token != null) {
      auth.isDeviceSupported().then(
            (bool isSupported) => setState(() => _supportState = isSupported
                ? _SupportState.supported
                : _SupportState.unsupported),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    var settingsCubit = context.read<ContactUsCubit>();
    return Scaffold(
      // appBar: AuthHeader(
      //   title: LocaleKeys.settings.tr(),
      // ),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(title: LocaleKeys.settings.tr(),),
          ),
          Expanded(
            child: BlocBuilder<ContactUsCubit, ContactUsState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.lang.tr(),
                            style: openSansBlack.copyWith(color: darkGreyColor),
                          ),
                          GestureDetector(
                            onTap: () {
                              settingsCubit.changeLanguage(context);
                            },
                            child: Container(
                              height: context.height * 0.06,
                              width: context.width * 0.25,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.RADIUS_LARGE),
                                  color: goldColor),
                              child: Center(
                                child: Text(
                                  LocaleKeys.languageType.tr(),
                                  textAlign: TextAlign.center,
                                  style: openSansMedium.copyWith(color: whiteColor,),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'خاصيه الدخول بالبصمه',
                      //       style: openSansBlack.copyWith(color: darkGreyColor),
                      //     ),
                      //     Switch.adaptive(value: settingsCubit.isBioActive, onChanged: (onChanged){
                      //       settingsCubit.activeBioMetrics(context);
                      //     })
                      //   ],
                      // ),
                      _supportState == _SupportState.supported
                          ? Padding(
                              padding: EdgeInsetsDirectional.only(
                                  top: context.height * 0.04),
                              child: SwitchListTile.adaptive(
                                  activeColor: darkGreyColor,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    LocaleKeys.biometricLocaleAuth.tr(),
                                    // LocaleKeys.roomNo.tr(),
                                    style: openSansExtraBold.copyWith(
                                        color: darkGreyColor),
                                  ),
                                  value:
                                      isBioActiveForUser ?? settingsCubit.isBioActive,
                                  onChanged: (val) {
                                    settingsCubit.activeBioMetrics(context);
                                    print(val);
                                  }),
                            )
                          : Text(LocaleKeys.deviceNotSupportLocaleAuth.tr()),
                      isBioActiveForUser == null
                          ? settingsCubit.isBioActive == true
                              ? CustomTextField(
                                  controller: controller,
                                  labelText: LocaleKeys.createOtpForBio.tr(),
                                )
                              : SizedBox()
                          : SizedBox(),
                      isBioActiveForUser == null
                          ? settingsCubit.isBioActive == true
                              ? CustomButton(
                                  color: darkGreysColor,
                                  textButton: LocaleKeys.save.tr(),
                                  onPressed: () {
                                    if (controller.text.isEmpty || controller.text.length < 5) {
                                      showCustomSnackBar(
                                          message: LocaleKeys.otpMustBeFive.tr(),
                                          state: ToastState.ERROR);
                                    }
                                    else {
                                      settingsCubit.saveBioSetting(password: controller.text);
                                    }
                                  },
                                )
                              : SizedBox()
                          : SizedBox(),
                      // SizedBox(height: 15.h,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'الإشعارات',
                      //       style: openSansBlack.copyWith(color: darkGreyColor),
                      //     ),
                      //     Switch.adaptive(value: true, onChanged: (onChanged) {},activeColor:lightYellowColor ,)
                      //   ],
                      // ),
                      // SizedBox(height: 15.h,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'الوضع',
                      //       style: openSansBlack.copyWith(color: darkGreyColor),
                      //     ),
                      //    Row(
                      //      children: [
                      //        Text('ليلي'),
                      //        Switch.adaptive(value: true, onChanged: (onChanged) {},activeColor:lightYellowColor ,),
                      //        Text('نهاري'),
                      //      ],
                      //    )
                      //   ],
                      // )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
