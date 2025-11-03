import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../utils/text_style.dart';

class ContactUsWidget extends StatelessWidget {
  final Function fct;
  final String contactInfo;
  final String svgPic;

  ContactUsWidget(
      {super.key,
      required this.fct,
      required this.contactInfo,
      required this.svgPic});

  @override
  Widget build(BuildContext context) {
    // var contactUsCubit = context.read<ContactUsCubit>();
    return GestureDetector(
      onTap: () {
        fct();
      },
      child: Row(
        children: [
          SvgPicture.asset(svgPic),
          SizedBox(
            width: context.width * 0.04.sp,
          ),
          Text(
            '${LocaleKeys.contactVia.tr()}${contactInfo}',
            style: openSansBlack.copyWith(color: darkGreyColor),
          ),
        ],
      ),
    );
  }
}
