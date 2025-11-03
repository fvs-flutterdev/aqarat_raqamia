import '../../bloc/bottom_navbar_cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/images.dart';
import '../../utils/text_style.dart';
import '../../view/screens/home/home_screen.dart';
import '../../view/screens/more/more_screen.dart';
import '../../view/screens/my_orders/my_orders.dart';
import '../../view/screens/providers/all_ads/all_ads_screen.dart';
import '../../view/screens/providers/more/more_provider.dart';
import '../../view/screens/providers/my_orders/provider_orders.dart';
import '../../view/screens/services/services_screen.dart';
import '../../view/screens/sponsor_partner_screen/sponsor_partner_screen.dart';

class NavbarCubit extends Cubit<BottomNavbarState> {
  NavbarCubit() : super(InitialNavbarState());

  static NavbarCubit get(context) => BlocProvider.of(context);
  int _selectedIndex = 0;
  bool _changeFloatingStatus = false;

  int get selectedIndex => _selectedIndex;

  bool get changeFloatingStatus => _changeFloatingStatus;
  PersistentTabController controller = PersistentTabController(
    initialIndex: 0,
  );
  List<PersistentTabConfig> clientItems() {
    return [
      PersistentTabConfig(
          screen: SponsorPartnerScreen(),
          navigatorConfig: NavigatorConfig(),
          item: ItemConfig(
            title: LocaleKeys.promotional.tr(),
            textStyle: openSansBold,
            activeColorSecondary: darkGreyColor,
            activeForegroundColor: darkGreyColor,
            inactiveForegroundColor: lightDarkMain,
            icon: SvgPicture.asset(Images.SelectedMarketing),
            inactiveIcon: SvgPicture.asset(Images.UnSelectedMarketing),
          )),
      PersistentTabConfig(
          screen: HomeScreen(),
          navigatorConfig: NavigatorConfig(),
          item: ItemConfig(
            activeForegroundColor: darkGreyColor,
            title: LocaleKeys.homeScreen.tr(),
            textStyle: openSansBold,
            activeColorSecondary: darkGreyColor,
            inactiveForegroundColor: lightDarkMain,
            icon: SvgPicture.asset(Images.SELECTED_HOME_SVG),
            inactiveIcon: SvgPicture.asset(Images.UNSELECTED_HOME_SVG),
          )),
      PersistentTabConfig(
          screen: ServicesScreen(),
          navigatorConfig: NavigatorConfig(),
          item: ItemConfig(
            title: LocaleKeys.requestService.tr(),
            iconSize: 10.sp,
            textStyle: openSansBold,
            activeColorSecondary: darkGreyColor,
            activeForegroundColor: darkGreyColor,
            inactiveForegroundColor: lightDarkMain,
            icon: SvgPicture.asset(Images.Logo_svg),
            //  inactiveIcon: SvgPicture.asset(Images.Unselected_Services_svg)
          )),
      PersistentTabConfig(
          screen: MyOrders(),
          navigatorConfig: NavigatorConfig(),
          item: ItemConfig(
              title: LocaleKeys.myOrders.tr(),
              textStyle: openSansBold,
              activeColorSecondary: darkGreyColor,
              activeForegroundColor: darkGreyColor,
              inactiveForegroundColor: lightDarkMain,
              icon: SvgPicture.asset(Images.SELECTED_ORDERS_SVG),
              inactiveIcon: SvgPicture.asset(Images.UNSELECTED_ORDERS_SVG))),
      PersistentTabConfig(
          screen: MoreScreen(),
          navigatorConfig: NavigatorConfig(),
          item: ItemConfig(
              activeForegroundColor: darkGreyColor,
              inactiveForegroundColor: lightDarkMain,
              title: LocaleKeys.more.tr(),
              textStyle: openSansBold,
              activeColorSecondary: darkGreyColor,
              icon: SvgPicture.asset(Images.SELECTED_MORE_SVG),
              inactiveIcon: SvgPicture.asset(Images.UNSELECTED_MORE_SVG))),
    ];
  }
  // List<Widget> screens = [
  //   SponsorPartnerScreen(),
  //   HomeScreen(),
  //   ServicesScreen(),
  //   MyOrders(),
  //   MoreScreen(),
  // ];
  // List<Widget> providerScreens = [
  //   SponsorPartnerScreen(),
  //   MyAdsScreen(),
  //   MyOrdersProviders(),
  //   RealStateAdsScreen(),
  //   ProfileProviderScreen(),
  //   MoreProviderScreen(),
  // ];



