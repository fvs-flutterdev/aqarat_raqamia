import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../location/set_location_on_map.dart';
import '../real_state_Ads/widget/age_widget.dart';
import '../real_state_Ads/widget/features_grid_view.dart';
import '../real_state_Ads/widget/first_page_upload_real_button.dart';
import '../real_state_Ads/widget/horizontal_widgets/living_room_widget.dart';
import '../real_state_Ads/widget/land_category.dart';
import '../real_state_Ads/widget/residential_building_widget.dart';
import '../real_state_Ads/widget/room_and_bath_column.dart';
import '../real_state_Ads/widget/usage_and_services_widget.dart';
import '../real_state_Ads/widget/view_widget.dart';
import '../real_state_Ads/widget/well_and_palm_count_widget.dart';
import '../filter/widget/purpose_grid.dart';
import '../home/widget/horizontal_grid_view.dart';
import '../../base/custom_text_field.dart';
import '../../error_widget/error_widget.dart';
import '../../base/lunch_widget.dart';
import '../../../bloc/location_cubit/cubit.dart';
import '../../../bloc/location_cubit/state.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/media_query_value.dart';
import '../../../utils/text_style.dart';
import '../../../view/base/adaptive_dialog_loader.dart';
import '../../../view/base/category_header.dart';
import '../../../bloc/add_real_ads/cubit.dart';
import '../../../bloc/add_real_ads/state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/dimention.dart';

