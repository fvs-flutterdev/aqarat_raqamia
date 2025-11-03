import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/view/screens/subscribtion_screen/compelete_price_offer_payment.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';

// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import '../../../../bloc/subscribtion_cubit/cubit.dart';
import '../../../../model/dynamic_model/subscribtion_callback_model.dart';
import '../../../../pusher_config/pusher.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/app_constant.dart';
import '../../../base/adaptive_dialog_loader.dart';
import '../compelete_ad_sponsored.dart';
import '../compelete_payment.dart';
import '../compelete_promotion_service_provider.dart';
import '../network_error.dart';
import '../spinkit_cube.dart';
import '../wallet/compelete_charge_wallet.dart';

class PaymentWebView extends StatefulWidget {
  String url;
  String redirectUrl;
  SubscriptionCallBackModel subscriptionCallBackModel;
  final Function onSuccess, onError;

  PaymentWebView(
      {super.key,
      required this.url,
      required this.redirectUrl,
      required this.onError,
      required this.subscriptionCallBackModel,
      required this.onSuccess});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;
  String checkoutUrl = 'https://tap.company';
  String navUrl = 'tap.company';
  bool loading = true;
  bool pageLoading = true;
  bool loadingError = false;
  int pressed = 0;

  loadPayment() async {
    setState(() {
      loading = true;
    });
    try {
      var getPayment = widget.subscriptionCallBackModel;
      if (
          //getPayment['error'] == false &&
          widget.subscriptionCallBackModel.url != null) {
        setState(() {
          checkoutUrl = widget.subscriptionCallBackModel.url!;
          navUrl = widget.subscriptionCallBackModel.url!;
          loading = false;
          pageLoading = false;
          loadingError = false;
        });
        _controller.loadRequest(Uri.parse(checkoutUrl));
      } else {
        widget.onError(getPayment);
        setState(() {
          loading = false;
          pageLoading = false;
          loadingError = true;
        });
      }
    } catch (e) {
      widget.onError(e);
      setState(() {
        loading = false;
        pageLoading = false;
        loadingError = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // var formData = {};
    //formData = widget.paymentData;
    // formData['post'] = {"url": widget.postUrl};
    // formData['redirect'] = {"url": widget.redirectUrl};
    // services = TapServices(
    //     apiKey: widget.apiKey,
    //     paymentData: {...widget.paymentData, ...formData});
    // setState(() {
    //   navUrl = 'checkout.payments.tap.company';
    // });

    // #docregion platform_features
    if (mounted) {
      setState(() {
        isDismiss = false;
      });
    }

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                pageLoading = true;
                loadingError = false;
              });
            }

            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print(url);
            if (mounted) {
              setState(() {
                navUrl = url;
                pageLoading = false;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            if (request.url.startsWith(
                'https://dashboard.redd.sa/api/subscriptions/payment/')) {
              debugPrint('//////////////////////////////////////////////123333');
              final uri = Uri.parse(request.url);
              debugPrint("Got back: ${uri.queryParameters}");
              LaravelEcho.init(token: userId.toString());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CompletePayments(
                        url: request.url,
                        // paymentResponseModel: context.read<SubscribeCubit>().paymentResponseModel,
                        // services: services,
                        onSuccess: widget.onSuccess,
                        onError: widget.onError)),
              );
            } else if (request.url
                .startsWith('https://dashboard.redd.sa/api/ads/payment/')) {
              debugPrint('//////////////////////////////////////////////ADS');
              final uri = Uri.parse(request.url);
              debugPrint("Got back: ${uri.queryParameters}");
              LaravelEcho.init(token: userId.toString());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CompleteAdsPayments(
                        url: request.url,
                        // paymentResponseModel: context.read<SubscribeCubit>().paymentResponseModel,
                        // services: services,
                        onSuccess: widget.onSuccess,
                        onError: widget.onError)),
              );
            } else if (request.url.startsWith(
                'https://dashboard.redd.sa/api/price-offer/payment/')) {
              debugPrint(
                  '//////////////////////////////////////////////PRICE OFFER');
              LaravelEcho.init(token: userId.toString());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CompletePriceOfferPayment(
                        url: request.url,
                        // paymentResponseModel: context.read<SubscribeCubit>().paymentResponseModel,
                        // services: services,
                        onSuccess: widget.onSuccess,
                        onError: widget.onError)),
              );
            }
            else if (request.url.startsWith(
                'https://dashboard.redd.sa/api/serviceProviders/payment/')) {
              debugPrint(
                  '//////////////////////////////////////////////PRICE OFFER');
              LaravelEcho.init(token: userId.toString());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CompletePromotionServicePayments(
                        url: request.url,
                        // paymentResponseModel: context.read<SubscribeCubit>().paymentResponseModel,
                        // services: services,
                        onSuccess: widget.onSuccess,
                        onError: widget.onError)),
              );
            }else if(request.url.startsWith("https://dashboard.redd.sa/api/wallet/deposit/")){
              debugPrint(
                  '//////////////////////////////////////////////deposit Wallet');
              LaravelEcho.init(token: userId.toString());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CompleteChargeWalletPayments(
                        url: request.url,
                        // paymentResponseModel: context.read<SubscribeCubit>().paymentResponseModel,
                        // services: services,
                        onSuccess: widget.onSuccess,
                        onError: widget.onError)),
              );
            }
            //
            debugPrint('allowing navigation to ${request.url}');
            // Navigator.pushReplacement(
            //   context,
            //
            //
            //
            //
            // 076848
            //   MaterialPageRoute(
            //       builder: (context) => CompletePayments(
            //           url: request.url,
            //        //   paymentResponseModel: context.read<SubscribeCubit>().paymentResponseModel,
            //           // services: services,
            //           onSuccess: widget.onSuccess,
            //           onError: widget.onError
            //       )),
            // );
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      );

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
    loadPayment();
    // setState(() {
    //   isDismiss=false;
    //   print('///////////////////////////////////$isDismiss');
    // });
    // Enable hybrid composition.
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (pressed < 2) {
          setState(() {
            pressed++;
          });
          final snackBar = SnackBar(
              content: Text(
                  'Press back ${3 - pressed} more times to cancel transaction'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF272727),
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white70,
            ),
            onTap: () {
              // setState(() {
              //   isDismiss=false;
              // });
              context.read<SubscribeCubit>().changeDialogAppear(dialog: false);
              debugPrint('////////////////////////$isDismiss');
              Navigator.pop(context);
            },
          ),
          title: Row(
            children: [
              Expanded(
                  child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Icon(
                      Icons.lock_outline,
                      color: Uri.parse(navUrl).hasScheme
                          ? Colors.green
                          : Colors.blue,
                      size: 18,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        navUrl,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.white70),
                      ),
                    ),
                    SizedBox(width: pageLoading ? 5 : 0),
                    pageLoading
                        ? const SpinKitFadingCube(
                            color: Color(0xFFEB920D),
                            size: 10.0,
                          )
                        : const SizedBox()
                  ],
                ),
              ))
            ],
          ),
          elevation: 0,
        ),
        body: SizedBox(
          height:context.height,
          width: context.width,
          child: loading ||
                  (checkoutUrl == 'https://tap.company' &&
                      loadingError == false)
              ? const Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: SpinKitFadingCube(
                          color:const Color(0xFFEB920D),
                          size: 30.0,
                        ),
                      ),
                    ),
                  ],
                )
              : loadingError
                  ? Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: NetworkError(
                                loadData: loadPayment,
                                message: LocaleKeys.paymentError.tr()),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: WebViewWidget(controller: _controller),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
