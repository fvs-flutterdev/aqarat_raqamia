import '../../../../bloc/add_real_ads/state.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../bloc/add_real_ads/cubit.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/text_style.dart';
import '../../../base/custom_text_field.dart';

class ResidentialBuildingColumnWidget extends StatelessWidget {
  final int? categoryId;
  final TextEditingController floorsCountController;
  final TextEditingController shopsCountController;

  const ResidentialBuildingColumnWidget({super.key,  this.categoryId,required this.floorsCountController,required this.shopsCountController});

  @override
  Widget build(BuildContext context) {
    var addRealAdsCubit = AddRealAdsCubit.get(context);
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
                LocaleKeys.floorNo.tr(),
                // LocaleKeys.roomNo.tr(),
                style: openSansExtraBold.copyWith(color: darkGreyColor),
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_SMALL.sp,
              ),
              CustomTextField(
                labelText: LocaleKeys.floorNo.tr(),
                // LocaleKeys
                //     .roomNo
                //     .tr(),
                controller: floorsCountController,
                //addRealAdsCubit.floorsCountController,
                keyboardType: TextInputType.number,
                maxHeight: context.width * 0.2.sp,
                minHeight: context.width * 0.15.sp,
                validator: (String val) {
                  if (val.isEmpty) {
                    return LocaleKeys.floorNoRequired.tr();
                    //  return LocaleKeys.roomNoRequires.tr();
                  }
                },
              ),
              //addRealAdsCubit.adsId == 27 || addRealAdsCubit.adsId == 13
              categoryId==27||categoryId==13
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
                                  LocaleKeys.commercialNo.tr(),
                                  // LocaleKeys.roomNo.tr(),
                                  style: openSansExtraBold.copyWith(
                                      color: darkGreyColor),
                                ),
                                SizedBox(
                                  height: Dimensions.PADDING_SIZE_SMALL.sp,
                                ),
                                CustomTextField(
                                  labelText: LocaleKeys.commercialNo.tr(),
                                  // LocaleKeys
                                  //     .roomNo
                                  //     .tr(),
                                  controller:shopsCountController,
                                   //   addRealAdsCubit.shopsCountController,
                                  keyboardType: TextInputType.number,
                                  maxHeight: context.width * 0.2.sp,
                                  minHeight: context.width * 0.15.sp,
                                  validator: (String val) {
                                    if (val.isEmpty) {
                                      return LocaleKeys.commercialNoRequired
                                          .tr();
                                      //  return LocaleKeys.roomNoRequires.tr();
                                    }
                                  },
                                ),
                              ],
                            ),
                          )),
                    ),
              BlocBuilder<AddRealAdsCubit, AddRealAdsState>(
                builder: (context, state) {
                  return SwitchListTile.adaptive(
                      activeColor: darkGreyColor,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        LocaleKeys.parking.tr(),
                        // LocaleKeys.roomNo.tr(),
                        style: openSansExtraBold.copyWith(color: darkGreyColor),
                      ),
                      value: addRealAdsCubit.isParking,
                      onChanged: (val) {
                        addRealAdsCubit.onChangeParking(val);
                        print(val);
                      });
                },
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_SMALL.sp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
