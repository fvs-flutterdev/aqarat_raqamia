import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//Color goldColor = Color(0xffC4B396);
Color goldColor = const Color(0xffB8A68D);
Color lightYellowColor = const Color(0xffFFF7EA);
Color darkGreysColor = const Color(0xff72828A);
Color darkGreyColor = const Color(0xff347782);
Color lightDarkMain = const Color(0xff579fa3);
Color lightDarkMain1 = const Color(0xff80AFAF);
Color whiteGreyColor = const Color(0xffC4CDD2);
Color redColor = const Color(0xffE37D7D);
Color whiteColor = const Color(0xffFFFFFF);
Color brownColor =const Color(0xff3C3C3B);
Color lightGrey = const Color(0xFFEFF5F8);
Color yellowColor = const Color(0xFFE0E37D);
Color blackColor = const Color(0xff393939);
Color transparentColor = Colors.transparent;

//final String googleApiKeyAndroid='AIzaSyAdMQuOnOTNXKJbBnh46Itl06sMIPQfjgc';
//final String googleApiKeyIOS='AIzaSyAqld28c3M4zNPxKPvXj3eb3WzqrrrDbOY';

final openSansRegular = TextStyle(
  fontFamily: 'Changa-regular',
  fontWeight: FontWeight.w400,
  fontSize: 14.sp,
);

final openSansMedium = TextStyle(
  fontFamily: 'Changa-Medium',
  fontWeight: FontWeight.w500,
  fontSize: 14.sp,
);

final openSansBold = TextStyle(
  fontFamily: 'Changa',
  fontWeight: FontWeight.w600,
  fontSize: 14.sp,
);
final openSansExtraBold = TextStyle(
  fontFamily: 'Changa-ExtraBold',
  fontWeight: FontWeight.w700,
  fontSize: 14.sp,
);

final openSansBlack = TextStyle(
  fontFamily: 'Changa-Light',
//  fontWeight: FontWeight.w900,
  fontSize: 14.sp,
);

void printLongString(var text) {
  final RegExp pattern =
      RegExp('.{1,5800000}'); // 800 is the size of each chunk
  pattern
      .allMatches(text)
      .forEach((RegExpMatch match) => print(match.group(0)));
}
