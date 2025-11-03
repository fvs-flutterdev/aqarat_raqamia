import 'dart:io';
import 'package:aqarat_raqamia/bloc/similar_ads_cubit/state.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/view/base/riyal_widget.dart';
import 'package:aqarat_raqamia/view/screens/details_screen/widget/adversiter_widget.dart';
import 'package:aqarat_raqamia/view/screens/details_screen/widget/grid_view_details.dart';
import 'package:aqarat_raqamia/view/screens/details_screen/widget/row_widget_for_details.dart';
import 'package:aqarat_raqamia/view/screens/details_screen/widget/sliver_app_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../bloc/similar_ads_cubit/cubit.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/dimention.dart';
import '../../../utils/images.dart';
import '../../../utils/text_style.dart';
import '../../base/back_button.dart';
import '../../base/full_screen_image/full_screen_image.dart';
import '../../base/lunch_widget.dart';
import '../../base/row_address_widget.dart';
import '../../base/show_toast.dart';
import '../comments_screen/widget/comments_widget.dart';
import '../location/map_string.dart';
import '../location/utility.dart';
import '../my_ads_screen/widget/visability_widget.dart';

//ignore: must_be_immutable
class SimilarDetailsScreen extends StatefulWidget {
  int index;
  String categoryId;
  bool isFav;
  Function favouriteFunction;

  SimilarDetailsScreen(
      {super.key,
      required this.index,
      required this.categoryId,
      required this.favouriteFunction,
      required this.isFav});

  @override
  State<SimilarDetailsScreen> createState() => _SimilarDetailsScreenState();
}

class _SimilarDetailsScreenState extends State<SimilarDetailsScreen> {
  CarouselSliderController carouselController = CarouselSliderController();

