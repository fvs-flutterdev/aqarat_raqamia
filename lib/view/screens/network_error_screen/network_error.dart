import 'package:restart_app/restart_app.dart';

import '../../../../../translation/locale_keys.g.dart';
import '../../../../../utils/text_style.dart';
import '../../../../../view/error_widget/error_widget.dart';
import '../../../../../view/restart_widget/restart_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../base/lunch_widget.dart';
import '../splash/splash_screen.dart';

class NetWorkErrorScreen extends StatelessWidget {
  const NetWorkErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          CustomErrorWidget(reload: () async {
            await  Restart.restartApp().then((value) => navigateAndRemove(SplashScreen()));
            // RestartWidget.restartApp(context);
            // navigateAndRemove(SplashScreen());
          }),
          SizedBox(height: 20.sp,),
          Text(
            LocaleKeys.networkError.tr(),
            style: openSansExtraBold.copyWith(color: redColor),
          ),
        ],
      ),
    );
  }
}
