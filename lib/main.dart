import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/screens/chat/chat_with_client.dart';
import 'package:aqarat_raqamia/view/screens/my_orders/order_details_screen.dart';
import 'package:aqarat_raqamia/view/screens/notification/notification_screen.dart';
import 'package:aqarat_raqamia/view/screens/providers/my_orders/providers_order_details.dart';
//import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc_observe.dart';
import 'model/dynamic_model/notification_body.dart';
import '../translation/codegen_loader.g.dart';
import '../utils/app_constant.dart';
import '../theme/light_theme.dart';
import '../utils/bloc_provider.dart';
import '../utils/fcm.dart';
import '../utils/navigation_service.dart';
import '../utils/shared_pref.dart';
import '../utils/text_style.dart';
import '../view/screens/splash/splash_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// void registerWindowsProtocol() {
//   // Register our protocol only on Windows platform
//   if (!kIsWeb) {
//     if (Platform.isWindows) {
//       registerProtocolHandler(kWindowsScheme);
//     }
//   }
// }

Future<void> main() async {
  // if (ResponsiveHelper.isMobilePhone()) {
  //   HttpOverrides.global = new MyHttpOverrides();
  // }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // options: DefaultFirebaseOptions.currentPlatform,
  // await di.init();
  await Future.wait([
    EasyLocalization.ensureInitialized(),
  ]);
  await Permission.notification.request();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // navigation bar color
    statusBarColor: transparentColor,
  ));
  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();
  // await UniServices().init();
  await FirebaseMessaging.instance.getToken().then((token) {
    debugPrint(
        '<<<<<<<<<<<<<<<FCM<<<<<<<<<<<<<$token>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    fcmToken = CacheHelper.saveData(key: 'fcmToken', value: token);
  });

  fcmToken = CacheHelper.getData(key: 'fcmToken');
  debugPrint(
      '<<<<<<<<<<FCM<<<<<<<<<<<<<<<<<${fcmToken.toString()}>>>>>>>>>>>>>>>>>>>>>>>>>>>');
  if (CacheHelper.getData(key: 'token') == null) {
    debugPrint('Nooooooooooo');
  } else {
    token = CacheHelper.getData(key: 'token');
    userId = CacheHelper.getData(key: 'UserId');
    accountType = CacheHelper.getData(key: 'status');
    verifyPassword = CacheHelper.getData(
      key: 'VerifyPass',
    );
    isBioActiveForUser = CacheHelper.getData(
      key: 'IsBio',
    );
    isProviderSubscribed = CacheHelper.getData(key: 'isSubscribed');
    debugPrint('<<<<<MY TOKEN<<<<<<<<<${token.toString()}>>>>>>>>>>>>>>');
    debugPrint('<<<<<<<<<<<<<<${accountType.toString()}>>>>>>>>>>>>>>');
    debugPrint('<<<<<<<<<<<<<<${userId.toString()}>>>>>>>>>>>>>>');
    debugPrint(
        '<<<<<<<<<<<<<<${isProviderSubscribed.toString()}>>>>>>>>>>>>>>');
    debugPrint('<<<<<<<<<<<<<<${isBioActiveForUser.toString()}>>>>>>>>>>>>>>');
    debugPrint('<<<<<<<<<<<<<<${verifyPassword.toString()}>>>>>>>>>>>>>>');
  }
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   // navigation bar color
  //   statusBarColor: darkGreyColor,
  //   systemNavigationBarColor: transparentColor,
  //   systemStatusBarContrastEnforced: true,
  //
  // ));
  await FirebaseNotifications().setUpFirebase();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // NotificationBody body;
  //  NotificationNewBody body;
  //  try {
  //    // if (Platform.) {
  //    final RemoteMessage? remoteMessage =
  //        await FirebaseMessaging.instance.getInitialMessage();
  //    if (remoteMessage != null) {
  //      body = FirebaseNotifications.convertNewNotification(remoteMessage.data);
  //      await FirebaseNotifications().setUpFirebase();
  //      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  //    }
  //
  //    //  }
  //  } catch (e) {
  //    debugPrint('//////////////#${e.toString()}');
  //  }
  ///
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    // Store this message to be handled after the app is fully initialized
    await _storeInitialMessage(initialMessage);
  }
  // await FirebaseMessaging.instance
  //     .getInitialMessage()
  //     .then((RemoteMessage? remoteMessage) {
  //   if (remoteMessage != null) {
  //     if(accountType=='service_provider'){
  //       navigateForward(OrderDetailsProvidersScreen(orderId: int.parse(body.requestServiceId),));
  //
  //     }else{
  //       navigateForward(ClientOrderDetailsScreen(
  //         orderId: int.parse(body.requestServiceId),
  //       ));
  //     }
  //     navigateForward(NotificationScreen());
  //   }
  // });
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // await SentryFlutter.init((options) {
  //   options.dsn = BaseUrl.SentryUrl;
  //   // 'https://4b2cfba89a25635305eec9d2c04677d1@o4508255820972032.ingest.de.sentry.io/4508255822479440';
  //   // options.environment=kReleaseMode?'production':'development';
  //   options.experimental.replay.sessionSampleRate = 1.0;
  //   options.experimental.replay.onErrorSampleRate = 1.0;
  //   options.experimental.replay.redactAllImages = true;
  //   options.experimental.replay.redactAllImages = true;
  // }, appRunner: () {
  //
  // });
  runApp(
    EasyLocalization(
      //,  Locale('en')
      supportedLocales: const [Locale('ar'), Locale('en')],
      //  path: "assets/langs",
      path: BaseUrl.LangUrl,
      assetLoader: const CodegenLoader(),
      startLocale: Locale('ar'),
      child: MyApp(),
    ),
  );
  // Widget mainWidget;
  // if(UniServices().receivedAdId==null){
  //   mainWidget=SplashScreen();
  // }else{
  //   mainWidget= AqarDetailsScreen(adId:int.parse(UniServices().receivedAdId??'') ,
  //        categoryId: UniServices().receivedCategoryId!,);
  // }
}

