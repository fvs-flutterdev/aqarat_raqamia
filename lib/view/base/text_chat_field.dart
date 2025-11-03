
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../translation/locale_keys.g.dart';
import '../../utils/images.dart';
import '../../utils/text_style.dart';

class TextFieldChat extends StatelessWidget {
  final double paddingBottom;
  final TextEditingController controller;
  final Function onTap;
  final bool isChatSupport;
  final Function? pickImage;
  final Function sendMessage;
  const TextFieldChat({required this.controller,required this.onTap,required this.sendMessage,required this.paddingBottom,this.isChatSupport=false,this.pickImage});

  @override
  Widget build(BuildContext context) {
    return   Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          bottom:paddingBottom ,
          top: 6.h,
          start: 7.w,
          end: 7.w,
        ),
        child: Card(
          elevation: 3,
          margin: EdgeInsets.only(bottom: 15.h),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.sp)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            height: 64.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.sp),
                color: whiteColor),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onTap: () {
                      onTap();
                    },
                    controller:controller ,
                    style: openSansRegular.copyWith(
                        fontSize: 17, color: blackColor),
                    decoration: InputDecoration(
                        hintText:LocaleKeys.sendMessage.tr(),
                      //  LocaleKeys.sendMessage.tr(),
                        focusColor: blackColor,
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: whiteColor),
                          borderRadius:
                          BorderRadius.circular(20.sp),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: whiteColor),
                          borderRadius:
                          BorderRadius.circular(20.sp),
                        ),
                        border: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: whiteColor),
                          borderRadius:
                          BorderRadius.circular(20.sp),
                        )),
                  ),
                ),
                isChatSupport?  IconButton(onPressed: (){
                  pickImage!();
                }, icon:SvgPicture.asset(Images.IMAGE_CHAT)):SizedBox(),
                InkWell(
                  onTap: () {
                    sendMessage();

                  },
                  child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: SvgPicture.asset(
                        Images.SEND_TEXT_CHAT,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
