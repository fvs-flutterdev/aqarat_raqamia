import 'dart:developer';

import 'package:aqarat_raqamia/bloc/bottom_navbar_cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../../../bloc/profile_cubit/cubit.dart';
import '../../../bloc/partner_sponsor_cubit/state.dart';
import '../../../bloc/profile_cubit/state.dart';
import '../../../bloc/send_clicks_cubit/cubit.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/images.dart';
import '../../../utils/media_query_value.dart';
import '../../../utils/text_style.dart';
import '../../../view/base/lunch_widget.dart';
import '../../../view/base/shimmer/ads_shimmer.dart';
import '../../../view/error_widget/error_widget.dart';
import '../../../view/screens/location/ads_on_map.dart';
import '../../../view/screens/nearby_aqar_screen/nearby_aqar_details.dart';
import '../../../view/screens/profile/profile_screen.dart';
import '../../../view/screens/sponsor_partner_screen/widget/container_sponsor_details.dart';
import '../../../view/screens/sponsor_partner_screen/widget/container_sponsor_widget.dart';
import '../../../view/screens/providers/provider_profile/profile_provider_screen.dart';
import '../../../view/screens/sponsor_partner_screen/widget/parnter_widget.dart';
import '../../../bloc/add_real_ads/cubit.dart';
import '../../../bloc/bottom_navbar_cubit/cubit.dart';
import '../../../bloc/partner_sponsor_cubit/cubit.dart';
import '../services/services_screen.dart';

class SponsorPartnerScreen extends StatefulWidget {
  const SponsorPartnerScreen({super.key});

  @override
  State<SponsorPartnerScreen> createState() => _SponsorPartnerScreenState();
}

class _SponsorPartnerScreenState extends State<SponsorPartnerScreen> {
  // late VideoPlayerController _controller;
  //  PartnerSponsorCubit? partnerSponsorCubit;
  //  NavbarCubit? navbarCubit;
  @override
  void initState() {
    super.initState();
    if(mounted){
      if(token==null){
        log('l;dlf;sd');
      }else{
        context.read<ProfileCubit>().getProfileData();
      }

    }
    // partnerSponsorCubit=PartnerSponsorCubit();
    // navbarCubit=NavbarCubit();
    // print('<<<<<<<<<<<<<<<<<<<<<<<<${navbarCubit?.providersItems().first.screen}>>>>>>>>>>>>>>>>>>>>>>>>');
    // _controller = VideoPlayerController.networkUrl(Uri.parse(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'))
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //     _controller.play();
    //     _controller.setLooping(true);
    //   });
  }

