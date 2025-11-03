import 'dart:io';
import 'package:aqarat_raqamia/view/base/adaptive_dialog_loader.dart';
import 'package:aqarat_raqamia/view/base/riyal_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../utils/media_query_value.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../bloc/my_ads_cubit/cubit.dart';
import '../../../bloc/my_ads_cubit/state.dart';
import '../../../bloc/upload_request_cubit/cubit.dart';
import '../../../model/dynamic_model/my_ads_model.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/dimention.dart';
import '../../../utils/images.dart';
import '../../../utils/text_style.dart';
import '../../base/back_button.dart';
import '../../base/full_screen_image/full_screen_image.dart';
import '../../base/lunch_widget.dart';
import '../../base/main_button.dart';
import '../../base/row_address_widget.dart';
import '../../base/show_toast.dart';
import '../details_screen/widget/grid_view_details.dart';
import '../details_screen/widget/sliver_app_bar.dart';
import '../location/map_string.dart';
import '../location/utility.dart';
import '../real_state_Ads/make_ads_spons.dart';
import 'edit_my_ad_info.dart';
import 'edit_my_ads_images.dart';
import 'widget/visability_widget.dart';

//ignore: must_be_immutable
class MyAdsDetailsScreen extends StatefulWidget {
  int adId;
  int index;
  int categoryId;
  List<MyAdsData> listMyAds;

  MyAdsDetailsScreen({super.key,
    required this.adId,
    required this.index,
    required this.categoryId,
    required this.listMyAds});

  @override
  State<MyAdsDetailsScreen> createState() => _MyAdsDetailsScreenState();
}

class _MyAdsDetailsScreenState extends State<MyAdsDetailsScreen> {
  CarouselSliderController carouselController = CarouselSliderController();

  @override
  void initState() {
    LocationHelper.generateLocationPreviewImage(
        latitude: double.parse(widget.listMyAds[widget.index].lat ?? "0.0"),
        longitude: double.parse(widget.listMyAds[widget.index].lan ?? "0.0"));
    super.initState();
  }

