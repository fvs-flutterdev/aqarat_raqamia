// import 'dart:convert';
//
// import 'package:aqarat_raqamia/controller/account_type_controller.dart';
// import 'package:aqarat_raqamia/controller/filter_controller.dart';
// import 'package:aqarat_raqamia/controller/login_controller.dart';
// import 'package:aqarat_raqamia/controller/nav_bar_controller.dart';
// import 'package:aqarat_raqamia/controller/register_provider_controller.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/get_instance.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../controller/add_real_state_controller.dart';
// import '../controller/loaction_controller.dart';
// import '../controller/localization_controller.dart';
// import '../controller/onboarding_controller.dart';
// import '../controller/providers_controller/profile_provider_controller.dart';
// import '../controller/upload_request_controller.dart';
// import '../model/static_model/language_model.dart';
// import '../utils/app_constant.dart';
//
// Future<Map<String, Map<String, String>>> init() async {
//   final sharedPreferences = await SharedPreferences.getInstance();
//   Get.lazyPut(() => sharedPreferences);
//   Get.lazyPut(() => LocalizationController(
//         sharedPreferences: Get.find(),
//       ));
//   Get.lazyPut(() => OnBoardingController());
//   Get.lazyPut(() => AccountTypeController());
//   Get.lazyPut(() => NavBarController());
//   Get.lazyPut(() => FilterController());
//   Get.lazyPut(() => UploadRequestController());
//   Get.lazyPut(()=>LocationController()..toggleServiceStatusStream());
//   Get.lazyPut(()=>AddRealStateAdsController());
//   Get.lazyPut(()=>UserLoginController());
//   Get.lazyPut(()=>RegisterProviderController());
//   Get.lazyPut(()=>ProfileProviderController());
//
//  // Get.lazyPut(()=>UserLoginController());
//
//   Map<String, Map<String, String>> _languages = Map();
//   for (LanguageModel languageModel in AppConstant.languages) {
//     String jsonStringValues = await rootBundle
//         .loadString('assets/language/${languageModel.languageCode}.json');
//     Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
//     Map<String, String> _json = Map();
//     _mappedJson.forEach((key, value) {
//       _json[key] = value.toString();
//     });
//     _languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
//         _json;
//   }
//   return _languages;
// }
