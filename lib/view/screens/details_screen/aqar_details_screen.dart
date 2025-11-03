import 'package:aqarat_raqamia/view/screens/details_screen/widget/sliver_app_bar.dart';

import '../../../bloc/similar_ads_cubit/cubit.dart';
import '../../../bloc/similar_ads_cubit/state.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/dimention.dart';
import '../../../utils/media_query_value.dart';
import '../../../utils/text_style.dart';
import '../../../view/base/lunch_widget.dart';
import '../../../view/base/shimmer/ads_shimmer.dart';
import '../../../view/screens/details_screen/similar_ads_detials_screen.dart';
import '../../../view/screens/details_screen/widget/adversiter_widget.dart';
import '../../../view/screens/details_screen/widget/grid_view_details.dart';
import '../../../view/screens/details_screen/widget/row_widget_for_details.dart';
import '../../../view/screens/details_screen/widget/similar_ads.dart';
import '../../../bloc/ads_by_id_cubit/cubit.dart';
import '../../../bloc/ads_by_id_cubit/state.dart';
import '../../../bloc/filter_search_add_cubit/cubit.dart';
import '../../../bloc/filter_search_add_cubit/state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/images.dart';
import '../../base/adaptive_dialog_loader.dart';
import '../../base/back_button.dart';
import '../../base/full_screen_image/full_screen_image.dart';
import '../../base/riyal_widget.dart';
import '../../base/row_address_widget.dart';
import '../../base/show_toast.dart';
import '../../error_widget/error_widget.dart';
import '../location/map_string.dart';
import '../my_ads_screen/widget/visability_widget.dart';
import '../comments_screen/widget/comments_widget.dart';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class AqarDetailsScreen extends StatefulWidget {
  final int adId;
  final String categoryId;

  AqarDetailsScreen({
    super.key,
    required this.adId,
    required this.categoryId,
  });

  @override
  State<AqarDetailsScreen> createState() => _AqarDetailsScreenState();
}

class _AqarDetailsScreenState extends State<AqarDetailsScreen> {
  CarouselSliderController carouselController = CarouselSliderController();

