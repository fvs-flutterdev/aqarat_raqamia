import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:upgrader/upgrader.dart';

import '../../../bloc/auth_cubit/auth_client/cubit.dart';
import '../../../bloc/bottom_navbar_cubit/cubit.dart';
import '../../../bloc/bottom_navbar_cubit/state.dart';
import '../../../bloc/profile_cubit/cubit.dart';
import '../../../bloc/profile_cubit/state.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/deep_link/uni_services.dart';
import '../../base/bottom_sheet.dart';

class MainScreenNavigation extends StatefulWidget {
  // int? i;

  MainScreenNavigation({super.key});

  @override
  State<MainScreenNavigation> createState() => _MainScreenNavigationState();
}

class _MainScreenNavigationState extends State<MainScreenNavigation> {
  // NavbarCubit? navbarCubit;
  // PartnerSponsorCubit? partnerSponsorCubit;

  @override
  void initState() {
    if (token != null) {
      context.read<ClientAuthCubit>().sendFcmToken();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await UniServices().init();
    });
    context.read<NavbarCubit>().controller =
        PersistentTabController(initialIndex: 0);
    FocusManager.instance.primaryFocus!.unfocus();

    super.initState();
  }

  isBottomSheetOpen() {
    print('///////////////$bottomSheetController//////////////');
    if (bottomSheetController != null) {
      bottomSheetController?.close;
      bottomSheetController = null;
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    bottomSheetController?.close;
    super.dispose();
    UniServices().dispose();
  }

  @override
  void deactivate() {
    context.read<NavbarCubit>().controller;
    super.deactivate();
  }

  // final GlobalKey<NavigatorState> myKey = GlobalKey();
  // final GlobalKey<NavigatorState> myKey1 = GlobalKey();
  // final GlobalKey<PersistentTabViewScaffoldState> myKey1 = GlobalKey();
  // final GlobalKey<PersistentTabViewScaffoldState> myKey2 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var navBarCubit = context.read<NavbarCubit>();
    //  var partnerSponsorCubit = context.read<PartnerSponsorCubit>();
    //  navBarCubit.makeFloatingFalse();

    return Scaffold(
      //  key: ValueKey('Test'),

      body: UpgradeAlert(
        upgrader: Upgrader(
            // languageCode: myLocale.toString(),
            // debugDisplayAlways: true,
            // storeController: UpgraderStoreController(
            //   onAndroid: () => UpgraderPlayStore(),
            // ),
            // debugLogging: true,
            // minAppVersion: "1.0.0+1",
            ),
        child: BlocConsumer<NavbarCubit, BottomNavbarState>(
          listener: (context, state) {
            // if(navBarCubit.providersItems().first.screen!=SponsorPartnerScreen()){
            //   partnerSponsorCubit.videoPlayerController.dispose();
            // }

            //  ?:null;
          },
          builder: (context, state) {
            return BlocListener<ProfileCubit, ProfileState>(
              listener: (context, state) {},
              child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                    //  navBarCubit.makeFloatingFalse();
                  },
                  child: PersistentTabView(
                    //  key: ValueKey('ssss'),
                    controller: navBarCubit.controller,
                    gestureNavigationEnabled: true,

                    //   navBarOverlap: ,
                    onTabChanged: (index) {
                      print(
                          '/////////////////////////////$index ##################');
                      navBarCubit.changeCurrentIndex(index);
                      isBottomSheetOpen();
                      // if (index == 0) {
                      //   partnerSponsorCubit.playVideo();
                      //   //  partnerSponsorCubit.getPartnerSponsor();
                      //   // partnerSponsorCubit.videoPlayerController =
                      //   //     VideoPlayerController.networkUrl(Uri.parse(
                      //   //         //   partnerSponsorModel.data?.backgroundImage??
                      //   //         'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
                      //   //       ..initialize().then((_) {
                      //   //         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                      //   //         //  emit(PlayVideoSponsorSuccessState());
                      //   //         partnerSponsorCubit.videoPlayerController
                      //   //             .play();
                      //   //         partnerSponsorCubit.videoPlayerController
                      //   //             .setLooping(true);
                      //   //       });
                      // } else {
                      //   partnerSponsorCubit.videoPlayerController.dispose();
                      // }
                    },

                    tabs: accountType == 'service_provider'
                        ? navBarCubit.providersItems()
                        : navBarCubit.clientItems(),
                    // tabs:
                    // accountType == 'service_provider' ?
                    // navBarCubit.clientItems()
                    //     : navBarCubit.providersItems(),
                    margin: EdgeInsets.only(top: 0),
                    navBarBuilder: (NavBarConfig) {
                      // if (accountType == 'service_provider') {
                      //   return Style4BottomNavBar(
                      //     navBarConfig: NavBarConfig,
                      //   );
                      // } else {
                      return Style13BottomNavBar(
                        //   navBarDecoration: NavBarDecoration(padding: EdgeInsets.zero),
                        //   key: _navKey2,
                        // navBarDecoration: NavBarDecoration(),
                        navBarConfig: NavBarConfig,
                      );
                      // }
                    },
                  )),
            );
          },
        ),
      ),
    );
  }
}

