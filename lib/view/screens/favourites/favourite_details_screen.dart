import 'dart:io';
import 'package:aqarat_raqamia/view/base/riyal_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

import '../../../bloc/favourite_cubit/favourite_cubit.dart';
import '../../../bloc/my_ads_cubit/cubit.dart';
import '../../../bloc/my_ads_cubit/state.dart';
import '../../../bloc/upload_request_cubit/cubit.dart';
import '../../../utils/media_query_value.dart';
import '../../../view/base/full_screen_image/full_screen_image.dart';
import '../../../view/base/lunch_widget.dart';
import '../../../view/screens/my_ads_screen/widget/visability_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../model/dynamic_model/favourite_model.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/dimention.dart';
import '../../../utils/text_style.dart';
import '../../base/back_button.dart';
import '../../base/row_address_widget.dart';
import '../../base/show_toast.dart';
import '../details_screen/widget/grid_view_details.dart';
import '../details_screen/widget/row_widget_for_details.dart';
import '../details_screen/widget/sliver_app_bar.dart';
import '../location/map_string.dart';
import '../location/utility.dart';

//ignore: must_be_immutable
class FavouriteDetailsScreen extends StatefulWidget {
  // int adId;
  int index;
  List<MyFavouriteData> listMyAds;

  FavouriteDetailsScreen(
      {super.key,
      // required this.adId,
      required this.index,
      required this.listMyAds});

  @override
  State<FavouriteDetailsScreen> createState() => _FavouriteDetailsScreenState();
}

class _FavouriteDetailsScreenState extends State<FavouriteDetailsScreen> {
  CarouselSliderController  carouselController = CarouselSliderController();
  @override
  void initState() {
    LocationHelper.generateLocationPreviewImage(
      latitude: double.parse(widget.listMyAds[widget.index].ads!.lat!),
      longitude: double.parse(widget.listMyAds[widget.index].ads!.lan!),
    );
    super.initState();
  }

