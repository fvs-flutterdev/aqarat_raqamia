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
import 'horizontal_widgets/horizontal_bath_no.dart';
import 'horizontal_widgets/horizontal_list_rooms_no.dart';

class RoomAndBathNoWidget extends StatelessWidget {
  const RoomAndBathNoWidget({super.key});

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
                    LocaleKeys.roomNo.tr(),
                    style: openSansExtraBold.copyWith(color: darkGreyColor),
                  ),
                  HorizontalListRoomsNo(
                      roomNoController: addRealAdsCubit.roomCountController),
                  addRealAdsCubit.resourceCreateModel.roomsNumber!.last.istabbed
                      ? CustomTextField(
                          labelText: LocaleKeys.roomNo.tr(),
                          controller: addRealAdsCubit.roomCountController,
                          keyboardType: TextInputType.number,
                          maxHeight: context.width * 0.2.sp,
                          minHeight: context.width * 0.15.sp,
                          validator: (String val) {
                            if (val.isEmpty) {
                              return LocaleKeys.roomNoRequires.tr();
                            }
                          },
                        )
                      : SizedBox(),
                  addRealAdsCubit.adsId == 18 ||
                          addRealAdsCubit.adsId == 22 ||
                          addRealAdsCubit.adsId == 32 ||
                          addRealAdsCubit.adsId == 33 ||
                          addRealAdsCubit.adsId == 13 ||
                          addRealAdsCubit.adsId == 14 ||
                          addRealAdsCubit.adsId == 24 ||
                          addRealAdsCubit.adsId == 28 ||
                          addRealAdsCubit.adsId == 36 ||
                          addRealAdsCubit.adsId == 21 ||
                          addRealAdsCubit.adsId == 27 ||
                          addRealAdsCubit.adsId == 16
                      ? SizedBox()
                      : Text(
                          LocaleKeys.toiletNo.tr(),
                          style:
                              openSansExtraBold.copyWith(color: darkGreyColor),
                        ),
                  addRealAdsCubit.adsId == 18 ||
                          addRealAdsCubit.adsId == 32 ||
                          addRealAdsCubit.adsId == 21 ||
                          addRealAdsCubit.adsId == 27 ||
                          addRealAdsCubit.adsId == 13 ||
                          addRealAdsCubit.adsId == 22 ||
                          addRealAdsCubit.adsId == 16 ||
                          addRealAdsCubit.adsId == 14 ||
                          addRealAdsCubit.adsId == 33 ||
                          addRealAdsCubit.adsId == 36 ||
                          addRealAdsCubit.adsId == 24 ||
                          addRealAdsCubit.adsId == 28
                      ? SizedBox()
                      : HorizontalBathNo(),
                  addRealAdsCubit
                          .resourceCreateModel.toiletNumber!.last.istabbed
                      ? CustomTextField(
                          labelText: LocaleKeys.toiletNo.tr(),
                          controller: addRealAdsCubit.bathCountController,
                          keyboardType: TextInputType.number,
                          maxHeight: context.width * 0.2.sp,
                          minHeight: context.width * 0.15.sp,
                          validator: (String val) {
                            if (val.isEmpty) {
                              return LocaleKeys.toiletNoRequired.tr();
                            }
                          },
                        )
                      : SizedBox(),
                ],
              ),
            )));
  }
}
