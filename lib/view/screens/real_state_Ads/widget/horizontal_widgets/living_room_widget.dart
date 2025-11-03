import '../../../../../utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../../bloc/add_real_ads/cubit.dart';
import '../../../../../translation/locale_keys.g.dart';
import '../../../../../utils/text_style.dart';
import '../../../../base/custom_text_field.dart';
import 'horizontal_living_room.dart';

class LivingRoomWidget extends StatelessWidget {
 final bool? isEdit;
 final TextEditingController livingRoomCountController;

   LivingRoomWidget({super.key,this.isEdit=false,required this.livingRoomCountController});

  @override
  Widget build(BuildContext context) {
    var addRealAdsCubit = context.read<AddRealAdsCubit>();
    return AnimationConfiguration.synchronized(
      duration: Duration(milliseconds: 370),
      child: SlideAnimation(
        curve: Curves.easeOutBack,
        verticalOffset: 50.0.sp,
        child: FadeInAnimation(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.livingRoomNo.tr(),
                style: openSansExtraBold.copyWith(color: darkGreyColor),
              ),
              isEdit==true?SizedBox():  HorizontalLivingRoom(),
              addRealAdsCubit
                  .resourceCreateModel
                  .livingRoom!
                  .last
                  .istabbed ||isEdit==true
                  ? CustomTextField(
                labelText:
                LocaleKeys.livingRoomNo.tr(),
                controller:livingRoomCountController,
               // controller: addRealAdsCubit.livingRoomCountController,
                keyboardType:
                TextInputType.number,
                maxHeight: context.width * 0.2.sp,
                minHeight: context.width * 0.15.sp,
                validator:
                    (String val) {
                  if (val
                      .isEmpty) {
                    return LocaleKeys
                        .livingRoomRequired
                        .tr();
                  }
                },
              )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
