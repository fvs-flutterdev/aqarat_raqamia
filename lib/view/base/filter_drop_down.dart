import 'package:aqarat_raqamia/utils/images.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FilterDropDown extends StatelessWidget {
   List<DropdownMenuItem> items;
   var value;
       String hint;
       Function fct;
       bool? isRequestService;
      bool isFlag = false;
   FilterDropDown({super.key,this.value,required this.fct,required this.hint,required this.isFlag,
     required this.items,this.isRequestService=false});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsetsDirectional.only(
            start:isRequestService==true?0: context.width*0.1,
            end: isRequestService==true?0:context.width*0.1,
            top:  context.height*0.01,bottom:context.height*0.01),
        child: Container(
            margin: EdgeInsets.zero,
            padding:
            EdgeInsetsDirectional.only(start: isFlag ? 0 : 0.w, end:isFlag ?0: 10.w,bottom: 0),
            height: context.height*0.07,
            width: context.width,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6.sp),
                border: Border.all(color: darkGreyColor)
            ),
            child: Row(
              children: [
                Expanded(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    height: context.height*0.07,

                    child: DropdownButtonFormField(


                      isExpanded: true,
                      decoration: const InputDecoration(
                        // errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        border: InputBorder.none,
                      ),
                      hint: FittedBox(child: Text(hint,style: openSansBold.copyWith(color: darkGreyColor,fontSize: 14),)),
                      style: openSansRegular.copyWith(fontSize: 14,color: darkGreyColor,),
                      alignment: AlignmentDirectional.centerStart,
                      iconSize: 0.0,
                      borderRadius: BorderRadius.circular(12.sp),
                      value: value,

                      items: items,
                      onChanged: (v) {
                        fct(v);
                      },
                      // validator: (v) {
                      //   return validator!(v);
                      // },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10.0),
                  child: SvgPicture.asset(Images.ARROW_DROPDOWN,width: 6,height: 6,),
                )
              ],
            )));
  }
}
