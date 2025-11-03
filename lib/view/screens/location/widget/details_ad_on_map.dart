import 'dart:io';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../bloc/map_ads_cubit/cubit.dart';
import '../../../../bloc/map_ads_cubit/state.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/app_constant.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/images.dart';
import '../../../../utils/text_style.dart';
import '../../../base/riyal_widget.dart';
import '../../../base/row_address_widget.dart';
import '../../../base/show_toast.dart';
import '../../comments_screen/widget/comments_widget.dart';
import '../../details_screen/widget/adversiter_widget.dart';
import '../../details_screen/widget/grid_view_details.dart';
import '../../details_screen/widget/row_widget_for_details.dart';
import '../../details_screen/widget/sliver_app_bar.dart';
import '../map_string.dart';

//ignore: must_be_immutable
class DetailsAdOnMap extends StatefulWidget {
  ScrollController scrollController;

  DetailsAdOnMap({required this.scrollController});

  @override
  State<DetailsAdOnMap> createState() => _DetailsAdOnMapState();
}

class _DetailsAdOnMapState extends State<DetailsAdOnMap> {
  CarouselSliderController carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    var adsOnMapCubit = context.read<AdsOnMapCubit>();
    return Scaffold(
      body: BlocBuilder<AdsOnMapCubit, AdsOnMapState>(
        builder: (context, state) {
          return FractionallySizedBox(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: CustomScrollView(
                controller: widget.scrollController,
                slivers: [
                  SliverAppBarWidget(
                    name: adsOnMapCubit.nearbyAqarModel
                        .data?[adsOnMapCubit.adsId].name ??
                        '',
                    activeIndex: adsOnMapCubit.selectedIndex,
                    carouselController: carouselController,
                    carouselFunction: (i, reason) {
                      print(i);
                      adsOnMapCubit.changeIndexCarousel(i);
                    },
                    images: adsOnMapCubit.nearbyAqarModel
                        .data?[adsOnMapCubit.adsId].photos! ??
                        [],
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              top: Dimensions.PADDING_SIZE_DEFAULT,
                              end: Dimensions.PADDING_SIZE_DEFAULT,
                              start: Dimensions.PADDING_SIZE_DEFAULT),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Center(child: AutoSizeText(
                                  adsOnMapCubit.nearbyAqarModel
                                      .data?[adsOnMapCubit.adsId].name ?? '',
                                  style: openSansExtraBold
                                      .copyWith(
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
                                )),
                                // Center(
                                //   child: AutoSizeText.rich(
                                //     TextSpan(
                                //         text:
                                //         "${LocaleKeys.adTitle.tr()} : ",
                                //         style: openSansBold.copyWith(
                                //             color: darkGreyColor),
                                //         children: [
                                //           TextSpan(
                                //               text:
                                //               '${adsOnMapCubit.nearbyAqarModel
                                //                   .data?[adsOnMapCubit.adsId].name ?? ''}',
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId].price ?? '',
                                        style: openSansBold
                                            .copyWith(
                                          color: goldColor,
                                        ),overflow: TextOverflow.ellipsis,
                                      presetFontSizes: [
                                        18.sp,
                                        13.sp,
                                        10.sp
                                      ],
                                      maxLines: 1,
                                      softWrap: true,),
                                    SizedBox(width: context.width * 0.005.w,),
                                    riyalWidget(context),
                                  ],
                                ),
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
                                                text: adsOnMapCubit
                                                    .nearbyAqarModel
                                                    .data?[adsOnMapCubit.adsId]
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
                                                text: adsOnMapCubit
                                                    .nearbyAqarModel
                                                    .data?[adsOnMapCubit.adsId]
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
                                        categoryId: adsOnMapCubit
                                            .nearbyAqarModel
                                            .data![adsOnMapCubit.adsId]
                                            .categoryAds!
                                            .id!,
                                        adsId: adsOnMapCubit.nearbyAqarModel
                                            .data![adsOnMapCubit.adsId].id!,
                                        isFav: adsOnMapCubit.nearbyAqarModel
                                            .data![adsOnMapCubit.adsId]
                                            .isFavorite!,

                                        fct: () {
                                          // print('////////////////////////');
                                          setState(() {
                                            adsOnMapCubit.nearbyAqarModel
                                                .data?[adsOnMapCubit.adsId]
                                                .isFavorite !=
                                                adsOnMapCubit.nearbyAqarModel
                                                    .data?[adsOnMapCubit.adsId]
                                                    .isFavorite!;
                                            adsOnMapCubit.nearbyAqarModel
                                                .data?[adsOnMapCubit.adsId]
                                                .isFavorite == true
                                                ? adsOnMapCubit
                                                .removeFavourite(
                                              adsOnMapCubit.adsId,
                                              adsOnMapCubit.nearbyAqarModel
                                                  .data![adsOnMapCubit.adsId]
                                                  .id.toString(),
                                              context,
                                            )
                                                : adsOnMapCubit
                                                .addFavourite(
                                              adsOnMapCubit.adsId,
                                              adsOnMapCubit.nearbyAqarModel
                                                  .data![adsOnMapCubit.adsId]
                                                  .id.toString(),
                                              context,
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
                                                text: adsOnMapCubit
                                                    .nearbyAqarModel
                                                    .data?[adsOnMapCubit.adsId]
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
                                            text: adsOnMapCubit.nearbyAqarModel
                                                .data?[adsOnMapCubit.adsId]
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
                                            text: adsOnMapCubit.nearbyAqarModel
                                                .data?[adsOnMapCubit.adsId]
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
                                adsOnMapCubit
                                    .nearbyAqarModel
                                    .data?[adsOnMapCubit.adsId]
                                    .categoryAds
                                    ?.id ==
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
                                        35
                                    ? Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.features.tr(),
                                      style: openSansExtraBold.copyWith(
                                          color: darkGreyColor,
                                          fontSize: 18.sp),
                                    ),
                                    SizedBox(
                                      height:
                                      Dimensions.PADDING_SIZE_SMALL.sp,
                                    ),
                                    FeaturesGridView(
                                        featureModel: adsOnMapCubit
                                            .nearbyAqarModel
                                            .data?[adsOnMapCubit.adsId]
                                            .additionalFeatures ??
                                            []),
                                    Divider(
                                      thickness: 1.2.sp,
                                    ),
                                    SizedBox(
                                      height:
                                      Dimensions.PADDING_SIZE_SMALL.sp,
                                    ),
                                  ],
                                )
                                    : SizedBox(),
                                Text(LocaleKeys.specialRealEstateInfo.tr(),
                                    style: openSansExtraBold
                                        .copyWith(
                                        color:
                                        darkGreyColor,
                                        fontSize: 18.sp)),
                                GridViewDetails(
                                    streetWidth: adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId].streetWidth,
                                    planNumber: adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId].planNumber,
                                    wellsNumber: adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId].wellsNumber
                                        .toString(),
                                    usage: adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId].usage,
                                    treesCount: adsOnMapCubit
                                        .nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId]
                                        .treesAndPalmsNumber
                                        .toString(),
                                    services: adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId].services,
                                    parking: adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId]
                                        .parkingSpaces == true
                                        ? LocaleKeys.available.tr()
                                        : LocaleKeys.notAvailable.tr(),
                                    livingRooms: adsOnMapCubit
                                        .nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId]
                                        .livingRoomsNumber
                                        .toString(),
                                    floorCount: adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId].floorsNumber
                                        .toString(),
                                    desiredPropertySpecifications: adsOnMapCubit
                                        .nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId]
                                        .desiredPropertySpecifications,
                                    commercialUnitsNumber: adsOnMapCubit
                                        .nearbyAqarModel.data?[adsOnMapCubit
                                        .adsId].commercialUnitsNumber
                                        .toString(),
                                    age: adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId].age
                                        .toString(),
                                    additionalRequirements: adsOnMapCubit
                                        .nearbyAqarModel.data?[adsOnMapCubit
                                        .adsId].additionalRequirements,
                                    landNo: adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId]
                                        .parcelNumber,
                                    purpose: adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId].type
                                        ?.name ?? '',
                                    vision: adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId]
                                        .prolongation ?? '',
                                    area: adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId].space ?? '',
                                    bedRoomNo: adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId]
                                        .roomsNumber ?? '',
                                    toiletNo: adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId]
                                        .toiletsNumber ?? '',
                                    id: adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId].categoryAds!
                                        .id ?? 0),
                                const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT,
                                ),
                                const Divider(
                                  thickness: 1.2,
                                ),
                                Text(
                                  LocaleKeys.description.tr(),
                                  style:
                                  openSansExtraBold
                                      .copyWith(
                                      color:
                                      darkGreyColor,
                                      fontSize: 18.sp),
                                ),
                                Container(
                                  child: Text(
                                    adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId].notes ??
                                        '',
                                    style: openSansMedium.copyWith(
                                        color: goldColor),
                                  ),
                                ),
                                const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT,
                                ),
                                const Divider(
                                  thickness: 1.2,
                                ),
                                Text(
                                  LocaleKeys.location.tr(),
                                  style:
                                  openSansExtraBold
                                      .copyWith(
                                      color:
                                      darkGreyColor,
                                      fontSize: 18.sp),
                                ),
                                const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT,
                                ),
                                RowAddressLocation(
                                    city:
                                    '${adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId].city ??
                                        "لا يمكن تحديد المدينة"}',
                                    district:
                                    '${adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId].district ??
                                        "لا يمكن تحديد الحي"}',
                                    region:
                                    '${adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId].region ??
                                        "لا يمكن تحديد المنطقه"}'),
                                SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT.sp,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (adsOnMapCubit.nearbyAqarModel
                                        .data?[adsOnMapCubit.adsId].lat ==
                                        null ||
                                        adsOnMapCubit.nearbyAqarModel
                                            .data?[adsOnMapCubit.adsId].lan ==
                                            null) {
                                      showCustomSnackBar(
                                          message:
                                          LocaleKeys.errorOnAdsLocation.tr(),
                                          state: ToastState.ERROR);
                                    } else {
                                      // navigateForward(FullImageScreen(image: previewImageUrl!,));
                                      if (Platform.isIOS) {
                                        await launchUrl(Uri.parse(
                                            "comgooglemaps://?q=${adsOnMapCubit
                                                .nearbyAqarModel
                                                .data?[adsOnMapCubit.adsId]
                                                .lat},"
                                                "${adsOnMapCubit.nearbyAqarModel
                                                .data?[adsOnMapCubit.adsId]
                                                .lan}&key=AIzaSyCjq0TIsXwDT8RQK2jBajVnHy93eoTt1HU"));
                                      } else {
                                        await launchUrl(Uri.parse(
                                            'https://www.google.com/maps/search/?api=1&query=${adsOnMapCubit
                                                .nearbyAqarModel
                                                .data?[adsOnMapCubit.adsId]
                                                .lat},${adsOnMapCubit
                                                .nearbyAqarModel
                                                .data?[adsOnMapCubit.adsId]
                                                .lan}'));
                                      }
                                    }
                                  },
                                  child: LocationView(
                                      double.parse(adsOnMapCubit.nearbyAqarModel
                                          .data?[adsOnMapCubit.adsId].lat ??
                                          '21.5574931'),
                                      double.parse(adsOnMapCubit.nearbyAqarModel
                                          .data?[adsOnMapCubit.adsId].lan ??
                                          '39.1775043')),
                                ),
                                const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT,
                                ),

                                // accountType == 'service_applicant'
                                //     ?
                                token == null ? SizedBox() : CommentsWidget(
                                  adId: adsOnMapCubit
                                      .nearbyAqarModel
                                      .data![adsOnMapCubit.adsId].id.toString(),
                                  // adId: adsByIdCubit
                                  //     .adsByIdModel.data!.id
                                  //     .toString(),
                                  rate: 2.5,
                                  model: adsOnMapCubit
                                      .nearbyAqarModel
                                      .data?[adsOnMapCubit.adsId].adComments ??
                                      [],
                                  //   review: 'عقار رائع',
                                  //  imageUrl: Images.AVATAR_IMAGE,
                                  // name: "احمد محمد",
                                ),
                                // accountType == 'service_applicant'
                                //     ?
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.contactWithAdvertiser.tr(),
                                      style: openSansExtraBold.copyWith(
                                          color: darkGreyColor,
                                          fontSize: 18.sp),
                                    ),
                                    AdvertiserCard(
                                      //   id: adsOnMapCubit.nearbyAqarModel.data?[adsOnMapCubit.adsId].userAds!.id??0,
                                        image: adsOnMapCubit
                                            .nearbyAqarModel
                                            .data?[adsOnMapCubit.adsId]
                                            .userAds!
                                            .photo ??
                                            Images.AVATAR_IMAGE,
                                        name: adsOnMapCubit
                                            .nearbyAqarModel
                                            .data?[adsOnMapCubit.adsId]
                                            .userAds!
                                            .name ??
                                            '',
                                        phone: adsOnMapCubit
                                            .nearbyAqarModel
                                            .data?[adsOnMapCubit.adsId]
                                            .userAds!
                                            .phone ??
                                            ''),
                                  ],
                                )
                                // : SizedBox()
                              ],
                            ),
                          ),
                        )
                      ]))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
