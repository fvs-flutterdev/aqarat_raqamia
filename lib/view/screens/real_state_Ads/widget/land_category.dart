import 'package:flutter/cupertino.dart';

import '../../../../bloc/add_real_ads/cubit.dart';
import '../../../../utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/text_style.dart';
import '../../../base/custom_text_field.dart';

class LandCategory extends StatelessWidget {
final TextEditingController  landNoController;
final TextEditingController streetWideController;
final TextEditingController plotCountController;
  const LandCategory({super.key,required this.landNoController,required this.streetWideController,required this.plotCountController});

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
              Text(
                LocaleKeys.LandNo.tr(),
                // LocaleKeys.price.tr(),
                style: openSansExtraBold.copyWith(color: darkGreyColor),
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_SMALL.sp,
              ),
              CustomTextField(
                labelText: LocaleKeys.LandNo.tr(),
               controller: landNoController,
               // controller: addRealAdsCubit.landNoController,
                keyboardType: TextInputType.number,
                maxHeight: context.width * 0.2.sp,
                minHeight: context.width * 0.15.sp,
                validator: (String val) {
                  if (val.isEmpty) {
                    return LocaleKeys.landNoRequired.tr();
                  }
                },
              ),
              Text(
                //'عرض الشارع',
                LocaleKeys.streetWidth.tr(),
                style: openSansExtraBold.copyWith(color: darkGreyColor),
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_SMALL.sp,
              ),
              CustomTextField(
                labelText: LocaleKeys.streetWidth.tr(),
                controller:streetWideController,
               // controller: addRealAdsCubit.streetWideController,
                keyboardType: TextInputType.number,
                maxHeight: context.width * 0.2.sp,
                minHeight: context.width * 0.15.sp,
                validator: (String val) {
                  if (val.isEmpty) {
                    return LocaleKeys.streetWidthRequired.tr();
                  }
                },
              ),
              Text(
                LocaleKeys.plotNo.tr(),
                // LocaleKeys.price.tr(),
                style: openSansExtraBold.copyWith(color: darkGreyColor),
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_SMALL.sp,
              ),
              CustomTextField(
                labelText: LocaleKeys.plotNo.tr(),
               controller: plotCountController,
               // controller: addRealAdsCubit.plotCountController,
                keyboardType: TextInputType.number,
                maxHeight: context.width * 0.2,
                minHeight: context.width * 0.15,
                validator: (String val) {
                  if (val.isEmpty) {
                    return LocaleKeys.plotNoRequired.tr();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
