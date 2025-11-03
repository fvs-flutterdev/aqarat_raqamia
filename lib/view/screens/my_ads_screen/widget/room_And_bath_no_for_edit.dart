import 'package:aqarat_raqamia/bloc/edit_ad_cubit/edit_ad_info_cubit/cubit.dart';

import '../../../../utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../bloc/add_real_ads/cubit.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/text_style.dart';
import '../../../base/custom_text_field.dart';

class RoomAndBathNoForEditWidget extends StatelessWidget {
  const RoomAndBathNoForEditWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var editMyAdCubit = context.read<EditAdInfoCubit>();
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
                    LocaleKeys.roomNo.tr(),
                    style: openSansExtraBold.copyWith(color: darkGreyColor),
                  ),
                  // HorizontalListRoomsNo(
                  //     roomNoController: addRealAdsCubit.roomCountController),
                  // addRealAdsCubit.resourceCreateModel.roomsNumber!.last.istabbed
                  //     ?
                  CustomTextField(
                    labelText: LocaleKeys.roomNo.tr(),
                    controller: editMyAdCubit.roomCountController,
                    keyboardType: TextInputType.number,
                    maxHeight: context.width * 0.2.sp,
                    minHeight: context.width * 0.15.sp,
                    validator: (String val) {
                      if (val.isEmpty) {
                        return LocaleKeys.roomNoRequires.tr();
                      }
                    },
                  ),
                    //  : SizedBox(),
                  editMyAdCubit.adsIdForEdit == 18 ||
                      editMyAdCubit.adsIdForEdit == 22 ||
                      editMyAdCubit.adsIdForEdit == 32 ||
                      editMyAdCubit.adsIdForEdit == 33 ||
                      editMyAdCubit.adsIdForEdit == 13 ||
                      editMyAdCubit.adsIdForEdit == 14 ||
                      editMyAdCubit.adsIdForEdit == 24 ||
                      editMyAdCubit.adsIdForEdit == 28 ||
                      editMyAdCubit.adsIdForEdit == 36 ||
                      editMyAdCubit.adsIdForEdit == 21 ||
                      editMyAdCubit.adsIdForEdit == 27 ||
                      editMyAdCubit.adsIdForEdit == 16
                      ? SizedBox()
                      : Text(
                    LocaleKeys.toiletNo.tr(),
                    style:
                    openSansExtraBold.copyWith(color: darkGreyColor),
                  ),
                  editMyAdCubit.adsIdForEdit == 18 ||
                       editMyAdCubit.adsIdForEdit == 32 ||
                       editMyAdCubit.adsIdForEdit == 21 ||
                       editMyAdCubit.adsIdForEdit == 27 ||
                       editMyAdCubit.adsIdForEdit == 13 ||
                       editMyAdCubit.adsIdForEdit == 22 ||
                       editMyAdCubit.adsIdForEdit == 16 ||
                       editMyAdCubit.adsIdForEdit == 14 ||
                       editMyAdCubit.adsIdForEdit == 33 ||
                       editMyAdCubit.adsIdForEdit == 36 ||
                       editMyAdCubit.adsIdForEdit == 24 ||
                       editMyAdCubit.adsIdForEdit == 28
                      ? SizedBox()
                      : CustomTextField(
                    labelText: LocaleKeys.toiletNo.tr(),
                    controller: editMyAdCubit.bathCountController,
                    keyboardType: TextInputType.number,
                    maxHeight: context.width * 0.2.sp,
                    minHeight: context.width * 0.15.sp,
                    validator: (String val) {
                      if (val.isEmpty) {
                        return LocaleKeys.toiletNoRequired.tr();
                      }
                    },
                  )
                     // : SizedBox(),
                ],
              ),
            )));
  }
}
