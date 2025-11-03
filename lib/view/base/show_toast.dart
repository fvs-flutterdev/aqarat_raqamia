import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/dimention.dart';
import '../../utils/text_style.dart';

// void showToast({required String text, required ToastState state}) =>
//     Fluttertoast.showToast(
//         msg: text,
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: chooseColor(state),
//         textColor: Colors.white,
//         fontSize: 16.0.sp);


void showCustomSnackBar({required String message, required ToastState state}) =>
    Fluttertoast.showToast(
        msg: message,

        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseColor(state),
        textColor: Colors.white,

        fontSize: 16.0.sp);

// void showCustomSnackBar(
//     {required String message, required BuildContext context,required ToastState state,bool isError=true,String? title}) {
//  // if (context != null) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       backgroundColor: chooseColor(state) ,
//
//      // snackPosition: SnackPosition.BOTTOM,
//       margin: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
//      // colorText: whiteColor,
//       duration: Duration(seconds: 3),
//
//       padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
//       content: Column(
//     children: [
//       Text(isError? 'Server Error':title!,style: openSansBold.copyWith(color: whiteColor),),
//       Text(message,style: openSansBold.copyWith(color: whiteColor),),
//     ],
//   )));
//     // Get.snackbar(
//     //   isError? 'Server Error':title!,
//     //   message,
//     //   backgroundColor: chooseColor(state),
//     //   snackPosition: SnackPosition.BOTTOM,
//     //   margin: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
//     //   colorText: whiteColor,
//     //   duration: Duration(seconds: 3),
//     //
//     // padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
//     // //  isDismissible: false
//     //
//     //
//     // );
//   // } else if (message != null && message.isNotEmpty) {
//   //   ScaffoldMessenger.of(context ?? Get.context!).showSnackBar(SnackBar(
//   //     dismissDirection: DismissDirection.horizontal,
//   //     margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//   //     duration: Duration(seconds: 3),
//   //     backgroundColor: isError ? Colors.red : Colors.green,
//   //     behavior: SnackBarBehavior.floating,
//   //     shape: RoundedRectangleBorder(
//   //         borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
//   //     content: Text(message, style: openSansMedium.copyWith(color: Colors.white)),
//   //   ));
//   //}
// }

enum ToastState { SUCCESS, ERROR, WARNING, }

Color chooseColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.WARNING:
      color = goldColor;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}