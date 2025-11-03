import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_app/restart_app.dart';
import '../../../bloc/setting_cubit/contact_us_cubit/state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/base_url.dart';
import '../../../utils/dio.dart';
import '../../../view/base/lunch_widget.dart';
import '../../../view/base/show_toast.dart';
import '../../../model/dynamic_model/contact_us_model.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/shared_pref.dart';
import '../../../view/restart_widget/restart_widget.dart';
import '../../../view/screens/splash/splash_screen.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(InitialContactUsState());

  static ContactUsCubit get(context) => BlocProvider.of(context);
  late ContactUsModel contactUsModel;
  bool isGetContactInfo = false;

  getContactInfo() {
    isGetContactInfo = false;
    emit(GetContactUsDataLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.GetContactUs)
        .then((value) {
      debugPrint('??????????????????${value.data.toString()}');
      contactUsModel = ContactUsModel.fromJson(value.data);
      isGetContactInfo = true;
      emit(GetContactUsDataSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetContactUsDataErrorState(error: error.toString()));
    });
  }

  Future changeLanguage(BuildContext context) async {
    if (isEnglish == false) {
      // context.deleteSaveLocale();
      isEnglish = !isEnglish!;
      context.setLocale(const Locale('en'));
      myLocale = context.locale.languageCode;
      myLocale = CacheHelper.saveData(key: 'myLocale', value: myLocale);
      CacheHelper.saveData(key: 'isEnglish', value: isEnglish);

      debugPrint('ISENGLISH :${isEnglish.toString()} ');
      debugPrint('myLocale ${myLocale.toString()}');
      emit(SetLanguageENState());
      myLocale = CacheHelper.getData(key: 'myLocale');
      debugPrint('SAVE LOCALE IS ${myLocale.toString()}');
    } else {
      // context.deleteSaveLocale();
      isEnglish = !isEnglish!;
      context.setLocale(const Locale('ar'));
      myLocale = context.locale.languageCode;
      myLocale = CacheHelper.saveData(key: 'myLocale', value: myLocale);
      CacheHelper.saveData(key: 'isEnglish', value: isEnglish);
      debugPrint('ISArabic :${isEnglish.toString()} ');
      debugPrint('myLocale ${myLocale.toString()}');
      emit(SetLanguageARState());
      myLocale = CacheHelper.getData(key: 'myLocale');
      debugPrint('SAVE LOCALE IS ${myLocale.toString()}');
    }
    await Future.delayed(Duration(milliseconds: 300)).then((value) async {
      await  Restart.restartApp().then((value) => navigateAndRemove(SplashScreen()));
      // RestartWidget.restartApp(context);
      //   navigateAndRemove(SplashScreen());
    });
    debugPrint('CUREENT LOCALE ${EasyLocalization.of(context)?.currentLocale.toString()}');
  }

  bool isBioActive = false;

  Future activeBioMetrics(onChange) async {
    if (isBioActiveForUser == null) {
      isBioActive = !isBioActive;
    } else {

    //  isBioActiveForUser = CacheHelper.saveData(key: 'IsBio', value: null);
      CacheHelper.sharedPreferences.remove('IsBio');
      isBioActiveForUser = CacheHelper.getData(key: 'IsBio',);
    //  verifyPassword = CacheHelper.saveData(key: 'VerifyPass', value: null);
      CacheHelper.sharedPreferences.remove('VerifyPass');
      verifyPassword = CacheHelper.getData(key: 'VerifyPass');
      isBioActive = !isBioActive;
      debugPrint('<<<<<<<<<<<<<<<<<<<<<<<<<<<<${isBioActiveForUser.toString()}');
      debugPrint('<<<<<<<<<<<<<<<<<<<<<<<<<<<<${verifyPassword.toString()}');
    }
    emit(ChangeBioMetricsState());
  }

  saveBioSetting({required String password}) {
    emit(SaveBioMetricsValueLoadingState());
    verifyPassword = CacheHelper.saveData(key: 'VerifyPass', value: password);
    isBioActiveForUser = CacheHelper.saveData(key: 'IsBio', value: true);
    emit(SaveBioMetricsValueLoadingState());
    verifyPassword = CacheHelper.getData(
      key: 'VerifyPass',
    );
    isBioActiveForUser = CacheHelper.getData(
      key: 'IsBio',
    );
    debugPrint('<<<<<<<<<<<<<<<<<<<<<${verifyPassword.toString()}>>>>>>>>>>>>>>>>>>>>');
    debugPrint('<<<<<<<<<<<<<<<<<<<<<${isBioActiveForUser.toString()}>>>>>>>>>>>>>>>>>>>>');
    showCustomSnackBar(message: LocaleKeys.otpActivatedSuccess.tr(), state: ToastState.SUCCESS);
    emit(SaveBioMetricsValueSuccessState());
  }
}
