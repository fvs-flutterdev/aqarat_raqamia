import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';

import '../../bloc/account_type_cubit/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/static_model/account_type_model.dart';
import '../../utils/app_constant.dart';
import '../../utils/shared_pref.dart';

class AccountTypeCubit extends Cubit<AccountTypeState> {
  AccountTypeCubit() : super(InitialAccountTypeState());

  static AccountTypeCubit get(context) => BlocProvider.of(context);
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectIndex(int index) {
    _selectedIndex = index;
    debugPrint(index.toString());
    debugPrint(selectedIndex.toString());
    emit(ChangeAccountTypeState());
  }

  // Future changeLanguage(BuildContext context) async {
  //   if (isEnglish == false) {
  //     // context.deleteSaveLocale();
  //     isEnglish = !isEnglish!;
  //     context.setLocale(const Locale('en'));
  //     myLocale = context.locale.languageCode;
  //     myLocale = CacheHelper.saveData(key: 'myLocale', value: myLocale);
  //     CacheHelper.saveData(key: 'isEnglish', value: isEnglish);
  //
  //     debugPrint('ISENGLISH :${isEnglish.toString()} ');
  //     debugPrint('myLocale ${myLocale.toString()}');
  //     emit(SetLanguageENAccountTypeState());
  //     myLocale = CacheHelper.getData(key: 'myLocale');
  //     debugPrint('SAVE LOCALE IS ${myLocale.toString()}');
  //   } else {
  //     // context.deleteSaveLocale();
  //     isEnglish = !isEnglish!;
  //     context.setLocale(const Locale('ar'));
  //     myLocale = context.locale.languageCode;
  //     myLocale = CacheHelper.saveData(key: 'myLocale', value: myLocale);
  //     CacheHelper.saveData(key: 'isEnglish', value: isEnglish);
  //     debugPrint('ISArabic :${isEnglish.toString()} ');
  //     debugPrint('myLocale ${myLocale.toString()}');
  //     emit(SetLanguageARAccountTypeState());
  //     myLocale = CacheHelper.getData(key: 'myLocale');
  //     debugPrint('SAVE LOCALE IS ${myLocale.toString()}');
  //   }
  //   await Future.delayed(Duration(milliseconds: 300)).then((value) async {
  //    // await  Restart.restartApp().then((value) => navigateAndRemove(SplashScreen()));
  //     // RestartWidget.restartApp(context);
  //     //   navigateAndRemove(SplashScreen());
  //   });
  //   debugPrint('CUREENT LOCALE ${EasyLocalization.of(context)?.currentLocale.toString()}');
  // }

  changeChangeAccountValueState(int i) {
    accountList.forEach((element) {
      element.isTabbed = false;
    });
    accountList[i].isTabbed = !accountList[i].isTabbed;
    // subscribeId = allPackageSubscription.data![i].id;
    // price = allPackageSubscription.data![i].price;



    //  subscribeModel[0].isTabbed =!subscribeModel[1].isTabbed;
    emit(ChangeSubscribeState());
    log('<<<<<<<<<<<<<<<<<<<<<<<${accountList[i].isTabbed.toString()}>>>>>>>>>>>>>>>>>>');
  }

}
