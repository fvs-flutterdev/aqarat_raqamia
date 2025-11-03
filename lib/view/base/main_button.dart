import 'package:aqarat_raqamia/utils/dimention.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/text_style.dart';

class CustomButton extends StatelessWidget {
  final String textButton;
  final Function onPressed;
  Color? color = darkGreyColor;
  final double? height;
  final double? width;
  Color? textColor ;
  Color? borderColor ;
  final double? radius;

  CustomButton({
      super.key,
      required this.textButton,
      required this.onPressed,
      this.width,
      this.radius = 10,
      this.height,
      this.textColor,
      this.borderColor,
      this.color,
      });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          onPressed();
        },
        style: TextButton.styleFrom(
          backgroundColor: color,
          minimumSize: Size(width ?? Dimensions.WEB_MAX_WIDTH, height ?? context.width*0.14.sp),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!),
            side: BorderSide(color: borderColor??Colors.transparent)
          ),
        ),
        child: Text(
          textButton,style: openSansRegular.copyWith(color: textColor??whiteColor),
        ),
    );
  }
}




class VerificationButton extends StatelessWidget {
  final Function onPressed;
  const VerificationButton({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
          onPressed: () {
            onPressed();
          },
          style: TextButton.styleFrom(
            backgroundColor: darkGreyColor,
            minimumSize: Size(70, 70),
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
            ),
          ),
          child:Icon(Icons.arrow_forward,color: whiteColor,)
      ),
    );
  }
}

