import 'package:aqarat_raqamia/translation/locale_keys.g.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:aqarat_raqamia/view/base/main_button.dart';
import 'package:aqarat_raqamia/view/restart_widget/restart_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restart_app/restart_app.dart';

import '../../bloc/account_type_cubit/cubit.dart';
import '../../bloc/auth_cubit/auth_client/cubit.dart';
import '../../model/static_model/account_type_model.dart';
import '../../utils/images.dart';
import '../screens/splash/splash_screen.dart';
import 'custom_text_field.dart';
import 'lunch_widget.dart';

class LoginFirst extends StatefulWidget {
  const LoginFirst({super.key});

  @override
  State<LoginFirst> createState() => _LoginFirstState();
}

class _LoginFirstState extends State<LoginFirst> {
  TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // var cubit=context.read<AccountTypeCubit>();
    // var authCubit = context.read<ClientAuthCubit>();
    return  Padding(
      padding:  EdgeInsetsDirectional.symmetric(horizontal: 20.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Images.loginFirst),
          SizedBox(height: 30.sp,),
          CustomButton(textButton: LocaleKeys.signFirst.tr(), onPressed: ()async{
           // Phoenix.rebirth(context);
          await  Restart.restartApp().then((value) => navigateAndRemove(SplashScreen()));
            // RestartWidget.restartApp(context);
            // navigateAndRemove(SplashScreen());
          },color: darkGreyColor),
          SizedBox(height: 20.sp,),
          Center(child: Text(LocaleKeys.loginFirst.tr(),textAlign: TextAlign.center,
            style: openSansExtraBold.copyWith(color: redColor),)),
        ],
      ),
    );
  }
}
