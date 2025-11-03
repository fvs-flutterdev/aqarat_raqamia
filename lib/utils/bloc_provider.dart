import 'package:aqarat_raqamia/bloc/comments_cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/coupons_cubit/cubit.dart';
import '../bloc/edit_ad_cubit/edit_ad_info_cubit/cubit.dart';
import '../bloc/interests_cubit/cubit.dart';
import '../bloc/region_cubit/cubit.dart';
import '../bloc/account_type_cubit/cubit.dart';
import '../bloc/add_real_ads/cubit.dart';
import '../bloc/ads_by_id_cubit/cubit.dart';
import '../bloc/auth_cubit/auth_client/cubit.dart';
import '../bloc/auth_cubit/auth_provider/cubit.dart';
import '../bloc/banner_cubit/cubit.dart';
import '../bloc/boarding_cubit/cubit.dart';
import '../bloc/bottom_navbar_cubit/cubit.dart';
import '../bloc/chat_cubit/all_conversation_cubit/cubit.dart';
import '../bloc/chat_cubit/chat_with_user_cubit/cubit.dart';
import '../bloc/client_oder_cubit/current_order_cubit/cubit.dart';
import '../bloc/client_oder_cubit/finished_order_cubit/cubit.dart';
import '../bloc/client_oder_cubit/new_oder_cubit/cubit.dart';
import '../bloc/edit_ad_cubit/edit_ads_images_cubit/cubit.dart';
import '../bloc/favourite_cubit/favourite_cubit.dart';
import '../bloc/filter_search_add_cubit/cubit.dart';
import '../bloc/location_cubit/cubit.dart';
import '../bloc/map_ads_cubit/cubit.dart';
import '../bloc/my_ads_cubit/cubit.dart';
import '../bloc/nearby_aqar_cubit/cubit.dart';
import '../bloc/notification_cubit/cubit.dart';
import '../bloc/partner_sponsor_cubit/cubit.dart';
import '../bloc/profile_cubit/cubit.dart';
import '../bloc/promoted_services_cubit/cubit.dart';
import '../bloc/provider_orders_cubit/cubit.dart';
import '../bloc/provider_orders_cubit/price_offer_cubit/cubit.dart';
import '../bloc/provider_orders_cubit/provider_current_orders/cubit.dart';
import '../bloc/provider_orders_cubit/provider_old_orders_cubit/cubit.dart';
import '../bloc/provider_rate_cubit/cubit.dart';
import '../bloc/send_clicks_cubit/cubit.dart';
import '../bloc/services_cubit/cubit.dart';
import '../bloc/setting_cubit/about_us_cubit/cubit.dart';
import '../bloc/setting_cubit/bank_account_cubit/cubit.dart';
import '../bloc/setting_cubit/complaint_cubit/cubit.dart';
import '../bloc/setting_cubit/contact_us_cubit/cubit.dart';
import '../bloc/setting_cubit/logout_cubit/cubit.dart';
import '../bloc/setting_cubit/terms_cubit/cubit.dart';
import '../bloc/similar_ads_cubit/cubit.dart';
import '../bloc/sponsor_ads_cubit/cubit.dart';
import '../bloc/start_app_cubit/cubit.dart';
import '../bloc/subscribtion_cubit/cubit.dart';
import '../bloc/summary_bloc/cubit.dart';
import '../bloc/upload_request_cubit/cubit.dart';
import '../bloc/wallet_cubit/cubit.dart';

class BlocProviders extends StatelessWidget {
  final Widget child;