  @override
  void dispose() {
    // partnerSponsorCubit?.close();
    // navbarCubit?.providersItems().first.screen!=SponsorPartnerScreen()?partnerSponsorCubit?.videoPlayerController.dispose():null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var addRealAdsCubit = context.read<AddRealAdsCubit>();
    var partnerSponsorCubit = context.read<PartnerSponsorCubit>();
    var profileCubit = context.read<ProfileCubit>();
    var navBarCubit = context.read<NavbarCubit>();

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return BlocBuilder<PartnerSponsorCubit, PartnerSponsorState>(
          builder: (context, state) {
            if (token == null) {
              profileCubit.isGetProfileDate = true;
            }
            if (state is GetPartnerSponsorLoadingState ||
                state is InitialPartnerSponsorState ||
                profileCubit.isGetProfileDate == false) {
              return AdsShimmer();
            } else if (state is GetPartnerSponsorErrorState) {
              return CustomErrorWidget(
                reload: () {
                  partnerSponsorCubit.getPartnerSponsor();
                },
              );
            } else {
              token == null || accountType != 'service_provider'
                  ? debugPrint('')
                  : profileCubit.getServiceList();
              //  partnerSponsorCubit.playVideo();
              return GestureDetector(
                onVerticalDragEnd:
                    (dragEndDetails) {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return DraggableScrollableSheet(
                          maxChildSize: 1,
                          initialChildSize: 0.99,
                          snap: true,
                          // snapSizes: TODO
                          expand: false,
                          builder: (context,
                              scrollController) =>
                              NearbyAqarScreen(id: 2,),
                        );
                      });
                },
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: -20,
                        child: partnerSponsorCubit
                                .partnerSponsorModel.data!.backgroundImage!
                                .endsWith(".mp4")
                            ? partnerSponsorCubit
                                    .videoPlayerController.value.isInitialized
                                ? SizedBox(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: VideoPlayer(
                                        partnerSponsorCubit.videoPlayerController),
                                  )
                                : Container()
                            : SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: FancyShimmerImage(
                                  imageUrl:
                                      //partnerSponsorCubit.partnerSponsorModel.data!.showBackgroundImage==false?'https://dashboard.redd.sa/dash/ad_promoteds/1732749500_company_image.jpg':
                                      partnerSponsorCubit.partnerSponsorModel.data!
                                          .backgroundImage!,
                                  errorWidget:
                                      Image.asset(Images.SPLASH_BACKGROUND),
                                  boxFit: BoxFit.fill,
                                ),
                              ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 18.0.sp,
                          bottom: context.height * 0.07.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            token == null
                                ? const SizedBox()
                                : SafeArea(
                                    child: GestureDetector(
                                      onTap: () =>
                                          accountType == "service_provider"
                                              ? navigateForward(
                                                  ProfileProviderScreen())
                                              : navigateForward(ProfileScreen()),
                                      child: PartnerWidget(
                                        image: profileCubit
                                            .profileModel.userProfile!.photo!,
                                        companyDes: LocaleKeys.client.tr(),
                                        child: Wrap(
                                          children: List.generate(
                                              profileCubit
                                                  .profileModel
                                                  .userProfile!
                                                  .services!
                                                  .length, (index) {
                                            return Text(
                                              '${profileCubit.profileModel.userProfile!.services![index].name!} - ',
                                              style: openSansMedium.copyWith(
                                                  color: whiteColor,
                                                  fontSize: 12.sp),
                                              softWrap: true,
                                              maxLines: 3,
                                            );
                                          }),
                                        ),
                                        companyName: profileCubit
                                            .profileModel.userProfile!.name,
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 90.sp,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          partnerSponsorCubit.partnerSponsorModel
                                                      .data?.showCompanyImage ==
                                                  false
                                              ? SizedBox()
                                              : Container(
                                                  // color: whiteColor,
                                                  margin: EdgeInsets.all(5.sp),
                                                  // constraints: BoxConstraints(
                                                  //   maxWidth: context.width * 0.3.sp,
                                                  //   maxHeight: context.height * 0.05.sp,
                                                  //   m
                                                  // ),
                                                  width: context.width * 0.3.sp,
                                                  height:
                                                      context.height * 0.05.sp,
                                                  child: FancyShimmerImage(
                                                    imageUrl: partnerSponsorCubit
                                                        .partnerSponsorModel
                                                        .data!
                                                        .companyImage!,
                                                    //  boxFit: BoxFit.fill,
                                                    errorWidget: Image.asset(
                                                      Images.SMALL_LOGO_ICON,
                                                    ),
                                                  ),
                                                ),
                                          partnerSponsorCubit
                                                      .partnerSponsorModel
                                                      .data
                                                      ?.showCompanyDescription ==
                                                  false
                                              ? SizedBox()
                                              : ContainerSponsorDetails(
                                                  text: partnerSponsorCubit
                                                          .partnerSponsorModel
                                                          .data
                                                          ?.companyDescription ??
                                                      '',
                                                  onTap: () {
                                                    context
                                                        .read<SendClicksCubit>()
                                                        .sendClickSponsorAds(
                                                            id: partnerSponsorCubit
                                                                .partnerSponsorModel
                                                                .data!
                                                                .id!);
                                                    launchUrl(Uri.parse(
                                                        partnerSponsorCubit
                                                            .partnerSponsorModel
                                                            .data!
                                                            .companyUrl!));
                                                  },
                                                ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          partnerSponsorCubit.partnerSponsorModel
                                                      .data?.showPosterImage ==
                                                  false
                                              ? SizedBox()
                                              : Container(
                                                  // color: whiteColor,
                                                  margin: EdgeInsets.all(5.sp),
                                                  // constraints: BoxConstraints(
                                                  //   maxWidth: context.width * 0.3.sp,
                                                  //   maxHeight: context.height * 0.05.sp,
                                                  //   m
                                                  // ),
                                                  width: context.width * 0.3.sp,
                                                  height:
                                                      context.height * 0.05.sp,
                                                  child: FancyShimmerImage(
                                                    imageUrl: partnerSponsorCubit
                                                        .partnerSponsorModel
                                                        .data!
                                                        .posterImage!,
                                                    //  boxFit: BoxFit.fill,
                                                    errorWidget: Image.asset(
                                                      Images.SMALL_LOGO_ICON,
                                                    ),
                                                  ),
                                                ),
                                          partnerSponsorCubit
                                                      .partnerSponsorModel
                                                      .data
                                                      ?.showPosterDescription ==
                                                  false
                                              ? SizedBox()
                                              : ContainerSponsorDetails(
                                                  text: partnerSponsorCubit
                                                          .partnerSponsorModel
                                                          .data
                                                          ?.namePoster ??
                                                      '',
                                                  onTap: () {
                                                    context
                                                        .read<SendClicksCubit>()
                                                        .sendClickSponsorAds(
                                                            id: partnerSponsorCubit
                                                                .partnerSponsorModel
                                                                .data!
                                                                .id!);
                                                    launchUrl(Uri.parse(
                                                        partnerSponsorCubit
                                                            .partnerSponsorModel
                                                            .data!
                                                            .companyUrl!));
                                                  },
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 50.sp,
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //
                                //
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 20.sp,
                                // ),
                                // accountType == 'service_provider'
                                //     ? SizedBox()
                                //     :
                                ContainerSponsorWidget(
                                        text: LocaleKeys.searchForEstate.tr(),
                                        onTap: () {
                                          addRealAdsCubit
                                              .returnAdsTypeToDefault();
                                          addRealAdsCubit
                                              .returnPurposeStateToDefault();
                                          isSearchMode = true;
                                          navigateForward(NearbyAqarScreen(
                                            id: 0,
                                            autoFocus: true,
                                          ));
                                          // navigateForward(FilterScreen(
                                          //   id: 1,
                                          // )
                                          // );
                                          //  navigateForward(MainScreenNavigation(i: context.read<NavbarCubit>().index=1));
                                        }),
                                // accountType == 'service_provider'
                                //     ? const SizedBox()
                                //     :
                                Row(
                                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              navBarCubit.controller.jumpToTab(2);
                                              //  navBarCubit.clientItems(2).;``
                                              //  navBarCubit.changeCurrentIndex(2);
                                              //  navBarCubit.selectedIndex==2;
                                              // navigateForward(ServicesScreen());
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(5.sp),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.sp),
                                              height: 50.sp,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.sp),
                                                color:
                                                    blackColor.withOpacity(0.2),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                LocaleKeys.requestProvider.tr(),
                                                style: openSansMedium.copyWith(
                                                    color: whiteColor),
                                              )),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              navigateForward(AdsOnMap());
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(5.sp),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.sp),
                                              height: 50.sp,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.sp),
                                                color:
                                                    blackColor.withOpacity(0.2),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                LocaleKeys.searchOnMap.tr(),
                                                style: openSansMedium.copyWith(
                                                    color: whiteColor),
                                              )),
                                            ),
                                          ),
                                          // Container(
                                          //   margin: EdgeInsets.all(5.sp),
                                          //   padding: EdgeInsets.symmetric(horizontal: 5.sp),
                                          //   height: 50.sp,
                                          //   decoration: BoxDecoration(
                                          //     borderRadius: BorderRadius.circular(10.sp),
                                          //     color: blackColor.withOpacity(0.2),
                                          //   ),
                                          //   child: Center(
                                          //       child: Text(
                                          //     'أطلب مزود خدمة',
                                          //     style: openSansMedium.copyWith(color: whiteColor),
                                          //   )),
                                          // ),
                                        ],
                                      ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
