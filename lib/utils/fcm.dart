import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:aqarat_raqamia/bloc/profile_cubit/cubit.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:aqarat_raqamia/view/screens/notification/notification_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../model/dynamic_model/notification_body.dart';
import '../view/base/lunch_widget.dart';
import '../view/screens/chat/chat_with_client.dart';
import '../view/screens/my_orders/order_details_screen.dart';
import '../view/screens/providers/my_orders/providers_order_details.dart';
import 'app_constant.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // FirebaseMessaging.instance
  //     .getInitialMessage()
  //     .then((RemoteMessage? remoteMessage) {
  //   print('App Killed And navigate :${remoteMessage?.data}');
  //   try {
  //     //  NotificationBody _payload;
  //     NotificationNewBody _payload;
  //     if (remoteMessage?.data != null) {
  //       _payload = NotificationNewBody.fromJson(remoteMessage!.data);
  //       print('${_payload.notificationType}');
  //       if (_payload.notificationType == "message") {
  //         navigateForward(ChatWithCustomerScreen(
  //           channelId: _payload.senderId,
  //           name: _payload.senderName ?? '',
  //         ));
  //       } else if (_payload.notificationType == "offer") {
  //         if (_payload.receiverId == userId.toString()) {
  //           navigateForward(ClientOrderDetailsScreen(
  //             orderId: _payload.chatRoomId,
  //           ));
  //         } else if (_payload.receiverId != userId.toString()) {
  //           navigateForward(OrderDetailsProvidersScreen(
  //             orderId: _payload.chatRoomId,
  //           ));
  //         }
  //       } else {
  //         navigateForward(NotificationScreen());
  //       }
  //       // _payload = NotificationBody.fromJson(remoteMessage!.data);
  //       // print('${_payload.requestServiceId}');
  //       // if (accountType == 'service_provider') {
  //       //   navigateForward(OrderDetailsProvidersScreen(
  //       //     orderId: int.parse(_payload.requestServiceId),
  //       //   ));
  //       // } else {
  //       //   navigateForward(ClientOrderDetailsScreen(
  //       //     orderId: int.parse(_payload.requestServiceId),
  //       //   ));
  //       // }
  //     } else {
  //       navigateForward(NotificationScreen());
  //     }
  //   } catch (e) {
  //     navigateForward(NotificationScreen());
  //     print('///////123//////////////${e}');
  //   }
  // });
  // debugPrint("Handling a background message: ${message.notification?.title}");
}

StreamController<Map<String, dynamic>> _onMessageStreamController =
    StreamController.broadcast();

class FirebaseNotifications {
  late FirebaseMessaging _firebaseMessaging;

  StreamController<Map<String, dynamic>> get notificationSubject {
    return _onMessageStreamController;
  }

  void killNotification() {
    _onMessageStreamController.close();
  }

  late FlutterLocalNotificationsPlugin _notificationsPlugin;

  late Map<String, dynamic> _not;

  Future<void> setUpFirebase() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.instance.getInitialMessage();

    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.setAutoInitEnabled(true);
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    // checkLastMessage();
    firebaseCloudMessagingListeners();
    print('//////////FCM NOTIFICATIONS');

