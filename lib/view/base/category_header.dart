import 'dart:io';

import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_constant.dart';
import '../../utils/dimention.dart';
import '../../utils/images.dart';
import '../../utils/text_style.dart';
import 'back_button.dart';
import 'filter_widget_region_category.dart';

class CategoryHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  Widget? action;
  Widget? leading;
  Function onTap;
  bool isFilter;
  bool isProvider;
  Function? changeStatusSearch;
  Widget? searchWidget;
  bool? isFilterRegion;
  ScrollController? scrollController;
  bool? isPadding;

  // double? bottomPadding;

  CategoryHeader({
    super.key,
    required this.title,
    this.action,
    this.isPadding = true,
    //  this.isSearchMode=false,
    this.searchWidget,
    this.changeStatusSearch,
    this.leading,
    required this.onTap,
    this.isFilter = true,
    this.isFilterRegion = false,
    this.scrollController,
    // this.bottomPadding,
    this.isProvider = false,
  });

// final _scrollController = ScrollController();
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(
      Dimensions.WEB_MAX_WIDTH,
      Platform.isWindows
          ? 70
          : isPadding == true
              ? 125.h
              : 175.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: whiteColor,
      //   statusBarBrightness: Brightness.dark
      // ),
      backgroundColor: whiteColor,
      automaticallyImplyLeading: false,
      elevation: 0,

      toolbarHeight:
          //bottomPadding??
          context.height * 0.01.sp,
      flexibleSpace: SafeArea(
        minimum: EdgeInsets.only(
            top: context.height * 0.05.sp,
            right: Dimensions.PADDING_SIZE_SMALL.sp,
            left: Dimensions.PADDING_SIZE_SMALL.sp,
            bottom: context.height * 0.03.sp),
        //  padding:  EdgeInsetsDirectional.only(top: context.height*0.1,start: Dimensions.PADDING_SIZE_SMALL,end: Dimensions.PADDING_SIZE_SMALL),
        child: isSearchMode == true
            ? Center(
                child: Column(
                children: [
                  searchWidget ?? SizedBox(),
                  SizedBox(
                    height: context.height * 0.01,
                  ),
                  isFilterRegion == true
                      ? FilterWidgetDropDown(
                          scrollControllerFilter: scrollController!,
                        )
                      // Row(
                      //         children: [
                      //           BlocBuilder<RegionsCubit, RegionState>(
                      //             builder: (context, state) {
                      //               return regionCubit.isGetRegion == false ||
                      //                       regionCubit.isGetRegion == null
                      //                   ? SizedBox()
                      //                   : Expanded(
                      //                       child: CustomDropDown(
                      //                           topPadding: 0.0,
                      //                           items: regionCubit
                      //                               .allRegionsModel.data!
                      //                               .map((e) {
                      //                             return DropdownMenuItem(
                      //                               child: Text(e.name ?? ''),
                      //                               value: e.regionId,
                      //                             );
                      //                           }).toList(),
                      //                           value: regionCubit.regionIdFilter,
                      //                           fct: (onChange) {
                      //                             regionCubit
                      //                                 .onChangeRegionIdFilter(
                      //                                     onChange);
                      //                             print(onChange);
                      //                           },
                      //                           hint: LocaleKeys.region.tr()),
                      //                     );
                      //             },
                      //           ),
                      //           SizedBox(
                      //             width: context.width * 0.02.w,
                      //           ),
                      //           BlocBuilder<AddRealAdsCubit, AddRealAdsState>(
                      //             builder: (context, state) {
                      //               return addRealAdsCubit.isGetResourceFeature ==
                      //                           false ||
                      //                       addRealAdsCubit.isGetResourceFeature ==
                      //                           null
                      //                   ? SizedBox()
                      //                   : Expanded(
                      //                       child: CustomDropDown(
                      //                           topPadding: 0.0,
                      //                           items: addRealAdsCubit
                      //                               .resourceCreateModel.adType!
                      //                               .map((e) {
                      //                             return DropdownMenuItem(
                      //                               child: Text(e.name ?? ''),
                      //                               value: e.id,
                      //                             );
                      //                           }).toList(),
                      //                           value: addRealAdsCubit
                      //                               .CategoryIdFilter,
                      //                           fct: (onChange) {
                      //                             addRealAdsCubit
                      //                                 .onChangeCategoryIdFilter(
                      //                                     onChange);
                      //                             regionCubit.regionIdFilter == 0
                      //                                 ? null
                      //                                 : regionCubit
                      //                                     .getCitiesByRegionId(
                      //                                         context: context,
                      //                                         page: 1,
                      //                                         regionId: regionCubit
                      //                                                 .regionIdFilter ??
                      //                                             0)
                      //                                     .then((value) {
                      //                                     // if(regionCubit.regionId == 0){
                      //                                     //   context.read<OrdersProviderCubit>().getPendingOrdersProvider(page: 1,context: context);
                      //                                     // }else {
                      //                                     CustomBottomSheet(
                      //                                         context: context,
                      //                                         regionFilter: regionCubit
                      //                                                 .regionIdFilter ??
                      //                                             0,
                      //                                         controller:
                      //                                             scrollController!,
                      //                                         confirm: () {
                      //                                           Navigator.pop(
                      //                                               context);
                      //                                           // orderProviderCubit
                      //                                           //     .getPendingOrdersProvider(
                      //                                           //     page: 1,
                      //                                           //     context: context);
                      //                                         });
                      //                                     //}
                      //                                   });
                      //                             print(onChange);
                      //                           },
                      //                           hint: 'نوع العقار'),
                      //                     );
                      //             },
                      //           ),
                      //         ],
                      //       )
                      : SizedBox(),
                ],
              ))
            : Column(
                children: [
                  Card(
                    color: whiteColor,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            Dimensions.RADIUS_EXTRA_LARGE.sp)),
                    child: Container(
                      margin: EdgeInsets.all(
                        Dimensions.PADDING_SIZE_EXTRA_SMALL.sp,
                      ),
                      padding: EdgeInsets.all(
                        Dimensions.PADDING_SIZE_EXTRA_SMALL.sp,
                      ),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(
                              Dimensions.RADIUS_EXTRA_LARGE.sp)),
                      child: isProvider
                          ? Center(
                              child: Text(
                                title,
                                style:
                                    openSansBold.copyWith(color: darkGreyColor),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                leading ??
                                    BackButtonWidget(
                                      color: darkGreyColor,
                                      foregroundColor: goldColor,
                                    ),
                                Text(
                                  title,
                                  style: openSansBold.copyWith(
                                      color: darkGreyColor),
                                ),
                                isFilter
                                    ? GestureDetector(
                                        onTap: () {
                                          onTap();
                                        },
                                        child: action ??
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  child: SvgPicture.asset(
                                                    Images.SearchIcon,
                                                    height: 30.sp,
                                                    width: 30.sp,
                                                  ),
                                                  onTap: () {
                                                    changeStatusSearch!();
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 5.sp,
                                                ),
                                                action ??
                                                    SvgPicture.asset(
                                                      Images.Filter_SVG,
                                                    ),
                                              ],
                                            ))
                                    : SvgPicture.asset(
                                        Images.Filter_SVG,
                                        color: whiteColor,
                                      )
                              ],
                            ),
                    ),
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  isFilterRegion == true
                      ? FilterWidgetDropDown(
                          scrollControllerFilter: scrollController!,
                        )
                      : SizedBox(),
                ],
              ),
      ),
    );
  }

// @override
// // TODO: implement preferredSize
// Size get preferredSize => Size(Dimensions.WEB_MAX_WIDTH,Dimensions.MESSAGE_INPUT_LENGTH);
}
