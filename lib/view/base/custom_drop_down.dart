import 'package:aqarat_raqamia/utils/images.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/dimention.dart';

class CustomDropDown extends StatelessWidget {
  List<DropdownMenuItem> items;
  var value;
  String hint;
  Function fct;
  bool isFlag;
  //bool isFilter;
  double? topPadding;

  CustomDropDown({
    required this.items,
    required this.value,
    required this.fct,
    required this.hint,
    this.topPadding,
    this.isFlag = false,
   // this.isFilter=false
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Padding(
        padding: EdgeInsetsDirectional.only(bottom: 5.h, top:topPadding?? 10.h),
        child: Container(
          padding:
              EdgeInsetsDirectional.only(start: isFlag ? 0 : 10.w, end: 10.w),
          height: context.width * 0.14,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
              border: Border.all(color: whiteGreyColor)),
          child: Row(
            children: [
              Expanded(
                child: ButtonTheme(

                //  padding: EdgeInsetsDirectional.only(start: context.height*0.3),
                  alignedDropdown: true,
                  height: context.width * 0.15,
                  child: DropdownButtonFormField(
                    //padding: EdgeInsetsDirectional.only(bottom: context.height*0.01.h),
                    isExpanded: true,
                    decoration: const InputDecoration(
                      // errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      border: InputBorder.none,
                    ),
                    hint: FittedBox(
                        child: Text(
                      hint,
                      style: openSansMedium.copyWith(color: darkGreyColor),
                      //  style: Theme.of(context).textTheme.labelSmall,
                    )),
                    style: openSansMedium.copyWith(color: darkGreyColor),
                    iconSize: 0.0,
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                    value: value,
                    items: items,
                    onChanged: (v) {
                      fct(v);
                    },
                  ),
                ),
              ),
              SvgPicture.asset(Images.ARROW_DROPDOWN)
            ],
          ),
        ),
      ),
    );
  }
}