    _notificationsPlugin = FlutterLocalNotificationsPlugin();

    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = const DarwinInitializationSettings();
    var initSetting = InitializationSettings(android: android, iOS: ios);
    _notificationsPlugin.initialize(initSetting,
        // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
        // onDidReceiveNotificationResponse: notificationTapBackground,
        onDidReceiveBackgroundNotificationResponse: (_pay) async {
      print('<<<<<<<<<<<<<<<${_pay.payload}>>>>>>>>>>>>>>>');
      final String? payload = _pay.payload;
      try {
        if (payload != null || payload!.isNotEmpty) {
          NotificationNewBody _notificationBody =
              await convertNewNotification(jsonDecode(payload));
          print(
              '<<<<<<<<<<<<<<<<<${_notificationBody.chatRoomId}>>>>>>>>>>>>>>>>>');
          if (_notificationBody.notificationType == "message") {
            navigateForward(ChatWithCustomerScreen(
              channelId: _notificationBody.senderId,
              name: _notificationBody.senderName ?? '',
            ));
          }
          else if (_notificationBody.notificationType == "offer") {
            if (_notificationBody.receiverId == userId.toString()) {
              navigateForward(ClientOrderDetailsScreen(
                orderId: _notificationBody.chatRoomId,
              ));
            } else if (_notificationBody.receiverId != userId.toString()) {
              navigateForward(OrderDetailsProvidersScreen(
                orderId: _notificationBody.chatRoomId,
              ));
            }
          }
          else {
            navigateForward(NotificationScreen());
          }
          // NotificationBody _notificationBody =
          //     NotificationBody.fromJson(jsonDecode(payload));
          // if (accountType == 'service_provider' &&
          //     _notificationBody.userId != userId) {
          //   navigateForward(OrderDetailsProvidersScreen(
          //     orderId: int.parse(_notificationBody.requestServiceId),
          //   ));
          // } else {
          //   navigateForward(ClientOrderDetailsScreen(
          //     orderId: int.parse(_notificationBody.requestServiceId),
          //   ));
          // }
        } else {
          navigateForward(NotificationScreen());
        }
      } catch (e) {
        print(e);
        navigateForward(NotificationScreen());
        print('//////123');
      }
      return;

      ///
    }, onDidReceiveNotificationResponse: (_pay) async {
      print('<<<<<<<<<<<<<<<${_pay.payload}>>>>>>>>>>>>>>>');
      final String? payload = _pay.payload;
      try {
        if (payload != null || payload!.isNotEmpty) {
          NotificationNewBody _notificationBody =
              await convertNewNotification(jsonDecode(payload));
          print(
              '<<<<<<<<<<<<<<<<<${_notificationBody.chatRoomId}>>>>>>>>>>>>>>>>>');
          if (_notificationBody.notificationType == "message") {
            navigateForward(ChatWithCustomerScreen(
              channelId: _notificationBody.senderId,
              name: _notificationBody.senderName ?? '',
            ));
          } else if (_notificationBody.notificationType == "offer") {
            if (_notificationBody.receiverId == userId.toString()) {
              navigateForward(ClientOrderDetailsScreen(
                orderId: _notificationBody.chatRoomId,
              ));
            } else if (_notificationBody.receiverId != userId.toString()) {
              navigateForward(OrderDetailsProvidersScreen(
                orderId: _notificationBody.chatRoomId,
              ));
            }
          } else {
            navigateForward(NotificationScreen());
          }
          // NotificationBody _notificationBody =
          //     NotificationBody.fromJson(jsonDecode(payload));
          // if (accountType == 'service_provider' &&
          //     _notificationBody.userId != userId) {
          //   navigateForward(OrderDetailsProvidersScreen(
          //     orderId: _notificationBody.requestServiceId),
          //   ));
          // } else {
          //   navigateForward(ClientOrderDetailsScreen(
          //     orderId: int.parse(_notificationBody.requestServiceId),
          //   ));
          // }
        } else {
          navigateForward(NotificationScreen());
        }
      } catch (e) {
        print(e);
        navigateForward(NotificationScreen());
        print('//////123456');
      }
      // try {
      //   NotificationBody _payload;
      //   // if (payload != null && payload.isNotEmpty) {
      //   //   _payload = NotificationBody.fromJson(jsonDecode(payload));
      //   //   print('${_payload.requestServiceId}');
      //   //   if(accountType=='service_provider'){
      //   //     navigateForward(OrderDetailsProvidersScreen(orderId: int.parse(_payload.requestServiceId),));
      //   //
      //   //   }else{
      //   //     navigateForward(ClientOrderDetailsScreen(
      //   //       orderId: int.parse(_payload.requestServiceId),
      //   //     ));
      //   //   }
      //   //
      //   // } else {
      //     navigateForward(NotificationScreen());
      //  // }
      // } catch (e) {
      //   navigateForward(NotificationScreen());
      //   print('///////333//////////////${e}');
      // }
      return;

      ///
    }

        //  onDidReceiveBackgroundNotificationResponse: (_pay)

        //  onSelectNotification: onSelectNotification
        );
  }

  Future<void> checkLastMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      print(initialMessage.data.toString());
      handlePath(initialMessage.data);
    }
  }

  BuildContext? context;

  Future<void> firebaseCloudMessagingListeners() async {
    if (Platform.isIOS) iOSPermission();

    _firebaseMessaging.getToken().then((token) {
      print("TOOOKEN" + token!);
      fcmToken = token;
      print(fcmToken);
    });
    //   GetNotificationModel? notificationModel;
    FirebaseMessaging.onMessage.listen((RemoteMessage data) {
      // handlePath(data.data);
      print('on message notification body ${data.notification?.body}');
      print('on message notification title ${data.notification?.title}');
      print(
          'on message notification bodyLocKey ${data.notification?.bodyLocKey}');
      print(
          'on message notification titleLocKey ${data.notification?.titleLocKey}');

      _not = data.data;
      print('/////lllllllllllllllll${_not}');

      showNotification(
          data.data, data.notification?.title, data.notification?.body);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('on Opened ' + message.data.toString());
      try {
        if (message.data != null || message.data.isNotEmpty) {
          NotificationNewBody _notificationBody =
              convertNewNotification(message);
          print(
              '<<<<<<<<<<<<<<<<<<<<<${_notificationBody.chatRoomId}>>>>>>>>>>>>>>>>>>>>>');
          if (_notificationBody.notificationType == "message") {
            navigateForward(ChatWithCustomerScreen(
              channelId: _notificationBody.senderId,
              name: _notificationBody.senderName ?? '',
            ));
          } else if (_notificationBody.notificationType == "offer") {
            if (_notificationBody.receiverId == userId.toString()) {
              navigateForward(ClientOrderDetailsScreen(
                orderId: _notificationBody.chatRoomId,
              ));
            } else if (_notificationBody.receiverId != userId.toString()) {
              navigateForward(OrderDetailsProvidersScreen(
                orderId: _notificationBody.chatRoomId,
              ));
            }
          } else {
            navigateForward(NotificationScreen());
          }
          // if (accountType == 'service_provider' &&
          //     _notificationBody.userId != userId) {
          //   navigateForward(OrderDetailsProvidersScreen(
          //     orderId: int.parse(_notificationBody.requestServiceId),
          //   ));
          // } else {
          //   navigateForward(ClientOrderDetailsScreen(
          //     orderId: int.parse(_notificationBody.requestServiceId),
          //   ));
          // }
        } else {
          navigateForward(NotificationScreen());
        }
      } catch (e) {
        print(e);
        navigateForward(NotificationScreen());
        print('///0000000///123');
      }
      // handlePathByRoute(data.data);
      // handlePath(data.data);
    });
    // FirebaseMessaging.instance
    //     .getInitialMessage()
    //     .then((RemoteMessage? message) {
    //   try {
    //     //  NotificationBody _payload;
    //     NotificationNewBody _payload;
    //     if (message?.data != null) {
    //       _payload = NotificationNewBody.fromJson(message!.data);
    //       print('${_payload.notificationType}');
    //       if (_payload.notificationType == "message") {
    //         navigateForward(ChatWithCustomerScreen(
    //           channelId: _payload.senderId,
    //           name: _payload.senderName ?? '',
    //         ));
    //       } else if (_payload.notificationType == "offer") {
    //         if (_payload.receiverId == userId.toString()) {
    //           navigateForward(ClientOrderDetailsScreen(
    //             orderId: _payload.chatRoomId,
    //           ));
    //         } else if (_payload.receiverId != userId.toString()) {
    //           navigateForward(OrderDetailsProvidersScreen(
    //             orderId: _payload.chatRoomId,
    //           ));
    //         }
    //       } else {
    //         navigateForward(NotificationScreen());
    //       }
    //       // _payload = NotificationBody.fromJson(remoteMessage!.data);
    //       // print('${_payload.requestServiceId}');
    //       // if (accountType == 'service_provider') {
    //       //   navigateForward(OrderDetailsProvidersScreen(
    //       //     orderId: int.parse(_payload.requestServiceId),
    //       //   ));
    //       // } else {
    //       //   navigateForward(ClientOrderDetailsScreen(
    //       //     orderId: int.parse(_payload.requestServiceId),
    //       //   ));
    //       // }
    //     } else {
    //       navigateForward(NotificationScreen());
    //     }
    //   } catch (e) {
    //     navigateForward(NotificationScreen());
    //     print('///////123//////////////${e}');
    //   }
    // });
  }

  showNotification(Map<String, dynamic> _message, String? title, String? body
      //  String title,
      //  String body,
      // // String orderID,
      //  NotificationBody notificationBody,
      //  FlutterLocalNotificationsPlugin fln
      ) async {
    printLongString("Notification Response : $_message");

    var androidt = const AndroidNotificationDetails(
        'real_State',
        'real_State2',
        priority: Priority.high,
        channelShowBadge: true,
        playSound: true,
        // sound: RawResourceAndroidNotificationSound('notification'),
        ticker: 'ticker',
        largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        icon: "@mipmap/ic_launcher",
        enableVibration: true,
        enableLights: true,
        importance: Importance.max);
    var iost = const DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    var platform = NotificationDetails(android: androidt, iOS: iost);
    // await fln.show(0, title, body, platform,
    //     payload: notificationBody != null
    //         ? jsonEncode(notificationBody.toJson())
    //         : null);
    await _notificationsPlugin.show(
      0,
      title,
      body,
      platform,
      payload: jsonEncode(_message),
    );
  }

  Future<void> showNotificationWithAttachment(Map<String, dynamic> _message,
      String title, String body, String imageUrl) async {
    print("Notification Response : $_message");
    var attachmentPicturePath = await _downloadAndSaveFile(
        imageUrl ?? 'https://via.placeholder.com/800x200',
        'attachment_img.jpg');
    var iOSPlatformSpecifics = DarwinNotificationDetails(
      attachments: [DarwinNotificationAttachment(attachmentPicturePath)],
    );
    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(attachmentPicturePath),
      contentTitle: '<b>$title</b>',
      htmlFormatContentTitle: true,
      summaryText: '$body',
      htmlFormatSummaryText: true,
    );
    var androidChannelSpecifics = AndroidNotificationDetails(
      'real_State',
      'real_State2',

      // 'channel_description',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
    );
    var notificationDetails = NotificationDetails(
        android: androidChannelSpecifics, iOS: iOSPlatformSpecifics);
    print("notificationDetails $notificationDetails");
    await _notificationsPlugin.show(0, title, body, notificationDetails,
        payload: _message != null ? jsonEncode(_message) : null);
  }

