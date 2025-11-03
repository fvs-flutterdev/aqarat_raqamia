import 'dart:ui';
import 'package:aqarat_raqamia/view/base/riyal_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/media_query_value.dart';
import '../../../utils/text_style.dart';
import '../../../utils/images.dart';
import '../../base/auth_header.dart';
import '../../../bloc/profile_cubit/cubit.dart';
import '../../../bloc/wallet_cubit/cubit.dart';
import '../../../bloc/wallet_cubit/state.dart';
import '../../../utils/dimention.dart';
import '../../../view/base/adaptive_dialog_loader.dart';
import '../../../view/base/custom_text_field.dart';
import '../../../view/base/main_button.dart';
import '../../base/show_toast.dart';

class MyWalletScreen extends StatefulWidget {
  MyWalletScreen({super.key});

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  final TextEditingController amountController = TextEditingController();
  // EdgeInsets _viewInsets = EdgeInsets.zero;
  // SingletonFlutterWindow? window;
//  ScrollController _controller = ScrollController();

  // @override
  // void initState() {
  //   super.initState();
  //
  //   window = WidgetsBinding.instance.window;
  //   window?.onMetricsChanged = () {
  //     if (mounted) {
  //       setState(() {
  //         final window = this.window;
  //         if (window != null) {
  //           _viewInsets = EdgeInsets.fromWindowPadding(
  //             window.viewInsets,
  //             window.devicePixelRatio,
  //           ).add(EdgeInsets.fromWindowPadding(
  //             window.padding,
  //             window.devicePixelRatio,
  //           )) as EdgeInsets;
  //         }
  //       });
  //     }
  //     ;
  //   };
  // }
  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var walletCubit = context.read<WalletCubit>();
    var profileCubit = context.read<ProfileCubit>();
    return Scaffold(

     // appBar: AuthHeader(title: LocaleKeys.myWallet.tr()),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(title: LocaleKeys.myWallet.tr()),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.15.w,
                  vertical: context.height * 0.07.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //    crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: SvgPicture.asset(
                          Images.Big_Wallet,
                          width: context.width * 0.4.w,
                          height: context.height * 0.13.h,
                        )),
                    SizedBox(
                      height: context.height * 0.08.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${LocaleKeys.availableBalance.tr()} ',
                          style: openSansExtraBold.copyWith(
                              color: darkGreyColor, fontSize: 17.sp),
                        ),
                        Row(
                          children: [
                            Text(
                              '${profileCubit.profileModel.userProfile?.wallet?.balance??0}',
                              style: openSansExtraBold.copyWith(
                                  color: goldColor, fontSize: 17.sp),
                            ),
                            SizedBox(width: context.width*0.005.w,),
                            riyalWidget(context),
                          ],
                        ),
                      ],
                    ),

                    // RichText(text: TextSpan(text: 'الرصيد المتاح ',style: openSansBold.copyWith(color: darkGreyColor),children: [
                    //   TextSpan(text: '50 ريال',style: openSansBold.copyWith(color: goldColor))
                    // ]))
                    SizedBox(
                      height: context.height * 0.1.h,
                    ),
                    BlocConsumer<WalletCubit, WalletState>(
                      listener: (context, state) {
                        if (state is ChargeWalletLoadingState)
                          adaptiveDialogLoader(context: context);
                        if (state is ChargeWalletErrorState) Navigator.pop(context);
                      },
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              //enableDrag: true,
                              isScrollControlled: true,

                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom:
                                        MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
                                      left: 16.0.sp,
                                      right: 16.0.sp,
                                      top: 20.0.sp,
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 15.sp),
                                      decoration: BoxDecoration(
                                          borderRadius:const BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  Dimensions.RADIUS_SMALL),
                                              topRight: Radius.circular(
                                                  Dimensions.RADIUS_SMALL))),
                                      child: Column(
                                      //  crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(LocaleKeys.enterChargeValue.tr(),style: openSansExtraBold.copyWith(color: darkGreyColor),),
                                          SizedBox(
                                            height: Dimensions.PADDING_SIZE_LARGE.h,
                                          ),
                                          CustomTextField(
                                            labelText: LocaleKeys.chargeValue.tr(),
                                            controller: amountController,
                                            keyboardType: TextInputType.number,
                                            // validator: (String val){
                                            //   if(val.isEmpty){
                                            //     return 'من فضلك ادخل قيمه الشحن';
                                            //   }
                                            // },
                                          ),
                                          CustomButton(
                                            textButton: LocaleKeys.pay.tr(),
                                            color: darkGreysColor,
                                            onPressed: () {
                                              if (amountController.text.isEmpty) {
                                                showCustomSnackBar(
                                                    message: LocaleKeys
                                                        .pleaseEnterChargeValue
                                                        .tr(),
                                                    state: ToastState.ERROR);
                                              } else {
                                                walletCubit.chargeWallet(
                                                    chargeValue: amountController.text);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                            // showAdaptiveDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return AlertDialog(
                            //         title: Text('أدخل القيمه'),
                            //         content: CustomTextField(
                            //           labelText: 'القيمه',
                            //           controller: amountController,
                            //         ),
                            //         actions: [
                            //           TextButton(onPressed: () {}, child: Text('دفع'))
                            //         ],
                            //       );
                            //     });
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            dashPattern: [
                              6,
                            ],
                            radius: const Radius.circular(5),
                            color: darkGreysColor,
                            padding: const EdgeInsets.all(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.RADIUS_DEFAULT.sp),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset(
                                    Images.Add_SVG,
                                    color: darkGreysColor,
                                  ),
                                  Text(
                                    LocaleKeys.recharge.tr(),
                                    style: openSansBold.copyWith(color: darkGreysColor),
                                  )
                                ],
                                //   width: 120,
                                // color: Colors.amber,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
