import 'dart:io';

import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/view/base/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/dimention.dart';
import '../../utils/images.dart';
import '../../utils/text_style.dart';

class AuthHeader extends StatelessWidget implements PreferredSizeWidget {
  double? height;
  bool isCanBack;
  String? title;
  Function? onTap;

  AuthHeader({super.key, this.height, this.isCanBack = true, this.title,this.onTap});

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size(Dimensions.WEB_MAX_WIDTH, Platform.isWindows ? 70.h : 100.h);

  //Size get preferredSize => throw UnimplementedError();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: transparentColor,
      elevation: 0,
      toolbarHeight: context.height * 0.1.sp,
      title: Text(
        title ?? '',
        style: openSansBold.copyWith(
            color: Colors.white, fontSize: context.height * 0.02.sp),
      ),
      centerTitle: true,
      leading: Padding(
        padding:  EdgeInsets.all(8.0.sp),
        child: isCanBack ? BackButtonWidget(onTap: onTap,) : const SizedBox(),
      ),
      flexibleSpace: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            height: context.height * 0.15.sp,
            decoration: BoxDecoration(
              color: darkGreyColor,
              border: Border.all(color: goldColor),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.RADIUS_LARGE.sp),
                  bottomRight: Radius.circular(Dimensions.RADIUS_LARGE.sp)),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Image.asset(
                Images.SMALL_LOGO_ICON,
                height: 37.h,
                width: 37.w,
              ),
            ),
          )
        ],
      ),
    );
  }
}
