import 'dart:convert';
import 'package:aqarat_raqamia/utils/images.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:aqarat_raqamia/view/base/chat_widget/time_division.dart';
import 'package:aqarat_raqamia/view/base/main_button.dart';
import 'package:aqarat_raqamia/view/restart_widget/restart_widget.dart';
import 'package:aqarat_raqamia/view/screens/subscribtion_screen/spinkit_cube.dart';
import 'package:aqarat_raqamia/view/screens/subscribtion_screen/payment_details_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:restart_app/restart_app.dart';
import '../../../bloc/promoted_services_cubit/cubit.dart';
import '../../../bloc/promoted_services_cubit/state.dart';
import '../../../bloc/subscribtion_cubit/cubit.dart';
import '../../../bloc/subscribtion_cubit/state.dart';
import '../../../pusher_config/pusher.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/shared_pref.dart';
import '../../base/chat_widget/setup_container.dart';
import '../../base/lunch_widget.dart';
import '../splash/splash_screen.dart';
import 'network_error.dart';

class CompletePromotionServicePayments extends StatefulWidget {
  final Function onSuccess, onError;
  final String url;

  const CompletePromotionServicePayments({
    Key? key,
    required this.onSuccess,
    required this.onError,
    required this.url,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CompletePromotionServicePaymentState createState() => _CompletePromotionServicePaymentState();
}

class _CompletePromotionServicePaymentState extends State<CompletePromotionServicePayments> {
  void listenChatChannel() {
    LaravelEcho.instance
        .channel('payment-channel')
        .listen('.new-provider-promotion-${userId}', (e) {
      if (e is PusherEvent) {
        if (e.data != null) {
          jsonDecode(e.data!);
          print(jsonDecode(e.data!));
          print('e.dataxxxx ${e.data!}');
          context
              .read<PromotedServicesCubit>()
              .handelResponsePayment(jsonDecode(e.data!));
        }
        print('????${jsonDecode(e.data!)}');
      }
    }).error((error) {
      print('error x $error');
    });
  }

  void leaveChannel() {
    try {
      LaravelEcho.instance.leave('payment-channel');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var promotedCubit = context.read<PromotedServicesCubit>();

    return BlocConsumer<PromotedServicesCubit, PromotedServicesState>(
      listener: (context, state) {
        // TODO: implement listenerdasd
      },
      builder: (context, state) {
        return StartUpContainer(
          onInit: () {
            LaravelEcho.init(token: token);
            listenChatChannel();
          },
          onDisposed: () {
            LaravelEcho.instance.disconnect();
            leaveChannel();
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF272727),
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lock_outline,
                            color: Uri.parse(widget.url).hasScheme
                                ? Colors.green
                                : Colors.blue,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              LocaleKeys.paymentComplete.tr(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              elevation: 0,
            ),
            body: Container(
              child: promotedCubit.loading
                  ? const Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SpinKitFadingCube(
                        color: Color(0xFFEB920D),
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              )
                  :
              //promotedCubit.loadingError
              promotedCubit.promotedServiceProviderModel.paymentDetails?.messageEn ==
                  'promoted successfully' || promotedCubit.promotedServiceProviderModel.paymentDetails?.message=='تم الترويج بنجاح'
                  ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: context.height * 0.1,
                        bottom: context.height * 0.04,
                      ),
                      child: SvgPicture.asset(
                        Images.completePayment,
                        height: context.height * 0.12,
                        width: context.width * 0.1,
                      ),
                    ),
                    PaymentDetailsWidget(
                      // bidDuration: promotedCubit.promotedServiceProviderModel
                      //     .paymentDetails?.data?.bidDuration ??
                      //     '',
                      price: promotedCubit.promotedServiceProviderModel
                          .paymentDetails?.data?.price ??
                          '',
                      // type: promotedCubit.promotedServiceProviderModel
                      //     .paymentDetails?.data?.type ??
                      //     '',
                      orderNumber: promotedCubit.promotedServiceProviderModel
                          .paymentDetails?.data?.orderNumber ??
                          '',
                      transaction: promotedCubit.promotedServiceProviderModel
                          .paymentDetails?.data?.transaction ??
                          '',
                      bidDuration: promotedCubit.dates?.formatDate()??'' ,
                      type: LocaleKeys.promotional.tr(),
                    ),
                    SizedBox(
                      height: context.height * 0.08,
                    ),
                    CustomButton(
                      width: context.width * 0.8,
                      height: context.height * 0.06,
                      textButton:LocaleKeys.returnToTheApp.tr(),
                      onPressed: () async {
                        // if (promotedCubit.promotedServiceProviderModel.paymentDetails?.messageEn ==
                        //     'promoted successfully' || promotedCubit.promotedServiceProviderModel.paymentDetails?.message=='تم الترويج بنجاح') {
                        //   isProviderSubscribed = CacheHelper.saveData(
                        //       key: 'isSubscribed',
                        //       value: true);
                        //   isProviderSubscribed = CacheHelper.getData(
                        //       key: 'isSubscribed');
                        //   print(
                        //       '<<<<<<<<<<<<<<<<<<$isProviderSubscribed>>>>>>>>>>>>>>>>>>');
                        //   RestartWidget.restartApp(context);
                        // } else {
                        await  Restart.restartApp().then((value) => navigateAndRemove(SplashScreen()));
                        //   RestartWidget.restartApp(context);
                        //   navigateAndRemove(SplashScreen());
                       // }
                      },
                      color: darkGreyColor,
                    ),
                  ],
                ),
              )
                  : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only( top: context.height * 0.1,
                      bottom: context.height * 0.04,),child:SvgPicture.asset(
                      Images.completePayment,
                      height: context.height * 0.12,
                      width: context.width * 0.1,
                    ) ,),
                    Text(LocaleKeys.paymentError.tr()),
                    SizedBox(
                      height: context.height * 0.1,
                    ),
                    CustomButton(
                      width: context.width * 0.8,
                      height: context.height * 0.06,
                      textButton:LocaleKeys.returnToTheApp.tr(),
                      onPressed: () async {
                        await  Restart.restartApp().then((value) => navigateAndRemove(SplashScreen()));
                        // RestartWidget.restartApp(context);
                        // navigateAndRemove(SplashScreen());
                      },
                      color: darkGreyColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
