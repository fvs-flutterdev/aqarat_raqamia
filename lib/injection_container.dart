// import 'dart:convert';
//
// import 'package:aqarat_raqamia/utils/app_constant.dart';
// import 'package:aqarat_raqamia/utils/new_api_handle/api_consumer.dart';
// import 'package:aqarat_raqamia/utils/new_api_handle/app_interceptors.dart';
// import 'package:aqarat_raqamia/utils/new_api_handle/dio_consumer.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/services.dart';
// //import 'package:get_it/get_it.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'model/static_model/language_model.dart';
//
// //final sl = GetIt.instance;
//
// Future<Map<String, Map<String, String>>> init() async {
//   //! Features
//
//   // Blocs
//   // sl.registerFactory<RandomQuoteCubit>(
//   //         () => RandomQuoteCubit(getRandomQuoteUseCase: sl()));
//   // sl.registerFactory<LocaleCubit>(
//   //         () => LocaleCubit(getSavedLangUseCase: sl(), changeLangUseCase: sl()));
//   //
//   // // Use cases
//   // sl.registerLazySingleton<GetRandomQuote>(
//   //         () => GetRandomQuote(quoteRepository: sl()));
//   // sl.registerLazySingleton<GetSavedLangUseCase>(
//   //         () => GetSavedLangUseCase(langRepository: sl()));
//   // sl.registerLazySingleton<ChangeLangUseCase>(
//   //         () => ChangeLangUseCase(langRepository: sl()));
//   //
//   // // Repository
//   // sl.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(
//   //     networkInfo: sl(),
//   //     randomQuoteRemoteDataSource: sl(),
//   //     randomQuoteLocalDataSource: sl()));
//   // sl.registerLazySingleton<LangRepository>(
//   //         () => LangRepositoryImpl(langLocalDataSource: sl()));
//   //
//   // // Data Sources
//   // sl.registerLazySingleton<RandomQuoteLocalDataSource>(
//   //         () => RandomQuoteLocalDataSourceImpl(sharedPreferences: sl()));
//   //sl.registerLazySingleton<ProfileCubit>(
//   // () => ProfileCubit(apiConsumer: sl())..getProfileDate());
//   // sl.registerLazySingleton<LangLocalDataSource>(
//   //         () => LangLocalDataSourceImpl(sharedPreferences: sl()));
//   //
//   // //! Core
//   // sl.registerLazySingleton<NetworkInfo>(
//   //         () => NetworkInfoImpl(connectionChecker: sl()));
//   sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
//
//   //! External
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton(() => sharedPreferences);
//   sl.registerLazySingleton(() => AppInterceptors());
//   sl.registerLazySingleton(() => LogInterceptor(
//       request: true,
//       requestBody: true,
//       requestHeader: true,
//       responseBody: true,
//       responseHeader: true,
//       error: true));
//   //sl.registerLazySingleton(() => InternetConnectionChecker());
//   sl.registerLazySingleton(() => Dio());
//   Map<String, Map<String, String>> _languages = Map();
//   for(LanguageModel languageModel in AppConstant.languages) {
//     String jsonStringValues =  await rootBundle.loadString('assets/langs/${languageModel.languageCode}.json');
//     Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
//     Map<String, String> _json = Map();
//     _mappedJson.forEach((key, value) {
//       _json[key] = value.toString();
//     });
//     _languages['${languageModel.languageCode}_${languageModel.countryCode}'] = _json;
//   }
//   return _languages;
// }
