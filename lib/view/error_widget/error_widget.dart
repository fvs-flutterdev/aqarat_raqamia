
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/images.dart';
import '../../utils/text_style.dart';
import '../base/main_button.dart';

class CustomErrorWidget extends StatelessWidget {
  final Function reload;
 // final int statusCode;

  CustomErrorWidget(
      {super.key, required this.reload,
       // required this.statusCode
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: context.height * 0.5,
            width: context.height * 0.5,
            child: Image.asset(Images.Error)),
        SizedBox(
          height: context.height * 0.03,
        ),
        CustomButton(
          textButton:LocaleKeys.reload.tr(),
          onPressed: () {
            reload();
          },
          color: darkGreyColor,
          width: context.width * 0.7,
        )
      ],
    );
    ;
  }
}
