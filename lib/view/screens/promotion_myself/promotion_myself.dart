import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/view/base/custom_text_field.dart';
import 'package:aqarat_raqamia/view/base/riyal_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../../../../translation/locale_keys.g.dart';
import '../../../../../view/base/adaptive_dialog_loader.dart';
import '../../../../../view/base/auth_header.dart';
import '../../../../../view/base/main_button.dart';
import '../../../../../view/base/shimmer/ads_shimmer.dart';
import '../../../../../view/error_widget/error_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../bloc/interests_cubit/cubit.dart';
import '../../../bloc/interests_cubit/state.dart';
import '../../../bloc/promoted_services_cubit/cubit.dart';
import '../../../bloc/promoted_services_cubit/state.dart';
import '../../../bloc/region_cubit/cubit.dart';
import '../../../bloc/region_cubit/state.dart';
import '../../../model/dynamic_model/intestes_model.dart';
import '../../../utils/dimention.dart';
import '../../../utils/text_style.dart';
import '../../base/filter_drop_down.dart';
import '../../base/show_toast.dart';

class PromotionMySelf extends StatelessWidget {
  PromotionMySelf({super.key});

  TextEditingController promoCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var promotionCubit = context.read<PromotedServicesCubit>();
    var regionCubit = context.read<RegionsCubit>();
    var interestsCubit = context.read<InterestsCubit>();
    return BlocConsumer<PromotedServicesCubit, PromotedServicesState>(
      listener: (context, state) {
        if (state is PayForPromotedMyAccLoadingState) {
          adaptiveDialogLoader(context: context);
        } else if (state is PayForPromotedMyAccErrorState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          // appBar: AuthHeader(title: LocaleKeys.PromotingMySelf.tr()),
          body: promotionCubit.isGetPromotionDetails == false
              ? AdsShimmer()
              : state is GetPromotedDetailsErrorState
                  ? CustomErrorWidget(reload: () {
                      promotionCubit.getPromotionDetails();
                    })
                  : Column(
                      children: [
                        Container(
                          height: context.height * 0.17.h,
                          margin: EdgeInsets.zero,
                          child: AuthHeader(
                              title: LocaleKeys.PromotingMySelf.tr()),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                FocusManager.instance.primaryFocus!.unfocus(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: context.width * 0.02.w,
                                  bottom: 30.sp,
                                  end: 10.sp),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      color: whiteColor,
                                      elevation: 3,
                                      margin: EdgeInsetsDirectional.only(
                                          top: context.height * 0.01.h,
                                          bottom: context.height * 0.02.h),
                                      child: Container(
                                        //  alignment: AlignmentDirectional.centerStart,
                                        margin: EdgeInsetsDirectional.only(
                                            start: context.width * 0.02.w,
                                            top: context.height * 0.01.h,
                                            bottom: context.height * 0.01.h),

                                        width: context.width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text:
                                                        '${LocaleKeys.servicePrice.tr()} : ',
                                                    style:
                                                        openSansMedium.copyWith(
                                                            color:
                                                                darkGreyColor),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            '"${promotionCubit.promotionDetailsModel.data!.promotionValueService}"',
                                                        style: openSansRegular
                                                            .copyWith(
                                                                color:
                                                                    goldColor),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      context.width * 0.005.w,
                                                ),
                                                riyalWidget(context)
                                              ],
                                            ),
                                            RichText(
                                                text: TextSpan(
                                                    text:
                                                        '${LocaleKeys.durationAd.tr()} : ',
                                                    style:
                                                        openSansMedium.copyWith(
                                                            color:
                                                                darkGreyColor),
                                                    children: [
                                                  TextSpan(
                                                    text:
                                                        '${promotionCubit.promotionDetailsModel.data!.promotionDaysService.toString()} ${LocaleKeys.day.tr()}',
                                                    style: openSansRegular
                                                        .copyWith(
                                                            color: goldColor,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade),
                                                  )
                                                ])),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: context.width * 0.02.w),
                                      child: Text(
                                        LocaleKeys.selectRegion.tr(),
                                        style: openSansBold.copyWith(
                                          color: darkGreyColor,
                                        ),
                                      ),
                                    ),
                                    // regionCubit.isGetRegion == true
                                    //     ? BlocBuilder<RegionsCubit, RegionState>(
                                    //         // listener: (context, state) {},
                                    //         builder: (context, state) {
                                    //           return FilterDropDown(
                                    //             isRequestService: true,
                                    //             fct: (onChange) async {
                                    //               regionCubit
                                    //                   .onChangeRegionId(onChange);
                                    //               print(
                                    //                   '??????????????????${regionCubit.regionId}');
                                    //
                                    //               ///
                                    //               // regionCubit.regionId == 0
                                    //               //     ? context
                                    //               //     .read<OrdersProviderCubit>()
                                    //               //     .getPendingOrdersProvider(
                                    //               //     page: 1, context: context)
                                    //               //     : regionCubit
                                    //               //     .getCitiesByRegionId(
                                    //               //     page: 1, context: context)
                                    //               //     .then((value) {
                                    //               // if(regionCubit.regionId == 0){
                                    //               //   context.read<OrdersProviderCubit>().getPendingOrdersProvider(page: 1,context: context);
                                    //               // }else {
                                    //               ///
                                    //               // CustomBottomSheet(
                                    //               //     context: context,
                                    //               //     controller: _scrollController,
                                    //               //     confirm: () {
                                    //               //       Navigator.pop(context);
                                    //               //       orderProviderCubit
                                    //               //           .getPendingOrdersProvider(
                                    //               //           page: 1,
                                    //               //           context: context);
                                    //               //     });
                                    //               //}
                                    //               // });
                                    //             },
                                    //             hint: LocaleKeys.allCity.tr(),
                                    //             isFlag: false,
                                    //             items: regionCubit
                                    //                 .allRegionsModel.data!
                                    //                 .map((e) => DropdownMenuItem(
                                    //                       child:
                                    //                           Text(e.name.toString()),
                                    //                       value: e.regionId,
                                    //                     ))
                                    //                 .toList(),
                                    //           );
                                    //         },
                                    //       )
                                    //     : const SizedBox(),
                                    //  regionCubit.isGetRegion == true?
                                    ///
                                    regionCubit.isGetRegion == true
                                        ? BlocBuilder<RegionsCubit,
                                        RegionState>(
                                      // listener: (context, state) {},
                                      builder: (context, state) {
                                        return FilterDropDown(
                                          isRequestService: true,
                                          fct: (onChange) async {
                                            regionCubit.onChangeRegionId(
                                                onChange);
                                            print(
                                                '??????????????????${regionCubit.regionId}');

                                          },
                                          hint: LocaleKeys.allCity.tr(),
                                          isFlag: false,
                                          items: regionCubit
                                              .allRegionsModel.data!
                                              .map(
                                                  (e) => DropdownMenuItem(
                                                child: Text(e.name
                                                    .toString()),
                                                value: e.regionId,
                                              ))
                                              .toList(),
                                        );
                                      },
                                    )
                                        : const SizedBox(),
                                    // regionCubit.isGetRegion == true
                                    //     ? BlocBuilder<RegionsCubit,
                                    //         RegionState>(
                                    //         builder: (context, state) {
                                    //           return regionCubit.isGetRegion ==
                                    //                   true
                                    //               ? Padding(
                                    //                   padding:
                                    //                       EdgeInsetsDirectional
                                    //                           .only(
                                    //                               top: context
                                    //                                       .height *
                                    //                                   0.03),
                                    //                   child:
                                    //                       MultiSelectDialogField(
                                    //                     // listType: MultiSelectListType.CHIP,
                                    //
                                    //                     title: Text(
                                    //                       LocaleKeys.region
                                    //                           .tr(),
                                    //                       style: openSansBold
                                    //                           .copyWith(
                                    //                               color:
                                    //                                   darkGreyColor),
                                    //                     ),
                                    //                     buttonText: Text(
                                    //                       LocaleKeys.region
                                    //                           .tr(),
                                    //                       style: openSansMedium
                                    //                           .copyWith(
                                    //                               color:
                                    //                                   darkGreyColor),
                                    //                     ),
                                    //                     searchTextStyle:
                                    //                         openSansMedium.copyWith(
                                    //                             color:
                                    //                                 darkGreyColor),
                                    //                     searchable: true,
                                    //                     searchHintStyle:
                                    //                         openSansMedium.copyWith(
                                    //                             color:
                                    //                                 darkGreyColor),
                                    //                     searchHint: LocaleKeys
                                    //                         .search
                                    //                         .tr(),
                                    //                     selectedItemsTextStyle:
                                    //                         openSansMedium.copyWith(
                                    //                             color:
                                    //                                 darkGreyColor),
                                    //                     unselectedColor:
                                    //                         darkGreyColor,
                                    //                     buttonIcon: Icon(
                                    //                       Icons
                                    //                           .arrow_drop_down_outlined,
                                    //                       color: darkGreyColor,
                                    //                     ),
                                    //                     selectedColor: goldColor
                                    //                         .withOpacity(0.1),
                                    //                     checkColor: goldColor,
                                    //                     itemsTextStyle:
                                    //                         openSansRegular,
                                    //                     decoration: BoxDecoration(
                                    //                         border: Border.all(
                                    //                             color:
                                    //                                 darkGreyColor),
                                    //                         borderRadius:
                                    //                             BorderRadius.circular(
                                    //                                 Dimensions
                                    //                                     .RADIUS_DEFAULT)),
                                    //                     //   initialValue: profileCubit.interestsProfile,
                                    //
                                    //                     items: regionCubit
                                    //                         .allRegionsModel
                                    //                         .data!
                                    //                         .map((e) {
                                    //                       return MultiSelectItem(
                                    //                           e.regionId,
                                    //                           e.name ?? '');
                                    //                     }).toList(),
                                    //                     onConfirm: (val) {
                                    //                       debugPrint(
                                    //                           '################${val.toString()}');
                                    //                       regionCubit
                                    //                           .onChangeRegionsList(
                                    //                               val);
                                    //                     },
                                    //                   ),
                                    //                 )
                                    //               : SizedBox();
                                    //         },
                                    //       )
                                    //     : SizedBox(),

                                    BlocBuilder<InterestsCubit, InterestsState>(
                                      builder: (context, state) {
                                        return interestsCubit.isGetInterest ==
                                                true
                                            ? Padding(
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                        top: context.height *
                                                            0.03),
                                                child: MultiSelectDialogField(
                                                  // listType: MultiSelectListType.CHIP,

                                                  title: Text(
                                                    LocaleKeys.interests.tr(),
                                                    style:
                                                        openSansBold.copyWith(
                                                            color:
                                                                darkGreyColor),
                                                  ),
                                                  buttonText: Text(
                                                    LocaleKeys.interests.tr(),
                                                    style:
                                                        openSansMedium.copyWith(
                                                            color:
                                                                darkGreyColor),
                                                  ),
                                                  searchTextStyle:
                                                      openSansMedium.copyWith(
                                                          color: darkGreyColor),
                                                  searchable: true,
                                                  searchHintStyle:
                                                      openSansMedium.copyWith(
                                                          color: darkGreyColor),
                                                  searchHint:
                                                      LocaleKeys.search.tr(),
                                                  selectedItemsTextStyle:
                                                      openSansMedium.copyWith(
                                                          color: darkGreyColor),
                                                  unselectedColor:
                                                      darkGreyColor,
                                                  buttonIcon: Icon(
                                                    Icons
                                                        .arrow_drop_down_outlined,
                                                    color: darkGreyColor,
                                                  ),
                                                  selectedColor: goldColor
                                                      .withOpacity(0.1),
                                                  checkColor: goldColor,
                                                  itemsTextStyle:
                                                      openSansRegular,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: darkGreyColor),
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                              .RADIUS_DEFAULT)),
                                                  //   initialValue: profileCubit.interestsProfile,

                                                  items: interestsCubit
                                                      .interestsModel.data!
                                                      .map((e) {
                                                    return MultiSelectItem(
                                                        e.id, e.name ?? '');
                                                  }).toList(),
                                                  onConfirm: (val) {
                                                    debugPrint(
                                                        '################${val.toString()}');
                                                    interestsCubit
                                                        .onChangeInterestsList(
                                                            val);
                                                  },
                                                ),
                                              )
                                            : SizedBox();
                                      },
                                    ),
                                    CustomTextField(
                                      labelText: LocaleKeys.discountCoupon.tr(),
                                      topPadding: context.height * 0.03,
                                      controller: promoCodeController,
                                    ),
                                    SizedBox(
                                      height: context.height * 0.1,
                                    ),
                                    // const Spacer(),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          bottom: context.height * 0.02.h),
                                      child: CustomButton(
                                        textButton:
                                            LocaleKeys.payForWallet.tr(),
                                        onPressed: () {
                                          if (interestsCubit
                                              .interestsList.isEmpty) {
                                            showCustomSnackBar(
                                                message: LocaleKeys
                                                    .selectYourInterest
                                                    .tr(),
                                                state: ToastState.ERROR);
                                          } else if (regionCubit.regionId==null) {
                                            showCustomSnackBar(
                                                message: LocaleKeys
                                                    .selectYourRegion
                                                    .tr(),
                                                state: ToastState.ERROR);
                                          } else {
                                            promotionCubit.payForPromotionMyAcc(
                                                categoryIds: interestsCubit
                                                    .interestsList,
                                                regionId:
                                                    regionCubit.regionsList,
                                                isWallet: true,
                                                promoCode:
                                                    promoCodeController.text);
                                          }
                                        },
                                        color: goldColor,
                                      ),
                                    ),
                                    CustomButton(
                                      textButton: LocaleKeys.pay.tr(),
                                      onPressed: () {
                                        if (interestsCubit.interestsList.isEmpty) {
                                          showCustomSnackBar(
                                              message: LocaleKeys
                                                  .selectYourInterest
                                                  .tr(),
                                              state: ToastState.ERROR);
                                        } else if (regionCubit.regionsList.isEmpty) {
                                          showCustomSnackBar(
                                              message: LocaleKeys
                                                  .selectYourRegion
                                                  .tr(),
                                              state: ToastState.ERROR);
                                        } else {
                                          promotionCubit.payForPromotionMyAcc(
                                              categoryIds:
                                                  interestsCubit.interestsList,
                                              regionId: regionCubit.regionsList,
                                              isWallet: false,
                                              promoCode:
                                                  promoCodeController.text);
                                        }
                                      },
                                      color: goldColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
        );
      },
    );
  }
}