//   static NotificationBody convertNotification(dynamic data) {
// // if (data['type'] == 'general') {
// //   return NotificationBody(notificationType: NotificationType.general);
// // } else if (data['type'] == 'order_status') {
// //   return NotificationBody(
// //       notificationType: NotificationType.order,
// //       orderId: int.parse(data['order_id']));
// // } else {
//     return NotificationBody(
//       id: data['id'],
//       updatedAt: data['updated_at'],
//       userId: data['user_id'],
//       bidDuration: data['bid_duration'],
//       commission: data['commission'],
//       createdAt: data['created_at'],
//       price: data['price'],
//       requestServiceId: data['request_service_id'],
//       serviceDetails: data['service_details'],
//     );
//
//     ///
//     return NotificationBody(
//       id: data['id'],
//       updatedAt: data['updated_at'],
//       userId: data['user_id'],
//       bidDuration: data['bid_duration'],
//       commission: data['commission'],
//       createdAt: data['created_at'],
//       price: data['price'],
//       requestServiceId: data['request_service_id'],
//       serviceDetails: data['service_details'],
//     );
//
//     ///
//
// // notificationType: NotificationType.message,
// // deliverymanId: data['sender_type'] == 'delivery_man' ? 0 : null,
// // adminId: data['sender_type'] == 'admin' ? 0 : null,
// // restaurantId: data['sender_type'] == 'vendor' ? 0 : null,
// // conversationId: int.parse(data['conversation_id'].toString()),
// //  );
// //  }
//   }

  static NotificationNewBody convertNewNotification(dynamic data) {
    return NotificationNewBody(
      receiverId: data['receiver_id'],
      chatRoomId: data['chat_room_id'],
      chatType: data['msg_type'],
      senderName: data['sender_name'],
      body: data['body'],
      notificationType: data['type'],
      title: data['title'],
      senderId: data['sender_id'],
    );
  }

  _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  void iOSPermission() {
    _firebaseMessaging.requestPermission(
        alert: true, announcement: true, badge: true, sound: true);
  }

  void handlePath(
    Map<String, dynamic> dataMap,
  ) {
    handlePathByRoute(
      dataMap,
    );
  }

  void onSelectNotification(String payload) async {
    print(payload.toString());
    handlePath(_not);
  }
