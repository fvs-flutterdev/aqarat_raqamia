import '../../../../utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../bloc/add_real_ads/cubit.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/text_style.dart';
import '../../../base/custom_text_field.dart';

class UsageAndServices extends StatelessWidget {
 final TextEditingController servicesController;
 final TextEditingController usageController;
 final int? categoryId;
  const UsageAndServices({super.key,required this.servicesController, this.categoryId,required this.usageController});

  @override
  Widget build(BuildContext context) {
   // var addRealAdsCubit = context.read<AddRealAdsCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      //  addRealAdsCubit.adsId
        categoryId   == 30
            ? SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.usage.tr(),
                    style: openSansExtraBold.copyWith(color: darkGreyColor),
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL.sp,
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.usage.tr(),
                    controller:usageController,
                    //addRealAdsCubit.usageController,
                    maxHeight: context.width * 0.2.sp,
                    minHeight: context.width * 0.15.sp,
                    validator: (String val) {
                      if (val.isEmpty) {
                        return LocaleKeys.usageRequired.tr();
                      }
                    },
                  ),
                ],
              ),
        Text(
          LocaleKeys.services.tr(),
          style: openSansExtraBold.copyWith(color: darkGreyColor),
        ),
        SizedBox(
          height: Dimensions.PADDING_SIZE_SMALL.sp,
        ),
        CustomTextField(
          labelText: LocaleKeys.services.tr(),
          controller:servicesController,
          //addRealAdsCubit.servicesController,
          maxHeight: context.width * 0.2.sp,
          minHeight: context.width * 0.15.sp,
          validator: (String val) {
            if (val.isEmpty) {
              return LocaleKeys.realEstateServiceRequired.tr();
            }
          },
        ),
      ],
    );
  }
}