// child: Scaffold(
//   //   key: key,
//   body:
//       //isProviderSubscribed==false
//       //  isProviderSubscribed == false&&accountType=='service_provider'
//       //    CacheHelper.getData(key: 'isSubscribed') == false&&CacheHelper.getData(key: 'status')=='service_provider'
//       //      ? PackagesScreen()
//       //         :
//       GestureDetector(
//     onTap: () {
//       FocusManager.instance.primaryFocus!.unfocus();
//       navBarCubit.makeFloatingFalse();
//     },
//     child: Stack(
//       children: [
//         accountType == 'service_provider'
//             ? navBarCubit.providerScreens[navBarCubit.selectedIndex]
//             : navBarCubit.screens[navBarCubit.selectedIndex],
//         navBarCubit.changeFloatingStatus
//             ? Padding(
//                 padding: EdgeInsetsDirectional.only(bottom: 35.sp),
//                 child: smallButtonSheet(context),
//               )
//             : const SizedBox(),
//       ],
//     ),
//   ),
//   floatingActionButtonLocation: token == null
//       ? null
//       : accountType == 'service_provider'
//           ? null
//           : FloatingActionButtonLocation.centerDocked,
//   floatingActionButton: accountType == 'service_provider'
//       ? SizedBox()
//       : token == null
//           ? SizedBox()
//           : FloatingActionButton(
//     elevation: 3,
//
//               backgroundColor: whiteColor,
//               child: SvgPicture.asset(navBarCubit.selectedIndex ==2
//                       ? Images.Selected_Services_svg
//                       : Images.Unselected_Services_svg),
//               // child: SvgPicture.asset(navBarCubit.changeFloatingStatus
//               //     ? Images.REMOVE_SVG
//               //     : Images.FLOATING_SVG),
//               onPressed: () {
//                  navBarCubit.changeCurrentIndex(2);
//                //  navBarCubit.makeFloatingFalse();
//
//
//               //  navBarCubit.changeCurrentFloatingStatus();
//               },
//             ),
//
//   bottomNavigationBar:
//       //  CacheHelper.getData(key: 'isSubscribed') == false&&CacheHelper.getData(key: 'status')=='service_provider'
//       //       ? SizedBox()
//       //       :
//       BottomNavigationBar(
//     selectedLabelStyle: openSansBold,
//     unselectedLabelStyle:
//         openSansRegular.copyWith(color: lightDarkMain),
//
//     type: BottomNavigationBarType.fixed,
//     currentIndex: navBarCubit.selectedIndex,
//     unselectedItemColor: lightDarkMain,
//     showUnselectedLabels: true,
//     selectedItemColor: darkGreyColor,
//     onTap: (i) {
//       // if(navBarCubit.selectedIndex==2){
//       //   print('object');
//       // }else{
//         navBarCubit.changeCurrentIndex(i);
//         navBarCubit.makeFloatingFalse();
//     //  }
//
//     },
//     items: accountType == 'service_provider'
//         ? [
//             BottomNavigationBarItem(
//                 icon: SvgPicture.asset(navBarCubit.selectedIndex == 0
//                     ? Images.SELECTED_HOME_SVG
//                     : Images.UNSELECTED_HOME_SVG),
//                 label: LocaleKeys.homeScreen.tr()),
//             BottomNavigationBarItem(
//                 icon: SvgPicture.asset(navBarCubit.selectedIndex == 1
//                     ? Images.SELECTED_MY_ADS
//                     : Images.UNSELECTED_MY_ADS),
//                 label: LocaleKeys.myAds.tr()),
//             BottomNavigationBarItem(
//                 icon: SvgPicture.asset(navBarCubit.selectedIndex == 2
//                     ? Images.SELECTED_ORDERS_SVG
//                     : Images.UNSELECTED_ORDERS_SVG),
//                 label: LocaleKeys.myOrders.tr()),
//             BottomNavigationBarItem(
//                 icon: SvgPicture.asset(navBarCubit.selectedIndex == 3
//                         ? Images.SELECTED_ADD_ADS
//                         : Images.FLOATING_SVG
//                     // Images.UNSELECTED_MY_ADS
//                     ),
//                 label: LocaleKeys.RealEstateAdvertisement.tr()),
//             BottomNavigationBarItem(
//                 icon: SvgPicture.asset(navBarCubit.selectedIndex == 4
//                     ? Images.SERVICES_SVG
//                     : Images.UNSELECTED_PROFILE_SVG),
//                 label: LocaleKeys.requestService.tr()),
//             BottomNavigationBarItem(
//                 icon: SvgPicture.asset(navBarCubit.selectedIndex == 5
//                     ? Images.SELECTED_MORE_SVG
//                     : Images.UNSELECTED_MORE_SVG),
//                 label: LocaleKeys.more.tr()),
//           ]
//         : [
//             BottomNavigationBarItem(
//                 icon: SvgPicture.asset(
//                     navBarCubit.selectedIndex == 0
//                         ? Images.SelectedMarketing
//                         : Images.UnSelectedMarketing,
//                     height: 25.sp),
//                 label: LocaleKeys.promotional.tr()),
//             BottomNavigationBarItem(
//                 icon: SvgPicture.asset(navBarCubit.selectedIndex == 1
//                     ? Images.SELECTED_HOME_SVG
//                     : Images.UNSELECTED_HOME_SVG),
//                 label: LocaleKeys.homeScreen.tr()),
//       BottomNavigationBarItem(icon: SizedBox(height: 20.sp,),label:LocaleKeys.requestService.tr() ),
//             // BottomNavigationBarItem(
//             //     icon: SvgPicture.asset(navBarCubit.selectedIndex == 2
//             //         ? Images.Selected_Services_svg
//             //         : Images.Unselected_Services_svg),
//             //     label: LocaleKeys.requestService.tr()),
//             BottomNavigationBarItem(
//                 icon: SvgPicture.asset(navBarCubit.selectedIndex == 3
//                     ? Images.SELECTED_ORDERS_SVG
//                     : Images.UNSELECTED_ORDERS_SVG),
//                 label: LocaleKeys.myOrders.tr()),
//             BottomNavigationBarItem(
//                 icon: SvgPicture.asset(navBarCubit.selectedIndex == 4
//                     ? Images.SELECTED_MORE_SVG
//                     : Images.UNSELECTED_MORE_SVG),
//                 label: LocaleKeys.more.tr()),
//           ],
//   ),
// ),