Future<void> _storeInitialMessage(RemoteMessage message) async {
  // You can use shared_preferences or any other storage method
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('initial_message', jsonEncode(message.data));
}

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    _setupInteractedMessage();
  }

  Future<void> _setupInteractedMessage() async {
    // Check for the initial message stored earlier
    await _checkInitialMessage();

    // Handle any future messages when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  Future<void> _checkInitialMessage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? initialMessageString = prefs.getString('initial_message');

    if (initialMessageString != null) {
      final initialMessageData = jsonDecode(initialMessageString);
      _handleMessage(RemoteMessage(data: initialMessageData));
      // Clear the stored message
      await prefs.remove('initial_message');
    }
  }

  void _handleMessage(RemoteMessage message) {
    print('Handling message: ${message.data}');
    try {
      NotificationNewBody _payload = NotificationNewBody.fromJson(message.data);
      if (_payload.notificationType == "message") {
        navigateForward(ChatWithCustomerScreen(
          channelId: _payload.senderId,
          name: _payload.senderName ?? '',
        ));
      } else if (_payload.notificationType == "offer") {
        if (_payload.receiverId == userId.toString()) {
          navigateForward(ClientOrderDetailsScreen(
            orderId: _payload.chatRoomId,
          ));
        } else if (_payload.receiverId != userId.toString()) {
          navigateForward(OrderDetailsProvidersScreen(
            orderId: _payload.chatRoomId,
          ));
        }
      } else {
        navigateForward(NotificationScreen());
      }
    } catch (e) {
      navigateForward(NotificationScreen());
      // _navigateToScreen(NotificationScreen());
      print('Error handling notification: $e');
    }
  }

  void _navigateToScreen(Widget screen) {
    // Use this method to navigate after the app is fully initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
    });
  }

  ///
  // @override
  // void initState() {
  //   super.initState();
  //   setupInteractedMessage();
  // }
  // Future<void> setupInteractedMessage() async {
  //   // Get any messages which caused the application to open from a terminated state.
  //   RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  //
  //   // If the message also contains a data property with a "type" of "chat",
  //   // navigate to a chat screen
  //   if (initialMessage != null) {
  //     _handleMessage(initialMessage);
  //   }
  //
  //   // Also handle any interaction when the app is in the background via a Stream listener
  //   FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  //   FirebaseMessaging.g
  // }
  //
  // void _handleMessage(RemoteMessage message) {
  //   print('App opened from notification: ${message.data}');
  //   try {
  //     NotificationNewBody _payload = NotificationNewBody.fromJson(message.data);
  //     if (_payload.notificationType == "message") {
  //       navigateForward(ChatWithCustomerScreen(
  //         channelId: _payload.senderId,
  //         name: _payload.senderName ?? '',
  //       ));
  //     } else if (_payload.notificationType == "offer") {
  //       if (_payload.receiverId == userId.toString()) {
  //         navigateForward(ClientOrderDetailsScreen(
  //           orderId: _payload.chatRoomId,
  //         ));
  //       } else if (_payload.receiverId != userId.toString()) {
  //         navigateForward(OrderDetailsProvidersScreen(
  //           orderId: _payload.chatRoomId,
  //         ));
  //       }
  //     } else {
  //       navigateForward(NotificationScreen());
  //     }
  //   } catch (e) {
  //     navigateForward(NotificationScreen());
  //     print('Error handling notification: $e');
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    myLocale = EasyLocalization.of(context)?.currentLocale;
    debugPrint('my locale ${myLocale.toString()}');
    isEnglish = CacheHelper.getData(key: 'isEnglish') ?? false;
    return BlocProviders(
      child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          designSize: AppConstant.designSize,
          builder: (context, widget1) {
            return OverlaySupport(
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                builder: (context, widget1) => MediaQuery(
                  // data: MediaQuery.of(context)
                  //     .copyWith(textScaler: TextScaler.linear(0.9)),
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
                  child: widget1 ?? Container(),
                ),
                title: AppConstant.APP_NAME,
                theme: light,
                navigatorKey: NavigationService.navigate().navigationKey,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                scrollBehavior: MaterialScrollBehavior().copyWith(
                  dragDevices: {
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.touch
                  },
                ),
                home: SplashScreen(),
              ),
            );
          }),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void responsiveInit(BuildContext context) {
//  context.isDarkMode;
  ScreenUtil.init(context,
      designSize: AppConstant.designSize,
      minTextAdapt: true,
      splitScreenMode: true);
}
