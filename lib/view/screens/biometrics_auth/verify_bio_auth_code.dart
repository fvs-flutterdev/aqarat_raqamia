import 'package:aqarat_raqamia/translation/locale_keys.g.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/images.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:aqarat_raqamia/view/base/auth_header.dart';
import 'package:aqarat_raqamia/view/base/custom_text_field.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/base/main_button.dart';
import 'package:aqarat_raqamia/view/base/show_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bottom_navigation/main_screen.dart';

class VerifyBioNumber extends StatelessWidget {
  VerifyBioNumber({super.key});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AuthHeader(
      //   title:LocaleKeys.verifyOtp.tr(),
      // ),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child:AuthHeader(
              title:LocaleKeys.verifyOtp.tr(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                  top: context.height * 0.06,
                  start: context.height * 0.02,
                  end: context.height * 0.02),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.only(bottom: context.height * 0.04),
                      child: SvgPicture.asset(
                        Images.Biometrics_svg,
                        height: context.height * 0.09,
                        width: context.height * 0.06,
                      ),
                    ),
                    CustomTextField(
                      labelText: LocaleKeys.verifyOtp.tr(),
                      bottomPadding: context.height * 0.04,
                      controller: controller,
                    ),
                    CustomButton(
                      textButton: LocaleKeys.verify.tr(),
                      onPressed: () {
                        if (controller.text.isEmpty ||
                            controller.text != verifyPassword.toString()) {
                          showCustomSnackBar(
                              message:LocaleKeys.enterOtpCorrectly.tr(),
                              state: ToastState.ERROR);
                        } else {
                          navigateForwardReplace(MainScreenNavigation());
                        }
                      },
                      color: darkGreysColor,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