//NotificationResponse notificationResponse
//   void notificationTapBackground(NotificationResponse notificationResponse) {
//     var androidInitialize =
//         new AndroidInitializationSettings('notification_icon');
//     var iOSInitialize = new DarwinInitializationSettings();
//     var initializationsSettings = new InitializationSettings(
//         android: androidInitialize, iOS: iOSInitialize);
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//     flutterLocalNotificationsPlugin.initialize(initializationsSettings);
//     //  _notificationsPlugin.show(message, flutterLocalNotificationsPlugin, true);
//     // ignore: avoid_print
//     // print('notification(${notificationResponse.id}) action tapped: '
//     //     '${notificationResponse.actionId} with'
//     //     ' payload: ${notificationResponse.payload.}');
//     // navigateForward(ClientOrderDetailsScreen(index: 0, orderId: dataMap['request_service_id'],
//     //   orderStatus: dataMap['status'],
//     //   serviceStatus: dataMap['order_status'],));
//      navigateForward(NotificationScreen());
//     // navigateForward(ClientOrderDetailsScreen(index: 0, orderId:int.parse(jsonEncode(data['request_service_id'])) ,
//     //     orderStatus:int.parse(jsonEncode(data['status'])) ,
//     //     serviceStatus:jsonEncode(data['order_status'])));
//   }
}

Future<void> handlePathByRoute(
  Map<String, dynamic> dataMap,
) async {
  String request = jsonEncode(dataMap['status']);
  print('@@@@@@@@#${request}');
// Get.to(() => NotificationScreen());
//navigateForward(NotificationScreen());
  print('/////////////#######${jsonEncode(dataMap['request_service_id'])}');
// navigateForward(ClientOrderDetailsScreen(index: 0, orderId:int.parse(jsonEncode(dataMap['request_service_id'])) ,
//   orderStatus:int.parse(jsonEncode(dataMap['status'])) ,
//   serviceStatus:jsonEncode(dataMap['order_status'])));
//
}
