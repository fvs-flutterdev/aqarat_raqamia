import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/dimention.dart';
import '../../utils/images.dart';
import '../../utils/text_style.dart';
import '../screens/providers/my_services/my_services.dart';
import 'back_button.dart';
import 'custom_dialog_pick_image.dart';

class ProfileHeader extends StatelessWidget {
  final bool isProvider;
  final String name;
  final Image image;
  double? rate;
  String? rateNo;
  final Function pickGallery;
  final Function pickCamera;
  final bool isVerified;

  ProfileHeader(
      {super.key,
      this.isProvider = false,
      this.isVerified = false,
      this.rate,
      this.rateNo,
      required this.name,
      required this.pickGallery,
      required this.pickCamera,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      //294
      height: context.width * 0.63.sp,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: context.width * 0.6.sp,
            width: double.infinity,
            child: Image.asset(
              Images.HEADER_PROFILE,
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                top: context.height * 0.01.sp,
                start: context.width * 0.05.sp,
              ),
              child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: BackButtonWidget(
                    radius: 17.sp,
                  )),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                top: context.height * 0.01.sp,
              ),
              child: Center(
                child: Column(
                  //  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.profilePersonal.tr(),
                      style: openSansBold.copyWith(color: whiteColor),
                    ),
                    Container(
                      height: context.width * 0.21.sp,
                      width: context.width * 0.21.sp,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: image.image, fit: BoxFit.fill),
                        color: whiteColor,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Image.asset(image),
                          CustomAlertDialog(pickGallery: () {
                            pickGallery();
                          }, pickCamera: () {
                            pickCamera();
                          }),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          style: openSansBold.copyWith(color: whiteColor),
                        ),
                        SizedBox(
                          width: context.width * 0.01.sp,
                        ),
                        isVerified
                            ? SvgPicture.asset(Images.VERIFIED)
                            : SizedBox(),
                        SizedBox(
                          width: context.width * 0.01.sp,
                        ),
                        // isVerified
                        //     ?
                        SvgPicture.asset(
                          Images.STAR_SVG,
                        ),
                        // : SizedBox(),
                        SizedBox(
                          width: context.width * 0.01.sp,
                        ),
                        isVerified
                            ? RichText(
                                text: TextSpan(
                                    style: openSansBold.copyWith(
                                        color: whiteColor),
                                    text: rate == null
                                        ? ''
                                        : '${rate?.toStringAsFixed(1)}',
                                    children: [
                                      TextSpan(
                                        text: '($rateNo)',
                                        style: openSansBold.copyWith(
                                            color: whiteColor),
                                      )
                                    ]),
                              )
                            : SizedBox()
                        // isVerified
                        //     ? Text(
                        //         '4.2 (2)',
                        //         style:
                        //             openSansBold.copyWith(color: whiteColor),
                        //       )
                        //     : SizedBox()
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_LARGE),
                child: Image.asset(
                  Images.SMALL_LOGO_ICON,
                  width: 37.sp,
                  height: 37.sp,
                ),
              )),
          isProvider
              ? Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        child: Text(LocaleKeys.myServices.tr(),
                            style: openSansBold.copyWith(
                                color: whiteColor,
                                decoration: TextDecoration.underline)),
                        onPressed: () {
                          navigateForward(MyServices());
                          //Get.to(() => MyServices());
                        },
                      )),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
