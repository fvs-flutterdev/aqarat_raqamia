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
                      return StyleBottomNavBarWidget(
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

class StyleBottomNavBarWidget extends StatelessWidget {
  StyleBottomNavBarWidget({
    required this.navBarConfig,
    this.navBarDecoration = const NavBarDecoration(),
    this.height,
    this.middleItemSize = 50,
    super.key,
  }) : assert(
          navBarConfig.items.length.isOdd,
          "The number of items must be odd for r",
        );

  final NavBarConfig navBarConfig;
  final NavBarDecoration navBarDecoration;
  final double? height;
  final double middleItemSize;

  Widget _buildItem(
    BuildContext context,
    ItemConfig item,
    bool isSelected,
    VoidCallback onTap,
  ) =>
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        splashColor: item.activeForegroundColor.withOpacity(0.1),
        child: AnimatedContainer(
          color: Colors.transparent,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AnimatedContainer(
                height: 44,
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.all(isSelected ? 8.0 : 6.0),
                decoration: BoxDecoration(
                  color: isSelected
                      ? item.activeForegroundColor.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: InkWell(
                  onTap: onTap,
                  child: IconTheme(
                    data: IconThemeData(
                      size: (item.iconSize ?? 22.0) + (isSelected ? 2.0 : 0.0),
                      color: isSelected
                          ? item.activeForegroundColor
                          : item.inactiveForegroundColor,
                    ),
                    child: isSelected ? item.icon : item.inactiveIcon,
                  ),
                ),
              ),
              if (item.title != null)
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 200),
                    style: item.textStyle.apply(
                          color: isSelected
                              ? item.activeForegroundColor
                              : item.inactiveForegroundColor,
                          fontSizeFactor: isSelected ? 1.0 : 0.9,
                        ) ??
                        TextStyle(
                          fontSize: isSelected ? 11.0 : 10.0,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected
                              ? item.activeForegroundColor
                              : item.inactiveForegroundColor,
                        ),
                    child: Text(
                      item.title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );

  Widget _buildMiddleItem(ItemConfig item, bool isSelected) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              navBarConfig.onItemSelected(
                (navBarConfig.items.length / 2).floor(),
              );
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: FloatingActionButton(
                onPressed: () {
                  navBarConfig.onItemSelected(
                    (navBarConfig.items.length / 2).floor(),
                  );
                },
                elevation: isSelected ? 8.0 : 6.0,
                backgroundColor: item.activeForegroundColor,
                heroTag: "middleNavButton",
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: InkWell(
                    onTap: () {
                      navBarConfig.onItemSelected(
                        (navBarConfig.items.length / 2).floor(),
                      );
                    },
                    child: IconTheme(
                      key: ValueKey(isSelected),
                      data: IconThemeData(
                        size: item.iconSize ?? 24.0,
                        color: item.inactiveForegroundColor,
                      ),
                      child: isSelected ? item.icon : item.inactiveIcon,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (item.title != null)
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 200),
                style: item.textStyle.apply(
                      color: isSelected
                          ? item.activeForegroundColor
                          : item.inactiveForegroundColor,
                      fontSizeFactor: isSelected ? 1.05 : 1.0,
                    ) ??
                    TextStyle(
                      fontSize: isSelected ? 11.0 : 10.0,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? item.activeForegroundColor
                          : item.inactiveForegroundColor,
                    ),
                child: Text(
                  item.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final midIndex = (navBarConfig.items.length / 2).floor();
    return SizedBox(
      height: height ?? 60.0,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          // Bottom Navigation Bar Background
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: DecoratedNavBar(
              decoration: navBarDecoration,
              height: height,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: navBarConfig.items.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final item = entry.value;

                    if (index == midIndex) {
                      // Placeholder for middle item
                      return SizedBox(
                        width: middleItemSize,
                        height: middleItemSize,
                      );
                    }

                    return Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: _buildItem(
                          context,
                          item,
                          navBarConfig.selectedIndex == index,
                          () {
                            navBarConfig.onItemSelected(index);
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          // Floating Action Button in the middle
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: _buildMiddleItem(
                navBarConfig.items[midIndex],
                navBarConfig.selectedIndex == midIndex,
              ),
            ),
          ),
        ],
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
