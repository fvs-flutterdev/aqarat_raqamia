import 'package:aqarat_raqamia/view/base/show_toast.dart';

import '../../../../utils/app_constant.dart';
import '../../../../utils/media_query_value.dart';
import '../../../../view/base/lunch_widget.dart';
import '../../../../view/screens/location/ads_on_map.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/images.dart';
import '../../../../utils/text_style.dart';
import '../../profile/profile_screen.dart';
import '../../providers/provider_profile/profile_provider_screen.dart';

class HomeHeaderScreen extends StatelessWidget {
  final String image;
  final double? height;

  HomeHeaderScreen({super.key, required this.image, this.height});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      bottom: false,
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: Dimensions.PADDING_SIZE_SMALL.sp, vertical: 0.0),
        //  height:height?? context.height * 0.11.sp,
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                  leading: Image.asset(
                    Images.SMALL_LOGO_ICON,
                    width: context.width * 0.1.sp,
                    height: context.height * 0.08.sp,
                  ),
                  title: Text(LocaleKeys.hello.tr()),
                  subtitle: Text(LocaleKeys.whatYouWantToSearch.tr()),
                  trailing: GestureDetector(
                      onTap: () {
                        navigateForward(AdsOnMap());
                      },
                      child: SvgPicture.asset(
                        Images.SearchIcon,
                        height: 25.sp,
                        width: 25.sp,
                      ))
                  // color: goldColor,
                  // onPressed: () {
                  //   navigateForward(AdsOnMap());
                  // },
                  // icon: Icon(
                  //   Icons.search,
                  // ),
                  // ),
                  ),
            ),
            SizedBox(
              width: context.width * 0.1.sp,
            ),
            GestureDetector(
              onTap: () {
                if(token==null){
                  showCustomSnackBar(message: LocaleKeys.loginFirst.tr(), state: ToastState.ERROR);
                  debugPrint('/////////////');
                }else {
                  if (accountType == 'service_provider') {
                    navigateForward(ProfileProviderScreen());
                  } else {
                    navigateForward(ProfileScreen());
                  }
                }
              },
              child: CircleAvatar(
                radius: 25.sp,
                backgroundColor: transparentColor,
                child: ClipOval(
                  child: FancyShimmerImage(
                    imageUrl: image,
                    errorWidget: Image.network(Images.AVATAR_IMAGE),
                  ),
                ),
                // backgroundImage:FancyShimmerImage(
                // imageUrl: image,
                // )
                //NetworkImage(Images.AVATAR_IMAGE),
              ),
            )
          ],
        ),
      ),
    );
  }
}
