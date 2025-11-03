import 'package:aqarat_raqamia/translation/locale_keys.g.dart';
import 'package:aqarat_raqamia/utils/images.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/screens/splash/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restart_app/restart_app.dart';
import '../../../../bloc/upload_request_cubit/cubit.dart';
import '../../../../bloc/upload_request_cubit/state.dart';
import '../../../../utils/text_style.dart';
import '../../../base/main_button.dart';
import '../../../base/riyal_widget.dart';
import '../../../restart_widget/restart_widget.dart';

class CompletePayWithWallet extends StatefulWidget {
  final dynamic withDrawAmount;
  final dynamic remainingValue;

  const CompletePayWithWallet(
      {super.key, required this.withDrawAmount, required this.remainingValue});

  @override
  State<CompletePayWithWallet> createState() => _CompletePayWithWalletState();
}

class _CompletePayWithWalletState extends State<CompletePayWithWallet> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadRequestCubit, UploadRequestState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: context.height * 0.1),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SvgPicture.asset(
                        Images.completePayment,
                        height: context.height * 0.12,
                        width: context.width * 0.1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "${LocaleKeys.amountWithdrawn.tr()} : ",
                            style: openSansExtraBold.copyWith(
                                color: darkGreysColor),
                            children: [
                              TextSpan(text: '${widget.withDrawAmount}')
                            ],
                          ),
                        ),
                        SizedBox(
                          width: context.width * 0.005.w,
                        ),
                        riyalWidget(context),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: context.height * 0.07),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "${LocaleKeys.availableBalance.tr()} : ",
                              style: openSansExtraBold.copyWith(
                                  color: darkGreysColor),
                              children: [TextSpan(text: widget.remainingValue.toString())],
                            ),
                          ),
                          SizedBox(
                            width: context.width * 0.005.w,
                          ),
                          riyalWidget(context),
                        ],
                      ),
                    ),
                    //  Spacer(),
                    CustomButton(
                      width: context.width * 0.8,
                      height: context.height * 0.06,
                      textButton: LocaleKeys.returnToTheApp.tr(),
                      onPressed: () async {
                        await Restart.restartApp()
                            .then((value) => navigateAndRemove(SplashScreen()));
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
