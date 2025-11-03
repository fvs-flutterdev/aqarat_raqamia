import 'package:aqarat_raqamia/view/base/custom_text_field.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/base/riyal_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restart_app/restart_app.dart';
import '../../../utils/media_query_value.dart';
import '../../../view/base/adaptive_dialog_loader.dart';
import '../../../view/base/auth_header.dart';
import '../../../view/base/shimmer/ads_shimmer.dart';
import '../../../view/restart_widget/restart_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/upload_request_cubit/cubit.dart';
import '../../../bloc/upload_request_cubit/state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/text_style.dart';
import '../../base/main_button.dart';
import '../splash/splash_screen.dart';

//ignore: must_be_immutable
class MakeSponsoredAds extends StatefulWidget {
  int adId;
  bool isComeFromAddAds;

  MakeSponsoredAds({super.key, required this.adId,this.isComeFromAddAds=false});

  @override
  State<MakeSponsoredAds> createState() => _MakeSponsoredAdsState();
}

class _MakeSponsoredAdsState extends State<MakeSponsoredAds> {
  final TextEditingController promoCodeController = TextEditingController();

  @override
  void dispose() {
    promoCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var uploadRequestCubit = UploadRequestCubit.get(context);
    return Scaffold(
     // appBar: AuthHeader(isCanBack: true, title: LocaleKeys.adFinancing.tr()),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(title: LocaleKeys.adFinancing.tr(),isCanBack:widget.isComeFromAddAds==false? true:false,),
          ),
          Expanded(
            child: BlocConsumer<UploadRequestCubit, UploadRequestState>(
              listener: (context, state) {
                if (state is CreateSponsoredAdLoadingState) {
                  adaptiveDialogLoader(context: context);
                } else if (state is CreateSponsoredAdErrorState) {
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                return state is GetSponsorAdsDetailsLoadingState ||
                        state is InitialUploadRequestState
                    ? AdsShimmer()
                    : GestureDetector(
                  onTap: ()=>FocusManager.instance.primaryFocus!.unfocus(),
                      child: Column(
                          children: [
                            Text(
                              LocaleKeys.wantFinanceAd.tr(),
                              style: openSansExtraBold.copyWith(color: redColor),
                            ),
                            Card(
                              color:whiteColor,
                              elevation:3,
                              margin: const EdgeInsets.all(8.0),
                              child: CheckboxListTile(
                                  // contentPadding: EdgeInsets.zero,
                                  title: Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            text: LocaleKeys.prominentAd.tr(),
                                            style: openSansRegular.copyWith(
                                                color: darkGreyColor),
                                            children: [
                                              TextSpan(
                                                  style: openSansRegular.copyWith(
                                                      color: goldColor),
                                                  text:
                                                      //LocaleKeys
                                                      '${LocaleKeys.costYou.tr()} ${uploadRequestCubit.sponsorAdsDetailsModel.data?.promotionValue.toString()}')
                                            ]),
                                      ),
                                      SizedBox(width: context.width*0.005.w,),
                                      riyalWidget(context),

                                    ],
                                  ),
                                  subtitle: RichText(
                                    text: TextSpan(
                                        text: LocaleKeys.durationAd.tr(),
                                        style: openSansRegular.copyWith(
                                            color: darkGreyColor),
                                        children: [
                                          TextSpan(
                                              style: openSansRegular.copyWith(
                                                  color: goldColor),
                                              text:
                                                  '${uploadRequestCubit.sponsorAdsDetailsModel.data?.promotionDays.toString()} ${LocaleKeys.day.tr()}')
                                        ]),
                                  ),
                                  value: uploadRequestCubit.isSpecialAds,
                                  onChanged: (val) {
                                    uploadRequestCubit.changeSpecialAdsState(val);
                                    print(val);
                                  }),
                            ),
                            uploadRequestCubit.isSpecialAds == true
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomTextField(
                                      labelText: LocaleKeys.discountCoupon.tr(),
                                      controller: promoCodeController,
                                    ),
                                  )
                                : const SizedBox(),
                            const Spacer(),
                            uploadRequestCubit.isSpecialAds
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: context.height * 0.05),
                                    child: CustomButton(
                                      textButton: LocaleKeys.payForWallet.tr(),
                                      onPressed: () {
                                        uploadRequestCubit.payForSponsoredAd(
                                            context: context,
                                            isWallet: true,
                                            adId: widget.adId,
                                            promoCode: promoCodeController.text);
                                      },
                                      color: goldColor,
                                      // width: context.width * 0.5,
                                    ),
                                  )
                                : SizedBox(),
                            Padding(
                              padding: EdgeInsets.only(
                                right: context.height * 0.05,
                                left: context.height * 0.05,
                                bottom: context.height * 0.05,
                                top: context.height * 0.02,
                              ),
                              child: CustomButton(
                                textButton: uploadRequestCubit.isSpecialAds
                                    ? LocaleKeys.pay.tr()
                                    : LocaleKeys.goToMain.tr(),
                                onPressed: () async {
                                  if (uploadRequestCubit.isSpecialAds == true) {
                                    uploadRequestCubit.payForSponsoredAd(
                                        context: context,
                                        isWallet: false,
                                        adId: widget.adId,
                                        promoCode: promoCodeController.text);
                                  } else {
                                    await  Restart.restartApp().then((value) => navigateAndRemove(SplashScreen()));
                                    // RestartWidget.restartApp(context);
                                    // navigateAndRemove(SplashScreen());
                                  }
                                },
                                // uploadRequestCubit.isSpecialAds
                                //                   ? () {
                                //                       uploadRequestCubit.payForSponsoredAd(
                                //                           context: context,
                                //                           isWallet: false,
                                //                           adId: widget.adId,
                                //                           promoCode: promoCodeController.text);
                                //                     }
                                //                   : () {
                                //                       RestartWidget.restartApp(context);
                                //                    //   navigateAndRemove(SplashScreen());
                                //                     },
                                color: goldColor,
                                // width: context.width * 0.5,
                              ),
                            ),
                          ],
                        ),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
