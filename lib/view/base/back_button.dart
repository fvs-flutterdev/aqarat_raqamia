import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/text_style.dart';

class BackButtonWidget extends StatelessWidget {
  Color? color;
  double? radius;
  Color? foregroundColor;
  Function? onTap;

  BackButtonWidget(
      {super.key, this.color, this.radius, this.foregroundColor, this.onTap});

  @override
  Widget build(BuildContext context) {

    return InkWell(
        onTap: () {
          onTap == null ? Navigator.pop(context) : onTap!();
        },
        child: CircleAvatar(
          foregroundColor: foregroundColor ?? goldColor,
          backgroundColor: color ?? goldColor,
          radius: radius ?? 15.sp,
          child: FittedBox(
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: whiteColor,
            ),
          ),
        ));
  }
}