  // var pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var myAdsCubit = context.read<MyAdsCubit>();
    context
        .read<UploadRequestCubit>()
        .adId = widget.adId;
    print('//////////////////${context
        .read<UploadRequestCubit>()
        .adId}');
    return Scaffold(
      body: BlocConsumer<MyAdsCubit, MyAdsState>(
        listener: (context, state) {
          if (state is DeleteMyAdsLoadingState) {
            adaptiveDialogLoader(context: context);
          } else if (state is DeleteMyAdsErrorState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: CustomScrollView(
              slivers: [
                SliverAppBarWidget(
                  isSameAd: true,
                  name: widget.listMyAds[widget.index].name ?? '',
                  activeIndex: myAdsCubit.selectedIndex,
                  carouselController: carouselController,
                  carouselFunction: (i, reason) {
                    myAdsCubit.changeIndexCarousel(i);
                  },
                  images: widget.listMyAds[widget.index].photos ?? [],
                  //   mainImage: widget.listMyAds[widget.index].image,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Center(
                              //     child: Text(
                              //   widget.listMyAds[widget.index].name ?? '',
                              //   style: openSansExtraBold.copyWith(
                              //       color: darkGreysColor),
                              // )),
                              Center(child: AutoSizeText(
                                '${widget.listMyAds[widget.index].name ?? ''}',
                                style: openSansExtraBold.copyWith(
                                  color: goldColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                                presetFontSizes: [18.sp, 13.sp, 10.sp],
                                maxLines: 1,
                                softWrap: true,),),
                              // Center(
                              //   child: AutoSizeText.rich(
                              //     TextSpan(
                              //         text: "${LocaleKeys.adTitle.tr()} : ",
                              //         style: openSansBold.copyWith(
                              //             color: darkGreyColor),
                              //         children: [
                              //           TextSpan(
                              //               text:
                              //                   '${widget.listMyAds[widget.index].name ?? ''}',
                              //               style: openSansExtraBold.copyWith(
                              //                 color: goldColor,
                              //               ))
                              //         ]),
                              //     overflow: TextOverflow.ellipsis,
                              //     presetFontSizes: [18.sp, 13.sp, 10.sp],
                              //     maxLines: 1,
                              //     softWrap: true,
                              //   ),
                              // ),
                              // Center(
                              //   child: AutoSizeText.rich(
                              //     overflow: TextOverflow.ellipsis,
                              //     presetFontSizes: [18.sp, 13.sp, 10.sp],
                              //     maxLines: 1,
                              //     softWrap: true,
                              //     TextSpan(
                              //         text: "${LocaleKeys.price.tr()} : ",
                              //         style: openSansBold.copyWith(
                              //           color: darkGreyColor,
                              //         ),
                              //         children: [
                              //           TextSpan(
                              //               text:
                              //               '${LocaleKeys.currency
                              //                   .tr()} ${widget.listMyAds[widget
                              //                   .index].price ?? ''}',
                              //               style: openSansExtraBold.copyWith(
                              //                 color: goldColor,
                              //               ))
                              //         ]),
                              //   ),
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                AutoSizeText(
                                  widget.listMyAds[widget.index].price ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  presetFontSizes: [18.sp, 13.sp, 10.sp],
                                  style: openSansBold.copyWith(
                                    color: goldColor,
                                  ),
                                  maxLines: 1,
                                  softWrap: true,),
                                  SizedBox(width: context.width*0.005.w,),
                                  riyalWidget(context),
                              ],),
                              // SizedBox(
                              //   height: Dimensions.PADDING_SIZE_LARGE,
                              // ),
                              RichText(
                                  text: TextSpan(
                                      text: "${LocaleKeys.adsNo.tr()}",
                                      style: openSansBold.copyWith(
                                          color: darkGreyColor),
                                      children: [
                                        TextSpan(
                                          text: widget.listMyAds[widget.index]
                                              .id
                                              .toString(),
                                          style: openSansBold.copyWith(
                                              color: goldColor),
                                        )
                                      ])),
                              RichText(
                                  text: TextSpan(
                                      text: "${LocaleKeys.purpose.tr()} : ",
                                      style: openSansBold.copyWith(
                                          color: darkGreyColor),
                                      children: [
                                        TextSpan(
                                          text: widget.listMyAds[widget.index]
                                              .type
                                              ?.name ??
                                              '',
                                          style: openSansBold.copyWith(
                                              color: goldColor),
                                        )
                                      ])),
                              RichText(
                                text: TextSpan(
                                  text: LocaleKeys.estateType.tr(),
                                  style: openSansBold.copyWith(
                                      color: darkGreyColor),
                                  children: [
                                    TextSpan(
                                        text: widget.listMyAds[widget.index]
                                            .categoryAds?.name,
                                        style: openSansBold.copyWith(
                                            color: goldColor))
                                  ],
                                ),
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: LocaleKeys.adCreated.tr(),
                                      style: openSansBold.copyWith(
                                          color: darkGreyColor),
                                      children: [
                                        TextSpan(
                                          text: widget.listMyAds[widget.index]
                                              .createDates?.createdAtHuman ??
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
                                          text: widget.listMyAds[widget.index]
                                              .updateDates?.updatedAtHuman ??
                                              '',
                                          style: openSansBold.copyWith(
                                              color: goldColor),
                                        )
                                      ])),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         Text(
                              //           widget.listMyAds[widget.index]
                              //                   .createDates?.createdAtHuman ??
                              //               '',
                              //           style: openSansRegular.copyWith(
                              //             color: darkGreyColor,
                              //           ),
                              //         ),
                              //         RichText(
                              //             text: TextSpan(
                              //                 text: LocaleKeys.adsNo.tr(),
                              //                 style: openSansMedium.copyWith(
                              //                     color: darkGreyColor),
                              //                 children: [
                              //               TextSpan(
                              //                   text: widget
                              //                       .listMyAds[widget.index].id
                              //                       .toString(),
                              //                   style: openSansRegular.copyWith(
                              //                       color: darkGreyColor))
                              //             ])),
                              //       ],
                              //     ),
                              //
                              //     //  RowWidgetForDetails()
                              //   ],
                              // ),
                              const SizedBox(
                                height: Dimensions.PADDING_SIZE_DEFAULT,
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     RichText(
                              //       text: TextSpan(
                              //         text: LocaleKeys.estateType.tr(),
                              //         style: openSansMedium.copyWith(
                              //             color: darkGreyColor),
                              //         children: [
                              //           TextSpan(
                              //               text: widget.listMyAds[widget.index]
                              //                   .categoryAds?.name,
                              //               style: openSansRegular.copyWith(
                              //                   color: darkGreyColor))
                              //         ],
                              //       ),
                              //     ),
                              //     // Text(
                              //     //   'نوع الإعلان : ${listMyAds[index].categoryAds?.name} ' ?? '',
                              //     //   style: openSansRegular.copyWith(
                              //     //       color: darkGreyColor),
                              //     // ),
                              //     Text(
                              //         '${LocaleKeys.currency.tr()} ${widget.listMyAds[widget.index].price ?? ''}',
                              //         style: openSansRegular.copyWith(
                              //             color: goldColor)),
                              //   ],
                              // ),
                              Divider(
                                thickness: 1.2.sp,
                              ),
                              widget.categoryId == 12 ||
                                  widget.categoryId == 14 ||
                                  widget.categoryId == 18 ||
                                  widget.categoryId == 13 ||
                                  widget.categoryId == 19 ||
                                  widget.categoryId == 16 ||
                                  widget.categoryId == 21 ||
                                  widget.categoryId == 24 ||
                                  widget.categoryId == 25 ||
                                  widget.categoryId == 27 ||
                                  widget.categoryId == 34 ||
                                  widget.categoryId == 36 ||
                                  widget.categoryId == 35
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
                                      featureModel: widget
                                          .listMyAds[widget.index]
                                          .additionalFeatures!),
                                  Divider(
                                    thickness: 1.2.sp,
                                  ),
                                  SizedBox(
                                    height:
                                    Dimensions.PADDING_SIZE_SMALL.sp,
                                  ),
                                ],
                              )
                                  : const SizedBox(),

                              Text(LocaleKeys.specialRealEstateInfo.tr(),
                                  style: openSansExtraBold.copyWith(
                                      color: darkGreyColor, fontSize: 18.sp)),
                              GridViewDetails(
                                area:
                                widget.listMyAds[widget.index].space ?? '',
                                additionalRequirements: widget
                                    .listMyAds[widget.index]
                                    .additionalRequirements,
                                age: widget.listMyAds[widget.index].age
                                    .toString(),
                                commercialUnitsNumber: widget
                                    .listMyAds[widget.index]
                                    .commercialUnitsNumber
                                    .toString(),
                                desiredPropertySpecifications: widget
                                    .listMyAds[widget.index]
                                    .desiredPropertySpecifications,
                                floorCount: widget
                                    .listMyAds[widget.index].floorsNumber
                                    .toString(),
                                livingRooms: widget
                                    .listMyAds[widget.index].livingRoomsNumber
                                    .toString(),
                                parking: widget.listMyAds[widget.index]
                                    .parkingSpaces ==
                                    true
                                    ? LocaleKeys.available.tr()
                                    : LocaleKeys.notAvailable.tr(),
                                services:
                                widget.listMyAds[widget.index].services,
                                treesCount: widget
                                    .listMyAds[widget.index].treesAndPalmsNumber
                                    .toString(),
                                usage: widget.listMyAds[widget.index].usage,
                                wellsNumber: widget
                                    .listMyAds[widget.index].wellsNumber
                                    .toString(),
                                toiletNo: widget.listMyAds[widget.index]
                                    .toiletsNumber ??
                                    '',
                                bedRoomNo: widget
                                    .listMyAds[widget.index].roomsNumber ??
                                    '',
                                purpose:
                                widget.listMyAds[widget.index].type?.name ??
                                    '',
                                vision: widget
                                    .listMyAds[widget.index].prolongation ??
                                    '',
                                id: widget
                                    .listMyAds[widget.index].categoryAds!.id!,
                                landNo:
                                widget.listMyAds[widget.index].parcelNumber,
                                planNumber:
                                widget.listMyAds[widget.index].planNumber,
                                streetWidth:
                                widget.listMyAds[widget.index].streetWidth,
                              ),
                              Divider(
                                thickness: 1.2.sp,
                              ),
                              Text(
                                LocaleKeys.description.tr(),
                                style: openSansExtraBold.copyWith(
                                    color: darkGreyColor, fontSize: 18.sp),
                              ),
                              Container(
                                child: Text(
                                  widget.listMyAds[widget.index].notes ?? '',
                                  style: openSansBold.copyWith(
                                      color: goldColor),
                                ),
                              ),
                              // SizedBox(
                              //   height: Dimensions.PADDING_SIZE_DEFAULT,
                              // ),
                              Divider(
                                thickness: 1.2.sp,
                              ),
                              Text(
                                LocaleKeys.location.tr(),
                                style: openSansExtraBold.copyWith(
                                    color: darkGreyColor,
                                    fontSize: 18.sp),
                              ),
                              SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_SMALL.sp,
                              ),
                              RowAddressLocation(
                                  city:
                                  '${widget.listMyAds[widget.index].city ??
                                      "لا يمكن تحديد المدينة"}',
                                  district:
                                  '${widget.listMyAds[widget.index].district ??
                                      "لا يمكن تحديد الحي"}',
                                  region:
                                  '${widget.listMyAds[widget.index].region ??
                                      "لا يمكن تحديد المنطقه"}'),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     AutoSizeText.rich(
                              //       TextSpan(
                              //         text: '${LocaleKeys.region.tr()} : ',
                              //         children: [
                              //           TextSpan(
                              //             text:
                              //                 '${widget.listMyAds[widget.index].region}',
                              //             style: openSansRegular.copyWith(
                              //                 color: goldColor),
                              //           )
                              //         ],
                              //         style: openSansBold.copyWith(
                              //             color: darkGreyColor),
                              //       ),
                              //       presetFontSizes: [11.sp, 9.sp, 7.sp],
                              //     ),
                              //     AutoSizeText.rich(
                              //       TextSpan(
                              //         text: '${LocaleKeys.city.tr()} : ',
                              //         children: [
                              //           TextSpan(
                              //             text:
                              //                 '${widget.listMyAds[widget.index].city}',
                              //             style: openSansRegular.copyWith(
                              //                 color: goldColor),
                              //           )
                              //         ],
                              //         style: openSansBold.copyWith(
                              //             color: darkGreyColor),
                              //       ),
                              //       presetFontSizes: [11.sp, 9.sp, 7.sp],
                              //     ),
                              //
                              //     AutoSizeText.rich(
                              //       TextSpan(
                              //         text: '${LocaleKeys.district.tr()} : ',
                              //         children: [
                              //           TextSpan(
                              //             text:
                              //                 '${widget.listMyAds[widget.index].district}',
                              //             style: openSansRegular.copyWith(
                              //                 color: goldColor),
                              //           )
                              //         ],
                              //         style: openSansBold.copyWith(
                              //             color: darkGreyColor),
                              //       ),
                              //       presetFontSizes: [11.sp, 9.sp, 7.sp],
                              //     ),
                              //     // AutoSizeText('المدينه : ${widget.listMyAds[widget.index].city}',presetFontSizes: [11.sp,9.sp,7.sp],style: openSansRegular.copyWith(color: darkGreyColor)),
                              //     // AutoSizeText('الحي : ${widget.listMyAds[widget.index].district}',presetFontSizes: [11.sp,9.sp,7.sp],style: openSansRegular.copyWith(color: darkGreyColor)),
                              //   ],
                              // ),
                              SizedBox(
                                height: Dimensions.PADDING_SIZE_DEFAULT.sp,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (widget.listMyAds[widget.index].lat ==
                                      null ||
                                      widget.listMyAds[widget.index].lan ==
                                          null) {
                                    showCustomSnackBar(
                                      //  context: context,
                                        message:
                                        LocaleKeys.errorOnAdsLocation.tr(),
                                        state: ToastState.ERROR);
                                    //showToast(text:LocaleKeys.noLocationTransportation.tr() , state: ToastState.ERROR);
                                  } else {
                                    if (Platform.isIOS) {
                                      await launchUrl(Uri.parse(
                                          "comgooglemaps://?q=${widget
                                              .listMyAds[widget.index].lat},"
                                              "${widget.listMyAds[widget.index]
                                              .lan}&key=$GOOGLE_API_KEY"));
                                    } else {
                                      await launchUrl(Uri.parse(
                                          'https://www.google.com/maps/search/?api=1&query='
                                              '${widget.listMyAds[widget.index]
                                              .lat}, '
                                              '${widget.listMyAds[widget.index]
                                              .lan}'
                                              '&key=$GOOGLE_API_KEY'));
                                    }
                                  }
                                },
                                child: LocationView(
                                    double.parse(
                                        widget.listMyAds[widget.index].lat ??
                                            '21.5574931'),
                                    double.parse(
                                        widget.listMyAds[widget.index].lan ??
                                            '39.1775043')),
                                // CustomTextField(
                                //     controller: TextEditingController(
                                //         text: listMyAds[index].address ?? ''),
                                //     labelText: LocaleKeys.location.tr(),
                                //     isEnabled: false),
                              ),
                              const SizedBox(
                                height: Dimensions.PADDING_SIZE_DEFAULT,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                    bottom: context.height * 0.02,
                                    top: Dimensions.PADDING_SIZE_DEFAULT),
                                child: CustomButton(
                                    textButton: LocaleKeys.delete.tr(),
                                    color: redColor,
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                LocaleKeys.deleteAd.tr(),
                                                style: openSansExtraBold
                                                    .copyWith(color: redColor),
                                              ),
                                              content: Text(
                                                '${LocaleKeys.areYouSureDeleteAd
                                                    .tr()}${widget.adId}',
                                                style: openSansBold.copyWith(
                                                    color: darkGreyColor),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    myAdsCubit.deleteAd(
                                                        adId: widget.adId);
                                                  },
                                                  child: Text(
                                                    LocaleKeys.yesDelete.tr(),
                                                    style:
                                                    openSansMedium.copyWith(
                                                        color: redColor),
                                                  ),
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                        LocaleKeys.noThanks
                                                            .tr(),
                                                        style: openSansMedium)),
                                              ],
                                            );
                                          });
                                      //   myAdsCubit.deleteAd(adId:  widget.adId);
                                      // navigateForward(
                                      //     EditMyAdInfoDetailsScreen(adId: widget.adId,));
                                    }),
                              ),
                              widget.listMyAds[widget.index].promoted == true
                                  ? const SizedBox()
                                  : CustomButton(
                                textButton: LocaleKeys.wantFinanceAd.tr(),
                                onPressed: () {
                                  navigateForward(MakeSponsoredAds(
                                    adId: widget.adId,
                                  ));
                                },
                                color: goldColor,
                              ),
                              // const SizedBox(
                              //   height: Dimensions.PADDING_SIZE_DEFAULT,
                              // ),

                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                    bottom: context.height * 0.05,
                                    top: Dimensions.PADDING_SIZE_DEFAULT),
                                child: CustomButton(
                                    textButton: LocaleKeys.edit.tr(),
                                    color: goldColor,
                                    onPressed: () {
                                      navigateForward(EditMyAdInfoDetailsScreen(
                                        adId: widget.adId,
                                      ));
                                    }),
                              )
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
                      ),
                    ],
                  ),
                ),
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
//   toolbarHeight: context.height*0.12.sp,
//   pinned: true,
//   floating: true,
//   centerTitle: true,
//   snap: true,
//   title: SABT(
//       child: Text(
//     widget.listMyAds[widget.index].name ?? '',
//     style: openSansBold.copyWith(color: goldColor),
//   )),
//
//   leading: Padding(
//     padding: EdgeInsetsDirectional.only(
//         start: Dimensions.PADDING_SIZE_LARGE),
//     child: BackButtonWidget(),
//   ),
//
//   flexibleSpace: FlexibleSpaceBar(
//     background: ClipRRect(
//       borderRadius: BorderRadius.only(
//         bottomRight:
//             Radius.circular(Dimensions.RADIUS_DEFAULT),
//         bottomLeft:
//             Radius.circular(Dimensions.RADIUS_DEFAULT),
//       ),
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           GestureDetector(
//             onTap: () {
//               navigateForward(FullImageListScreen(
//                   itemCount: widget
//                       .listMyAds[widget.index].photos!.length,
//                   image:
//                       widget.listMyAds[widget.index].photos ??
//                           []));
//             },
//             child: CarouselSlider(
//               carouselController: carouselController,
//               options: CarouselOptions(
//                   height: context.height * 0.9.sp,
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
//               items: widget.listMyAds[widget.index].photos!
//                   .map((e) {
//                 return Builder(builder: (context) {
//                   return Card(
//                     margin: EdgeInsetsDirectional.zero,
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                             bottomRight: Radius.circular(
//                                 Dimensions.RADIUS_DEFAULT),
//                             bottomLeft: Radius.circular(
//                                 Dimensions
//                                     .RADIUS_DEFAULT))),
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
//                             ),
//                       ),
//                       // child: Image.network(e,fit: BoxFit.contain),
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
//             activeIndex: myAdsCubit.selectedIndex,
//             count:
//                 widget.listMyAds[widget.index].photos!.length,
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
//           ),
//           GestureDetector(
//             onTap: () {
//               navigateForward(EditMyAdsImagesScreen(
//                 adId: context.read<UploadRequestCubit>().adId!,
//                 photos: widget.listMyAds[widget.index].photos!,
//               ));
//             },
//             child: Padding(
//               padding: EdgeInsetsDirectional.all(8.0.sp),
//               child: Align(
//                 alignment: AlignmentDirectional.bottomEnd,
//                 child: Container(
//                   padding: EdgeInsets.zero,
//                   child:
//                       SvgPicture.asset(Images.edit_images_svg),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     ),
//   ),
// ),
