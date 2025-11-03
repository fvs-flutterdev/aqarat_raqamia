import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/text_style.dart';
import 'details_ad_on_map.dart';

class DragabbleWidget extends StatelessWidget {
  const DragabbleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd:
          (dragEndDetails) {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return DraggableScrollableSheet(
                maxChildSize: 1,
                initialChildSize: 0.99,
                snap: true,
                // snapSizes: TODO
                expand: false,
                builder: (context,
                    scrollController) =>
                    DetailsAdOnMap(
                      scrollController:
                      scrollController,
                    ),
              );
            });
      },
      child: Container(
        padding:
        EdgeInsetsDirectional.only(
            top: 5.sp),
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius:
            BorderRadius.only(
                topRight:
                Radius.circular(
                    15.sp),
                topLeft: Radius
                    .circular(
                    15.sp))),
        width: double.infinity,
        height: context.height * 0.1.sp,
        child: Column(
          children: [
            Icon(
              Icons.arrow_circle_up,
              color: darkGreyColor,
            ),
            Text(
              LocaleKeys.dragToTop.tr(),
              textAlign:
              TextAlign.center,
              style:
              openSansBold.copyWith(
                  color:
                  darkGreyColor),
            ),
          ],
        ),
      ),
    );
  }
}
