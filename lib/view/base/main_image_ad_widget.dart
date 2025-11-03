import 'dart:io';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/dimention.dart';
import '../../utils/images.dart';
import '../../utils/text_style.dart';
//ignore: must_be_immutable
class MainImageAdWidget extends StatelessWidget {
  bool isListEmpty;
  Function? pickImage;
  File? imageFile;

  MainImageAdWidget(
      {super.key,
      required this.isListEmpty,
      this.pickImage,
      required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return isListEmpty
        ? GestureDetector(
            onTap: () {
              pickImage!();
            },
            child: Container(
              margin: EdgeInsetsDirectional.only(
                top: context.width * 0.02.sp,
              ),
              height: context.height * 0.15.sp,
              width: context.width * 0.24.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                border: Border.all(color: goldColor),
              ),
              child: Center(
                child: SvgPicture.asset(
                  Images.Add_SVG,
                ),
              ),
            ),
          )
        : Container(
            height: context.height * 0.15.sp,
            width: context.width * 0.24.sp,
            decoration: BoxDecoration(
                border: Border.all(color: goldColor),
                borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.RADIUS_DEFAULT.sp))),
            margin: EdgeInsetsDirectional.only(
                end: context.width * 0.02.sp,
                bottom: context.width * 0.02.sp,
                start: 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT.sp),
              child: Image.file(
                File(imageFile!.absolute.path),
                fit: BoxFit.cover,
              ),
            ),
          );
  }
}
