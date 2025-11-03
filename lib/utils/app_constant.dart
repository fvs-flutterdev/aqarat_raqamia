import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../model/static_model/language_model.dart';

var fcmToken;
var myLocale;
var token;
var userId;
var isProviderSubscribed;
var accountType;
var latAds;
var lngAds;
dynamic latAdsEdit;
dynamic lngAdsEdit;
var latUserRegister;
var lngUserRegister;
dynamic currentRegion;
bool? isEnglish;
double ratingCount=0.0;
String? previewImageUrl;
Widget? startWidget;
bool isSearchMode=false;
var isBioActiveForUser;

var verifyPassword;

class AppConstant {
  static const String APP_NAME = 'عقارات الرقمية';
  static const Size designSize = Size(375, 812);
  static double ratingCount = 0.0;

  //shared Key
  static const String LANGUAGE_CODE = 'language_code';
  static const String COUNTRY_CODE = 'country_code';
  static dynamic account_type = '';
  static List<LanguageModel> languages = [
    LanguageModel(
      // imageUrl: Images.arabic,
      languageName: 'عربى',
      countryCode: 'SA',
      languageCode: 'ar',
    ),
    LanguageModel(
      // imageUrl: Images.english,
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en',
    ),
  ];
}
