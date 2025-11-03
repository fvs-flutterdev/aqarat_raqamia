import 'package:aqarat_raqamia/bloc/sponsor_ads_cubit/cubit.dart';
import 'package:aqarat_raqamia/bloc/sponsor_ads_cubit/state.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/base/shimmer/ads_shimmer.dart';
import 'package:aqarat_raqamia/view/error_widget/error_widget.dart';
import 'package:aqarat_raqamia/view/screens/details_screen/widget/similar_ads.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../bloc/ads_by_id_cubit/cubit.dart';
import '../../../../bloc/send_clicks_cubit/cubit.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/images.dart';
import '../../details_screen/aqar_details_screen.dart';
import '../../favourites/widget/favourite_widget.dart';

class HorizontalSponsorAdsListView extends StatelessWidget {
  double? height;
  double? width;

  HorizontalSponsorAdsListView({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    var getSponsorAdsCubit = context.read<SponsorAdsCubit>();
    return BlocBuilder<SponsorAdsCubit, SponsorAdsState>(
      builder: (context, state) {
        if (getSponsorAdsCubit.isGetSponsorAds == false) {
          return AdsShimmer(
            isCategory: true,
          );
        } else if (state is GetSponsorAdsErrorState) {
          return CustomErrorWidget(reload: () {
            return getSponsorAdsCubit.getSponsorAds(page: 1);
          });
        } else if (getSponsorAdsCubit.sponsorAdsModel.data!.isEmpty) {
          return Center(
            child: Text(
              LocaleKeys.noData.tr(),
              style: openSansMedium.copyWith(color: darkGreyColor),
            ),
          );
        } else {
          return Container(
            height: height ?? context.height * 0.31.sp,
        //   height: height ?? context.height * 0.137.h,
           // width:context.width*0.8.w,

            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(
                  Dimensions.RADIUS_LARGE,
                )),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: Dimensions.PADDING_SIZE_DEFAULT.w,
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount:
                  getSponsorAdsCubit.sponsorAdsModel.data!.length ,
                      //< 2 ? 1 : 2,
              itemBuilder: (context, index) {
                // return SimilarAds(
                //   width:context.width*0.91.w,
                //   isFavouriteWidget:
                //   false,
                //   isTabbedFavourite:
                //   getSponsorAdsCubit.sponsorAdsModel
                //       .data![
                //   index]
                //       .isFavorite!,
                //   favouriteFunction:
                //       () {
                //         getSponsorAdsCubit.sponsorAdsModel
                //         .data![
                //     index]
                //         .isFavorite!
                //         ? getSponsorAdsCubit.removeFavourite(
                //        index: index, adId:  getSponsorAdsCubit
                //             .sponsorAdsModel
                //             .data![
                //         index]
                //             .id
                //             .toString(), context:  context)
                //         : getSponsorAdsCubit.addFavourite(
                //              index,
                //             getSponsorAdsCubit
                //                 .sponsorAdsModel
                //             .data![index]
                //             .id
                //             .toString(),
                //         context);
                //   },
                //   image: getSponsorAdsCubit.sponsorAdsModel
                //       .data![
                //   index]
                //       .photos!
                //       .isEmpty ||
                //       getSponsorAdsCubit.sponsorAdsModel
                //           .data![
                //       index]
                //           .photos ==
                //           null
                //       ? Images
                //       .AVATAR_IMAGE
                //       : getSponsorAdsCubit.sponsorAdsModel
                //       .data![
                //   index]
                //       .photos!
                //       .first,
                //   onTap: () {
                //    // navigateForward(
                //       context.read<AdyByIdCubit>().getAdById(
                //           id: getSponsorAdsCubit
                //               .sponsorAdsModel.data![index].id!);
                //       navigateForward(
                //       AqarDetailsScreen(
                //       adId:
                //       getSponsorAdsCubit.sponsorAdsModel.data![index].id!,
                //       categoryId: getSponsorAdsCubit
                //           .sponsorAdsModel.data![index].categoryAds!.id
                //           .toString(),
                //     ),
                //     );
                //   //  );
                //   },
                //   child: Column(
                //     crossAxisAlignment:
                //     CrossAxisAlignment
                //         .start,
                //     mainAxisAlignment:
                //     MainAxisAlignment
                //         .center,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets
                //             .only(
                //             bottom:
                //             Dimensions.PADDING_SIZE_EXTRA_SMALL),
                //         child: Row(
                //           mainAxisSize:
                //           MainAxisSize
                //               .max,
                //           mainAxisAlignment:
                //           MainAxisAlignment
                //               .spaceBetween,
                //           children: [
                //             Text(
                //                 '${getSponsorAdsCubit.sponsorAdsModel.data?[index].categoryAds?.name ?? ''}',
                //                 style:
                //                 openSansExtraBold.copyWith(color: darkGreyColor)),
                //             //  Spacer(),
                //
                //             Text(
                //                 '${getSponsorAdsCubit.sponsorAdsModel.data?[index].price} ${LocaleKeys.currency.tr()}',
                //                 style:
                //                 openSansBold.copyWith(color: goldColor))
                //           ],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets
                //             .only(
                //             bottom:
                //             Dimensions.PADDING_SIZE_EXTRA_SMALL),
                //         child: Row(
                //           children: [
                //             SvgPicture
                //                 .asset(
                //               Images
                //                   .SMALL_LOCATION,
                //               height:
                //               context.height * 0.01.h,
                //               width:
                //               context.width * 0.01.w,
                //             ),
                //             SizedBox(
                //               width:
                //               5.w,
                //             ),
                //             Expanded(
                //               child:
                //               Text(
                //                 "${getSponsorAdsCubit.sponsorAdsModel.data?[index].district}, ${getSponsorAdsCubit.sponsorAdsModel.data?[index].city}, ${getSponsorAdsCubit.sponsorAdsModel.data?[index].region}" ??
                //                     '',
                //                 overflow:
                //                 TextOverflow.ellipsis,
                //                 softWrap:
                //                 true,
                //                 style:
                //                 openSansMedium.copyWith(color: darkGreyColor),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       getSponsorAdsCubit.sponsorAdsModel.data?[index].categoryAds?.id == 12 ||
                //           getSponsorAdsCubit.sponsorAdsModel.data?[index].categoryAds?.id ==
                //               14 ||
                //           getSponsorAdsCubit.sponsorAdsModel.data?[index].categoryAds?.id ==
                //               18 ||
                //           getSponsorAdsCubit.sponsorAdsModel.data?[index].categoryAds?.id ==
                //               13 ||
                //           getSponsorAdsCubit.sponsorAdsModel.data?[index].categoryAds?.id ==
                //               19 ||
                //           getSponsorAdsCubit.sponsorAdsModel.data?[index].categoryAds?.id ==
                //               16 ||
                //           getSponsorAdsCubit.sponsorAdsModel.data?[index].categoryAds?.id ==
                //               21 ||
                //           getSponsorAdsCubit.sponsorAdsModel.data?[index].categoryAds?.id ==
                //               24 ||
                //           getSponsorAdsCubit.sponsorAdsModel.data?[index].categoryAds?.id ==
                //               25 ||
                //           getSponsorAdsCubit.sponsorAdsModel.data?[index].categoryAds?.id ==
                //               27 ||
                //           getSponsorAdsCubit.sponsorAdsModel.data?[index].categoryAds?.id ==
                //               34 ||
                //           getSponsorAdsCubit.sponsorAdsModel.data?[index].categoryAds?.id ==
                //               36 ||
                //           getSponsorAdsCubit.sponsorAdsModel.data?[index].categoryAds?.id == 35 &&
                //               getSponsorAdsCubit.sponsorAdsModel.data![index].additionalFeatures!.isNotEmpty
                //           ? Expanded(
                //         child:
                //         Container(
                //           height: getSponsorAdsCubit.sponsorAdsModel.data![index].additionalFeatures!.isEmpty
                //               ? 0
                //               : 20.sp,
                //           width:
                //           context.width,
                //           child:
                //           Wrap(
                //             children: List.generate(
                //               getSponsorAdsCubit.sponsorAdsModel.data![index].additionalFeatures!.length >= 4 ? 4 : getSponsorAdsCubit.sponsorAdsModel.data![index].additionalFeatures!.length,
                //                   (indexx) {
                //                 return Padding(
                //                   padding: EdgeInsetsDirectional.only(
                //                     end: context.width * 0.02,
                //                   ),
                //                   child: Row(
                //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //                     mainAxisSize: MainAxisSize.min,
                //                     children: [
                //                       Image.network(
                //                         getSponsorAdsCubit.sponsorAdsModel.data![index].additionalFeatures?[indexx].image ?? 'https://dashboard.redd.sa/dash/additional_features/1717849710.png',
                //                         height: context.height * 0.03,
                //                         width: context.width * 0.04,
                //                         // width: 20.sp,
                //                         // height: 20.sp,
                //                       ),
                //                       SizedBox(
                //                         width: context.width * 0.01,
                //                       ),
                //                       AutoSizeText(
                //                         getSponsorAdsCubit.sponsorAdsModel.data![index].additionalFeatures?[indexx].name ?? '',
                //                         presetFontSizes: [
                //                           12.sp,
                //                           10.sp,
                //                           5.sp
                //                         ],
                //                         overflow: TextOverflow.clip,
                //                         style: openSansMedium.copyWith(color: goldColor),
                //                       ),
                //                       // SizedBox(
                //                       //   width: context.width * 0.1.sp,
                //                       // ),
                //                     ],
                //                   ),
                //                 );
                //               },
                //             ),
                //           ),
                //           // ListView.builder(
                //           //     physics: NeverScrollableScrollPhysics(),
                //           //     scrollDirection: Axis.horizontal,
                //           //     itemCount: getSponsorAdsCubit.sponsorAdsModel.data![index].additionalFeatures!.length >= 2 ? 2 : getSponsorAdsCubit.sponsorAdsModel.data?[index].additionalFeatures!.length,
                //           //     itemBuilder: (context, i) {
                //           //       return FittedBox(
                //           //         child: Row(
                //           //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           //           mainAxisSize: MainAxisSize.max,
                //           //           children: [
                //           //             Image.network(
                //           //               similarAdsCubit.similarAdsModel.data?[index].additionalFeatures?[i].image ?? 'https://dashboard.redd.sa/dash/additional_features/1717849710.png',
                //           //               width: 20.sp,
                //           //               height: 20.sp,
                //           //             ),
                //           //             AutoSizeText(
                //           //               similarAdsCubit.similarAdsModel.data?[index].additionalFeatures?[i].name ?? '',
                //           //               presetFontSizes: [
                //           //                 12.sp,
                //           //                 10.sp,
                //           //                 7.sp
                //           //               ],
                //           //               style: openSansMedium.copyWith(color: goldColor),
                //           //             ),
                //           //             SizedBox(
                //           //               width: context.width * 0.1,
                //           //             ),
                //           //           ],
                //           //         ),
                //           //       );
                //           //     }),
                //         ),
                //       )
                //           : const SizedBox(),
                //       const SizedBox(
                //         height: Dimensions
                //             .PADDING_SIZE_DEFAULT,
                //       )
                //     ],
                //   ),
                // );
                return FavouriteWidget(
                  categoryId: getSponsorAdsCubit
                      .sponsorAdsModel.data![index].categoryAds!.id,
                  features: getSponsorAdsCubit
                      .sponsorAdsModel.data![index].additionalFeatures,
                  isTabbedFavourite: getSponsorAdsCubit
                      .sponsorAdsModel.data![index].isFavorite!,
                  favouriteFunction: () {
                    getSponsorAdsCubit.sponsorAdsModel.data![index].isFavorite!
                        ? getSponsorAdsCubit.removeFavourite(
                            index: index,
                            adId: getSponsorAdsCubit
                                .sponsorAdsModel.data![index].id
                                .toString(),
                            context: context,
                          )
                        : getSponsorAdsCubit.addFavourite(
                            index,
                            getSponsorAdsCubit.sponsorAdsModel.data![index].id
                                .toString(),
                            context,
                          );
                  },
                  onTap: () {

                    context.read<AdyByIdCubit>().getAdById(
                        id: getSponsorAdsCubit
                            .sponsorAdsModel.data![index].id!);
                    navigateForward(
                      AqarDetailsScreen(
                        adId:
                            getSponsorAdsCubit.sponsorAdsModel.data![index].id!,
                        categoryId: getSponsorAdsCubit
                            .sponsorAdsModel.data![index].categoryAds!.id
                            .toString(),
                      ),
                    );
                  },
                  width: width ?? context.width * 0.9.sp,
                  adLocation:
                      '${getSponsorAdsCubit.sponsorAdsModel.data![index].district}, ${getSponsorAdsCubit.sponsorAdsModel.data![index].city}, ${getSponsorAdsCubit.sponsorAdsModel.data![index].region}',
                  title: getSponsorAdsCubit
                          .sponsorAdsModel.data![index].name ??
                      '',
                  image: getSponsorAdsCubit
                          .sponsorAdsModel.data![index].photos?.first ??
                      Images.AVATAR_IMAGE,
                  bathNo: getSponsorAdsCubit
                          .sponsorAdsModel.data![index].toiletsNumber ??
                      '',
                  bedNo: getSponsorAdsCubit
                          .sponsorAdsModel.data![index].roomsNumber ??
                      '',
                  price:
                      '${getSponsorAdsCubit.sponsorAdsModel.data![index].price}',
                );

              },
            ),
          );
        }
      },
    );
  }
}
