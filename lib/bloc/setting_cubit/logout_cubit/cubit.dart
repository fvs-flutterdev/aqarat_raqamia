import 'package:aqarat_raqamia/bloc/setting_cubit/logout_cubit/state.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:aqarat_raqamia/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_app/restart_app.dart';

import '../../../view/base/lunch_widget.dart';
import '../../../view/screens/splash/splash_screen.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(InitialLogOutState());

  logout(BuildContext context) {
    emit(LogOutLoadingState());
    DioHelper.postData(url: BaseUrl.baseUrl + BaseUrl.logout, token: token)
        .then((value) async {
      print(value.data);
      await CacheHelper.sharedPreferences.clear();
      await CacheHelper.removeData();
      token = null;
      userId = null;
      accountType = null;
      isProviderSubscribed = null;
      emit(LogOutSuccessState());
      print('<<<<<<<<<<<<<<<<<<<<<<<<<$token>>>>>>>>>>>>>>>>>>>>>>>>>');
      //  Phoenix.rebirth(context);
      Restart.restartApp().then((value) => navigateAndRemove(SplashScreen()));
      // RestartWidget.restartApp(context);
      // navigateAndRemove(SplashScreen());
    }).catchError((error) {
      emit(LogOutErrorState(error: error.toString()));
      print(error.toString());
    });
  }
}
//khalid alshammari
