import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../bloc/ads_by_id_cubit/cubit.dart';
import '../../../bloc/promoted_services_cubit/cubit.dart';
import '../../../bloc/promoted_services_cubit/state.dart';
import '../../../bloc/sponsor_ads_cubit/cubit.dart';
import '../../../bloc/sponsor_ads_cubit/state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/dimention.dart';
import '../../../utils/images.dart';
import '../../../utils/media_query_value.dart';
import '../../../utils/text_style.dart';
import '../../../view/base/lunch_widget.dart';
import '../../../view/error_widget/error_widget.dart';
import '../../../view/screens/filter/filter_screen.dart';
import '../../../view/screens/location/ads_on_map.dart';
import '../../base/category_header.dart';
import '../../base/main_button.dart';
import '../../base/pagination_view.dart';
import '../../base/riyal_widget.dart';
import '../../base/shimmer/ads_shimmer.dart';
import '../details_screen/aqar_details_screen.dart';
import '../details_screen/widget/similar_ads.dart';
import '../promoted/widget/promoted_provider_body.dart';

class SponsorAdsScreen extends StatefulWidget {
  SponsorAdsScreen({
    super.key,
  });

  @override
  State<SponsorAdsScreen> createState() => _SponsorAdsScreenState();
}

class _SponsorAdsScreenState extends State<SponsorAdsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    context.read<SponsorAdsCubit>().getSponsorAds(page: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var promotedServicesCubit = context.read<PromotedServicesCubit>();
    var sponsorAdsCubit = context.read<SponsorAdsCubit>();
    // var promotedCubit = context.read<PromotedServicesCubit>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: CategoryHeader(
            title: LocaleKeys.distinctiveRealEstate.tr(),
            isFilter: false,
            onTap: () {
              navigateForward(FilterScreen());
            }),
        body: BlocBuilder<SponsorAdsCubit, SponsorAdsState>(
          builder: (context, state) {
            if (sponsorAdsCubit.isGetSponsorAds == false) {
              return AdsShimmer();
            }
            return state is GetSponsorAdsErrorState
                ? CustomErrorWidget(reload: () {
                    sponsorAdsCubit.getSponsorAds(page: 1);
                  })
                : sponsorAdsCubit.sponsorAdsModel.data!.isEmpty
                    ? Container(
                        alignment: AlignmentDirectional.topCenter,
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(bottom: context.width * 0.06),
                              child: Image.asset(
                                Images.EMPTY_SEARCH,
                                width: context.width * 0.8,
                              ),
                            ),
                            Text(
                              LocaleKeys.noSearchResult.tr(),
                              style: openSansExtraBold.copyWith(
                                  color: darkGreyColor),
                            )
                          ],
                        ),
                      )
                    : Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: PaginatedListView(
                            last:
                                sponsorAdsCubit.sponsorAdsModel.meta!.lastPage!,
                            offset: sponsorAdsCubit
                                .sponsorAdsModel.meta!.currentPage!,
                            onPaginate: (int offset) async {
                              debugPrint(offset.toString());
                              await sponsorAdsCubit.getSponsorAds(
                                page: offset,
                              );
                            },
                            scrollController: _scrollController,
                            totalSize:
                                sponsorAdsCubit.sponsorAdsModel.meta?.to ?? 15,
                            //  reverse: true,
                            enabledPagination: true,
                            productView: Column(
                              children: [
                                // FavouriteWidget(
                                //   categoryId: sponsorAdsCubit.sponsorAdsModel
                                //       .data?.first.categoryAds?.id,
                                //   features: sponsorAdsCubit.sponsorAdsModel.data
                                //       ?.first.additionalFeatures,
                                //   adLocation: sponsorAdsCubit.sponsorAdsModel
                                //           .data?.first.address ??
                                //       '',
                                //   onTap: () {
                                //     context.read<AdyByIdCubit>().getAdById(
                                //         id: sponsorAdsCubit
                                //             .sponsorAdsModel.data!.first.id!);
                                //     navigateForward(
                                //       AqarDetailsScreen(
                                //         adId: sponsorAdsCubit
                                //             .sponsorAdsModel.data!.first.id!,
                                //         categoryId: sponsorAdsCubit
                                //             .sponsorAdsModel
                                //             .data!
                                //             .first
                                //             .categoryAds!
                                //             .id
                                //             .toString(),
                                //       ),
                                //     );
                                //   },
                                //   isFavourite: true,
                                //   isTabbedFavourite: sponsorAdsCubit
                                //       .sponsorAdsModel.data!.first.isFavorite!,
                                //   favouriteFunction: () {
                                //     sponsorAdsCubit.sponsorAdsModel.data!.first
                                //             .isFavorite!
                                //         ? sponsorAdsCubit.removeFavourite(
                                //             index: 0,
                                //             adId: sponsorAdsCubit
                                //                 .sponsorAdsModel.data!.first.id
                                //                 .toString(),
                                //             context: context,
                                //           )
                                //         : sponsorAdsCubit.addFavourite(
                                //             0,
                                //             sponsorAdsCubit
                                //                 .sponsorAdsModel.data!.first.id
                                //                 .toString(),
                                //             context,
                                //           );
                                //   },
                                //   // width:width?? 358.w,
                                //   title: sponsorAdsCubit.sponsorAdsModel.data
                                //           ?.first.name ??
                                //       '',
                                //   image: sponsorAdsCubit.sponsorAdsModel.data!
                                //           .first.photos!.isEmpty
                                //       ? '${Images.AVATAR_IMAGE}'
                                //       : sponsorAdsCubit.sponsorAdsModel.data!
                                //               .first.photos?.first ??
                                //           '',
                                //   bathNo: sponsorAdsCubit.sponsorAdsModel.data
                                //           ?.first.toiletsNumber ??
                                //       '',
                                //   bedNo: sponsorAdsCubit.sponsorAdsModel.data
                                //           ?.first.roomsNumber ??
                                //       '',
                                //   price: sponsorAdsCubit
                                //           .sponsorAdsModel.data?.first.price ??
                                //       '',
                                //   // kitchenNo: '2', livingNo: '2'
                                // ),
                                // SizedBox(
                                //   height: 10.h,
                                // ),
                                // sponsorAdsCubit.sponsorAdsModel.data!.length > 1
                                //     ?
                                Container(
                                  child: ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return SimilarAds(
                                          isFavouriteWidget: false,
                                          isTabbedFavourite: sponsorAdsCubit
                                              .sponsorAdsModel
                                              .data![index]
                                              .isFavorite!,
                                          favouriteFunction: () {
                                            sponsorAdsCubit.sponsorAdsModel
                                                    .data![index].isFavorite!
                                                ? sponsorAdsCubit
                                                    .removeFavourite(
                                                    index: index,
                                                    adId: sponsorAdsCubit
                                                        .sponsorAdsModel
                                                        .data![index]
                                                        .id
                                                        .toString(),
                                                    context: context,
                                                  )
                                                : sponsorAdsCubit.addFavourite(
                                                    index + 1,
                                                    sponsorAdsCubit
                                                        .sponsorAdsModel
                                                        .data![index]
                                                        .id
                                                        .toString(),
                                                    context);
                                          },
                                          onTap: () {
                                            context
                                                .read<AdyByIdCubit>()
                                                .getAdById(
                                                    id: sponsorAdsCubit
                                                        .sponsorAdsModel
                                                        .data![index]
                                                        .id!);
                                            navigateForward(
                                              AqarDetailsScreen(
                                                adId: sponsorAdsCubit
                                                    .sponsorAdsModel
                                                    .data![index]
                                                    .id!,
                                                categoryId: sponsorAdsCubit
                                                    .sponsorAdsModel
                                                    .data![index]
                                                    .categoryAds!
                                                    .id
                                                    .toString(),
                                              ),
                                            );
                                            // Get.to(() => );
                                          },
                                          image: sponsorAdsCubit.sponsorAdsModel
                                                  .data![index].photos!.isEmpty
                                              ? '${Images.AVATAR_IMAGE}'
                                              : sponsorAdsCubit
                                                      .sponsorAdsModel
                                                      .data![index]
                                                      .photos
                                                      ?.first ??
                                                  '',
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: Dimensions
                                                        .PADDING_SIZE_EXTRA_SMALL),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        '${sponsorAdsCubit.sponsorAdsModel.data?[index].categoryAds?.name ?? ''}',
                                                        style: openSansMedium
                                                            .copyWith(
                                                                color:
                                                                    darkGreyColor)),
                                                    //  Spacer(),

                                                    Row(
                                                      children: [
                                                        Text(
                                                            '${sponsorAdsCubit.sponsorAdsModel.data?[index].price}',
                                                            style: openSansMedium
                                                                .copyWith(
                                                                    color:
                                                                        goldColor)),
                                                        SizedBox(
                                                          width: context.width *
                                                              0.005.w,
                                                        ),
                                                        riyalWidget(context),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: Dimensions
                                                        .PADDING_SIZE_EXTRA_SMALL),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        Images.SMALL_LOCATION),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        sponsorAdsCubit
                                                                .sponsorAdsModel
                                                                .data?[index]
                                                                .address ??
                                                            '',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: true,
                                                        style: openSansMedium
                                                            .copyWith(
                                                                color:
                                                                    darkGreyColor),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              sponsorAdsCubit
                                                              .sponsorAdsModel
                                                              .data?[index]
                                                              .categoryAds
                                                              ?.id ==
                                                          12 ||
                                                      sponsorAdsCubit
                                                              .sponsorAdsModel
                                                              .data?[index]
                                                              .categoryAds
                                                              ?.id ==
                                                          14 ||
                                                      sponsorAdsCubit
                                                              .sponsorAdsModel
                                                              .data?[index]
                                                              .categoryAds
                                                              ?.id ==
                                                          18 ||
                                                      sponsorAdsCubit
                                                              .sponsorAdsModel
                                                              .data?[index]
                                                              .categoryAds
                                                              ?.id ==
                                                          13 ||
                                                      sponsorAdsCubit
                                                              .sponsorAdsModel
                                                              .data?[index]
                                                              .categoryAds
                                                              ?.id ==
                                                          19 ||
                                                      sponsorAdsCubit
                                                              .sponsorAdsModel
                                                              .data?[index]
                                                              .categoryAds
                                                              ?.id ==
                                                          16 ||
                                                      sponsorAdsCubit
                                                              .sponsorAdsModel
                                                              .data?[index]
                                                              .categoryAds
                                                              ?.id ==
                                                          21 ||
                                                      sponsorAdsCubit
                                                              .sponsorAdsModel
                                                              .data?[index]
                                                              .categoryAds
                                                              ?.id ==
                                                          24 ||
                                                      sponsorAdsCubit
                                                              .sponsorAdsModel
                                                              .data?[index]
                                                              .categoryAds
                                                              ?.id ==
                                                          25 ||
                                                      sponsorAdsCubit
                                                              .sponsorAdsModel
                                                              .data?[index]
                                                              .categoryAds
                                                              ?.id ==
                                                          27 ||
                                                      sponsorAdsCubit
                                                              .sponsorAdsModel
                                                              .data?[index]
                                                              .categoryAds
                                                              ?.id ==
                                                          34 ||
                                                      sponsorAdsCubit
                                                              .sponsorAdsModel
                                                              .data?[index]
                                                              .categoryAds
                                                              ?.id ==
                                                          36 ||
                                                      sponsorAdsCubit
                                                                  .sponsorAdsModel
                                                                  .data?[index]
                                                                  .categoryAds
                                                                  ?.id ==
                                                              35 &&
                                                          sponsorAdsCubit
                                                              .sponsorAdsModel
                                                              .data![index]
                                                              .additionalFeatures!
                                                              .isNotEmpty
                                                  ? Container(
                                                      height: sponsorAdsCubit
                                                              .sponsorAdsModel
                                                              .data![index]
                                                              .additionalFeatures!
                                                              .isEmpty
                                                          ? 0
                                                          : 20.sp,
                                                      width: context.width,
                                                      child: Wrap(
                                                        children: List.generate(
                                                          sponsorAdsCubit
                                                                      .sponsorAdsModel
                                                                      .data![
                                                                          index]
                                                                      .additionalFeatures!
                                                                      .length >=
                                                                  4
                                                              ? 4
                                                              : sponsorAdsCubit
                                                                  .sponsorAdsModel
                                                                  .data![index]
                                                                  .additionalFeatures!
                                                                  .length,
                                                          (indexx) {
                                                            return Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .only(
                                                                end: context
                                                                        .width *
                                                                    0.02,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Image.network(
                                                                    sponsorAdsCubit
                                                                            .sponsorAdsModel
                                                                            .data![index]
                                                                            .additionalFeatures?[indexx]
                                                                            .image ??
                                                                        'https://dashboard.redd.sa/dash/additional_features/1717849710.png',
                                                                    height: context
                                                                            .height *
                                                                        0.03,
                                                                    width: context
                                                                            .width *
                                                                        0.04,
                                                                    // width: 20.sp,
                                                                    // height: 20.sp,
                                                                  ),
                                                                  SizedBox(
                                                                    width: context
                                                                            .width *
                                                                        0.01,
                                                                  ),
                                                                  AutoSizeText(
                                                                    sponsorAdsCubit
                                                                            .sponsorAdsModel
                                                                            .data![index]
                                                                            .additionalFeatures?[indexx]
                                                                            .name ??
                                                                        '',
                                                                    presetFontSizes: [
                                                                      12.sp,
                                                                      10.sp,
                                                                      5.sp
                                                                    ],
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    style: openSansMedium
                                                                        .copyWith(
                                                                            color:
                                                                                goldColor),
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
                                                      // ListView
                                                      //     .builder(
                                                      //         physics:
                                                      //             NeverScrollableScrollPhysics(),
                                                      //         scrollDirection:
                                                      //             Axis
                                                      //                 .horizontal,
                                                      //         itemCount: sponsorAdsCubit.sponsorAdsModel.data![index + 1].additionalFeatures!.length >=
                                                      //                 2
                                                      //             ? 2
                                                      //             : sponsorAdsCubit
                                                      //                 .sponsorAdsModel
                                                      //                 .data![index +
                                                      //                     1]
                                                      //                 .additionalFeatures!
                                                      //                 .length,
                                                      //         itemBuilder:
                                                      //             (context,
                                                      //                 i) {
                                                      //           return FittedBox(
                                                      //             child:
                                                      //                 Row(
                                                      //               mainAxisAlignment:
                                                      //                   MainAxisAlignment.spaceBetween,
                                                      //               mainAxisSize:
                                                      //                   MainAxisSize.max,
                                                      //               children: [
                                                      //                 Image.network(
                                                      //                   sponsorAdsCubit.sponsorAdsModel.data![index + 1].additionalFeatures?[i].image ?? Images.PlaceHolderAdditionalFeature,
                                                      //                   width: 20.sp,
                                                      //                   height: 20.sp,
                                                      //                 ),
                                                      //                 AutoSizeText(
                                                      //                   sponsorAdsCubit.sponsorAdsModel.data![index + 1].additionalFeatures?[i].name ?? '',
                                                      //                   presetFontSizes: [
                                                      //                     12.sp,
                                                      //                     10.sp,
                                                      //                     7.sp
                                                      //                   ],
                                                      //                   style: openSansMedium.copyWith(color: goldColor),
                                                      //                 ),
                                                      //                 SizedBox(
                                                      //                   width: context.width * 0.1,
                                                      //                 ),
                                                      //               ],
                                                      //             ),
                                                      //           );
                                                      //         }),
                                                    )
                                                  : const SizedBox(),
                                              const SizedBox(
                                                height: Dimensions
                                                    .PADDING_SIZE_DEFAULT,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (context, providerIndex) {
                                        return BlocBuilder<
                                            PromotedServicesCubit,
                                            PromotedServicesState>(
                                          builder: (context, state) {
                                            if (state
                                                    is GetServiceProviderPromotedLoadingState ||
                                                promotedServicesCubit
                                                        .isGetPromotedProviders ==
                                                    false) {
                                              return AdsShimmer();
                                            } else if (state
                                                is GetServiceProviderPromotedErrorState) {
                                              return CustomErrorWidget(
                                                  reload: () {
                                                promotedServicesCubit
                                                    .getProviderPromotion();
                                              });
                                            } else if (promotedServicesCubit
                                                .serviceProviderPromoted
                                                .data!
                                                .isEmpty) {
                                              return Center(
                                                child: Text(
                                                  LocaleKeys.noServiceProvider
                                                      .tr(),
                                                  style: openSansBold.copyWith(
                                                      color: goldColor),
                                                ),
                                              );
                                            } else {
                                              return promotedServicesCubit
                                                          .serviceProviderPromoted
                                                          .data!
                                                          .length >=
                                                      providerIndex + 1
                                                  ? Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  10.0.sp),
                                                      child:
                                                          ProviderPromotedBody(
                                                        index: providerIndex,
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      height: 10.sp,
                                                    );
                                            }
                                          },
                                        );
                                      },
                                      itemCount: sponsorAdsCubit
                                              .sponsorAdsModel.data!.length -
                                          1),
                                ),
                                //  : const SizedBox(),
                                Padding(
                                  padding: const EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_EXTRA_LARGE),
                                  child: CustomButton(
                                      textButton: LocaleKeys.onMap.tr(),
                                      onPressed: () {
                                        navigateForward(AdsOnMap());
                                        // Get.to(() => );
                                      },
                                      color: darkGreyColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
          },
        ),
      ),
    );
  }
}
