import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../bloc/ads_by_id_cubit/cubit.dart';
import '../../../../bloc/map_ads_cubit/cubit.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/images.dart';
import '../../../../utils/text_style.dart';
import '../../../base/lunch_widget.dart';
import '../../../base/riyal_widget.dart';
import '../../details_screen/aqar_details_screen.dart';
import '../../details_screen/widget/similar_ads.dart';
import 'dragabble_widget.dart';

class VisibilityWidgetOnMap extends StatelessWidget {
  const VisibilityWidgetOnMap({super.key});

  @override
  Widget build(BuildContext context) {
    var adsOnMapCubit = context.read<AdsOnMapCubit>();
    return Visibility(
      visible: adsOnMapCubit.tabbed != 00,
      child: Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Card(
              elevation: 3,
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE)),
              child: SimilarAds(
                image: adsOnMapCubit.nearbyAqarModel.data![adsOnMapCubit.adsId]
                        .photos!.isEmpty
                    ? Images.AVATAR_IMAGE
                    : adsOnMapCubit.nearbyAqarModel.data![adsOnMapCubit.adsId]
                        .photos!.first,
                isFavouriteWidget: false,
                isTabbedFavourite: adsOnMapCubit
                    .nearbyAqarModel.data![adsOnMapCubit.adsId].isFavorite!,
                favouriteFunction: () {
                  adsOnMapCubit.nearbyAqarModel.data![adsOnMapCubit.adsId]
                          .isFavorite!
                      ? adsOnMapCubit.removeFavourite(
                          adsOnMapCubit.adsId,
                          adsOnMapCubit
                              .nearbyAqarModel.data![adsOnMapCubit.adsId].id
                              .toString(),
                          context)
                      : adsOnMapCubit.addFavourite(
                          adsOnMapCubit.adsId,
                          adsOnMapCubit
                              .nearbyAqarModel.data![adsOnMapCubit.adsId].id
                              .toString(),
                          context);
                },
                onTap: () {
                  context.read<AdyByIdCubit>().getAdById(
                      id: adsOnMapCubit
                          .nearbyAqarModel.data![adsOnMapCubit.adsId].id!);
                  navigateForward(AqarDetailsScreen(
                    adId: adsOnMapCubit
                        .nearbyAqarModel.data![adsOnMapCubit.adsId].id!,
                    categoryId: adsOnMapCubit.nearbyAqarModel
                        .data![adsOnMapCubit.adsId].categoryAds!.id
                        .toString(),
                    // aqarIndex: 0,
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${adsOnMapCubit.nearbyAqarModel.data?[adsOnMapCubit.adsId].categoryAds?.name ?? ''}',
                              style: openSansMedium.copyWith(
                                  color: darkGreyColor)),
                          //  Spacer(),

                          Row(
                            children: [
                              Text(
                                  '${adsOnMapCubit.nearbyAqarModel.data?[adsOnMapCubit.adsId].price}',
                                  style: openSansMedium.copyWith(color: goldColor)),
                              SizedBox(width:context.width*0.005.w),
                              riyalWidget(context),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(Images.SMALL_LOCATION),
                          SizedBox(
                            width: 5.w,
                          ),
                          Expanded(
                            child: Text(
                              "${adsOnMapCubit.nearbyAqarModel.data?[adsOnMapCubit.adsId].district}, ${adsOnMapCubit.nearbyAqarModel.data?[adsOnMapCubit.adsId].city}, ${adsOnMapCubit.nearbyAqarModel.data?[adsOnMapCubit.adsId].region}",
                              // adsOnMapCubit
                              //         .nearbyAqarModel
                              //         .data?[
                              //             adsOnMapCubit
                              //                 .adsId]
                              //         .address ??
                              //     '',
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  openSansMedium.copyWith(color: darkGreyColor),
                            ),
                          ),
                        ],
                      ),
                      adsOnMapCubit.nearbyAqarModel.data?[adsOnMapCubit.adsId]
                                      .categoryAds?.id ==
                                  12 ||
                              adsOnMapCubit
                                      .nearbyAqarModel
                                      .data?[adsOnMapCubit.adsId]
                                      .categoryAds
                                      ?.id ==
                                  14 ||
                              adsOnMapCubit
                                      .nearbyAqarModel
                                      .data?[adsOnMapCubit.adsId]
                                      .categoryAds
                                      ?.id ==
                                  18 ||
                              adsOnMapCubit
                                      .nearbyAqarModel
                                      .data?[adsOnMapCubit.adsId]
                                      .categoryAds
                                      ?.id ==
                                  13 ||
                              adsOnMapCubit
                                      .nearbyAqarModel
                                      .data?[adsOnMapCubit.adsId]
                                      .categoryAds
                                      ?.id ==
                                  19 ||
                              adsOnMapCubit
                                      .nearbyAqarModel
                                      .data?[adsOnMapCubit.adsId]
                                      .categoryAds
                                      ?.id ==
                                  16 ||
                              adsOnMapCubit
                                      .nearbyAqarModel
                                      .data?[adsOnMapCubit.adsId]
                                      .categoryAds
                                      ?.id ==
                                  21 ||
                              adsOnMapCubit
                                      .nearbyAqarModel
                                      .data?[adsOnMapCubit.adsId]
                                      .categoryAds
                                      ?.id ==
                                  24 ||
                              adsOnMapCubit
                                      .nearbyAqarModel
                                      .data?[adsOnMapCubit.adsId]
                                      .categoryAds
                                      ?.id ==
                                  25 ||
                              adsOnMapCubit
                                      .nearbyAqarModel
                                      .data?[adsOnMapCubit.adsId]
                                      .categoryAds
                                      ?.id ==
                                  27 ||
                              adsOnMapCubit
                                      .nearbyAqarModel
                                      .data?[adsOnMapCubit.adsId]
                                      .categoryAds
                                      ?.id ==
                                  34 ||
                              adsOnMapCubit
                                      .nearbyAqarModel
                                      .data?[adsOnMapCubit.adsId]
                                      .categoryAds
                                      ?.id ==
                                  36 ||
                              adsOnMapCubit
                                          .nearbyAqarModel
                                          .data?[adsOnMapCubit.adsId]
                                          .categoryAds
                                          ?.id ==
                                      35 &&
                                  adsOnMapCubit
                                      .nearbyAqarModel
                                      .data![adsOnMapCubit.adsId]
                                      .additionalFeatures!
                                      .isNotEmpty
                          ? Container(
                              height: adsOnMapCubit
                                      .nearbyAqarModel
                                      .data![adsOnMapCubit.adsId]
                                      .additionalFeatures!
                                      .isEmpty
                                  ? 0
                                  : 20.sp,
                              width: context.width,
                              child:
                              Wrap(
                                children: List.generate(
                                  adsOnMapCubit
                                      .nearbyAqarModel
                                      .data![adsOnMapCubit.adsId].additionalFeatures!.length >= 4 ? 4 : adsOnMapCubit
                                      .nearbyAqarModel
                                      .data![adsOnMapCubit.adsId].additionalFeatures!.length,
                                      (indexx) {
                                    return Padding(
                                      padding: EdgeInsetsDirectional.only(
                                        end: context.width * 0.02,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.network(
                                            adsOnMapCubit
                                      .nearbyAqarModel
                                      .data![adsOnMapCubit.adsId].additionalFeatures?[indexx].image ?? 'https://dashboard.redd.sa/dash/additional_features/1717849710.png',
                                            height: context.height * 0.03,
                                            width: context.width * 0.04,
                                            // width: 20.sp,
                                            // height: 20.sp,
                                          ),
                                          SizedBox(
                                            width: context.width * 0.01,
                                          ),
                                          AutoSizeText(
                                            adsOnMapCubit
                                      .nearbyAqarModel
                                      .data![adsOnMapCubit.adsId].additionalFeatures?[indexx].name ?? '',
                                            presetFontSizes: [
                                              12.sp,
                                              10.sp,
                                              5.sp
                                            ],
                                            overflow: TextOverflow.clip,
                                            style: openSansMedium.copyWith(color: goldColor),
                                          ),
                                          // SizedBox(
                                          //   width: context.width * 0.1.sp,
                                          // ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // ListView.builder(
                              //     physics: NeverScrollableScrollPhysics(),
                              //     scrollDirection: Axis.horizontal,
                              //     itemCount: adsOnMapCubit
                              //                 .nearbyAqarModel
                              //                 .data![adsOnMapCubit.adsId]
                              //                 .additionalFeatures!
                              //                 .length >=
                              //             2
                              //         ? 2
                              //         : adsOnMapCubit
                              //             .nearbyAqarModel
                              //             .data![adsOnMapCubit.adsId]
                              //             .additionalFeatures!
                              //             .length,
                              //     itemBuilder: (context, i) {
                              //       return FittedBox(
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceBetween,
                              //           mainAxisSize: MainAxisSize.max,
                              //           children: [
                              //             Image.network(
                              //               adsOnMapCubit
                              //                       .nearbyAqarModel
                              //                       .data![adsOnMapCubit.adsId]
                              //                       .additionalFeatures?[i]
                              //                       .image ??
                              //                   'https://dashboard.redd.sa/dash/additional_features/1717849710.png',
                              //               width: 20.sp,
                              //               height: 20.sp,
                              //             ),
                              //             AutoSizeText(
                              //               adsOnMapCubit
                              //                       .nearbyAqarModel
                              //                       .data![adsOnMapCubit.adsId]
                              //                       .additionalFeatures?[i]
                              //                       .name ??
                              //                   '',
                              //               presetFontSizes: [
                              //                 12.sp,
                              //                 10.sp,
                              //                 7.sp
                              //               ],
                              //               style: openSansMedium.copyWith(
                              //                   color: goldColor),
                              //             ),
                              //             SizedBox(
                              //               width: context.width * 0.1,
                              //             ),
                              //           ],
                              //         ),
                              //       );
                              //     }),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT,
                      )
                    ],
                  ),
                ),
              ),
            ),
            DragabbleWidget(),
          ],
        ),
      ),
    );
  }
}