  const BlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StartAppCubit>(
          create: (context) => StartAppCubit()
            ..getBoardingData()
            ..getAccountType(),
        ),
        BlocProvider<AccountTypeCubit>(create: (context) => AccountTypeCubit()),
        BlocProvider<BoardingCubit>(create: (context) => BoardingCubit()),
        BlocProvider<NavbarCubit>(create: (context) => NavbarCubit()
            // ..sendFcmToken()
            ),
        BlocProvider<FilterSearchAdsCubit>(
            create: (context) => FilterSearchAdsCubit()..getPriceRange()),
        BlocProvider<NotificationCubit>(
            create: (context) =>
                NotificationCubit()..getNotificationData(page: 1)),
        BlocProvider<AddRealAdsCubit>(
            create: (context) => AddRealAdsCubit()
              ..getResourceFeature()
              ..getFeaturesList()),
        BlocProvider<LocationCubit>(
            create: (context) => LocationCubit()
              ..getAllRegions()
              ..getCurrentPosition()),
        BlocProvider<UploadRequestCubit>(
            create: (context) => UploadRequestCubit()..getSponsorDetails()),
        BlocProvider<ClientAuthCubit>(create: (context) => ClientAuthCubit()),
        BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit()..getProfileData()),
        BlocProvider<RegisterProviderCubit>(
            create: (context) => RegisterProviderCubit()
              ..getProviderEntityRegister()
              ..getInterests()),
        BlocProvider<ContactUsCubit>(
            create: (context) => ContactUsCubit()..getContactInfo()),
        BlocProvider<TermsAndConditionCubit>(
            create: (context) =>
                TermsAndConditionCubit()..getTermsAndCondition()),
        BlocProvider<AboutUsCubit>(
            create: (context) => AboutUsCubit()..getAboutUsData()),
        BlocProvider<MyAdsCubit>(
            create: (context) => MyAdsCubit(
                // myAdsRepository
                )
            //  ..getMyAdsData()
            ),
        BlocProvider<FavouriteCubit>(create: (context) => FavouriteCubit()),
        BlocProvider<ServicesCubit>(
            create: (context) => ServicesCubit()..getServicesData(page: 1)),

        ///Order_Client
        BlocProvider<NewOrdersClientCubit>(
            create: (context) => NewOrdersClientCubit()),
        BlocProvider<ClientCurrentOrderCubit>(
            create: (context) => ClientCurrentOrderCubit()),
        BlocProvider<ClientFinishedOrderCubit>(
            create: (context) => ClientFinishedOrderCubit()),

        BlocProvider<SimilarAdsCubit>(create: (context) => SimilarAdsCubit()),
        BlocProvider<NearbyAqarCubit>(
            create: (context) => NearbyAqarCubit()
              ..getNearbyAqarData(context: context, page: 1)),
        BlocProvider<AdsOnMapCubit>(
            create: (context) =>
                AdsOnMapCubit()..getAllAdsOnMap(context: context, page: 1)),
        BlocProvider<LogoutCubit>(create: (context) => LogoutCubit()),
        BlocProvider<SponsorAdsCubit>(
            create: (context) => SponsorAdsCubit()..getSponsorAds(page: 1)),

        ///providers
        BlocProvider<OrdersProviderCubit>(
            create: (context) => OrdersProviderCubit()),
        BlocProvider<RegionsCubit>(
            create: (context) => RegionsCubit()..getAllRegions()),

        BlocProvider<OldProviderOrdersCubit>(
            create: (context) => OldProviderOrdersCubit(
                //  oldOrdersProvidersRepository
                )),

        BlocProvider<CurrentProviderOrdersCubit>(
            create: (context) => CurrentProviderOrdersCubit()),
        BlocProvider<SendOfferPriceCubit>(
            create: (context) => SendOfferPriceCubit()),
        BlocProvider<ChatMessageCubit>(
            create: (context) => ChatMessageCubit(
                // getAllMessageRepository
                )),
        BlocProvider<AllConversationCubit>(
            create: (context) => AllConversationCubit()),
        BlocProvider<SubscribeCubit>(
            create: (context) =>
                SubscribeCubit()..getPackagesSubscription(page: 1)),
        BlocProvider<PartnerSponsorCubit>(
            create: (context) => PartnerSponsorCubit()..getPartnerSponsor()),
        BlocProvider<PromotedServicesCubit>(
            create: (context) => PromotedServicesCubit()
              ..getPromotedServices()
              ..getPromotionDetails()
              ..getProviderPromotion()),
        BlocProvider<ProviderRatesCubit>(
            create: (context) => ProviderRatesCubit()..getProvidersRates()),
        BlocProvider<ComplaintCubit>(
            create: (context) => ComplaintCubit()..getMyComplaints()),
        BlocProvider<BankAccountCubit>(
            create: (context) => BankAccountCubit()..getBankAccountsData()),
        BlocProvider<BannersCarouselCubit>(
            create: (context) => BannersCarouselCubit()..getBanners()),
        BlocProvider<EditAdsImagesCubit>(
            create: (context) => EditAdsImagesCubit()),
        BlocProvider<AdyByIdCubit>(create: (context) => AdyByIdCubit()),
        BlocProvider<CouponsCubit>(
            create: (context) => CouponsCubit()..getCoupons()),
        BlocProvider<WalletCubit>(create: (context) => WalletCubit()),
        BlocProvider<SendClicksCubit>(create: (context) => SendClicksCubit()),
        BlocProvider<InterestsCubit>(
            create: (context) => InterestsCubit()..getInterestsData()),
        BlocProvider<CommentsCubit>(create: (context) => CommentsCubit()),
        BlocProvider<EditAdInfoCubit>(create: (context) => EditAdInfoCubit()),
        BlocProvider<SummaryCubit>(
            create: (context) => SummaryCubit()..getSummary()),
      ],
      child: child,
    );
  }
}
