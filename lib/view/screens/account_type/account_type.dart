import 'package:aqarat_raqamia/bloc/start_app_cubit/cubit.dart';
import 'package:aqarat_raqamia/utils/dimention.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/shared_pref.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/base/main_button.dart';
import 'package:aqarat_raqamia/view/screens/auth/client_auth/login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgrader/upgrader.dart';
import '../../../../helper/responsive_helper.dart';
import '../../../bloc/account_type_cubit/cubit.dart';
import '../../../bloc/account_type_cubit/state.dart';
import '../../../bloc/setting_cubit/contact_us_cubit/cubit.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/app_constant.dart';
import '../bottom_navigation/main_screen.dart';

class AccountTypeScreen extends StatefulWidget {
  const AccountTypeScreen({super.key});

  @override
  State<AccountTypeScreen> createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // // Instantiate NewVersion manager object (Using GCP Console app as example)
    // final newVersion = NewVersionPlus(
    // //  iOSId: 'com.disney.disneyplus',
    //   androidId: 'com.fvs.aqaratraqamia.ksa',
    // //  androidPlayStoreCountry: "es_ES",
    //   androidHtmlReleaseNotes: true, //support country code
    // );
    //
    // // You can let the plugin handle fetching the status and showing a dialog,
    // // or you can fetch the status and display your own dialog, or no dialog.
    // final ver = VersionStatus(
    //
    //   appStoreLink: 'https://play.google.com/store/apps/details?id=com.fvs.aqaratraqamia.ksa',
    //   localVersion: '1.0.0',
    //   storeVersion: '1.0.0',
    //   releaseNotes: 'test',
    //   originalStoreVersion: '1.0.0',
    // );
    // print(ver);


    // if(mounted){
    //   final status = await newVersion.getVersionStatus();
    //   if (status != null) {
    //     // debugPrint(status.releaseNotes);
    //     // debugPrint(status.appStoreLink);
    //     // debugPrint(status.localVersion);
    //     // debugPrint(status.storeVersion);
    //     // debugPrint(status.canUpdate.toString());
    //
    //     newVersion.showUpdateDialog(
    //       context: context,
    //       versionStatus: status,
    //       dialogTitle:LocaleKeys.updateAvailable.tr(),
    //       dialogText: LocaleKeys.updateNow.tr(),
    //
    //       //  dismissButtonText: LocaleKeys.update.tr(),
    //       updateButtonText: LocaleKeys.update.tr(),
    //       launchModeVersion: LaunchModeVersion.external,
    //       allowDismissal: false,
    //     );
    //   }
    // }

  }

  @override
  Widget build(BuildContext context) {
    var accountTypeCubit =  context.read<AccountTypeCubit>();
    var startAppCubit = context.read<StartAppCubit>();
    var settingsCubit = context.read<ContactUsCubit>();
    return Scaffold(
      body:
      // UpgradeAlert(
      //   upgrader: Upgrader(
      //     languageCode: myLocale.toString(),
      //     debugDisplayAlways: true,
      //     storeController: UpgraderStoreController(
      //       onAndroid: () => UpgraderPlayStore(),
      //     ),
      //     debugLogging: true,
      //     minAppVersion: "1.0.0+1",
      //   ),
      //   child:
        BlocConsumer<AccountTypeCubit, AccountTypeState>(
            listener: (context, state) {},
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: context.height * 0.2,
                      decoration: BoxDecoration(
                          color: darkGreyColor,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(Dimensions.RADIUS_LARGE),
                              bottomRight:
                                  Radius.circular(Dimensions.RADIUS_LARGE))),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.accountType.tr(),
                                style:
                                    openSansMedium.copyWith(color: darkGreyColor),
                              ),
                              InkWell(
                                onTap: () {
                                  settingsCubit.changeLanguage(context);
                                  // myLocale == 'ar'
                                  //     ? startAppCubit.setLanguage(
                                  //         Locale(
                                  //             AppConstant.languages[1].languageCode,
                                  //             AppConstant.languages[1].countryCode),
                                  //         context)
                                  //     : startAppCubit.setLanguage(
                                  //         Locale(
                                  //             AppConstant.languages[0].languageCode,
                                  //             AppConstant.languages[0].countryCode),
                                  //         context);
                                },
                                child: Text(
                                  LocaleKeys.languageType.tr(),
                                  style: openSansExtraBold.copyWith(
                                      color: darkGreyColor),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_SMALL,
                          ),
                          Text(
                            LocaleKeys.chooseAccountType.tr(),
                            style: openSansMedium.copyWith(color: darkGreyColor),
                          ),
                          Container(
                            // height: 100,
                            child: GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 2,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            ResponsiveHelper.isDesktop(context)
                                                ? 4
                                                : ResponsiveHelper.isTab(context)
                                                    ? 3
                                                    : 2,
                                        childAspectRatio: (1 / 1),
                                        crossAxisSpacing: 15),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      accountTypeCubit.setSelectIndex(index);
                                    },
                                    child: Container(
                                      width: context.height * 0.1,
                                      height: context.height * 0.1,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  accountTypeCubit.selectedIndex ==
                                                          index
                                                      ? goldColor
                                                      : transparentColor),
                                          color: Theme.of(context).splashColor,
                                          borderRadius: BorderRadius.circular(
                                              context.height * 0.02)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          FancyShimmerImage(
                                            imageUrl: startAppCubit.accountTypeModel
                                                    .data?[index].image ??
                                                '',
                                            width: context.height * 0.1,
                                            height: context.height * 0.1,

                                          ),
                                          //  Image.network(startAppCubit.accountTypeModel.data?[index].image??''),
                                          Text(
                                            startAppCubit.accountTypeModel
                                                    .data?[index].title ??
                                                '',
                                            style: openSansRegular.copyWith(
                                                color: darkGreyColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: TextButton(
                                onPressed: () {
                                  //  accountType == 'service_applicant';
                                  navigateForward(MainScreenNavigation());
                                },
                                child: Text(
                                  LocaleKeys.signAsGuest.tr(),
                                  // textAlign: TextAlign.center,
                                  style: openSansBold.copyWith(
                                    color: goldColor,
                                    decoration: TextDecoration.underline,
                                    //  fontFamily: 'OpenSans',
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          CustomButton(
                              color: darkGreyColor,
                              textButton: LocaleKeys.next.tr(),
                              onPressed: () {
                                accountTypeCubit.selectedIndex == 0
                                    ? AppConstant.account_type =
                                        CacheHelper.saveData(
                                        key: 'accountType',
                                        value: 'service_applicant',
                                      )
                                    : AppConstant.account_type =
                                        CacheHelper.saveData(
                                        key: 'accountType',
                                        value: 'service_provider ',
                                      );
                                navigateForward(ClientLogin(
                                    id: accountTypeCubit.selectedIndex ?? 0));

                                print('object');
                              }),
                          SizedBox(
                            height: 20.sp,
                          ),
                          SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                              child: accountTypeCubit.selectedIndex == 0
                                  ? Html(
                                  data: startAppCubit.accountTypeModel.data?[0]
                                      .description ??
                                      '')
                                  : Html(
                                  data: startAppCubit.accountTypeModel.data?[1]
                                      .description ??
                                      '')),


                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
     // ),
    );
  }
}
