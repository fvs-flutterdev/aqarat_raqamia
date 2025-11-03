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

class AgeWidgetTextField extends StatelessWidget {
  final TextEditingController ageController;
  final int? categoryId;
  const AgeWidgetTextField({super.key,required this.ageController, this.categoryId});

  @override
  Widget build(BuildContext context) {
  //  var addRealAdsCubit = context.read<AddRealAdsCubit>();
    return
    //  addRealAdsCubit.adsId
      categoryId == 15
        ? SizedBox()
        : AnimationConfiguration.synchronized(
            duration: Duration(milliseconds: 370),
            child: SlideAnimation(
                curve: Curves.easeOutBack,
                verticalOffset: 50.0.sp,
                child: FadeInAnimation(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.realEstateAge.tr(),
                      style: openSansExtraBold.copyWith(color: darkGreyColor),
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL.sp,
                    ),
                    // AreaGridViewFilter(),
                    CustomTextField(
                      labelText: LocaleKeys.realEstateAge.tr(),
                      controller: ageController,
                      //addRealAdsCubit.realEstateAgeController,
                      keyboardType: TextInputType.number,
                      maxHeight: context.width * 0.2.sp,
                      minHeight: context.width * 0.15.sp,
                      validator: (String val) {
                        if (val.isEmpty) {
                          return LocaleKeys.realEstateAgeRequired.tr();
                        }
                      },
                    ),
                  ],
                ))),
          );
  }
}