//ignore: must_be_immutable
class RealStateAdsScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var addRealAdsCubit = context.read<AddRealAdsCubit>();
    var locationCubit = context.read<LocationCubit>();

    addRealAdsCubit.isGetResourceFeature == false
        ? null
        : addRealAdsCubit.returnAdsTypeToDefault();
    addRealAdsCubit.isGetResourceFeature == false
        ? null
        : addRealAdsCubit.returnPurposeStateToDefault();
    addRealAdsCubit.isGetResourceFeature == false
        ? null
        : addRealAdsCubit.returnAdsVisionToDefault();
    addRealAdsCubit.isGetResourceFeature == false
        ? null
        : addRealAdsCubit.returnRoomStateToDefault();
    addRealAdsCubit.isGetResourceFeature == false
        ? null
        : addRealAdsCubit.returnToiletStateToDefault();

    return BlocConsumer<AddRealAdsCubit, AddRealAdsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: CategoryHeader(
            isPadding: true,
            title: LocaleKeys.realEstateInfo.tr(),

            onTap: () {},
            isFilter: false,
            isProvider:  false,
          ),
          body: addRealAdsCubit.isGetResourceFeature == false
              ? adaptiveCircleProgress()
              : addRealAdsCubit.isGetResourceFeature == null
                  ? CustomErrorWidget(
                      reload: () {
                        addRealAdsCubit.getResourceFeature();
                      },
                    )
                  : GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleKeys.location.tr(),
                                  style: openSansExtraBold.copyWith(
                                      color: darkGreyColor),
                                ),
                                const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT,
                                ),
                                BlocBuilder<LocationCubit, LocationState>(
                                  builder: (context, state) {
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: CustomTextField(
                                          controller: locationCubit
                                              .locationTextController,
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
                                          width:
                                              Dimensions.PADDING_SIZE_DEFAULT,
                                        ),
                                        LocationCard(fct: () {
                                          navigateForward(SetLocationOnMap(
                                            i: 1,
                                            locationName: locationCubit
                                                .locationTextController,
                                            areaName: locationCubit
                                                .districtTextController,
                                            cityName: locationCubit
                                                .cityTextController,
                                            regionName: locationCubit
                                                .regionTextController,
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
                                Text(
                                  LocaleKeys.realEstateType.tr(),
                                  style: openSansExtraBold.copyWith(
                                      color: darkGreyColor),
                                ),
                                HorizontalGridRealEstateType(
                                    isTabExtent: false),
                                //  HorizontalGridView(isTabExtent: false),
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
                                  controller: addRealAdsCubit.adTitleController,
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
                                  controller: addRealAdsCubit.priceController,
                                  keyboardType: TextInputType.number,
                                  maxHeight: context.width * 0.2.sp,
                                  minHeight: context.width * 0.15.sp,
                                  validator: (String val) {
                                    if (val.isEmpty) {
                                      return LocaleKeys.priceRequired.tr();
                                    }
                                  },
                                ),

                                addRealAdsCubit.adsId == 20
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            LocaleKeys.area.tr(),
                                            style: openSansExtraBold.copyWith(
                                                color: darkGreyColor),
                                          ),
                                          SizedBox(
                                            height: Dimensions
                                                .PADDING_SIZE_SMALL.sp,
                                          ),
                                          // AreaGridViewFilter(),
                                          CustomTextField(
                                            labelText:
                                                '${LocaleKeys.area.tr()} ${LocaleKeys.squareArea.tr()}',
                                            controller:
                                                addRealAdsCubit.areaController,
                                            keyboardType: TextInputType.number,
                                            maxHeight: context.width * 0.2.sp,
                                            minHeight: context.width * 0.15.sp,
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return LocaleKeys.areaRequired
                                                    .tr();
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                addRealAdsCubit.adsId == 21 ||
                                        addRealAdsCubit.adsId == 28 ||
                                        addRealAdsCubit.adsId == 15
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            LocaleKeys.additionalRequirements
                                                .tr(),
                                            //  "متطلبات اضافيه"
                                            //   LocaleKeys.desiredPropertySpecifications.tr(),
                                            style: openSansExtraBold.copyWith(
                                                color: darkGreyColor),
                                          ),
                                          SizedBox(
                                            height: Dimensions
                                                .PADDING_SIZE_SMALL.sp,
                                          ),
                                          CustomTextField(
                                            labelText: LocaleKeys
                                                .additionalRequirements
                                                .tr(),
                                            controller: addRealAdsCubit
                                                .additionalRequirementController,
                                            hintText: LocaleKeys
                                                .matchBuildingCode
                                                .tr(),
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
                                addRealAdsCubit.adsId == 20
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            LocaleKeys
                                                .desiredPropertySpecifications
                                                .tr(),
                                            style: openSansExtraBold.copyWith(
                                                color: darkGreyColor),
                                          ),
                                          SizedBox(
                                            height: Dimensions
                                                .PADDING_SIZE_SMALL.sp,
                                          ),
                                          CustomTextField(
                                            labelText: LocaleKeys
                                                .desiredPropertySpecifications
                                                .tr(),
                                            controller: addRealAdsCubit
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
                                UsageAndServices(
                                  usageController: addRealAdsCubit.usageController,
                                  servicesController:
                                      addRealAdsCubit.servicesController,
                                  categoryId: addRealAdsCubit.adsId,
                                ),
                                AgeWidgetTextField(
                                  ageController:
                                      addRealAdsCubit.realEstateAgeController,
                                  categoryId: addRealAdsCubit.adsId,
                                ),
                                addRealAdsCubit.adsId == 19
                                    ? WellAndPalmCountWidget(
                                        wellCountController:
                                            addRealAdsCubit.wellCountController,
                                        palmCountController:
                                            addRealAdsCubit.palmCountController,
                                      )
                                    : const SizedBox(),
                                addRealAdsCubit.adsId == 16 ||
                                        addRealAdsCubit.adsId == 27 ||
                                        addRealAdsCubit.adsId == 13
                                    ? ResidentialBuildingColumnWidget(
                                        categoryId: addRealAdsCubit.adsId,
                                        floorsCountController: addRealAdsCubit
                                            .floorsCountController,
                                        shopsCountController: addRealAdsCubit
                                            .shopsCountController,
                                      )
                                    : const SizedBox(),
                                addRealAdsCubit.adsId == 20 ||
                                        addRealAdsCubit.adsId == 34 ||
                                        addRealAdsCubit.adsId == 35 ||
                                        //   addRealAdsCubit.adsId == 16 ||
                                        addRealAdsCubit.adsId == 19 ||
                                        addRealAdsCubit.adsId == 37 ||
                                        addRealAdsCubit.adsId == 31 ||
                                        addRealAdsCubit.adsId == 30 ||
                                        addRealAdsCubit.adsId == 25 ||
                                        addRealAdsCubit.adsId == 29 ||
                                        addRealAdsCubit.adsId == 17 ||
                                        addRealAdsCubit.adsId == 26 ||
                                        addRealAdsCubit.adsId == 23
                                    ? const SizedBox()
                                    : addRealAdsCubit.adsId == 15
                                        ? LandCategory(
                                            landNoController: addRealAdsCubit
                                                .landNoController,
                                            streetWideController:
                                                addRealAdsCubit
                                                    .streetWideController,
                                            plotCountController: addRealAdsCubit
                                                .plotCountController,
                                          )
                                        : const RoomAndBathNoWidget(),
                                addRealAdsCubit.adsId == 12
                                    ? LivingRoomWidget(
                                        livingRoomCountController:
                                            addRealAdsCubit
                                                .livingRoomCountController,
                                      )
                                    : const SizedBox(),

                                addRealAdsCubit.adsId == 20 ||
                                        addRealAdsCubit.adsId == 34 ||
                                        addRealAdsCubit.adsId == 21 ||
                                        addRealAdsCubit.adsId == 37 ||
                                        addRealAdsCubit.adsId == 35 ||
                                        addRealAdsCubit.adsId == 14 ||
                                        addRealAdsCubit.adsId == 23
                                    ? const SizedBox()
                                    : const ViewWidgetColumn(),
                                Text(
                                  LocaleKeys.purpose.tr(),
                                  style: openSansExtraBold.copyWith(
                                      color: darkGreyColor),
                                ),
                                const SizedBox(
                                  height: Dimensions.PADDING_SIZE_LARGE,
                                ),
                                PurposeGridViewFilter(),
                                addRealAdsCubit.adsId == 15 ||
                                        addRealAdsCubit.adsId == 30 ||
                                        addRealAdsCubit.adsId == 31 ||
                                        addRealAdsCubit.adsId == 17 ||
                                        addRealAdsCubit.adsId == 37 ||
                                        addRealAdsCubit.adsId == 32 ||
                                        addRealAdsCubit.adsId == 29 ||
                                        addRealAdsCubit.adsId == 22 ||
                                        addRealAdsCubit.adsId == 26 ||
                                        addRealAdsCubit.adsId == 33 ||
                                        addRealAdsCubit.adsId == 20 ||
                                        addRealAdsCubit.adsId == 23 ||
                                        addRealAdsCubit.adsId == 28
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            LocaleKeys.features.tr(),
                                            style: openSansExtraBold.copyWith(
                                                color: darkGreyColor),
                                          ),
                                          const SizedBox(
                                            height:
                                                Dimensions.PADDING_SIZE_LARGE,
                                          ),
                                          Container(
                                            height: 100.sp,
                                            child: const CustomGridFeature(),
                                          ),
                                        ],
                                      ),
                                SizedBox(
                                  height: 20.sp,
                                ),
                                FirstPageUploadRealButton(
                                  formKey: _formKey,
                                ),
                                // CustomButton(
                                //   textButton: LocaleKeys.next.tr(),
                                //   onPressed: () {
                                //     if (_formKey.currentState!.validate()) {
                                //       if (context
                                //               .read<AddRealAdsCubit>()
                                //               .purposeId ==
                                //           null) {
                                //         showCustomSnackBar(
                                //             // context: context,
                                //             message:
                                //                 LocaleKeys.enterAdsPurpose.tr(),
                                //             state: ToastState.ERROR);
                                //       } else if (context
                                //               .read<AddRealAdsCubit>()
                                //               .adsId ==
                                //           null) {
                                //         showCustomSnackBar(
                                //             // context: context,
                                //             message: LocaleKeys
                                //                 .pleaseSelectAdType
                                //                 .tr(),
                                //             state: ToastState.ERROR);
                                //       } else if (addRealAdsCubit.adsId != 15 &&addRealAdsCubit.adsId != 17 && context.read<AddRealAdsCubit>().bathNo == null && addRealAdsCubit.bathNoController.text.isEmpty || addRealAdsCubit.adsId != 15 &&addRealAdsCubit.adsId != 17 && context.read<AddRealAdsCubit>().roomNo == null && addRealAdsCubit.roomNoController.text.isEmpty) {
                                //         showCustomSnackBar(
                                //             // context: context,
                                //             message:
                                //                 LocaleKeys.pleaseFeatureAd.tr(),
                                //             state: ToastState.ERROR);
                                //       } else if (context
                                //               .read<AddRealAdsCubit>()
                                //               .vision ==
                                //           null) {
                                //         showCustomSnackBar(
                                //             // context: context,
                                //             message: LocaleKeys
                                //                 .pleaseSelectEstateProlongation
                                //                 .tr(),
                                //             state: ToastState.ERROR);
                                //       } else {
                                //         navigateForward(SecondScreenAds(
                                //           adsType: context
                                //               .read<AddRealAdsCubit>()
                                //               .adsId
                                //               .toString(),
                                //           price: addRealAdsCubit
                                //               .priceController.text,
                                //           area: addRealAdsCubit
                                //               .areaController.text,
                                //           // area:context.read<FilterSearchAdsCubit>().selectedAre! ,
                                //           bathNo: addRealAdsCubit
                                //                   .resourceCreateModel
                                //                   .toiletNumber!
                                //                   .last
                                //                   .istabbed
                                //               ? addRealAdsCubit
                                //                   .bathNoController.text
                                //               : context
                                //                       .read<AddRealAdsCubit>()
                                //                       .bathNo ??
                                //                   '',
                                //           location: locationCubit
                                //               .locationTextController.text,
                                //           purpose: context
                                //                   .read<AddRealAdsCubit>()
                                //                   .purposeId ??
                                //               '',
                                //           roomNo: addRealAdsCubit
                                //                   .resourceCreateModel
                                //                   .toiletNumber!
                                //                   .last
                                //                   .istabbed
                                //               ? addRealAdsCubit
                                //                   .roomNoController.text
                                //               : context
                                //                       .read<AddRealAdsCubit>()
                                //                       .roomNo ??
                                //                   '',
                                //           vision: context
                                //                   .read<AddRealAdsCubit>()
                                //                   .vision ??
                                //               '',
                                //         ));
                                //         context
                                //             .read<UploadRequestCubit>()
                                //             .clearImage();
                                //       }
                                //     }
                                //   },
                                //   color: goldColor,
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
