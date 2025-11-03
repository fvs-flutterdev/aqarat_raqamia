import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/text_style.dart';

class ContainerSponsorDetails extends StatelessWidget {
  final String text;
  final Function onTap;
  ContainerSponsorDetails({super.key,required this.text,required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        margin: EdgeInsets.all(5.sp),
        padding: EdgeInsets.symmetric(horizontal: 5.sp),
        width: context.width*0.5.sp,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          color: blackColor.withOpacity(0.2),

        ),
        child: Text(text,style: openSansMedium.copyWith(color: whiteColor),),
      ),
    );
  }
}
