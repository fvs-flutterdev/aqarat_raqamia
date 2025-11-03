import 'package:aqarat_raqamia/bloc/edit_ad_cubit/edit_ad_info_cubit/state.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/view/base/adaptive_dialog_loader.dart';
import 'package:aqarat_raqamia/view/base/auth_header.dart';
import 'package:aqarat_raqamia/view/base/main_button.dart';
import 'package:aqarat_raqamia/view/base/shimmer/ads_shimmer.dart';
import 'package:aqarat_raqamia/view/screens/my_ads_screen/widget/horizontal_category_widget.dart';
import 'package:aqarat_raqamia/view/screens/my_ads_screen/widget/room_And_bath_no_for_edit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/ads_by_id_cubit/cubit.dart';
import '../../../bloc/edit_ad_cubit/edit_ad_info_cubit/cubit.dart';
import '../../../bloc/location_cubit/cubit.dart';
import '../../../bloc/location_cubit/state.dart';
import '../../../bloc/my_ads_cubit/cubit.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/dimention.dart';
import '../../../utils/text_style.dart';
import '../../base/custom_text_field.dart';
import '../../base/lunch_widget.dart';
import '../filter/widget/purpose_grid.dart';
import '../home/widget/horizontal_grid_view.dart';
import '../location/set_location_on_map.dart';
import '../real_state_Ads/widget/age_widget.dart';
import '../real_state_Ads/widget/features_grid_view.dart';
import '../real_state_Ads/widget/horizontal_widgets/living_room_widget.dart';
import '../real_state_Ads/widget/land_category.dart';
import '../real_state_Ads/widget/residential_building_widget.dart';
import '../real_state_Ads/widget/room_and_bath_column.dart';
import '../real_state_Ads/widget/usage_and_services_widget.dart';
import '../real_state_Ads/widget/view_widget.dart';
import '../real_state_Ads/widget/well_and_palm_count_widget.dart';

class EditMyAdInfoDetailsScreen extends StatefulWidget {
  final int adId;

  const EditMyAdInfoDetailsScreen({super.key, required this.adId});

  @override
  State<EditMyAdInfoDetailsScreen> createState() =>
      _EditMyAdInfoDetailsScreenState();
}