  @override
  void initState() {
    context.read<SimilarAdsCubit>()
      ..getSimilarAdsData(categoryId: widget.categoryId);
    context.read<AdyByIdCubit>()..getAdById(id: widget.adId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var filterAdsCubit = context.read<FilterSearchAdsCubit>();
    var similarAdsCubit = context.read<SimilarAdsCubit>();
    var adsByIdCubit = context.read<AdyByIdCubit>();
    return Scaffold(
      body: BlocConsumer<AdyByIdCubit, AdsByIdState>(
        listener: (context, state) {},
        builder: (context, state) {
          return adsByIdCubit.isGetAdsById == false
              ? adaptiveCircleProgress()
              : BlocConsumer<FilterSearchAdsCubit, FilterSearchAdsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: CustomScrollView(
                        slivers: [
                          SliverAppBarWidget(
                            name: adsByIdCubit.adsByIdModel.data?.name ?? '',
                            activeIndex: filterAdsCubit.selectedIndex,
                            carouselController: carouselController,
                            carouselFunction: (i, reason) {
                              print('///////////////////');
                              filterAdsCubit.changeIndexCarousel(i);
                            },
                            images:
                                adsByIdCubit.adsByIdModel.data!.photos ?? [],
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      top: Dimensions.PADDING_SIZE_DEFAULT,
                                      end: Dimensions.PADDING_SIZE_DEFAULT,
                                      start: Dimensions.PADDING_SIZE_DEFAULT),
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // Center(
                                        //   child: AutoSizeText.rich(
                                        //     TextSpan(
                                        //         text:
                                        //             "${LocaleKeys.adTitle.tr()} : ",
                                        //         style: openSansBold.copyWith(
                                        //             color: darkGreyColor),
                                        //         children: [
                                        //           TextSpan(
                                        //               text:
                                        //                   '${adsByIdCubit.adsByIdModel.data!.name ?? ''}',
                                        //               style: openSansExtraBold
                                        //                   .copyWith(
                                        //                 color: goldColor,
                                        //               ))
                                        //         ]),
                                        //     overflow: TextOverflow.ellipsis,
                                        //     presetFontSizes: [
                                        //       18.sp,
                                        //       13.sp,
                                        //       10.sp
                                        //     ],
                                        //     maxLines: 1,
                                        //     softWrap: true,
                                        //   ),
                                        // ),
                                        Center(
                                          child: AutoSizeText(
                                            '${adsByIdCubit.adsByIdModel.data!.name ?? ''}',
                                            style: openSansExtraBold.copyWith(
                                              color: goldColor,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            presetFontSizes: [
                                              18.sp,
                                              13.sp,
                                              10.sp
                                            ],
                                            maxLines: 1,
                                            softWrap: true,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              '${adsByIdCubit.adsByIdModel.data!.price ?? ''}',
                                              style: openSansBold.copyWith(
                                                color: goldColor,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              presetFontSizes: [
                                                18.sp,
                                                13.sp,
                                                10.sp
                                              ],
                                              maxLines: 1,
                                              softWrap: true,
                                            ),
                                            SizedBox(width: context.width*0.005.w,),
                                            riyalWidget(context)
                                          ],
                                        ),
                                        // Center(
                                        //   child: AutoSizeText.rich(
                                        //     overflow: TextOverflow.ellipsis,
                                        //     presetFontSizes: [
                                        //       18.sp,
                                        //       13.sp,
                                        //       10.sp
                                        //     ],
                                        //     maxLines: 1,
                                        //     softWrap: true,
                                        //     TextSpan(
                                        //         text:
                                        //             "${LocaleKeys.price.tr()} : ",
                                        //         style: openSansBold.copyWith(
                                        //           color: darkGreyColor,
                                        //         ),
                                        //         children: [
                                        //           TextSpan(
                                        //               text:
                                        //                   '${LocaleKeys.currency.tr()} ${adsByIdCubit.adsByIdModel.data!.price ?? ''}',
                                        //               style: openSansExtraBold
                                        //                   .copyWith(
                                        //                 color: goldColor,
                                        //               ))
                                        //         ]),
                                        //   ),
                                        // ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceAround,
                                        //   children: [
                                        //
                                        //    // Spacer(),
                                        //
                                        //     // Text(
                                        //     //                                           adsByIdCubit.adsByIdModel.data!.name ?? '',
                                        //     //                                           style: openSansExtraBold.copyWith(
                                        //     //   color: darkGreyColor,fontSize: 20.sp),
                                        //     //                                         ),
                                        //     // Text(
                                        //     //     '${LocaleKeys.currency.tr()} ${adsByIdCubit.adsByIdModel.data!.price ?? ''}',
                                        //     //     style: openSansExtraBold.copyWith(
                                        //     //         color: goldColor)),
                                        //   ],
                                        // ),
                                        const SizedBox(
                                          height: Dimensions.PADDING_SIZE_LARGE,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AutoSizeText.rich(TextSpan(
                                                    text:
                                                        "${LocaleKeys.adsNo.tr()}",
                                                    style:
                                                        openSansBold.copyWith(
                                                            color:
                                                                darkGreyColor),
                                                    children: [
                                                      TextSpan(
                                                        text: adsByIdCubit
                                                            .adsByIdModel
                                                            .data!
                                                            .id
                                                            .toString(),
                                                        style: openSansBold
                                                            .copyWith(
                                                                color:
                                                                    goldColor),
                                                      )
                                                    ])),
                                                AutoSizeText.rich(TextSpan(
                                                    text:
                                                        "${LocaleKeys.purpose.tr()} : ",
                                                    style:
                                                        openSansBold.copyWith(
                                                            color:
                                                                darkGreyColor),
                                                    children: [
                                                      TextSpan(
                                                        text: adsByIdCubit
                                                                .adsByIdModel
                                                                .data!
                                                                .type
                                                                ?.name ??
                                                            '',
                                                        style: openSansBold
                                                            .copyWith(
                                                                color:
                                                                    goldColor),
                                                      )
                                                    ])),
                                              ],
                                            ),
                                            //    SizedBox(width: context.width*0.03.w,),
                                            Flexible(
                                              child: RowWidgetForDetails(
                                                categoryId: adsByIdCubit
                                                    .adsByIdModel
                                                    .data!
                                                    .categoryAds!
                                                    .id!,
                                                adsId: adsByIdCubit
                                                    .adsByIdModel.data!.id!,
                                                isFav: adsByIdCubit.adsByIdModel
                                                    .data!.isFavorite!,
                                                fct: () {
                                                  // print('////////////////////////');
                                                  setState(() {
                                                    adsByIdCubit.adsByIdModel
                                                            .data!.isFavorite !=
                                                        adsByIdCubit
                                                            .adsByIdModel
                                                            .data!
                                                            .isFavorite!;
                                                    adsByIdCubit
                                                                .adsByIdModel
                                                                .data!
                                                                .isFavorite ==
                                                            true
                                                        ? adsByIdCubit
                                                            .removeFavourite(
                                                            adId: adsByIdCubit
                                                                .adsByIdModel
                                                                .data!
                                                                .id!,
                                                            //  context,
                                                          )
                                                        : adsByIdCubit
                                                            .addFavourite(
                                                            adId: adsByIdCubit
                                                                .adsByIdModel
                                                                .data!
                                                                .id!,
                                                            // context,
                                                          );
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                                text: TextSpan(
                                                    text: LocaleKeys.estateType
                                                        .tr(),
                                                    style:
                                                        openSansBold.copyWith(
                                                            color:
                                                                darkGreyColor),
                                                    children: [
                                                  TextSpan(
                                                    text: adsByIdCubit
                                                            .adsByIdModel
                                                            .data!
                                                            .categoryAds
                                                            ?.name ??
                                                        '',
                                                    style:
                                                        openSansBold.copyWith(
                                                            color: goldColor),
                                                  )
                                                ])),
                                          ],
                                        ),
                                        RichText(
                                            text: TextSpan(
                                                text: LocaleKeys.adCreated.tr(),
                                                style: openSansBold.copyWith(
                                                    color: darkGreyColor),
                                                children: [
                                              TextSpan(
                                                text: adsByIdCubit
                                                        .adsByIdModel
                                                        .data!
                                                        .createDates
                                                        ?.createdAtHuman ??
                                                    '',
                                                style: openSansBold.copyWith(
                                                    color: goldColor),
                                              )
                                            ])),
                                        RichText(
                                            text: TextSpan(
                                                text: LocaleKeys.lastUpdate.tr(),
                                                style: openSansBold.copyWith(
                                                    color: darkGreyColor),
                                                children: [
                                                  TextSpan(
                                                    text: adsByIdCubit
                                                        .adsByIdModel
                                                        .data!
                                                        .updateDates
                                                        ?.updatedAtHuman ??
                                                        '',
                                                    style: openSansBold.copyWith(
                                                        color: goldColor),
                                                  )
                                                ])),
                                        const Divider(
                                          thickness: 1.2,
                                        ),
                                        adsByIdCubit.adsByIdModel.data!.categoryAds?.id == 12 ||
                                                adsByIdCubit.adsByIdModel.data!
                                                        .categoryAds?.id ==
                                                    14 ||
                                                adsByIdCubit.adsByIdModel.data!
                                                        .categoryAds?.id ==
                                                    18 ||
                                                adsByIdCubit.adsByIdModel.data!
                                                        .categoryAds?.id ==
                                                    13 ||
                                                adsByIdCubit.adsByIdModel.data!
                                                        .categoryAds?.id ==
                                                    19 ||
                                                adsByIdCubit.adsByIdModel.data!
                                                        .categoryAds?.id ==
                                                    16 ||
                                                adsByIdCubit.adsByIdModel.data!
                                                        .categoryAds?.id ==
                                                    21 ||
                                                adsByIdCubit.adsByIdModel.data!
                                                        .categoryAds?.id ==
                                                    24 ||
                                                adsByIdCubit.adsByIdModel.data!
                                                        .categoryAds?.id ==
                                                    25 ||
                                                adsByIdCubit.adsByIdModel.data!
                                                        .categoryAds?.id ==
                                                    27 ||
                                                adsByIdCubit.adsByIdModel.data!
                                                        .categoryAds?.id ==
                                                    34 ||
                                                adsByIdCubit.adsByIdModel.data!
                                                        .categoryAds?.id ==
                                                    36 ||
                                                adsByIdCubit.adsByIdModel.data!
                                                        .categoryAds?.id ==
                                                    35
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    LocaleKeys.features.tr(),
                                                    style: openSansExtraBold
                                                        .copyWith(
                                                            color:
                                                                darkGreyColor,
                                                            fontSize: 18.sp),
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions
                                                        .PADDING_SIZE_SMALL.sp,
                                                  ),
                                                  FeaturesGridView(
                                                      featureModel: adsByIdCubit
                                                          .adsByIdModel
                                                          .data!
                                                          .additionalFeatures!),
                                                  Divider(
                                                    thickness: 1.2.sp,
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions
                                                        .PADDING_SIZE_SMALL.sp,
                                                  ),
                                                ],
                                              )
                                            : const SizedBox(),
                                        Text(
                                            LocaleKeys.specialRealEstateInfo
                                                .tr(),
                                            style: openSansExtraBold.copyWith(
                                                color: darkGreyColor,
                                                fontSize: 18.sp)),
                                        GridViewDetails(
                                            streetWidth: adsByIdCubit
                                                .adsByIdModel.data!.streetWidth,
                                            planNumber: adsByIdCubit
                                                .adsByIdModel.data!.planNumber,
                                            wellsNumber: adsByIdCubit
                                                .adsByIdModel.data!.wellsNumber
                                                .toString(),
                                            usage: adsByIdCubit
                                                .adsByIdModel.data!.usage,
                                            treesCount: adsByIdCubit
                                                .adsByIdModel
                                                .data!
                                                .treesAndPalmsNumber
                                                .toString(),
                                            services: adsByIdCubit
                                                .adsByIdModel.data!.services,
                                            parking: adsByIdCubit.adsByIdModel.data!.parkingSpaces == true
                                                ? LocaleKeys.available.tr()
                                                : LocaleKeys.notAvailable.tr(),
                                            livingRooms: adsByIdCubit
                                                .adsByIdModel
                                                .data!
                                                .livingRoomsNumber
                                                .toString(),
                                            floorCount: adsByIdCubit
                                                .adsByIdModel.data!.floorsNumber
                                                .toString(),
                                            desiredPropertySpecifications: adsByIdCubit
                                                .adsByIdModel
                                                .data!
                                                .desiredPropertySpecifications,
                                            commercialUnitsNumber: adsByIdCubit
                                                .adsByIdModel
                                                .data!
                                                .commercialUnitsNumber
                                                .toString(),
                                            age: adsByIdCubit.adsByIdModel.data!.age.toString(),
                                            additionalRequirements: adsByIdCubit.adsByIdModel.data!.additionalRequirements,
                                            landNo: adsByIdCubit.adsByIdModel.data!.parcelNumber,
                                            purpose: adsByIdCubit.adsByIdModel.data!.type?.name ?? '',
                                            vision: adsByIdCubit.adsByIdModel.data!.prolongation ?? '',
                                            area: adsByIdCubit.adsByIdModel.data!.space ?? '',
                                            bedRoomNo: adsByIdCubit.adsByIdModel.data!.roomsNumber ?? '',
                                            toiletNo: adsByIdCubit.adsByIdModel.data!.toiletsNumber ?? '',
                                            id: adsByIdCubit.adsByIdModel.data!.categoryAds!.id!),
                                        const SizedBox(
                                          height:
                                              Dimensions.PADDING_SIZE_DEFAULT,
                                        ),
                                        const Divider(
                                          thickness: 1.2,
                                        ),
                                        Text(
                                          LocaleKeys.description.tr(),
                                          style: openSansExtraBold.copyWith(
                                              color: darkGreyColor,
                                              fontSize: 18.sp),
                                        ),
                                        Container(
                                          child: Text(
                                            adsByIdCubit
                                                    .adsByIdModel.data!.notes ??
                                                '',
                                            style: openSansBold.copyWith(
                                                color: goldColor),
                                          ),
                                        ),
                                        const SizedBox(
                                          height:
                                              Dimensions.PADDING_SIZE_DEFAULT,
                                        ),
                                        const Divider(
                                          thickness: 1.2,
                                        ),
                                        Text(
                                          LocaleKeys.location.tr(),
                                          style: openSansExtraBold.copyWith(
                                              color: darkGreyColor,
                                              fontSize: 18.sp),
                                        ),
                                        const SizedBox(
                                          height:
                                              Dimensions.PADDING_SIZE_DEFAULT,
                                        ),
                                        RowAddressLocation(
                                            city:
                                                '${adsByIdCubit.adsByIdModel.data!.city ?? "لا يمكن تحديد المدينة"}',
                                            district:
                                                '${adsByIdCubit.adsByIdModel.data!.district ?? "لا يمكن تحديد الحي"}',
                                            region:
                                                '${adsByIdCubit.adsByIdModel.data!.region ?? "لا يمكن تحديد المنطقه"}'),
                                        SizedBox(
                                          height: Dimensions
                                              .PADDING_SIZE_DEFAULT.sp,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (adsByIdCubit.adsByIdModel.data!
                                                        .lat ==
                                                    null ||
                                                adsByIdCubit.adsByIdModel.data!
                                                        .lan ==
                                                    null) {
                                              showCustomSnackBar(
                                                  message: LocaleKeys
                                                      .errorOnAdsLocation
                                                      .tr(),
                                                  state: ToastState.ERROR);
                                            } else {
                                              // navigateForward(FullImageScreen(image: previewImageUrl!,));
                                              if (Platform.isIOS) {
                                                await launchUrl(Uri.parse(
                                                    "comgooglemaps://?q=${adsByIdCubit.adsByIdModel.data!.lat},"
                                                    "${adsByIdCubit.adsByIdModel.data!.lan}&key=AIzaSyCjq0TIsXwDT8RQK2jBajVnHy93eoTt1HU"));
                                              } else {
                                                await launchUrl(Uri.parse(
                                                    'https://www.google.com/maps/search/?api=1&query=${adsByIdCubit.adsByIdModel.data!.lat},${adsByIdCubit.adsByIdModel.data!.lan}'

                                                    // 'comgooglemaps://?q='
                                                    // '${widget.model.data![widget.aqarIndex].lat}, '
                                                    // '${widget.model.data![widget.aqarIndex].lan}'
                                                    // '&key=AIzaSyCjq0TIsXwDT8RQK2jBajVnHy93eoTt1HU'
                                                    ));
                                              }
                                            }
                                          },
                                          child: LocationView(
                                              double.parse(adsByIdCubit
                                                      .adsByIdModel.data!.lat ??
                                                  '21.5574931'),
                                              double.parse(adsByIdCubit
                                                      .adsByIdModel.data!.lan ??
                                                  '39.1775043')),
                                        ),
                                        const SizedBox(
                                          height:
                                              Dimensions.PADDING_SIZE_DEFAULT,
                                        ),
                                        // accountType == 'service_applicant'
                                        //     ?
                                        token == null
                                            ? SizedBox()
                                            : CommentsWidget(
                                                adId: adsByIdCubit
                                                    .adsByIdModel.data!.id
                                                    .toString(),
                                                rate: 2.5,
                                                model: adsByIdCubit.adsByIdModel
                                                        .data?.adComments ??
                                                    [],
                                                //   review: 'عقار رائع',
                                                //  imageUrl: Images.AVATAR_IMAGE,
                                                // name: "احمد محمد",
                                              ),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              LocaleKeys.contactWithAdvertiser
                                                  .tr(),
                                              style: openSansExtraBold.copyWith(
                                                  color: darkGreyColor,
                                                  fontSize: 18.sp),
                                            ),
                                            AdvertiserCard(
                                                // id: adsByIdCubit.adsByIdModel
                                                //     .data!.userAds!.id!,
                                                image: adsByIdCubit.adsByIdModel
                                                        .data!.userAds!.photo ??
                                                    Images.AVATAR_IMAGE,
                                                name: adsByIdCubit.adsByIdModel
                                                        .data!.userAds!.name ??
                                                    '',
                                                phone: adsByIdCubit.adsByIdModel
                                                        .data!.userAds!.phone ??
                                                    ''),
                                            const SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_DEFAULT,
                                            ),
                                            Text(
                                              LocaleKeys.similarAds.tr(),
                                              style: openSansExtraBold.copyWith(
                                                  color: darkGreyColor,
                                                  fontSize: 18.sp),
                                            ),
                                            BlocConsumer<SimilarAdsCubit,
                                                SimilarAdsState>(
                                              listener: (context, state) {
                                                // TODO: implement listener
                                              },
                                              builder: (context, state) {
                                                if (state
                                                    is GetSimilarAdsLoadingState) {
                                                  return AdsShimmer();
                                                }
                                                return state
                                                        is GetSimilarAdsErrorState
                                                    ? CustomErrorWidget(
                                                        reload: () {
                                                        Navigator.pop(context);
                                                      })
                                                    : Container(
                                                        child:
                                                            ListView.separated(
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return const SizedBox(
                                                              height: Dimensions
                                                                  .PADDING_SIZE_LARGE,
                                                            );
                                                          },
                                                          shrinkWrap: true,
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          itemBuilder:
                                                              (context, index) {
                                                            return SimilarAds(
                                                              isFavouriteWidget:
                                                                  false,
                                                              isTabbedFavourite:
                                                                  similarAdsCubit
                                                                      .similarAdsModel
                                                                      .data![
                                                                          index]
                                                                      .isFavorite!,
                                                              favouriteFunction:
                                                                  () {
                                                                similarAdsCubit
                                                                        .similarAdsModel
                                                                        .data![
                                                                            index]
                                                                        .isFavorite!
                                                                    ? similarAdsCubit.removeFavourite(
                                                                        index,
                                                                        similarAdsCubit
                                                                            .similarAdsModel
                                                                            .data![
                                                                                index]
                                                                            .id
                                                                            .toString(),
                                                                        context)
                                                                    : similarAdsCubit.addFavourite(
                                                                        index,
                                                                        similarAdsCubit
                                                                            .similarAdsModel
                                                                            .data![index]
                                                                            .id
                                                                            .toString(),
                                                                        context);
                                                              },
                                                              image: similarAdsCubit
                                                                          .similarAdsModel
                                                                          .data![
                                                                              index]
                                                                          .photos!
                                                                          .isEmpty ||
                                                                      similarAdsCubit
                                                                              .similarAdsModel
                                                                              .data![
                                                                                  index]
                                                                              .photos ==
                                                                          null
                                                                  ? Images
                                                                      .AVATAR_IMAGE
                                                                  : similarAdsCubit
                                                                      .similarAdsModel
                                                                      .data![
                                                                          index]
                                                                      .photos!
                                                                      .first,
                                                              onTap: () {
                                                                navigateForward(
                                                                  SimilarDetailsScreen(
                                                                    favouriteFunction:
                                                                        () {
                                                                      similarAdsCubit
                                                                              .similarAdsModel
                                                                              .data![
                                                                                  index]
                                                                              .isFavorite!
                                                                          ? similarAdsCubit.removeFavourite(
                                                                              index,
                                                                              similarAdsCubit.similarAdsModel.data![index].id
                                                                                  .toString(),
                                                                              context)
                                                                          : similarAdsCubit.addFavourite(
                                                                              index,
                                                                              similarAdsCubit.similarAdsModel.data![index].id.toString(),
                                                                              context);
                                                                    },
                                                                    index:
                                                                        index,
                                                                    categoryId: similarAdsCubit
                                                                        .similarAdsModel
                                                                        .data![
                                                                            index]
                                                                        .categoryAds!
                                                                        .id
                                                                        .toString(),
                                                                    isFav: similarAdsCubit
                                                                        .similarAdsModel
                                                                        .data![
                                                                            index]
                                                                        .isFavorite!,
                                                                  ),
                                                                );
                                                              },
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                            '${similarAdsCubit.similarAdsModel.data?[index].categoryAds?.name ?? ''}',
                                                                            style:
                                                                                openSansExtraBold.copyWith(color: darkGreyColor)),
                                                                        //  Spacer(),

                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                                '${similarAdsCubit.similarAdsModel.data?[index].price}',
                                                                                style:
                                                                                    openSansBold.copyWith(color: goldColor)),
                                                                            SizedBox(width:context.width*0.005),
                                                                            riyalWidget(context),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                                                    child: Row(
                                                                      children: [
                                                                        SvgPicture
                                                                            .asset(
                                                                          Images
                                                                              .SMALL_LOCATION,
                                                                          height:
                                                                              context.height * 0.01.h,
                                                                          width:
                                                                              context.width * 0.01.w,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5.w,
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            "${similarAdsCubit.similarAdsModel.data?[index].district}, ${similarAdsCubit.similarAdsModel.data?[index].city}, ${similarAdsCubit.similarAdsModel.data?[index].region}" ??
                                                                                '',
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            softWrap:
                                                                                true,
                                                                            style:
                                                                                openSansMedium.copyWith(color: darkGreyColor),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  similarAdsCubit.similarAdsModel.data?[index].categoryAds?.id == 12 ||
                                                                          similarAdsCubit.similarAdsModel.data?[index].categoryAds?.id ==
                                                                              14 ||
                                                                          similarAdsCubit.similarAdsModel.data?[index].categoryAds?.id ==
                                                                              18 ||
                                                                          similarAdsCubit.similarAdsModel.data?[index].categoryAds?.id ==
                                                                              13 ||
                                                                          similarAdsCubit.similarAdsModel.data?[index].categoryAds?.id ==
                                                                              19 ||
                                                                          similarAdsCubit.similarAdsModel.data?[index].categoryAds?.id ==
                                                                              16 ||
                                                                          similarAdsCubit.similarAdsModel.data?[index].categoryAds?.id ==
                                                                              21 ||
                                                                          similarAdsCubit.similarAdsModel.data?[index].categoryAds?.id ==
                                                                              24 ||
                                                                          similarAdsCubit.similarAdsModel.data?[index].categoryAds?.id ==
                                                                              25 ||
                                                                          similarAdsCubit.similarAdsModel.data?[index].categoryAds?.id ==
                                                                              27 ||
                                                                          similarAdsCubit.similarAdsModel.data?[index].categoryAds?.id ==
                                                                              34 ||
                                                                          similarAdsCubit.similarAdsModel.data?[index].categoryAds?.id ==
                                                                              36 ||
                                                                          similarAdsCubit.similarAdsModel.data?[index].categoryAds?.id == 35 &&
                                                                              similarAdsCubit.similarAdsModel.data![index].additionalFeatures!.isNotEmpty
                                                                      ? Expanded(
                                                                          child:
                                                                              Container(
                                                                            height: similarAdsCubit.similarAdsModel.data![index].additionalFeatures!.isEmpty
                                                                                ? 0
                                                                                : 20.sp,
                                                                            width:
                                                                                context.width,
                                                                            child:
                                                                                Wrap(
                                                                              children: List.generate(
                                                                                similarAdsCubit.similarAdsModel.data![index].additionalFeatures!.length >= 4 ? 4 : similarAdsCubit.similarAdsModel.data![index].additionalFeatures!.length,
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
                                                                                          similarAdsCubit.similarAdsModel.data![index].additionalFeatures?[indexx].image ?? 'https://dashboard.redd.sa/dash/additional_features/1717849710.png',
                                                                                          height: context.height * 0.03,
                                                                                          width: context.width * 0.04,
                                                                                          // width: 20.sp,
                                                                                          // height: 20.sp,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: context.width * 0.01,
                                                                                        ),
                                                                                        AutoSizeText(
                                                                                          similarAdsCubit.similarAdsModel.data![index].additionalFeatures?[indexx].name ?? '',
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
                                                                            //     itemCount: similarAdsCubit.similarAdsModel.data![index].additionalFeatures!.length >= 2 ? 2 : similarAdsCubit.similarAdsModel.data?[index].additionalFeatures!.length,
                                                                            //     itemBuilder: (context, i) {
                                                                            //       return FittedBox(
                                                                            //         child: Row(
                                                                            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            //           mainAxisSize: MainAxisSize.max,
                                                                            //           children: [
                                                                            //             Image.network(
                                                                            //               similarAdsCubit.similarAdsModel.data?[index].additionalFeatures?[i].image ?? 'https://dashboard.redd.sa/dash/additional_features/1717849710.png',
                                                                            //               width: 20.sp,
                                                                            //               height: 20.sp,
                                                                            //             ),
                                                                            //             AutoSizeText(
                                                                            //               similarAdsCubit.similarAdsModel.data?[index].additionalFeatures?[i].name ?? '',
                                                                            //               presetFontSizes: [
                                                                            //                 12.sp,
                                                                            //                 10.sp,
                                                                            //                 7.sp
                                                                            //               ],
                                                                            //               style: openSansMedium.copyWith(color: goldColor),
                                                                            //             ),
                                                                            //             SizedBox(
                                                                            //               width: context.width * 0.1,
                                                                            //             ),
                                                                            //           ],
                                                                            //         ),
                                                                            //       );
                                                                            //     }),
                                                                          ),
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
                                                          itemCount:
                                                              similarAdsCubit
                                                                  .similarAdsModel
                                                                  .data!
                                                                  .length,
                                                        ),
                                                      );
                                              },
                                            ),
                                            const SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_DEFAULT,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}

// SliverAppBar(
//   backgroundColor: whiteColor,
//   expandedHeight: context.width * 0.9.sp,
//   toolbarHeight: context.height * 0.12.sp,
//   pinned: true,
//   floating: true,
//   centerTitle: true,
//   snap: true,
//   title: SABT(
//     child: SafeArea(
//       minimum: EdgeInsets.only(
//         top: Dimensions.PADDING_SIZE_LARGE.sp,
//       ),
//       child: Text(
//         adsByIdCubit.adsByIdModel.data?.name ?? '',
//         style:
//             openSansBold.copyWith(color: goldColor),
//       ),
//     ),
//   ),
//   leading: Padding(
//     padding: EdgeInsetsDirectional.only(
//         // top: 50.sp,
//         top: Dimensions.PADDING_SIZE_LARGE.sp,
//         start: Dimensions.PADDING_SIZE_LARGE.sp),
//     child: BackButtonWidget(),
//   ),
//   flexibleSpace: FlexibleSpaceBar(
//     background: ClipRRect(
//       borderRadius: BorderRadius.only(
//         bottomRight: Radius.circular(
//             Dimensions.RADIUS_DEFAULT),
//         bottomLeft: Radius.circular(
//             Dimensions.RADIUS_DEFAULT),
//       ),
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           GestureDetector(
//             onTap: () {
//               navigateForward(FullImageListScreen(
//                 image: adsByIdCubit
//                         .adsByIdModel.data?.photos ??
//                     [],
//                 itemCount: adsByIdCubit.adsByIdModel
//                     .data!.photos!.length,
//               ));
//             },
//             child: CarouselSlider(
//               carouselController: carouselController,
//               options: CarouselOptions(
//                   height: context.width * 0.9.sp,
//                   aspectRatio: 16 / 9,
//                   viewportFraction: 1,
//                   initialPage: 0,
//                   enableInfiniteScroll: true,
//                   reverse: false,
//                   autoPlayAnimationDuration:
//                       const Duration(
//                           milliseconds: 800),
//                   autoPlayInterval:
//                       const Duration(seconds: 3),
//                   enlargeCenterPage: true,
//                   autoPlayCurve:
//                       Curves.fastLinearToSlowEaseIn,
//                   scrollDirection: Axis.horizontal,
//                   onPageChanged: (i, reason) {
//                     filterAdsCubit
//                         .changeIndexCarousel(i);
//                   }),
//               items: adsByIdCubit
//                   .adsByIdModel.data!.photos!
//                   .map((e) {
//                 return Builder(builder: (context) {
//                   return Card(
//                     margin: EdgeInsets.zero,
//                     clipBehavior:
//                         Clip.antiAliasWithSaveLayer,
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                         // side: BorderSide(color: goldColor),
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius
//                                 .circular(Dimensions
//                                     .RADIUS_DEFAULT),
//                             bottomRight: Radius
//                                 .circular(Dimensions
//                                     .RADIUS_DEFAULT))),
//                     child: Container(
//                       width: context.width,
//                       clipBehavior:
//                           Clip.antiAliasWithSaveLayer,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius
//                                 .circular(Dimensions
//                                     .RADIUS_DEFAULT),
//                             bottomRight: Radius
//                                 .circular(Dimensions
//                                     .RADIUS_DEFAULT)),
//                       ),
//                       child: CachedNetworkImage(
//                         imageUrl: adsByIdCubit
//                                 .adsByIdModel
//                                 .data!
//                                 .photos!
//                                 .isEmpty
//                             ? Images.AVATAR_IMAGE
//                             : e,
//                         fit: BoxFit.cover,
//                         placeholder: (l, n) {
//                           return Image.asset(
//                               Images.SMALL_LOGO_ICON);
//                         },
//                         errorWidget: (z, x, c) {
//                           return Image.asset(
//                               Images.Error);
//                         },
//                       ),
//                     ),
//                   );
//                 });
//               }).toList(),
//             ),
//           ),
//           AnimatedSmoothIndicator(
//             activeIndex: filterAdsCubit.selectedIndex,
//             count: adsByIdCubit
//                 .adsByIdModel.data!.photos!.length,
//             effect: WormEffect(
//                 activeDotColor: goldColor,
//                 dotColor: whiteColor,
//                 radius: 20.sp),
//           ),
//           Align(
//             alignment: AlignmentDirectional.center,
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: 8.0.sp),
//               child: Row(
//                 mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment:
//                     CrossAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () => carouselController
//                         .previousPage(
//                       duration: Duration(
//                         milliseconds: 800,
//                       ),
//                       //  curve: Curves.fastLinearToSlowEaseIn
//                     ),
//                     child: SvgPicture.asset(
//                         Images.Back_svg),
//                   ),
//                   GestureDetector(
//                     onTap: () =>
//                         carouselController.nextPage(
//                       duration: Duration(
//                         milliseconds: 800,
//                       ),
//                       // curve: Curves.fastLinearToSlowEaseIn
//                     ),
//                     child: SvgPicture.asset(
//                         Images.Forward_svg),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     ),
//   ),
// ),