  List<PersistentTabConfig> providersItems() {
    return [
      PersistentTabConfig(
          screen: SponsorPartnerScreen(),
          item: ItemConfig(
            title: LocaleKeys.promotional.tr(),
            textStyle: openSansBold,
            activeColorSecondary: darkGreyColor,
            activeForegroundColor: darkGreyColor,
            inactiveForegroundColor: lightDarkMain,
            icon: SvgPicture.asset(Images.SelectedMarketing),
            inactiveIcon: SvgPicture.asset(Images.UnSelectedMarketing),
          )),
      PersistentTabConfig(
        screen: HomeScreen(),
         // screen: AllAdsScreen(),
          //MyAdsScreen(),
          item: ItemConfig(
            activeForegroundColor: darkGreyColor,
           title: LocaleKeys.homeScreen.tr(),
           // title: LocaleKeys.Ads.tr(),
            // title: LocaleKeys.myAds.tr(),
            textStyle: openSansBold,
            activeColorSecondary: darkGreyColor,
            inactiveForegroundColor: lightDarkMain,
            // icon: SvgPicture.asset(Images.SELECTED_MY_ADS),
            // inactiveIcon: SvgPicture.asset(Images.UNSELECTED_MY_ADS),
            icon: SvgPicture.asset(Images.SELECTED_HOME_SVG),
            inactiveIcon: SvgPicture.asset(Images.UNSELECTED_HOME_SVG),
          )),
      PersistentTabConfig(
          screen: ServicesScreen(),
          item: ItemConfig(
            title: LocaleKeys.requestService.tr(),
            iconSize: 10.sp,
            textStyle: openSansBold,
            activeColorSecondary: darkGreyColor,
            activeForegroundColor: darkGreyColor,
            inactiveForegroundColor: lightDarkMain,
            icon: SvgPicture.asset(Images.Logo_svg),
            //  inactiveIcon: SvgPicture.asset(Images.Unselected_Services_svg)
          )),
      PersistentTabConfig(
          screen: MyOrdersProviders(),
          item: ItemConfig(
              title: LocaleKeys.myOrders.tr(),
              textStyle: openSansBold,
              activeColorSecondary: darkGreyColor,
              activeForegroundColor: darkGreyColor,
              inactiveForegroundColor: lightDarkMain,
              icon: SvgPicture.asset(Images.SELECTED_ORDERS_SVG),
              inactiveIcon: SvgPicture.asset(Images.UNSELECTED_ORDERS_SVG))),
      // PersistentTabConfig(
      //     screen: RealStateAdsScreen(),
      //     item: ItemConfig(
      //         title: LocaleKeys.RealEstateAdvertisement.tr(),
      //         textStyle: openSansBold,
      //         activeColorSecondary: darkGreyColor,
      //         activeForegroundColor: darkGreyColor,
      //         inactiveForegroundColor: lightDarkMain,
      //         icon: SvgPicture.asset(Images.SELECTED_ADD_ADS),
      //         inactiveIcon: SvgPicture.asset(Images.FLOATING_SVG))),
      ///
      // PersistentTabConfig(
      //     screen: ProfileProviderScreen(),
      //     item: ItemConfig(
      //         activeForegroundColor: darkGreyColor,
      //         inactiveForegroundColor: lightDarkMain,
      //         title: LocaleKeys.requestService.tr(),
      //         textStyle: openSansBold,
      //         activeColorSecondary: darkGreyColor,
      //         icon: SvgPicture.asset(Images.SERVICES_SVG),
      //         inactiveIcon: SvgPicture.asset(Images.UNSELECTED_PROFILE_SVG))),
      PersistentTabConfig(
          screen: MoreProviderScreen(),
          item: ItemConfig(
              activeForegroundColor: darkGreyColor,
              inactiveForegroundColor: lightDarkMain,
              title: LocaleKeys.more.tr(),
              textStyle: openSansBold,
              activeColorSecondary: darkGreyColor,
              icon: SvgPicture.asset(Images.SELECTED_MORE_SVG),
              inactiveIcon: SvgPicture.asset(Images.UNSELECTED_MORE_SVG))),
    ];
  }

  changeCurrentIndex(int i) {
    _selectedIndex = i;
    emit(ChangeCurrentNavbarState());
    //   update();
  }

  changeCurrentFloatingStatus() {
    _changeFloatingStatus = !_changeFloatingStatus;
    emit(ChangeCurrentFloatingNavbarState());
  }

  makeFloatingFalse() {
    _changeFloatingStatus = false;
    emit(MakeFloatingFalseNavbarState());
  }
}
