import 'package:aqarat_raqamia/utils/images.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/screens/about_us/about_us_screen.dart';
import 'package:aqarat_raqamia/view/screens/chat/my_conversations_screen.dart';
import 'package:aqarat_raqamia/view/screens/coupons_screen/coupons_screen.dart';
import 'package:aqarat_raqamia/view/screens/favourites/favourite_screen.dart';
import 'package:aqarat_raqamia/view/screens/my_ads_screen/my_ads_screen.dart';
import 'package:aqarat_raqamia/view/screens/my_wallet/my_wallet_screen.dart';
import 'package:aqarat_raqamia/view/screens/profile/profile_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/app_constant.dart';
import '../../view/base/show_toast.dart';
import '../../view/screens/bank_accounts/bank_account_screen.dart';
import '../../view/screens/complaint_screen/compalint_screen.dart';
import '../../view/screens/contact_us/contact_us_screen.dart';
import '../../view/screens/my_subscriptions/my_subscription.dart';
import '../../view/screens/notification/notification_screen.dart';
import '../../view/screens/privacy_policy/privacy_policy_screen.dart';
import '../../view/screens/promoted/promoted_service_provider.dart';
import '../../view/screens/promotion_myself/promotion_myself.dart';
import '../../view/screens/providers/provider_profile/profile_provider_screen.dart';
import '../../view/screens/providers/rate_screen/rate_screen.dart';
import '../../view/screens/real_state_Ads/make_ads_spons.dart';
import '../../view/screens/real_state_Ads/real_state_ads_scraan.dart';
import '../../view/screens/setting/setting_screen.dart';
import '../../view/screens/subscribtion_screen/wallet/complete_pay_with_wallet.dart';
import '../../view/screens/summary/summary.dart';

class MoreModel {
  Function onPressed;
  String title;
  String svgIcon;

  MoreModel(
      {required this.title, required this.onPressed, required this.svgIcon});
}

