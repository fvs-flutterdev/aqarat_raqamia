import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/images.dart';

Widget svgWidgetPayment({required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.only(
      top: context.height * 0.1,
      bottom: context.height * 0.04,
    ),
    child: SvgPicture.asset(
      Images.completePayment,
      height: context.height * 0.12,
      width: context.width * 0.1,
    ),
  );
}
