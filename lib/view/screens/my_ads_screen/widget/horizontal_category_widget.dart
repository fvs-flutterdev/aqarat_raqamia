import '../../../../bloc/edit_ad_cubit/edit_ad_info_cubit/cubit.dart';
import '../../../../utils/images.dart';
import '../../../../utils/media_query_value.dart';
import '../../../../view/base/lunch_widget.dart';
import '../../../../view/base/shimmer/ads_shimmer.dart';
import '../../../../view/error_widget/error_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../bloc/add_real_ads/cubit.dart';
import '../../../../bloc/add_real_ads/state.dart';
import '../../../../bloc/filter_search_add_cubit/cubit.dart';
import '../../../../bloc/filter_search_add_cubit/state.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/text_style.dart';
import '../../category/category_screen.dart';

///
//ignore: must_be_immutable
class HorizontalGridRealEstateTypeForEditWidget extends StatelessWidget {
  Function? onTap;
  Color? backgroundColor;
  bool? isSame;
  int? adId;
  //bool isTabExtent;

  HorizontalGridRealEstateTypeForEditWidget({
    super.key,
    this.onTap,
    this.backgroundColor,
    this.isSame,
    this.adId,
   // this.isTabExtent = false,
  });

  @override
  Widget build(BuildContext context) {
    var editAdInfoCubit=context.read<EditAdInfoCubit>();
  //  var addRealAdsCubit = context.read<AddRealAdsCubit>();
    var filterSearchAdsCubit = context.read<FilterSearchAdsCubit>();
    return BlocBuilder<AddRealAdsCubit, AddRealAdsState>(
      builder: (context, state) {
        if (state is GetFeatureForCreateAdsLoadingState) {
          return AdsShimmer(
            isHorizontal: true,
          );
        }
        return state is GetFeatureForCreateAdsErrorsState
            ? CustomErrorWidget(reload: () {
          return editAdInfoCubit.getResourceFeatureForEdit();
        })
            : editAdInfoCubit.isGetResourceFeature == false
            ? AdsShimmer(
          isHorizontal: true,
        )
            : Container(
          height: context.height * 0.3.sp,
          child: AnimationConfiguration.synchronized(
              duration: const Duration(milliseconds: 520),
              child: SlideAnimation(
                curve: Curves.fastEaseInToSlowEaseOut,
                verticalOffset: 50.0.sp,
                child: FadeInAnimation(
                  child: MasonryGridView.count(
                    itemCount: editAdInfoCubit
                        .resourceCreateModel.adType?.length,
                    scrollDirection: Axis.horizontal,
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 10.sp,
                    itemBuilder: (BuildContext context, int index) {
                      return BlocBuilder<FilterSearchAdsCubit, FilterSearchAdsState>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap:
                            // isTabExtent ? () async {
                            //   filterSearchAdsCubit.searchAdsById(
                            //       categoryId: addRealAdsCubit
                            //           .resourceCreateModel
                            //           .adType![index]
                            //           .id
                            //           .toString(),
                            //       page: 1,
                            //       context: context);
                            //   navigateForward(CategoryScreen(
                            //     nameOfCategory: addRealAdsCubit
                            //         .resourceCreateModel
                            //         .adType![index]
                            //         .name ??
                            //         '',
                            //     index: addRealAdsCubit
                            //         .resourceCreateModel
                            //         .adType![index]
                            //         .id!,
                            //     // model: SearchResultModel,
                            //   ));
                            //   //  categoryModel[index].onTap();
                            // }
                            //     :
                                () {
                                  editAdInfoCubit.changeStateOfItemForEdit(
                                  index: index);
                              filterSearchAdsCubit.categoryId =
                                  editAdInfoCubit
                                      .resourceCreateModel
                                      .adType![index]
                                      .id
                                      .toString();
                                  editAdInfoCubit.adsTypeForEdit =
                                      editAdInfoCubit
                                      .resourceCreateModel
                                      .adType![index]
                                      .name ??
                                      '';
                                  editAdInfoCubit.adsIdForEdit =
                                      editAdInfoCubit
                                      .resourceCreateModel
                                      .adType![index]
                                      .id;
                              // addRealAdsCubit.adsType addRealAdsCubit.resourceCreateModel.adType![index].name??'' ;
                              // index= addRealAdsCubit.resourceCreateModel.adType![index].id!;
                              print(filterSearchAdsCubit
                                  .categoryId);
                              // filterSearchAdsCubit.changeStateOfItem(index: index);
                              //   print(categoryModel[index].isTabbed);
                            },
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Stack(
                                  // fit: StackFit.expand,
                                  alignment:
                                  AlignmentDirectional.center,
                                  children: [
                                    Card(
                                      elevation: 0.5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              Dimensions
                                                  .RADIUS_LARGE)),
                                      color: darkGreyColor,
                                      child: Container(
                                        height: 70.sp,
                                        width: 70.sp,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius
                                                .circular(Dimensions
                                                .RADIUS_LARGE),
                                            // color: whiteColor,
                                            color:

                                            editAdInfoCubit.resourceCreateModel.adType![index].istabbed==true||(isSame==true&&adId==editAdInfoCubit.resourceCreateModel.adType![index].id)
                                                ? darkGreysColor
                                                : whiteColor),
                                        child: Image.network(
                                            editAdInfoCubit
                                                .resourceCreateModel
                                                .adType![index]
                                                .photo ??
                                                ''),
                                      ),
                                    ),
                                    editAdInfoCubit
                                        .resourceCreateModel
                                        .adType![index]
                                        .istabbed==true||(isSame==true&&adId==editAdInfoCubit.resourceCreateModel.adType![index].id)
                                        ? SvgPicture.asset(
                                        Images.Stack_Checked,
                                        fit: BoxFit.contain)
                                        : const SizedBox()
                                  ],
                                ),
                                const SizedBox(
                                  height:
                                  Dimensions.PADDING_SIZE_SMALL,
                                ),
                                AutoSizeText(
                                  editAdInfoCubit.resourceCreateModel
                                      .adType![index].name ??
                                      '',
                                  // maxLines: 1,

                                  presetFontSizes: [
                                    10.sp,
                                    8.sp,
                                    7.sp
                                  ],
                                  softWrap: true,
                                  maxFontSize: 10.sp,
                                  minFontSize: 7.sp,
                                  maxLines: 1,

                                  overflow: TextOverflow.ellipsis,
                                  style: openSansMedium.copyWith(
                                      color: darkGreyColor),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              )),
        );
      },
    );
  }
}
// class HorizontalGridView extends StatelessWidget {
//   Function? onTap;
//   Color? backgroundColor;
//   bool isTabExtent;
//
//   // String? name;
//   // String? aqaerId;
//
//   HorizontalGridView({
//     super.key,
//     this.onTap,
//     this.backgroundColor,
//     this.isTabExtent = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     var filterSearchAdsCubit = context.read<FilterSearchAdsCubit>();
//     var adRealAdsCubit = context.read<AddRealAdsCubit>();
//
//     //FilterSearchAdsCubit.get(context);
//     return BlocBuilder<AddRealAdsCubit, AddRealAdsState>(
//
//       builder: (context, state) {
//
//         if (state is GetFeatureForCreateAdsLoadingState) {
//           return AdsShimmer(
//             isHorizontal: true,
//           );
//         }
//         return state is GetFeatureForCreateAdsErrorsState
//             ? CustomErrorWidget(reload: () {
//                 return adRealAdsCubit.getResourceFeature();
//               })
//             :adRealAdsCubit.isGetResourceFeature==false?AdsShimmer(
//           isHorizontal: true,
//         ):
//         Container(
//                 height: 150.sp,
//                 child: GridView.builder(
//                     itemCount:
//                         adRealAdsCubit.resourceCreateModel.adType?.length,
//                     scrollDirection: Axis.horizontal,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         mainAxisExtent: 70.sp,
//                         mainAxisSpacing: 5.w,
//                         crossAxisCount: 1),
//                     itemBuilder: (context, index) {
//
//                       return BlocBuilder<FilterSearchAdsCubit,
//                           FilterSearchAdsState>(
//                         builder: (context, state) {
//
//                           return GestureDetector(
//                             onTap: isTabExtent
//                                 ? () async{
//                                     filterSearchAdsCubit.searchAdsById(
//                                         categoryId: adRealAdsCubit.resourceCreateModel.adType![index].id.toString(),
//                                         page: 1,
//                                         context: context);
//                                     navigateForward(CategoryScreen(
//                                       nameOfCategory: adRealAdsCubit
//                                           .resourceCreateModel
//                                           .adType![index]
//                                           .name ??
//                                           '',
//                                       index: adRealAdsCubit
//                                           .resourceCreateModel
//                                           .adType![index]
//                                           .id!,
//                                       // model: SearchResultModel,
//                                     ));
//                                     //  categoryModel[index].onTap();
//                                   }
//                                 : () {
//                                     adRealAdsCubit.changeStateOfItem(index: index);
//                                     filterSearchAdsCubit.categoryId = adRealAdsCubit.resourceCreateModel.adType![index].id.toString();
//                                     adRealAdsCubit.adsType = adRealAdsCubit.resourceCreateModel.adType![index].name ??
//                                         '';
//                                     adRealAdsCubit.adsId = adRealAdsCubit
//                                         .resourceCreateModel.adType![index].id;
//                                     // adRealAdsCubit.adsType adRealAdsCubit.resourceCreateModel.adType![index].name??'' ;
//                                     // index= adRealAdsCubit.resourceCreateModel.adType![index].id!;
//                                     print(filterSearchAdsCubit.categoryId);
//                                     // filterSearchAdsCubit.changeStateOfItem(index: index);
//                                  //   print(categoryModel[index].isTabbed);
//                                   },
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Card(
//                                   elevation: 0.5,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(
//                                           Dimensions.RADIUS_LARGE)),
//                                   color: darkGreyColor,
//                                   child: Container(
//                                     height: 70.sp,
//                                     width: 70.sp,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(
//                                             Dimensions.RADIUS_LARGE),
//                                         color: adRealAdsCubit
//                                                 .resourceCreateModel
//                                                 .adType![index]
//                                                 .istabbed
//                                             ? lightGrey
//                                             : whiteColor),
//                                     child: Image.network(adRealAdsCubit
//                                             .resourceCreateModel
//                                             .adType![index]
//                                             .photo ??
//                                         ''),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: Dimensions.PADDING_SIZE_SMALL,
//                                 ),
//                                 AutoSizeText(
//                                   adRealAdsCubit.resourceCreateModel
//                                           .adType![index].name ??
//                                       '',
//                                  // maxLines: 1,
//                                   presetFontSizes: [ 14.sp,12.sp,10.sp],
//                                   softWrap: true,
//                                   maxLines:1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: openSansMedium.copyWith(
//
//
//                                       color: darkGreyColor),
//                                 )
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     }),
//               );
//       },
//     );
//   }
// }
