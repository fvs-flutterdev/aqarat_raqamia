import 'dart:ffi';

import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/images.dart';
import '../../../../utils/text_style.dart';

class ContainerSponsorWidget extends StatelessWidget {
  final String text;
 final Function onTap;
   ContainerSponsorWidget({super.key,required this.text,required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        margin: EdgeInsets.all(5.sp),
        padding: EdgeInsets.symmetric(horizontal: 5.sp),
        height:50.sp,
      //  width: double.infinity,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          color: blackColor.withOpacity(0.2),

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,style: openSansMedium.copyWith(color: whiteColor),),
            SvgPicture.asset(Images.Filter_SVG)
          ],
        ),
      ),
    );
  }
}