  @override
  void initState() {
    LocationHelper.generateLocationPreviewImage(
        latitude: double.parse(context
            .read<SimilarAdsCubit>()
            .similarAdsModel
            .data![widget.index]
            .lat!),
        longitude: double.parse(context
            .read<SimilarAdsCubit>()
            .similarAdsModel
            .data![widget.index]
            .lan!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var similarAdsCubit = context.read<SimilarAdsCubit>();
    return Scaffold(
      body: BlocConsumer<SimilarAdsCubit, SimilarAdsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: CustomScrollView(
              slivers: [
                SliverAppBarWidget(
                  name: similarAdsCubit.similarAdsModel.data![widget.index].name ?? '',
                  activeIndex: similarAdsCubit.selectedIndex,
                  carouselController: carouselController,
                  carouselFunction: (i, reason) {
                    similarAdsCubit.changeIndexCarousel(i);
                  },
                  images:
                  similarAdsCubit.similarAdsModel.data![widget.index].photos ?? [],
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                        end: Dimensions.PADDING_SIZE_DEFAULT,
                        start: Dimensions.PADDING_SIZE_DEFAULT),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Center(
                          //     child: Text(
                          //       similarAdsCubit.similarAdsModel
                          //           .data![widget.index].name ??
                          //           '',
                          //       style: openSansExtraBold.copyWith(
                          //           color: darkGreyColor,fontSize: 20.sp),
                          //     )),
                          Center(child: AutoSizeText('${similarAdsCubit.similarAdsModel.data![widget.index].name ?? ''}',
                              style: openSansExtraBold
                                  .copyWith(
                                color:
                                goldColor,
                              ),overflow: TextOverflow.ellipsis,
                            presetFontSizes: [18.sp,13.sp,10.sp],
                            maxLines: 1,
                            softWrap: true,),),
                          // Center(
                          //   child: AutoSizeText.rich(
                          //     TextSpan(
                          //         text: "${LocaleKeys.adTitle.tr()} : ",
                          //         style: openSansBold.copyWith(color: darkGreyColor),
                          //         children: [
                          //           TextSpan(
                          //               text:
                          //               '${similarAdsCubit.similarAdsModel.data![widget.index].name ?? ''}',
                          //               style: openSansExtraBold
                          //                   .copyWith(
                          //                 color:
                          //                 goldColor,
                          //               ))
                          //         ]),
                          //     overflow: TextOverflow.ellipsis,
                          //     presetFontSizes: [18.sp,13.sp,10.sp],
                          //     maxLines: 1,
                          //     softWrap: true,
                          //   ),
                          // ),
                          // Center(
                          //   child: AutoSizeText.rich(
                          //     overflow: TextOverflow.ellipsis,
                          //     presetFontSizes: [18.sp,13.sp,10.sp],
                          //     maxLines: 1,
                          //     softWrap: true,
                          //     TextSpan(
                          //         text: "${LocaleKeys.price.tr()} : ",
                          //         style: openSansBold.copyWith(color: darkGreyColor,),
                          //         children: [
                          //           TextSpan(
                          //               text:
                          //               '${LocaleKeys.currency.tr()} ${similarAdsCubit.similarAdsModel.data![widget.index].price ?? ''}',
                          //               style: openSansExtraBold
                          //                   .copyWith(
                          //                 color:
                          //                 goldColor,))
                          //         ]),
                          //   ),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AutoSizeText('${similarAdsCubit.similarAdsModel.data![widget.index].price ?? ''}',
                                style: openSansBold
                                .copyWith(
                                color:
                                goldColor,),
                                  overflow: TextOverflow.ellipsis,
                                  presetFontSizes: [18.sp,13.sp,10.sp],
                                  maxLines: 1,
                                  softWrap: true,),
                              SizedBox(width: context.width*0.005.w,),
                              riyalWidget(context),
                            ],
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //

                                  AutoSizeText.rich(
                                     TextSpan(
                                          text: "${LocaleKeys.adsNo.tr()}",
                                          style: openSansBold.copyWith(
                                              color: darkGreyColor),
                                          children: [
                                        TextSpan(
                                          text: similarAdsCubit.similarAdsModel
                                              .data![widget.index].id
                                              .toString(),
                                          style: openSansBold.copyWith(
                                              color: goldColor),
                                        )
                                      ])),
                                  AutoSizeText.rich(
                                       TextSpan(
                                          text: "${LocaleKeys.purpose.tr()} : ",
                                          style: openSansBold.copyWith(
                                              color: darkGreyColor),
                                          children: [
                                        TextSpan(
                                          text: similarAdsCubit
                                                  .similarAdsModel
                                                  .data![widget.index]
                                                  .type
                                                  ?.name ??
                                              '',
                                          style: openSansBold.copyWith(
                                              color: goldColor),
                                        )
                                      ])),
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       LocaleKeys.adsNo.tr(),
                                  //       style: openSansMedium.copyWith(
                                  //           color: darkGreyColor),
                                  //     ),
                                  //     Text(
                                  //         similarAdsCubit.similarAdsModel
                                  //             .data![widget.index].id
                                  //             .toString(),
                                  //         style: openSansRegular.copyWith(
                                  //             color: darkGreyColor)),
                                  //   ],
                                  // )
                                ],
                              ),
                              Flexible(
                                child: RowWidgetForDetails(
                                  categoryId: similarAdsCubit.similarAdsModel
                                      .data![widget.index].categoryAds!.id!,
                                  adsId: similarAdsCubit
                                      .similarAdsModel.data![widget.index].id!,
                                  isFav:  similarAdsCubit.similarAdsModel
                                      .data![widget.index].isFavorite!,
                                  fct: () {
                                    setState(() {
                                      similarAdsCubit.similarAdsModel
                                          .data![widget.index].isFavorite != similarAdsCubit.similarAdsModel
                                          .data![widget.index].isFavorite;
                                      similarAdsCubit.similarAdsModel
                                          .data![widget.index]
                                          .isFavorite==true
                                          ? similarAdsCubit
                                          .removeFavourite(
                                        widget.index,similarAdsCubit
                                          .similarAdsModel.data![widget.index].id.toString(),context
                                      )
                                          :  similarAdsCubit
                                          .addFavourite(
                                          widget.index,similarAdsCubit
                                          .similarAdsModel.data![widget.index].id.toString(),context
                                        // context,
                                      );
                                    });
                                    // similarAdsCubit.similarAdsModel.data!
                                    //     .first.isFavorite!
                                    //     ? similarAdsCubit.removeFavourite(
                                    //     0,
                                    //     similarAdsCubit.similarAdsModel
                                    //         .data!.first.id
                                    //         .toString(),
                                    //     context)
                                    //     : similarAdsCubit.addFavourite(
                                    //     0,
                                    //     similarAdsCubit.similarAdsModel
                                    //         .data!.first.id
                                    //         .toString(),
                                    //     context);
                                  },
                                ),
                              )
                            ],
                          ),
                          // SizedBox(
                          //   height: Dimensions.PADDING_SIZE_DEFAULT,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      text: LocaleKeys.estateType.tr(),
                                      style: openSansBold.copyWith(
                                          color: darkGreyColor),
                                      children: [
                                    TextSpan(
                                      text: similarAdsCubit
                                              .similarAdsModel
                                              .data![widget.index]
                                              .categoryAds
                                              ?.name ??
                                          '',
                                      style: openSansBold.copyWith(
                                          color: goldColor),
                                    )
                                  ])),
                              // Text(
                              //   similarAdsCubit.similarAdsModel.data![widget.index]
                              //           .categoryAds?.name ??
                              //       '',
                              //   style: openSansRegular.copyWith(
                              //       color: darkGreyColor),
                              // ),
                              // Text(
                              //     '${LocaleKeys.currency.tr()} ${similarAdsCubit.similarAdsModel.data![widget.index].price ?? ''}',
                              //     style: openSansExtraBold.copyWith(
                              //         color: goldColor)),
                            ],
                          ),
                          RichText(
                              text: TextSpan(
                                  text: LocaleKeys.adCreated.tr(),
                                  style: openSansBold.copyWith(
                                      color: darkGreyColor),
                                  children: [
                                TextSpan(
                                  text: similarAdsCubit
                                          .similarAdsModel
                                          .data![widget.index]
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
                                      text:similarAdsCubit
                                          .similarAdsModel
                                          .data![widget.index]
                                          .createDates
                                          ?.createdAtHuman ??
                                          '',
                                      style: openSansBold.copyWith(
                                          color: goldColor),
                                    )
                                  ])),
                          Divider(
                            thickness: 1.2.sp,
                          ),
                          widget.categoryId == '12' ||
                                  widget.categoryId == '14' ||
                                  widget.categoryId == '18' ||
                                  widget.categoryId == '13' ||
                                  widget.categoryId == '19' ||
                                  widget.categoryId == '16' ||
                                  widget.categoryId == '21' ||
                                  widget.categoryId == '24' ||
                                  widget.categoryId == '25' ||
                                  widget.categoryId == '27' ||
                                  widget.categoryId == '34' ||
                                  widget.categoryId == '36' ||
                                  widget.categoryId == '35'
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.features.tr(),
                                      style: openSansExtraBold.copyWith(
                                          color: darkGreyColor,fontSize: 18.sp),
                                    ),
                                    SizedBox(
                                      height: Dimensions.PADDING_SIZE_SMALL.sp,
                                    ),
                                    FeaturesGridView(
                                        featureModel: similarAdsCubit
                                            .similarAdsModel
                                            .data![widget.index]
                                            .additionalFeatures!),
                                    Divider(
                                      thickness: 1.2.sp,
                                    ),
                                    SizedBox(
                                      height: Dimensions.PADDING_SIZE_SMALL.sp,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          Text(LocaleKeys.specialRealEstateInfo.tr(),
                              style: openSansExtraBold.copyWith(
                                  color: darkGreyColor,fontSize: 18.sp)),
                          GridViewDetails(
                              streetWidth: similarAdsCubit.similarAdsModel
                                  .data![widget.index].streetWidth,
                              planNumber: similarAdsCubit.similarAdsModel
                                  .data![widget.index].planNumber,
                              wellsNumber: similarAdsCubit.similarAdsModel
                                  .data![widget.index].wellsNumber
                                  .toString(),
                              usage: similarAdsCubit
                                  .similarAdsModel.data![widget.index].usage,
                              treesCount: similarAdsCubit.similarAdsModel
                                  .data![widget.index].treesAndPalmsNumber
                                  .toString(),
                              services: similarAdsCubit
                                  .similarAdsModel.data![widget.index].services,
                              parking: similarAdsCubit.similarAdsModel.data![widget.index].parkingSpaces == true
                                  ? LocaleKeys.available.tr()
                                  : LocaleKeys.notAvailable.tr(),
                              livingRooms: similarAdsCubit.similarAdsModel
                                  .data![widget.index].livingRoomsNumber
                                  .toString(),
                              floorCount: similarAdsCubit.similarAdsModel
                                  .data![widget.index].floorsNumber
                                  .toString(),
                              desiredPropertySpecifications: similarAdsCubit
                                  .similarAdsModel
                                  .data![widget.index]
                                  .desiredPropertySpecifications,
                              commercialUnitsNumber: similarAdsCubit.similarAdsModel.data![widget.index].commercialUnitsNumber.toString(),
                              age: similarAdsCubit.similarAdsModel.data![widget.index].age.toString(),
                              additionalRequirements: similarAdsCubit.similarAdsModel.data![widget.index].additionalRequirements,
                              landNo: similarAdsCubit.similarAdsModel.data![widget.index].parcelNumber,
                              purpose: similarAdsCubit.similarAdsModel.data![widget.index].type?.name ?? '',
                              vision: similarAdsCubit.similarAdsModel.data![widget.index].prolongation ?? '',
                              area: similarAdsCubit.similarAdsModel.data![widget.index].space ?? '',
                              bedRoomNo: similarAdsCubit.similarAdsModel.data![widget.index].roomsNumber ?? '',
                              toiletNo: similarAdsCubit.similarAdsModel.data![widget.index].toiletsNumber ?? '',
                              id: similarAdsCubit.similarAdsModel.data![widget.index].categoryAds!.id!),
                          SizedBox(
                            height: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          // SizedBox(
                          //   height: Dimensions.PADDING_SIZE_DEFAULT,
                          // ),
                          Divider(
                            thickness: 1.2,
                          ),
                          Text(
                            LocaleKeys.description.tr(),
                            style: openSansExtraBold.copyWith(color: darkGreyColor,fontSize: 18.sp),
                          ),
                          Container(
                            child: Text(
                              similarAdsCubit.similarAdsModel
                                      .data![widget.index].notes ??
                                  '',
                              style:
                              openSansBold.copyWith(color: goldColor),
                            ),
                          ),
                          Divider(
                            thickness: 1.2,
                          ),
                          Text(
                            LocaleKeys.location.tr(),
                            style: openSansExtraBold.copyWith(color: darkGreyColor,fontSize: 18.sp),
                          ),
                          SizedBox(
                            height: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          RowAddressLocation(
                              city:
                                  '${similarAdsCubit.similarAdsModel.data![widget.index].city ?? "لا يمكن تحديد المدينة"}',
                              district:
                                  '${similarAdsCubit.similarAdsModel.data![widget.index].district ?? "لا يمكن تحديد الحي"}',
                              region:
                                  '${similarAdsCubit.similarAdsModel.data![widget.index].region ?? "لا يمكن تحديد المنطقه"}'),
                          // SizedBox(
                          //   height: Dimensions.PADDING_SIZE_DEFAULT.sp,
                          // ),
                          // Text(
                          //   LocaleKeys.location.tr(),
                          //   style: openSansBold.copyWith(color: darkGreyColor),
                          // ),
                          SizedBox(
                            height: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (similarAdsCubit.similarAdsModel
                                          .data![widget.index].lat ==
                                      null ||
                                  similarAdsCubit.similarAdsModel
                                          .data![widget.index].lan ==
                                      null) {
                                showCustomSnackBar(
                                    // context: context,
                                    message: LocaleKeys.errorOnAdsLocation.tr(),
                                    state: ToastState.ERROR);
                              } else {
                                if (Platform.isIOS) {
                                  await launchUrl(Uri.parse(
                                      "comgooglemaps://?q=${similarAdsCubit.similarAdsModel.data![widget.index].lat},"
                                      "${similarAdsCubit.similarAdsModel.data![widget.index].lan}&key=AIzaSyCjq0TIsXwDT8RQK2jBajVnHy93eoTt1HU"));
                                } else {
                                  await launchUrl(Uri.parse(
                                      'https://www.google.com/maps/search/?api=1&query='
                                      '${similarAdsCubit.similarAdsModel.data![widget.index].lat}, '
                                      '${similarAdsCubit.similarAdsModel.data![widget.index].lan}'
                                      '&key=AIzaSyCjq0TIsXwDT8RQK2jBajVnHy93eoTt1HU'));
                                }
                                //google.navigation:q=
                              }
                            },
                            child: LocationView(
                                double.parse(similarAdsCubit
                                    .similarAdsModel.data![widget.index].lat!),
                                double.parse(similarAdsCubit
                                    .similarAdsModel.data![widget.index].lan!)),
                            //imagePreviewLocation(),
                            // CustomTextField(
                            //     controller: TextEditingController(
                            //         text: similarAdsCubit.similarAdsModel
                            //                 .data![index].address ??
                            //             ''),
                            //     labelText: LocaleKeys.location.tr(),
                            //     isEnabled: false),
                          ),
                          SizedBox(
                            height: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          token==null?SizedBox():    GestureDetector(
                            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
                            child: CommentsWidget(
                              adId:similarAdsCubit.similarAdsModel
                                  .data![widget.index].id
                                  .toString(),
                              rate: 2.5,
                              model:similarAdsCubit.similarAdsModel
                                  .data![widget.index].adComments??[]
                            //  adsByIdCubit.adsByIdModel.data?.adComments??[] ,
                              //   review: 'عقار رائع',
                              //  imageUrl: Images.AVATAR_IMAGE,
                              // name: "احمد محمد",
                            ),
                          ),
                          // accountType == 'service_applicant'
                          //     ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.contactWithAdvertiser.tr (),
                                style:
                                    openSansExtraBold.copyWith(color: darkGreyColor,fontSize: 18.sp),
                              ),
                              AdvertiserCard(
                                  // id: similarAdsCubit.similarAdsModel
                                  //     .data![widget.index].userAds!.id!,
                                  image: similarAdsCubit.similarAdsModel
                                          .data![widget.index].userAds!.photo ??
                                      '',
                                  name: similarAdsCubit.similarAdsModel
                                          .data![widget.index].userAds!.name ??
                                      '',
                                  phone: similarAdsCubit.similarAdsModel
                                          .data![widget.index].userAds!.phone ??
                                      ''),
                              SizedBox(
                                height: Dimensions.PADDING_SIZE_DEFAULT,
                              ),
                              SizedBox(
                                height: Dimensions.PADDING_SIZE_DEFAULT,
                              ),
                            ],
                          )
                          //  : SizedBox()
                        ],
                      ),
                    ),
                  )
                ]))
              ],
            ),
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
//       child: Text(
//     similarAdsCubit.similarAdsModel.data![widget.index].name ??
//         '',
//     style: openSansBold.copyWith(color: goldColor),
//   )),
//
//   leading: Padding(
//     padding: EdgeInsetsDirectional.only(
//         start: Dimensions.PADDING_SIZE_LARGE.sp),
//     child: BackButtonWidget(),
//   ),
//   // floating: true,
//   //  automaticallyImplyLeading: false,
//   flexibleSpace: FlexibleSpaceBar(
//     background: ClipRRect(
//       borderRadius: BorderRadius.only(
//         bottomRight:
//             Radius.circular(Dimensions.RADIUS_DEFAULT.sp),
//         bottomLeft:
//             Radius.circular(Dimensions.RADIUS_DEFAULT.sp),
//       ),
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           GestureDetector(
//             onTap: () {
//               navigateForward(FullImageListScreen(
//                 image: similarAdsCubit.similarAdsModel
//                     .data![widget.index].photos!,
//                 itemCount: similarAdsCubit.similarAdsModel
//                     .data![widget.index].photos!.length,
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
//                       const Duration(milliseconds: 800),
//                   autoPlayInterval: const Duration(seconds: 3),
//                   enlargeCenterPage: true,
//                   autoPlayCurve: Curves.fastLinearToSlowEaseIn,
//                   scrollDirection: Axis.horizontal,
//                   onPageChanged: (i, reason) {
//                     similarAdsCubit.changeIndexCarousel(i);
//                   }),
//               items: similarAdsCubit
//                   .similarAdsModel.data![widget.index].photos!
//                   .map((e) {
//                 return Builder(builder: (context) {
//                   return Card(
//                     margin: EdgeInsetsDirectional.zero,
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                             bottomRight: Radius.circular(
//                                 Dimensions.RADIUS_DEFAULT.sp),
//                             bottomLeft: Radius.circular(
//                                 Dimensions.RADIUS_DEFAULT.sp))),
//                     child: Container(
//                       width: context.width,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: NetworkImage(e.isEmpty
//                                 ? Images.AVATAR_IMAGE
//                                 : e),
//                             fit: BoxFit.cover),
//                         borderRadius: BorderRadius.only(
//                             bottomRight: Radius.circular(
//                                 Dimensions.RADIUS_DEFAULT.sp),
//                             bottomLeft: Radius.circular(
//                                 Dimensions.RADIUS_DEFAULT.sp)),
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
//             activeIndex: similarAdsCubit.selectedIndex,
//             count: similarAdsCubit.similarAdsModel
//                 .data![widget.index].photos!.length,
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
//                 mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//
//                   GestureDetector(
//                     onTap: () =>
//                         carouselController.previousPage(
//                       duration: Duration(milliseconds: 800),
//                       // curve: Curves.fastLinearToSlowEaseIn
//                     ),
//                     child: SvgPicture.asset(Images.Back_svg),
//                   ),
//                   GestureDetector(
//                     onTap: () => carouselController.nextPage(
//                       duration: Duration(milliseconds: 800),
//                       //curve: Curves.fastLinearToSlowEaseIn
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