List<MoreModel> moreList = [
  MoreModel(
      title: LocaleKeys.RealEstateAdvertisement,
      onPressed: () {
     // navigateForward(CompletePayWithWallet( withDrawAmount: 520, remainingValue: 20,));
        token==null?
        showCustomSnackBar(message: LocaleKeys.loginFirst.tr(),
          state:ToastState.ERROR,
          //  context: con
        ):
       navigateForward(RealStateAdsScreen());
      },
      svgIcon: Images.FLOATING_SVG),
  MoreModel(
      title: LocaleKeys.aboutUs,
      onPressed: () {

       navigateForward(AboutUsScreen());
      },
      svgIcon: Images.ABOUT_SVG),
  MoreModel(
      title: LocaleKeys.profile,
      onPressed: () {
        token==null?
        showCustomSnackBar(message: LocaleKeys.loginFirst.tr(),
          state:ToastState.ERROR,
          //  context: con
        ):
        navigateForward(ProfileScreen());
      },
      svgIcon: Images.SELECTED_PROFILE_SVG),
  MoreModel(
      title: LocaleKeys.myAds,
      onPressed: () {
        navigateForward(MyAdsScreen());
      },
      svgIcon: Images.MyAdsGold),
  MoreModel(
      title:LocaleKeys.summary,
      onPressed: () {
        token==null?
        showCustomSnackBar(message: LocaleKeys.loginFirst.tr(),
          state:ToastState.ERROR,
          //  context: con
        ): navigateForward(SummaryScreen());
        //  navigateForward(MySubscriptionScreen());
      },
      svgIcon: Images.Info),
  MoreModel(
      title:LocaleKeys.discountCoupons ,
      onPressed: () {
        navigateForward(CouponsScreen());
      },
      svgIcon: Images.MyAdsGold),
  MoreModel(
      title: LocaleKeys.myWallet,
      onPressed: () {
        token==null?
        showCustomSnackBar(message: LocaleKeys.loginFirst.tr(),
          state:ToastState.ERROR,
          //  context: con
        ):
        navigateForward(MyWalletScreen());
      },
      svgIcon: Images.My_Wallet),
  MoreModel(
      title: LocaleKeys.PromotedServiceProvider,
      onPressed: () {
        navigateForward(PromotedServiceProvider());
      },
      svgIcon: Images.Marketing),
  MoreModel(
      title: LocaleKeys.favourite,
      onPressed: () {
        navigateForward(FavouriteScreen());
      },
      svgIcon: Images.FAVOURITE_SVG),
  MoreModel(
      title: LocaleKeys.notifications,
      onPressed: () {
        navigateForward(NotificationScreen());
      },
      svgIcon: Images.NOTIFICATIONS_SVG),
  MoreModel(
      title: LocaleKeys.MyConversations,
      onPressed: () {
        navigateForward(MyConversationScreen());
      },
      svgIcon: Images.MyChatsGold),
  MoreModel(
      title: LocaleKeys.contactUs,
      onPressed: () {
        navigateForward(ContactUsScreen());
      },
      svgIcon: Images.CALL_SVG),
  MoreModel(
      title: LocaleKeys.settings,
      onPressed: () {
        navigateForward(SettingsScreen());
      },
      svgIcon: Images.SETTINGS_SVG),
  MoreModel(
      title: LocaleKeys.complaintsSuggestions,
      onPressed: () {
        token==null?
        showCustomSnackBar(message: LocaleKeys.loginFirst.tr(),
          state:ToastState.ERROR,
          //  context: con
        ):
        navigateForward(ComplaintScreen());
      },
      svgIcon: Images.complaint_svg),
  MoreModel(
      title: LocaleKeys.bankAccounts,
      onPressed: () {
        navigateForward(BankAccountsScreen());
      },
      svgIcon: Images.bank_account_svg),
  MoreModel(
      title: LocaleKeys.privacyPolicy,
      onPressed: () {
        navigateForward(PrivacyPolicyScreen());
      },
      svgIcon: Images.PRIVACY_SVG),
];
List<MoreModel> moreListProviders = [
  MoreModel(
      title: LocaleKeys.RealEstateAdvertisement,
      onPressed: () {
      //  navigateForward(MakeSponsoredAds(adId: 325,));
      //  navigateForward(Screen2());
       navigateForward(RealStateAdsScreen());
      },
      svgIcon: Images.FLOATING_SVG),
  MoreModel(
      title: LocaleKeys.aboutUs,
      onPressed: () {
        navigateForward(AboutUsScreen());
      },
      svgIcon: Images.ABOUT_SVG),
  MoreModel(
      title: LocaleKeys.customerRate,
      onPressed: () {
        navigateForward(RateScreen());
      },
      svgIcon: Images.RateLogo),
  MoreModel(
      title: LocaleKeys.profile,
      onPressed: () {
        navigateForward(ProfileProviderScreen());
      },
      svgIcon: Images.SELECTED_PROFILE_SVG),
  MoreModel(
      title: LocaleKeys.myAds,
      onPressed: () {
        navigateForward(MyAdsScreen());
      },
      svgIcon: Images.MyAdsGold),
  MoreModel(
      title:LocaleKeys.summary,
      onPressed: () {
        token==null?
        showCustomSnackBar(message: LocaleKeys.loginFirst.tr(),
          state:ToastState.ERROR,
          //  context: con
        ):  navigateForward(SummaryScreen());
      //  navigateForward(MySubscriptionScreen());
      },
      svgIcon: Images.Info),
  MoreModel(
      title: LocaleKeys.discountCoupons,
      onPressed: () {
        navigateForward(CouponsScreen());
      },
      svgIcon: Images.MyAdsGold),
  MoreModel(
      title: LocaleKeys.notifications,
      onPressed: () {
        navigateForward(NotificationScreen());
      },
      svgIcon: Images.NOTIFICATIONS_SVG),
  MoreModel(
      title: LocaleKeys.PromotingMySelf,
      onPressed: () {
        navigateForward(PromotionMySelf());
      },
      svgIcon: Images.Marketing),
  MoreModel(
      title: LocaleKeys.myWallet,
      onPressed: () {
        navigateForward(MyWalletScreen());
      },
      svgIcon: Images.My_Wallet),
  MoreModel(
      title: LocaleKeys.favourite,
      onPressed: () {
        navigateForward(FavouriteScreen());
      },
      svgIcon: Images.FAVOURITE_SVG),
  MoreModel(
      title: LocaleKeys.MyConversationsProvider,
      onPressed: () {
        navigateForward(MyConversationScreen());
      },
      svgIcon: Images.MyChatsGold),
  MoreModel(
      title: LocaleKeys.contactUs,
      onPressed: () {
        navigateForward(ContactUsScreen());
      },
      svgIcon: Images.CALL_SVG),
  MoreModel(
      title: LocaleKeys.settings,
      onPressed: () {
        navigateForward(SettingsScreen());
      },
      svgIcon: Images.SETTINGS_SVG),
  MoreModel(
      title: LocaleKeys.complaintsSuggestions,
      onPressed: () {
        navigateForward(ComplaintScreen());
      },
      svgIcon: Images.complaint_svg),
  MoreModel(
      title: LocaleKeys.bankAccounts,
      onPressed: () {
        navigateForward(BankAccountsScreen());
      },
      svgIcon: Images.bank_account_svg),
  MoreModel(
      title: LocaleKeys.privacyPolicy,
      onPressed: () {
        navigateForward(PrivacyPolicyScreen());
      },
      svgIcon: Images.PRIVACY_SVG),
];
