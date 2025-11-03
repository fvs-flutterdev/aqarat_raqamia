
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/text_style.dart';

class RowMoreWidget extends StatelessWidget {
  final String text;
  final Function navigation;
 // final Function? reload;
  final bool isSponsorAD;
   RowMoreWidget({super.key,required this.text,required this.navigation,
   //  this.reload,
      this.isSponsorAD=false,
   });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: openSansExtraBold.copyWith(
              color: darkGreyColor,
              fontSize: 18.sp),
        ),
        // Row(
        //   children: [
          //  isComment==true?  IconButton(onPressed: (){reload!();}, icon:Icon(Icons.refresh,color: darkGreysColor,) ):SizedBox(),
        isSponsorAD==true?SizedBox():  TextButton(onPressed: (){
              navigation();
            //
            }, child:Text('${LocaleKeys.more.tr()} >>', style: openSansMedium.copyWith(
                decoration: TextDecoration.underline,
                color: darkGreyColor,
                fontSize: 14.sp),
            )),
        //   ],
        // )
      ],
    );
  }
}