  // var pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var myAdsCubit = context.read<MyAdsCubit>();
    var favouriteCubit = context.read<FavouriteCubit>();
    // context.read<UploadRequestCubit>().adId = widget.adId;
    print('//////////////////${context.read<UploadRequestCubit>().adId}');
    return Scaffold(
      body: BlocConsumer<MyAdsCubit, MyAdsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: CustomScrollView(
              slivers: [
                SliverAppBarWidget(
                  name: widget.listMyAds[widget.index].ads?.name ?? '',
                  activeIndex: myAdsCubit.selectedIndex,
                  carouselController: carouselController,
                  carouselFunction: (i, reason) {
                    myAdsCubit.changeIndexCarousel(i);
                  },
                  images:
                  widget.listMyAds[widget.index].ads!.photos ?? [],
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
                          Center(
                            child: AutoSizeText(
                                widget.listMyAds[widget.index].ads?.name ?? '',
                                style: openSansExtraBold
                                    .copyWith(
                                  color:
                                  goldColor,
                                ),
                              overflow: TextOverflow.ellipsis,
                              presetFontSizes: [18.sp,13.sp,10.sp],
                              maxLines: 1,
                              softWrap: true,
                            ),
                          ),
                          // Center(
                          //   child: AutoSizeText.rich(
                          //     TextSpan(
                          //         text: "${LocaleKeys.adTitle.tr()} : ",
                          //         style: openSansBold.copyWith(color: darkGreyColor),
                          //         children: [
                          //           TextSpan(
                          //               text:
                          //               '${widget.listMyAds[widget.index].ads?.name ?? ''}',
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
                          //               '${LocaleKeys.currency.tr()} ${widget.listMyAds[widget.index].ads?.price ?? ''}',
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
                              AutoSizeText(
                                widget.listMyAds[widget.index].ads?.price ?? '',
                                style: openSansBold
                                    .copyWith(
                                  color:
                                  goldColor,),
                                overflow: TextOverflow.ellipsis,
                                presetFontSizes: [18.sp,13.sp,10.sp],
                                maxLines: 1,
                                softWrap: true,
                                                        ),
                              SizedBox(width: context.width*0.005.w,),
                              riyalWidget(context),
                            ],
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_LARGE,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText.rich(
                                      TextSpan(
                                          text:
                                          "${LocaleKeys.adsNo.tr()}",
                                          style: openSansBold
                                              .copyWith(
                                              color:
                                              darkGreyColor),
                                          children: [
                                            TextSpan(
                                              text: widget
                                                  .listMyAds[widget.index].ads?.id
                                                  .toString(),
                                              style: openSansBold
                                                  .copyWith(
                                                  color:
                                                  goldColor),
                                            )
                                          ])),
                                  AutoSizeText.rich(
                                      TextSpan(
                                          text:
                                          "${LocaleKeys.purpose.tr()} : ",
                                          style: openSansBold
                                              .copyWith(
                                              color:
                                              darkGreyColor),
                                          children: [
                                            TextSpan(
                                              text: widget.listMyAds[widget.index].ads
                                                  ?.type?.name ??
                                                  '',
                                              style: openSansBold
                                                  .copyWith(
                                                  color:
                                                  goldColor),
                                            )
                                          ])),
                                  // Text(
                                  //     widget.listMyAds[widget.index].ads
                                  //             ?.categoryAds?.name ??
                                  //         '',
                                  //     style: openSansRegular.copyWith(
                                  //         color: darkGreyColor)),
                                  // RichText(
                                  //     text: TextSpan(
                                  //         text: LocaleKeys.adsNo.tr(),
                                  //         style: openSansMedium.copyWith(
                                  //             color: darkGreyColor),
                                  //         children: [
                                  //       TextSpan(
                                  //           text: widget
                                  //               .listMyAds[widget.index].ads?.id
                                  //               .toString(),
                                  //           style: openSansRegular.copyWith(
                                  //               color: darkGreyColor))
                                  //     ])),
                                ],
                              ),
                              Flexible(
                                child: RowWidgetForDetails(
                                  isFavouriteScreen: true,
                                  fct: () {
                                    setState(() {
                                      // widget.listMyAds[widget.index].ads!.isFavorite =
                                      // !widget.listMyAds[widget.index].ads!.isFavorite!;
                                      favouriteCubit
                                                  .favouriteModel
                                                  .data![widget.index]
                                                  .ads!
                                                  .isFavorite ==
                                              true
                                          ? favouriteCubit.removeFavourite(
                                              widget.index,
                                              favouriteCubit.favouriteModel
                                                  .data![widget.index].ads!.id
                                                  .toString(),
                                              //  context,
                                            )
                                          : favouriteCubit.addFavourite(
                                              widget.index,
                                              favouriteCubit.favouriteModel
                                                  .data![widget.index].ads!.id
                                                  .toString(),
                                              widget.listMyAds[widget.index].ads!
                                                  .isFavorite
                                              // context,
                                              );
                                    });
                                  },
                                  isFav: widget
                                      .listMyAds[widget.index].ads!.isFavorite!,
                                  adsId: widget.listMyAds[widget.index].ads!.id!,
                                  categoryId: widget.listMyAds[widget.index].ads!
                                      .categoryAds!.id!,
                                ),
                              ),


                            ],
                          ),
                          RichText(
                              text: TextSpan(
                                  text: LocaleKeys.estateType.tr(),
                                  style: openSansBold.copyWith(
                                      color: darkGreyColor),
                                  children: [
                                    TextSpan(
                                        text: widget.listMyAds[widget.index].ads
                                            ?.categoryAds?.name,
                                        style: openSansExtraBold.copyWith(
                                            color: goldColor))
                                  ])),
                          RichText(
                              text: TextSpan(
                                  text: LocaleKeys.adCreated.tr(),
                                  style: openSansBold.copyWith(
                                      color: darkGreyColor),
                                  children: [
                                    TextSpan(
                                      text: widget.listMyAds[widget.index].ads?.createDates?.createdAtHuman ??
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
                                      text: widget.listMyAds[widget.index].ads?.updateDates?.updatedAtHuman ??
                                          '',
                                      style: openSansBold.copyWith(
                                          color: goldColor),
                                    )
                                  ])),

                          // const SizedBox(
                          //   height: Dimensions.PADDING_SIZE_DEFAULT,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //
                          //     // Text(
                          //     //   'نوع الإعلان : ${listMyAds[index].categoryAds?.name} ' ?? '',
                          //     //   style: openSansRegular.copyWith(
                          //     //       color: darkGreyColor),
                          //     // ),
                          //     Text(
                          //         '${LocaleKeys.currency.tr()} ${widget.listMyAds[widget.index].ads?.price ?? ''}',
                          //         style: openSansRegular.copyWith(
                          //             color: goldColor)),
                          //   ],
                          // ),
                          const Divider(
                            thickness: 1.2,
                          ),
                          widget.listMyAds[widget.index].ads?.categoryAds
                                          ?.id ==
                                      12 ||
                                  widget.listMyAds[widget.index].ads
                                          ?.categoryAds?.id ==
                                      14 ||
                                  widget.listMyAds[widget.index].ads
                                          ?.categoryAds?.id ==
                                      18 ||
                                  widget.listMyAds[widget.index].ads
                                          ?.categoryAds?.id ==
                                      13 ||
                                  widget.listMyAds[widget.index].ads
                                          ?.categoryAds?.id ==
                                      19 ||
                                  widget.listMyAds[widget.index].ads
                                          ?.categoryAds?.id ==
                                      16 ||
                                  widget.listMyAds[widget.index].ads
                                          ?.categoryAds?.id ==
                                      21 ||
                                  widget.listMyAds[widget.index].ads
                                          ?.categoryAds?.id ==
                                      24 ||
                                  widget.listMyAds[widget.index].ads
                                          ?.categoryAds?.id ==
                                      25 ||
                                  widget.listMyAds[widget.index].ads
                                          ?.categoryAds?.id ==
                                      27 ||
                                  widget.listMyAds[widget.index].ads
                                          ?.categoryAds?.id ==
                                      34 ||
                                  widget.listMyAds[widget.index].ads
                                          ?.categoryAds?.id ==
                                      36 ||
                                  widget.listMyAds[widget.index].ads
                                          ?.categoryAds?.id ==
                                      35
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
                                        featureModel: widget
                                            .listMyAds[widget.index]
                                            .ads!
                                            .additionalFeatures!),
                                    Divider(
                                      thickness: 1.2.sp,
                                    ),
                                    SizedBox(
                                      height: Dimensions.PADDING_SIZE_SMALL.sp,
                                    ),
                                  ],
                                )
                              :const SizedBox(),
                          Text(LocaleKeys.specialRealEstateInfo.tr(),
                              style: openSansExtraBold.copyWith(
                                  color: darkGreyColor,fontSize: 18.sp),),
                          GridViewDetails(
                              streetWidth: widget
                                  .listMyAds[widget.index].ads?.streetWidth,
                              planNumber: widget
                                  .listMyAds[widget.index].ads?.planNumber,
                              wellsNumber: widget.listMyAds[widget.index].ads?.wellsNumber
                                  .toString(),
                              usage: widget.listMyAds[widget.index].ads?.usage,
                              treesCount: widget.listMyAds[widget.index].ads
                                  ?.treesAndPalmsNumber
                                  .toString(),
                              services:
                                  widget.listMyAds[widget.index].ads?.services,
                              parking: widget.listMyAds[widget.index].ads?.parkingSpaces == true
                                  ? LocaleKeys.available.tr()
                                  : LocaleKeys.notAvailable.tr(),
                              livingRooms: widget.listMyAds[widget.index].ads
                                  ?.livingRoomsNumber
                                  .toString(),
                              floorCount: widget.listMyAds[widget.index].ads?.floorsNumber
                                  .toString(),
                              desiredPropertySpecifications: widget
                                  .listMyAds[widget.index]
                                  .ads
                                  ?.desiredPropertySpecifications,
                              commercialUnitsNumber: widget
                                  .listMyAds[widget.index]
                                  .ads
                                  ?.commercialUnitsNumber
                                  .toString(),
                              age: widget.listMyAds[widget.index].ads?.age.toString(),
                              additionalRequirements: widget.listMyAds[widget.index].ads?.additionalRequirements,
                              landNo: widget.listMyAds[widget.index].ads?.parcelNumber,
                              purpose: widget.listMyAds[widget.index].ads?.type?.name ?? '',
                              vision: widget.listMyAds[widget.index].ads?.prolongation ?? '',
                              area: widget.listMyAds[widget.index].ads?.space ?? '',
                              bedRoomNo: widget.listMyAds[widget.index].ads?.roomsNumber ?? '',
                              toiletNo: widget.listMyAds[widget.index].ads?.toiletsNumber ?? '',
                              id: widget.listMyAds[widget.index].ads!.categoryAds!.id!),
                          const    SizedBox(
                            height: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          // Divider(
                          //   thickness: 1.2,
                          // ),
                          ///
                          // Text(
                          //   LocaleKeys.features.tr(),
                          //   style: openSansBold.copyWith(color: darkGreyColor),
                          // ),
                          // GridViewDetails(
                          //     area: widget.listMyAds[widget.index].ads?.space ?? '',
                          //     toiletNo: widget.listMyAds[widget.index].ads?.toiletsNumber ?? '',
                          //     bedRoomNo: widget.listMyAds[widget.index].ads?.roomsNumber ?? '',
                          //     purpose: widget.listMyAds[widget.index].ads?.type?.name ?? '',
                          //     vision: widget.listMyAds[widget.index].ads?.prolongation ?? '',
                          //     id: widget.listMyAds[widget.index].ads!.categoryAds!.id!),
                          const  Divider(
                            thickness: 1.2,
                          ),
                          // SizedBox(
                          //   height: Dimensions.PADDING_SIZE_DEFAULT,
                          // ),
                          Text(
                            LocaleKeys.description.tr(),
                            style: openSansExtraBold.copyWith(
                                color: darkGreyColor,fontSize: 18.sp),
                          ),
                          Container(
                            child: Text(
                              widget.listMyAds[widget.index].ads?.notes ?? '',
                              style:
                                  openSansBold.copyWith(color: goldColor),
                            ),
                          ),
                          const  SizedBox(
                            height: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          Divider(
                            thickness: 1.2,
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          Text(
                            LocaleKeys.location.tr(),
                            style: openSansExtraBold.copyWith(
                                color: darkGreyColor,fontSize: 18.sp),
                          ),
                         const SizedBox(
                            height: Dimensions.PADDING_SIZE_DEFAULT,
                          ),

                          RowAddressLocation(
                              city:
                              '${widget.listMyAds[widget.index].ads?.city ?? "لا يمكن تحديد المدينة"}',
                              district:
                              '${widget.listMyAds[widget.index].ads?.district ?? "لا يمكن تحديد الحي"}',
                              region:
                              '${widget.listMyAds[widget.index].ads?.region ?? "لا يمكن تحديد المنطقه"}'),
                          SizedBox(
                            height: Dimensions.PADDING_SIZE_DEFAULT.sp,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (widget.listMyAds[widget.index].ads?.lat ==
                                      null ||
                                  widget.listMyAds[widget.index].ads?.lan ==
                                      null) {
                                showCustomSnackBar(
                                    //  context: context,
                                    message: LocaleKeys.errorOnAdsLocation.tr(),
                                    state: ToastState.ERROR);
                                //showToast(text:LocaleKeys.noLocationTransportation.tr() , state: ToastState.ERROR);
                              } else {
                                if (Platform.isIOS) {
                                  await launchUrl(Uri.parse(
                                      "comgooglemaps://?q=${widget.listMyAds[widget.index].ads?.lat},"
                                      "${widget.listMyAds[widget.index].ads?.lan}&key=AIzaSyCjq0TIsXwDT8RQK2jBajVnHy93eoTt1HU"));
                                } else {
                                  await launchUrl(Uri.parse(
                                      'https://www.google.com/maps/search/?api=1&query='
                                      '${widget.listMyAds[widget.index].ads?.lat}, '
                                      '${widget.listMyAds[widget.index].ads?.lan}'
                                      '&key=AIzaSyCjq0TIsXwDT8RQK2jBajVnHy93eoTt1HU'));
                                }
                              }
                            },
                            child: LocationView(
                              double.parse(
                                  widget.listMyAds[widget.index].ads!.lat!),
                              double.parse(
                                  widget.listMyAds[widget.index].ads!.lan!),
                            ),
                            // CustomTextField(
                            //     controller: TextEditingController(
                            //         text: listMyAds[index].address ?? ''),
                            //     labelText: LocaleKeys.location.tr(),
                            //     isEnabled: false),
                          ),
                        const  SizedBox(
                            height: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          // widget.listMyAds[widget.index].ads?.promoted == true
                          //     ? SizedBox()
                          //     : CustomButton(
                          //   textButton: LocaleKeys.wantFinanceAd.tr(),
                          //   onPressed: () {
                          //     navigateForward(MakeSponsoredAds(
                          //       adId: widget.adId,
                          //     ));
                          //   },
                          //   color: goldColor,
                          // ),
                         const SizedBox(
                            height: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          // accountType == 'service_applicant'
                          //     ? Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Text(
                          //             LocaleKeys.contactWithAdvertiser.tr(),
                          //             style: openSansBold.copyWith(
                          //                 color: darkGreyColor),
                          //           ),
                          //           AdvertiserCard(
                          //             name:
                          //                 listMyAds[index].userAds?.name ?? '',
                          //             image:
                          //                 listMyAds[index].userAds?.photo ?? '',
                          //             phone:
                          //                 listMyAds[index].userAds?.phone ?? '',
                          //           ),
                          //           SizedBox(
                          //             height: Dimensions.PADDING_SIZE_DEFAULT,
                          //           ),
                          //           Text(
                          //             LocaleKeys.similarAds.tr(),
                          //             style: openSansBold.copyWith(
                          //                 color: darkGreyColor),
                          //           ),
                          //           // Container(
                          //           //   child: ListView.separated(
                          //           //     separatorBuilder: (context, index) {
                          //           //       return SizedBox(
                          //           //         height:
                          //           //             Dimensions.PADDING_SIZE_LARGE,
                          //           //       );
                          //           //     },
                          //           //     shrinkWrap: true,
                          //           //     physics: NeverScrollableScrollPhysics(),
                          //           //     itemBuilder: (context, index) {
                          //           //       return SimilarAds(
                          //           //         onTap: () {},
                          //           //         image: Images.SERVICES_MARKTING,
                          //           //         child: Column(
                          //           //           crossAxisAlignment:
                          //           //               CrossAxisAlignment.start,
                          //           //           mainAxisAlignment:
                          //           //               MainAxisAlignment
                          //           //                   .spaceBetween,
                          //           //           children: [
                          //           //             Row(
                          //           //               mainAxisAlignment:
                          //           //                   MainAxisAlignment
                          //           //                       .spaceEvenly,
                          //           //               children: [
                          //           //                 Text('روف',
                          //           //                     style: openSansMedium
                          //           //                         .copyWith(
                          //           //                             color:
                          //           //                                 darkGreyColor)),
                          //           //                 //  Spacer(),
                          //           //                 Text('1.200.350 ريال',
                          //           //                     style: openSansMedium
                          //           //                         .copyWith(
                          //           //                             color:
                          //           //                                 goldColor))
                          //           //               ],
                          //           //             ),
                          //           //             Row(
                          //           //               mainAxisAlignment:
                          //           //                   MainAxisAlignment
                          //           //                       .spaceBetween,
                          //           //               children: [
                          //           //                 Row(
                          //           //                   children: [
                          //           //                     Text(
                          //           //                       '1',
                          //           //                       style: openSansMedium
                          //           //                           .copyWith(
                          //           //                               color:
                          //           //                                   darkGreyColor),
                          //           //                     ),
                          //           //                     SizedBox(
                          //           //                       width: 5.w,
                          //           //                     ),
                          //           //                     SvgPicture.asset(Images
                          //           //                         .LIVING_ROOM_SVG),
                          //           //                   ],
                          //           //                 ),
                          //           //                 // SizedBox(width: 15.w,),
                          //           //                 Row(
                          //           //                   children: [
                          //           //                     Text(
                          //           //                       '2',
                          //           //                       style: openSansMedium
                          //           //                           .copyWith(
                          //           //                               color:
                          //           //                                   darkGreyColor),
                          //           //                     ),
                          //           //                     SizedBox(
                          //           //                       width: 5.w,
                          //           //                     ),
                          //           //                     SvgPicture.asset(
                          //           //                         Images.KITCHEN_SVG),
                          //           //                   ],
                          //           //                 ),
                          //           //                 // SizedBox(width:15.w,),
                          //           //                 Row(
                          //           //                   children: [
                          //           //                     Text(
                          //           //                       '3',
                          //           //                       style: openSansMedium
                          //           //                           .copyWith(
                          //           //                               color:
                          //           //                                   darkGreyColor),
                          //           //                     ),
                          //           //                     SizedBox(
                          //           //                       width: 5.w,
                          //           //                     ),
                          //           //                     SvgPicture.asset(Images
                          //           //                         .BATH_ROOM_SVG),
                          //           //                   ],
                          //           //                 ),
                          //           //                 //  SizedBox(width: 15.w,),
                          //           //                 Row(
                          //           //                   children: [
                          //           //                     Text(
                          //           //                       '3',
                          //           //                       style: openSansMedium
                          //           //                           .copyWith(
                          //           //                               color:
                          //           //                                   darkGreyColor),
                          //           //                     ),
                          //           //                     SizedBox(
                          //           //                       width: 5.w,
                          //           //                     ),
                          //           //                     SvgPicture.asset(Images
                          //           //                         .BED_ROOM_SVG),
                          //           //                   ],
                          //           //                 ),
                          //           //               ],
                          //           //             ),
                          //           //             SizedBox(
                          //           //               height: Dimensions
                          //           //                   .PADDING_SIZE_DEFAULT,
                          //           //             )
                          //           //           ],
                          //           //         ),
                          //           //       );
                          //           //     },
                          //           //     itemCount: 3,
                          //           //   ),
                          //           // ),
                          //           SizedBox(
                          //             height: Dimensions.PADDING_SIZE_DEFAULT,
                          //           ),
                          //         ],
                          //       )
                          //     : SizedBox()
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
//     widget.listMyAds[widget.index].ads?.name ?? '',
//     style: openSansBold.copyWith(color: goldColor),
//   )),
//   leading: Padding(
//     padding: EdgeInsetsDirectional.only(
//         start: Dimensions.PADDING_SIZE_LARGE),
//     child: BackButtonWidget(),
//   ),
//   flexibleSpace: FlexibleSpaceBar(
//     background: ClipRRect(
//       borderRadius: BorderRadius.only(
//         bottomRight: Radius.circular(Dimensions.RADIUS_DEFAULT),
//         bottomLeft: Radius.circular(Dimensions.RADIUS_DEFAULT),
//       ),
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           GestureDetector(
//             onTap: () {
//               navigateForward(FullImageListScreen(
//                   itemCount: widget.listMyAds[widget.index].ads!
//                       .photos!.length,
//                   image: widget.listMyAds[widget.index].ads
//                           ?.photos ??
//                       []));
//             },
//             child: CarouselSlider(
//               options: CarouselOptions(
//                   height: context.height * 0.9,
//                   aspectRatio: 16 / 9,
//                   viewportFraction: 1,
//                   initialPage: 0,
//                   enableInfiniteScroll: true,
//                   reverse: false,
//                   //  autoPlay: true,
//                   autoPlayAnimationDuration:
//                       const Duration(milliseconds: 800),
//                   autoPlayInterval: const Duration(seconds: 3),
//                   enlargeCenterPage: true,
//                   autoPlayCurve: Curves.fastLinearToSlowEaseIn,
//                   scrollDirection: Axis.horizontal,
//                   onPageChanged: (i, reason) {
//                     myAdsCubit.changeIndexCarousel(i);
//                   }),
//               items: widget.listMyAds[widget.index].ads?.photos!
//                   .map((e) {
//                 return Builder(builder: (context) {
//                   return Card(
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                             bottomRight: Radius.circular(
//                                 Dimensions.RADIUS_DEFAULT),
//                             bottomLeft: Radius.circular(
//                                 Dimensions.RADIUS_DEFAULT))),
//                     child: Container(
//                       // margin: EdgeInsets.symmetric(horizontal: Dimensions.RADIUS_SMALL),
//                       width: context.width,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: NetworkImage(e),
//                             fit: BoxFit.cover),
//                         borderRadius: BorderRadius.only(
//                             bottomRight: Radius.circular(
//                                 Dimensions.RADIUS_DEFAULT),
//                             bottomLeft: Radius.circular(
//                                 Dimensions.RADIUS_DEFAULT)
//                             // topRight: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
//                             // topLeft: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
//                             ),
//                       ),
//                       // child: Image.network(e,fit: BoxFit.contain),
//                     ),
//                   );
//                 });
//               }).toList(),
//             ),
//           ),
//           AnimatedSmoothIndicator(
//             activeIndex: myAdsCubit.selectedIndex,
//             count: widget
//                 .listMyAds[widget.index].ads!.photos!.length,
//             effect: WormEffect(
//                 activeDotColor: goldColor,
//                 dotColor: whiteColor,
//                 radius: 20.sp),
//           ),
//         ],
//       ),
//     ),
//   ),
// ),