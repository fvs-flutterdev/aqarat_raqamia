import '../../../../../../pusher_config/pusher.dart';
import '../../../../../../view/base/custom_text_field.dart';
import '../../../../../../view/base/lunch_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../translation/locale_keys.g.dart';
import '../../../../../utils/dimention.dart';
import '../../../../../utils/images.dart';
import '../../../../../utils/text_style.dart';
import '../../../../base/main_button.dart';
import '../../../chat/chat_with_client.dart';

class UserInfoWidget extends StatelessWidget {
  bool? isPrevious;
  bool? isUser;
  String? name;
  int? id;
  String? rate;
  String? type;
  String? image;
  bool? isPending;

  UserInfoWidget(
      {this.isPrevious = false,
      this.name,
      this.type,
      this.rate,
      this.id,
      this.isPending,
      this.isUser = false,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type ?? '',
          style: openSansExtraBold.copyWith(color: darkGreyColor),
        ),
        const  SizedBox(
          height: 5,
        ),
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius:  BorderRadius.circular(Dimensions.RADIUS_LARGE)),
          child: Container(
            //height: 200,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
            ),

            child: ListTile(
              // leading: CircleAvatar(
              //     backgroundColor: Colors.transparent,
              //     child: Image.network(image ?? '')),
              leading: ClipOval(
                child: CircleAvatar(
                    radius: 20.sp,
                    backgroundColor: transparentColor,
                    child: FancyShimmerImage(
                        imageUrl: image ?? '',

                        //   partnerSponsorCubit.partnerSponsorModel.data!.posterImage!,
                        errorWidget: Image.network(Images.AVATAR_IMAGE))),
              ),
              title: Text(
                name ?? '',
                style: openSansBold.copyWith(color: darkGreyColor),
              ),
              subtitle: isUser == true
                  ?const SizedBox()
                  : Row(
                      children: [
                        SvgPicture.asset(Images.STAR_SVG),
                        Text(
                          rate ?? '',
                          style: openSansRegular.copyWith(color: darkGreyColor),
                        )
                      ],
                    ),
              trailing:
                  //isPrevious==true?SizedBox():
                  isPending == true
                      ?const SizedBox()
                      : Container(
                          //width: 180.w,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                //  print(id.toString());
                                  LaravelEcho.init(token: id.toString());
                                  navigateForward(ChatWithCustomerScreen(
                                    name: name ?? '',
                                    channelId: id.toString(),
                                  ));
                                },
                                child: Container(
                                  padding:const EdgeInsets.all(18),
                                  child: SvgPicture.asset(
                                    Images.CHAT_SVG,
                                  ),
                                  decoration: BoxDecoration(
                                      color: lightGrey,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.RADIUS_LARGE)),
                                ),
                              ),
                            ],
                          ),
                        ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        isPrevious == true
            ?const SizedBox()
            : CustomButton(
                textButton: LocaleKeys.serviceReceived.tr(),
                onPressed: () {
                  showBottomSheet(
                      context: context,
                      builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus!.unfocus();
                          },
                          child: Container(
                            padding:
                            const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius:const BorderRadius.only(
                                    topRight: Radius.circular(
                                        Dimensions.RADIUS_LARGE),
                                    topLeft: Radius.circular(
                                        Dimensions.RADIUS_LARGE))),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    // LocaleKeys.
                                    'تقييم طالب الخدمه',
                                    style: openSansExtraBold.copyWith(
                                        color: darkGreyColor),
                                  ),
                                  const SizedBox(
                                    height: Dimensions.PADDING_SIZE_LARGE,
                                  ),
                                  const Divider(),
                                  Image.asset(Images.RATE),
                                  // StarRating(),
                                  CustomTextField(
                                    labelText: LocaleKeys.notes.tr(),
                                    maxHeight: 150,
                                    minHeight: 150,
                                    isBig: true,
                                    lines: 5,
                                  ),
                                  CustomButton(
                                    textButton: LocaleKeys.send.tr(),
                                    onPressed: () {},
                                    color: darkGreyColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                  // Get.bottomSheet(
                  //    );
                },
                color: darkGreyColor,
              ),
      ],
    );
  }
}