class _EditMyAdInfoDetailsScreenState extends State<EditMyAdInfoDetailsScreen> {
  @override
  void initState() {
    context.read<EditAdInfoCubit>().getAdById(id: widget.adId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var getMyAdsCubit = context.read<MyAdsCubit>();
    var getMyAdsIdCubit = context.read<AdyByIdCubit>();
    var editAdInfoCubit = context.read<EditAdInfoCubit>();
    return Scaffold(
      // appBar: AuthHeader(
      //   title:'${LocaleKeys.adsNo.tr()} ${widget.adId}',
      //       //'تعديل الإعلان رقم ${widget.adId}',
      // ),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(
              title: '${LocaleKeys.adsNo.tr()} ${widget.adId}',
            ),
          ),
          Expanded(
            child: BlocConsumer<EditAdInfoCubit, EditAdInfoState>(
              listener: (context, state) {
                if (state is EditAdInfoLoadingState) {
                  adaptiveDialogLoader(context: context);
                } else if (state is EditAdInfoErrorState) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (editAdInfoCubit.isGetAdsById == null ||
                    editAdInfoCubit.isGetAdsById == false ||
                    editAdInfoCubit.isGetResourceFeature == null ||
                    editAdInfoCubit.isGetResourceFeature == false ||
                    editAdInfoCubit.isGetAdditionalFeatures == null ||
                    editAdInfoCubit.isGetAdditionalFeatures == false) {
                  return AdsShimmer();
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<LocationCubit, LocationState>(
                            builder: (context, state) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: CustomTextField(
                                    controller:
                                        editAdInfoCubit.locationTextController,
                                    labelText: LocaleKeys.location.tr(),
                                    maxHeight: context.width * 0.2.sp,
                                    minHeight: context.width * 0.15.sp,
                                    isEnabled: false,
                                    validator: (String val) {
                                      if (val.isEmpty) {
                                        return '';
                                      }
                                    },
                                  )),
                                  const SizedBox(
                                    width: Dimensions.PADDING_SIZE_DEFAULT,
                                  ),
                                  LocationCard(fct: () {
                                    navigateForward(SetLocationOnMap(
                                      isEdit: true,
                                      i: 1,
                                      locationName: editAdInfoCubit
                                          .locationTextController,
                                      areaName: editAdInfoCubit
                                          .districtTextController,
                                      cityName:
                                          editAdInfoCubit.cityTextController,
                                      regionName:
                                          editAdInfoCubit.regionTextController,
                                      // areaName:
                                      //     locationCubit.locationTextController,
                                      // cityName:
                                      //     locationCubit.locationTextController,
                                    ));
                                  }),
                                ],
                              );
                            },
                          ),
                          HorizontalGridRealEstateTypeForEditWidget(
                            isSame: editAdInfoCubit.isSame,
                            adId: editAdInfoCubit.adsIdForEdit,
                          ),

                          Text(
                            LocaleKeys.adTitle.tr(),
                            style: openSansExtraBold.copyWith(
                                color: darkGreyColor),
                          ),
                          SizedBox(
                            height: Dimensions.PADDING_SIZE_SMALL.sp,
                          ),
                          CustomTextField(
                            labelText: LocaleKeys.adTitle.tr(),
                            controller: editAdInfoCubit.adTitleController,
                            maxHeight: context.width * 0.2.sp,
                            minHeight: context.width * 0.15.sp,
                            validator: (String val) {
                              if (val.isEmpty) {
                                return LocaleKeys.enterAdTitle.tr();
                              }
                            },
                          ),
                          Text(
                            // LocaleKeys.price.tr()
                            LocaleKeys.price.tr(),
                            style: openSansExtraBold.copyWith(
                                color: darkGreyColor),
                          ),
                          SizedBox(
                            height: Dimensions.PADDING_SIZE_SMALL.sp,
                          ),
                          CustomTextField(
                            labelText: LocaleKeys.price.tr(),
                            controller: editAdInfoCubit.priceController,
                            keyboardType: TextInputType.number,
                            maxHeight: context.width * 0.2.sp,
                            minHeight: context.width * 0.15.sp,
                            validator: (String val) {
                              if (val.isEmpty) {
                                return LocaleKeys.priceRequired.tr();
                              }
                            },
                          ),

                          editAdInfoCubit.adsIdForEdit == 20
                              ? const SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.area.tr(),
                                      style: openSansExtraBold.copyWith(
                                          color: darkGreyColor),
                                    ),
                                    SizedBox(
                                      height: Dimensions.PADDING_SIZE_SMALL.sp,
                                    ),
                                    // AreaGridViewFilter(),
                                    CustomTextField(
                                      labelText:
                                          '${LocaleKeys.area.tr()} ${LocaleKeys.squareArea.tr()}',
                                      controller:
                                          editAdInfoCubit.areaController,
                                      keyboardType: TextInputType.number,
                                      maxHeight: context.width * 0.2.sp,
                                      minHeight: context.width * 0.15.sp,
                                      validator: (String val) {
                                        if (val.isEmpty) {
                                          return LocaleKeys.areaRequired.tr();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                          editAdInfoCubit.adsIdForEdit == 21 ||
                                  editAdInfoCubit.adsIdForEdit == 28 ||
                                  editAdInfoCubit.adsIdForEdit == 15
                              ? const SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.additionalRequirements.tr(),
                                      style: openSansExtraBold.copyWith(
                                          color: darkGreyColor),
                                    ),
                                    SizedBox(
                                      height: Dimensions.PADDING_SIZE_SMALL.sp,
                                    ),
                                    CustomTextField(
                                      labelText: LocaleKeys
                                          .additionalRequirements
                                          .tr(),
                                      controller: editAdInfoCubit
                                          .additionalRequirementController,
                                      hintText:
                                          LocaleKeys.matchBuildingCode.tr(),
                                      maxHeight: context.width * 0.2.sp,
                                      minHeight: context.width * 0.15.sp,
                                      validator: (String val) {
                                        if (val.isEmpty) {
                                          return LocaleKeys
                                              .additionalRequirementsREQUIRED
                                              .tr();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                          editAdInfoCubit.adsIdForEdit == 20
                              ? const SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.desiredPropertySpecifications
                                          .tr(),
                                      style: openSansExtraBold.copyWith(
                                          color: darkGreyColor),
                                    ),
                                    SizedBox(
                                      height: Dimensions.PADDING_SIZE_SMALL.sp,
                                    ),
                                    CustomTextField(
                                      labelText: LocaleKeys
                                          .desiredPropertySpecifications
                                          .tr(),
                                      controller: editAdInfoCubit
                                          .desiredPropertySpecificationsController,
                                      lines: 9,
                                      length: 2500,
                                      maxHeight: context.width * 0.39.sp,
                                      minHeight: context.width * 0.39.sp,
                                      validator: (String val) {
                                        if (val.isEmpty) {
                                          return LocaleKeys
                                              .desiredPropertySpecificationsRequired
                                              .tr();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                          CustomTextField(
                            labelText: LocaleKeys.adsDetails.tr(),
                            isBig: true,
                            lines: 20,
                            length: 2000,
                            maxHeight: context.width * 0.39.sp,
                            minHeight: context.width * 0.39.sp,
                            controller: editAdInfoCubit.detailsOfAdsController,
                            validator: (String val) {
                              if (val.isEmpty) {
                                return LocaleKeys.enterAdsDetails.tr();
                              }
                            },
                          ),
                          UsageAndServices(
                            categoryId: editAdInfoCubit.adsIdForEdit ?? 0,
                            servicesController:
                                editAdInfoCubit.servicesController,
                            usageController: editAdInfoCubit.usageController,
                          ),
                          AgeWidgetTextField(
                            ageController: editAdInfoCubit.ageController,
                            categoryId: editAdInfoCubit.adsIdForEdit ?? 0,
                          ),
                          editAdInfoCubit.adsIdForEdit == 19
                              ? WellAndPalmCountWidget(
                                  palmCountController:
                                      editAdInfoCubit.palmCountController,
                                  wellCountController:
                                      editAdInfoCubit.wellCountController,
                                )
                              : const SizedBox(),
                          editAdInfoCubit.adsIdForEdit == 16 ||
                                  editAdInfoCubit.adsIdForEdit == 27 ||
                                  editAdInfoCubit.adsIdForEdit == 13
                              ? ResidentialBuildingColumnWidget(
                                  floorsCountController:
                                      editAdInfoCubit.floorsCountController,
                                  categoryId: editAdInfoCubit.adsIdForEdit!,
                                  shopsCountController:
                                      editAdInfoCubit.shopsCountController,
                                )
                              : const SizedBox(),
                          editAdInfoCubit.adsIdForEdit == 20 ||
                                  editAdInfoCubit.adsIdForEdit == 34 ||
                                  editAdInfoCubit.adsIdForEdit == 35 ||
                                  //   editAdInfoCubit.adsIdForEdit == 16 ||
                                  editAdInfoCubit.adsIdForEdit == 19 ||
                                  editAdInfoCubit.adsIdForEdit == 37 ||
                                  editAdInfoCubit.adsIdForEdit == 31 ||
                                  editAdInfoCubit.adsIdForEdit == 30 ||
                                  editAdInfoCubit.adsIdForEdit == 25 ||
                                  editAdInfoCubit.adsIdForEdit == 29 ||
                                  editAdInfoCubit.adsIdForEdit == 17 ||
                                  editAdInfoCubit.adsIdForEdit == 26 ||
                                  editAdInfoCubit.adsIdForEdit == 23
                              ? const SizedBox()
                              : editAdInfoCubit.adsIdForEdit == 15
                                  ? LandCategory(
                                      landNoController:
                                          editAdInfoCubit.landNoController,
                                      plotCountController:
                                          editAdInfoCubit.plotCountController,
                                      streetWideController:
                                          editAdInfoCubit.streetWideController,
                                    )
                                  : const RoomAndBathNoForEditWidget(),
                          editAdInfoCubit.adsIdForEdit == 12
                              ? LivingRoomWidget(
                                  isEdit: true,
                                  livingRoomCountController:
                                      editAdInfoCubit.LivingRoomCountController,
                                )
                              : const SizedBox(),

                          editAdInfoCubit.adsIdForEdit == 20 ||
                                  editAdInfoCubit.adsIdForEdit == 34 ||
                                  editAdInfoCubit.adsIdForEdit == 21 ||
                                  editAdInfoCubit.adsIdForEdit == 37 ||
                                  editAdInfoCubit.adsIdForEdit == 35 ||
                                  editAdInfoCubit.adsIdForEdit == 14 ||
                                  editAdInfoCubit.adsIdForEdit == 23
                              ? const SizedBox()
                              : ViewWidgetColumn(
                                  isEdit: true,
                                  visionName: editAdInfoCubit.visionNameForEdit,
                                  isSameVision: editAdInfoCubit.isSameVision,
                                ),
                          Text(
                            LocaleKeys.purpose.tr(),
                            style: openSansExtraBold.copyWith(
                                color: darkGreyColor),
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_LARGE,
                          ),
                          PurposeGridViewForEditFilter(
                            isSamePurpose: editAdInfoCubit.isSamePurpose,
                            purposeId: editAdInfoCubit.purposeIdEdit,
                          ),
                          // PurposeGridViewFilter(),
                          editAdInfoCubit.adsIdForEdit == 15 ||
                                  editAdInfoCubit.adsIdForEdit == 30 ||
                                  editAdInfoCubit.adsIdForEdit == 31 ||
                                  editAdInfoCubit.adsIdForEdit == 17 ||
                                  editAdInfoCubit.adsIdForEdit == 37 ||
                                  editAdInfoCubit.adsIdForEdit == 32 ||
                                  editAdInfoCubit.adsIdForEdit == 29 ||
                                  editAdInfoCubit.adsIdForEdit == 22 ||
                                  editAdInfoCubit.adsIdForEdit == 26 ||
                                  editAdInfoCubit.adsIdForEdit == 33 ||
                                  editAdInfoCubit.adsIdForEdit == 20 ||
                                  editAdInfoCubit.adsIdForEdit == 23 ||
                                  editAdInfoCubit.adsIdForEdit == 28
                              ? const SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.features.tr(),
                                      style: openSansExtraBold.copyWith(
                                          color: darkGreyColor),
                                    ),
                                    const SizedBox(
                                      height: Dimensions.PADDING_SIZE_LARGE,
                                    ),
                                    CustomGridFeatureForEdit(),
                                  ],
                                ),

                          SizedBox(
                            height: 20.sp,
                          ),

                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                bottom: context.height * 0.05),
                            child: CustomButton(
                              textButton: LocaleKeys.update.tr(),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          LocaleKeys.uploadAd.tr(),
                                          style: openSansExtraBold.copyWith(
                                              color: goldColor),
                                        ),
                                        content: Text(
                                          '${LocaleKeys.areYouSureUpdateAd.tr()}${widget.adId}',
                                          style: openSansBold.copyWith(
                                              color: darkGreyColor),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              editAdInfoCubit.updateAdInfo(
                                                  context: context);
                                            },
                                            child: Text(
                                              LocaleKeys.update.tr(),
                                              style: openSansMedium,
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                  LocaleKeys.noThanks.tr(),
                                                  style:
                                                      openSansMedium.copyWith(
                                                          color: redColor))),
                                        ],
                                      );
                                    });
                              },
                              color: goldColor,
                            ),
                          )

                          // FirstPageUploadRealButton(
                          //   formKey: _formKey,
                          // ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
