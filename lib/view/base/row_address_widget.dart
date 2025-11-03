import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../translation/locale_keys.g.dart';
import '../../utils/text_style.dart';

class RowAddressLocation extends StatelessWidget {
  final String region,city,district;

  const RowAddressLocation({super.key,required this.region,required this.city,required this.district});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
         // flex: 1,
          child: AutoSizeText.rich(
            TextSpan(
              text: '${LocaleKeys.region.tr()} : ',
              children: [
                TextSpan(
                  text:region,
                 // '${widget.listMyAds[widget.index].region}',
                  style: openSansBold.copyWith(
                      color: goldColor,fontSize: 15.sp),
                )
              ],
              style: openSansBold.copyWith(
                  color: darkGreyColor,fontSize: 15.sp),
            ),
            presetFontSizes: [15.sp, 11.sp, 10.sp],
            softWrap: true,
            maxLines: 1,
          ),
        ),
        Expanded(
          child: AutoSizeText.rich(
            TextSpan(
              text: '${LocaleKeys.city.tr()} : ',
              children: [
                TextSpan(
                  text:city,
                 // '${widget.listMyAds[widget.index].city}',
                  style: openSansBold.copyWith(
                      color: goldColor,fontSize: 15.sp),
                )
              ],
              style: openSansBold.copyWith(
                  color: darkGreyColor,fontSize: 15.sp),
            ),
            presetFontSizes:[15.sp, 11.sp, 9.sp],
            softWrap: true,
            maxLines: 1,
          ),
        ),

        Expanded(
          child: AutoSizeText.rich(
            TextSpan(
              text: '${LocaleKeys.district.tr()} : ',
              children: [
                TextSpan(
                  text:district,
                //  '${widget.listMyAds[widget.index].district}',
                  style: openSansBold.copyWith(
                      color: goldColor,fontSize: 15.sp),
                )
              ],
              style: openSansBold.copyWith(
                  color: darkGreyColor,fontSize: 15.sp),
            ),
            presetFontSizes:[15.sp, 11.sp, 9.sp],
            softWrap: true,
            maxLines:1,
          ),
        ),
        // AutoSizeText('المدينه : ${widget.listMyAds[widget.index].city}',presetFontSizes: [11.sp,9.sp,7.sp],style: openSansRegular.copyWith(color: darkGreyColor)),
        // AutoSizeText('الحي : ${widget.listMyAds[widget.index].district}',presetFontSizes: [11.sp,9.sp,7.sp],style: openSansRegular.copyWith(color: darkGreyColor)),
      ],
    );
  }
}