// smallButtonSheet(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_OVER_LARGE),
//     child: Align(
//       alignment: AlignmentDirectional.bottomEnd,
//       child: Card(
//         color: lightGrey,
//         elevation: 3,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
//         ),
//         child: Container(
//           margin: EdgeInsets.all(8.sp),
//           height: context.height * 0.1,
//           width: context.width * 0.22,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
//             color: lightGrey,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               FittedBox(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SvgPicture.asset(Images.FLOATING_SVG),
//                     TextButton(
//                       onPressed: () {
//                         navigateForward(RealStateAdsScreen());
//                       },
//                       child: AutoSizeText(
//                           LocaleKeys.RealEstateAdvertisement.tr(),
//                           style:
//                               openSansRegular.copyWith(color: darkGreyColor)),
//                     )
//                   ],
//                 ),
//               ),
//               // const SizedBox(
//               //   height: 10,
//               // ),
//               accountType == 'service_provider'
//                   ? SizedBox()
//                   : FittedBox(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SvgPicture.asset(Images.FLOATING_SVG),
//                           TextButton(
//                             child: AutoSizeText(
//                               LocaleKeys.requestService.tr(),
//                               style: openSansRegular.copyWith(
//                                   color: darkGreyColor),
//                             ),
//                             onPressed: () {
//                               navigateForward(ServicesScreen());
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