// SliverAppBar(
//   backgroundColor: whiteColor,
//   expandedHeight: context.width * 0.7.sp,
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
//         adsOnMapCubit.nearbyAqarModel.data?[adsOnMapCubit.adsId]
//                 .categoryAds?.name ??
//             '',
//         style: openSansBold.copyWith(color: goldColor),
//       ),
//     ),
//   ),
//   leading: Padding(
//     padding: EdgeInsetsDirectional.only(
//         start: Dimensions.PADDING_SIZE_LARGE),
//     child: BackButtonWidget(),
//   ),
//   flexibleSpace: FlexibleSpaceBar(
//     background: ClipRRect(
//       borderRadius: BorderRadius.only(
//         bottomRight: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
//         bottomLeft: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
//       ),
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           GestureDetector(
//             onTap: () {
//               navigateForward(FullImageListScreen(
//                 image: adsOnMapCubit.nearbyAqarModel
//                         .data?[adsOnMapCubit.adsId].photos ??
//                     [],
//                 itemCount: adsOnMapCubit.nearbyAqarModel
//                     .data![adsOnMapCubit.adsId].photos!.length,
//               ));
//             },
//             child: CarouselSlider(
//               carouselController: carouselController,
//               options: CarouselOptions(
//                   height: context.width * 0.7.sp,
//                   aspectRatio: 16 / 9,
//                   viewportFraction: 1,
//                   initialPage: 0,
//                   enableInfiniteScroll: true,
//                   reverse: false,
//                   autoPlayAnimationDuration:
//                       const Duration(milliseconds: 800),
//                   autoPlayInterval: const Duration(seconds: 3),
//                   enlargeCenterPage: true,
//                   autoPlayCurve: Curves.fastLinearToSlowEaseIn,
//                   scrollDirection: Axis.horizontal,
//                   onPageChanged: (i, reason) {
//                     // filterAdsCubit
//                     //     .changeIndexCarousel(i);
//                   }),
//               items: adsOnMapCubit.nearbyAqarModel
//                   .data?[adsOnMapCubit.adsId].photos!
//                   .map((e) {
//                 return Builder(builder: (context) {
//                   return Card(
//                     margin: EdgeInsets.zero,
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                         // side: BorderSide(color: goldColor),
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(
//                                 Dimensions.RADIUS_EXTRA_LARGE),
//                             bottomRight: Radius.circular(
//                                 Dimensions.RADIUS_EXTRA_LARGE))),
//                     child: Container(
//                       width: context.width,
//                       clipBehavior: Clip.antiAliasWithSaveLayer,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(
//                                 Dimensions.RADIUS_EXTRA_LARGE),
//                             bottomRight: Radius.circular(
//                                 Dimensions.RADIUS_EXTRA_LARGE)),
//                       ),
//                       child: CachedNetworkImage(
//                         imageUrl: adsOnMapCubit
//                                 .nearbyAqarModel
//                                 .data![adsOnMapCubit.adsId]
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
//                           return Image.asset(Images.Error);
//                         },
//                       ),
//                     ),
//                   );
//                 });
//               }).toList(),
//             ),
//           ),
//           // Align(
//           //   alignment: AlignmentDirectional.topStart,
//           //   child: Padding(padding: EdgeInsetsDirectional.only(top: 40.sp,start: 15.sp),child: BackButtonWidget()),
//           // ),
//           AnimatedSmoothIndicator(
//             activeIndex: 0,
//             //filterAdsCubit.selectedIndex,
//             count: adsOnMapCubit.nearbyAqarModel
//                 .data![adsOnMapCubit.adsId].photos!.length,
//             effect: WormEffect(
//                 activeDotColor: goldColor,
//                 dotColor: whiteColor,
//                 radius: 20.sp),
//           ),
//           Align(
//             alignment: AlignmentDirectional.center,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () => carouselController.previousPage(
//                       duration: Duration(
//                         milliseconds: 800,
//                       ),
//                       //  curve: Curves.fastLinearToSlowEaseIn
//                     ),
//                     child: SvgPicture.asset(Images.Back_svg),
//                   ),
//                   GestureDetector(
//                     onTap: () => carouselController.nextPage(
//                       duration: Duration(
//                         milliseconds: 800,
//                       ),
//                       // curve: Curves.fastLinearToSlowEaseIn
//                     ),
//                     child: SvgPicture.asset(Images.Forward_svg),
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
