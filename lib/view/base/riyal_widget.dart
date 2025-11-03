import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/images.dart';

Widget riyalWidget(BuildContext context) {
  return SvgPicture.asset(
    Images.Riyal,
    width: context.width * 0.02.w,
    height: context.height * 0.014.h,
  );
}