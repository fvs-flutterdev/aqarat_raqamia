import '../../../../view/screens/real_state_Ads/widget/vision_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/text_style.dart';

class ViewWidgetColumn extends StatelessWidget {
  final bool isEdit;
  final bool? isSameVision;
  final String? visionName;

  const ViewWidgetColumn(
      {super.key, this.isEdit = false, this.isSameVision, this.visionName});

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.synchronized(
      duration: Duration(milliseconds: 370),
      child: SlideAnimation(
          curve: Curves.easeOutBack,
          verticalOffset: 50.0.sp,
          child: FadeInAnimation(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.view.tr(),
                style: openSansExtraBold.copyWith(color: darkGreyColor),
              ),
              isEdit == true
                  ? VisionListForEditWidget(
                      isSameVision: isSameVision,
                      visionName: visionName,
                    )
                  : VisionListWidget(),
            ],
          ))),
    );
  }
}
