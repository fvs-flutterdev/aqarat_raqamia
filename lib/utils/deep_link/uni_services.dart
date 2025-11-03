import 'dart:async';
import 'dart:developer';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/screens/details_screen/aqar_details_screen.dart';
import 'package:aqarat_raqamia/view/screens/splash/splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:uni_links2/uni_links.dart';

class UniServices {
  static String _code = '';

  static String get code => _code;

  static bool get hasCode => _code.isNotEmpty;

  static void reset() => _code = '';
  StreamSubscription? sub;

  init() async {
    try {
      final Uri? uri = await getInitialUri();
      uniHandler(uri);
      print('//////////URI DYNAMIC LINK////////////');
    } on PlatformException catch (e) {
      log('Failed to receive uri ??');
      log(e.toString());
    } on FormatException catch (e) {
      log('Wrong Format');
      log(e.toString());
    }
    sub = linkStream.listen(
      (String? uri) {
        uniHandler(Uri.parse(uri ?? ''));
        log('//////////URI DYNAMIC LINK//////3//////');
      },
      onError: (error) {
        log("OnUriLink ${error.toString()}");
      },
    );
  }

  dispose() {
    sub?.cancel();
  }

  String? receivedAdId;
  String? receivedCategoryId;

  uniHandler(Uri? uri) {
    print('/////////////$uri');
    //  if (uri == null || uri.queryParameters.isNotEmpty) return;
    Map<String, dynamic> param = uri?.queryParameters ?? {};
    receivedAdId = param['ad'];
    receivedCategoryId = param['cat'];

    if (receivedAdId != null) {
      //  startWidget=SplashScreen();
      print('////////////////////////${receivedAdId}  TEST');
      navigateForward(AqarDetailsScreen(
        adId: int.parse(receivedAdId ?? ''),
        categoryId: receivedCategoryId!,
      ));
    }
    // else {
    //
    // //  startWidget=
    //   navigateForward(SplashScreen());
    //   print('///////////////////////// No');
    // }
  }
}
