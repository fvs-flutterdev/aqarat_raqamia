class BaseUrl {
  static const baseUrl = 'https://dashboard.redd.sa';
  static const SentryUrl =
      "https://4b2cfba89a25635305eec9d2c04677d1@o4508255820972032.ingest.de.sentry.io/4508255822479440";
  static const LangUrl = "assets/langs";

//  static const baseUrl = 'https://test.redd.sa';
  // static const testBaseUrl = 'https://test.redd.sa';
  static const login = '/api/auth/login';
  static const checkOtpLogin = '/api/auth/checkOtp';
  static const sendFcmToken = '/api/auth/update-fcm-token';
  static const register = '/api/auth/register';
  static const getProfile = '/api/auth/user-profile';
  static const updateProfile = '/api/auth/update-user-profile';
  static const createAds = '/api/ads/create';
  static const GetAdsFeature = '/api/ads/create/resources';
  static const GetContactUs = '/api/settings/contact-us';
  static const GetTermsAndCondition = '/api/settings/terms-and-conditions';
  static const GetAboutUs = '/api/settings/about-us';
  static const GetMyAds = '/api/ads/my-ads/show';
  static const SearchAds = '/api/ads';
  static const AddFavourite = '/api/favorites/create';
  static const RemoveFavourite = '/api/favorites/delete';
  static const GetFavourite = '/api/favorites/all';
  static const GetServices = "/api/services";
  static const GetInterests = '/api/interests';
  static const GetSimilarAds = "/api/ads/ad-details/similar-ads";
  static const RequestService = "/api/request_services/create";
  static const GetServiceClient = "/api/request_services/show";
  static const FinishOrder = "/api/request_services/change-status";
  static const declineOfferPrice = "/api/price-offer/change-status";
  static const acceptOfferPrice = "/api/price-offer/accept";
  static const CreateNewAd = "/api/ads/create/new-ad";
  static const ProviderResourceEntity =
      "/api/auth/service-providers/create/resource";
  static const logout = "/api/auth/logout";
  static const deleteAccount = "/api/auth/account-delete";
  static const pending_orders_provider =
      "/api/request_services/provider-reference";
  static const old_orders_provider = "/api/request_services/provider-old";
  static const current_orders_provider =
      "/api/request_services/provider-current";
  static const Send_Price_provider = "/api/price-offer/create";
  static const Get_All_Conversations = '/api/chats/all';
  static const get_chat_message = "/api/chats";
  static const get_Packages_Subscription = "/api/subscriptions/all-packages";
  static const Pay_For_Subscription = "/api/subscriptions/payment/pay";
  static const GetBoardingContent = "/api/settings/on-board-content";
  static const GetAccountTypeContent = "/api/settings/account-types";
  static const SponsoredAd = "/api/ads/payment/pay";
  static const GetSponsoredAd = "/api/ads/promoted/all";
  static const GetSponsoredAdDetails = "/api/settings/promotion-details";
  static const GetNotificationModel =
      "/api/notifications/user-notifications/all";
  static const PayPriceOffer = "/api/price-offer/payment/pay";
  static const GetRegions = "/api/locations/regions";
  static const GetCities = "/api/locations/getCitiesByRegionId";
  static const GetPartnerSponsor = "/api/ad-promoteds";
  static const ChangeOrderStatus = "/api/request_services/change-status";
  static const getPromotedService = "/api/services/provider_service_promo";
  static const getPromotedDetails = "/api/settings/promotion-service-details";
  static const PayForPromotedMyAcc = "/api/serviceProviders/payment/pay";
  static const getProvidersPromoted = "/api/serviceProviders/promo";
  static const AddRateProvider = "/api/rates/create";
  static const GetFeatureList = "/api/additional-features";
  static const PostComplaint = "/api/complaints/create";
  static const BankAccounts = '/api/settings/banks';
  static const banners = '/api/settings/banners';
  static const rate_client = "/api/ratesapplicant/create";
  static const Coupons = "/api/coupons";
  static const PriceRange = "/api/ads/price-range";
  static const ChargeWallet = "/api/wallet/deposit";
  static const MyComplaints = "/api/complaints";
  static const SubServices = "/api/services/sub-services";
  static const SendClick = '/api/ad-promoteds/click';
  static const payAdFromWallet = '/api/wallet/withdraw';
  static const UpgradeAccountStatus = "/api/auth/update-status";
  static const PostCommentForAd = "/api/ads/comments/create";
  static const UpdateServicesOfProvider = "/api/auth/update-user-services";
  static const Summary = "/api/auth/requests-summary";
//  static const GetCommentForAd ="/api/ads/comments";
}
