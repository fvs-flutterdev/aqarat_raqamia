import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../bloc/provider_orders_cubit/price_offer_cubit/cubit.dart';
import '../../../../../bloc/provider_orders_cubit/price_offer_cubit/state.dart';
import '../../../../../utils/media_query_value.dart';
import '../../../../../view/base/show_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../translation/locale_keys.g.dart';
import '../../../../../utils/dimention.dart';
import '../../../../../utils/text_style.dart';
import '../../../../base/adaptive_dialog_loader.dart';
import '../../../../base/custom_text_field.dart';
import '../../../../base/main_button.dart';

class SendOfferPriceButton extends StatefulWidget {
  String orderId;

  SendOfferPriceButton({super.key, required this.orderId});

  @override
  State<SendOfferPriceButton> createState() => _SendOfferPriceButtonState();
}

class _SendOfferPriceButtonState extends State<SendOfferPriceButton> {
  // TextEditingController orderDetailsController = TextEditingController();
  //
  // TextEditingController orderPriceController = TextEditingController();

  // @override
  // void dispose() {
  //   super.dispose();
  //   if(mounted){
  //     context.read<SendOfferPriceCubit>().dispose();
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    var priceOfferCubit = context.read<SendOfferPriceCubit>();
    return BlocConsumer<SendOfferPriceCubit, SendPriceOfferState>(
      listener: (context, state) {
        if (state is SendPriceOfferLoadingState) {
          adaptiveDialogLoader(context: context);
        }
        if (state is SendPriceOfferSuccessState ||
            state is SendPriceOfferErrorState) {
          Navigator.pop(context);
        }
      },
      // listener: (context, state) {
      //   // TODO: implement listener
      // },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                textButton: LocaleKeys.sendPriceOffer.tr(),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus!.unfocus();
                          },
                          child: Container(
                            height: context.height * 0.8,
                            padding: const EdgeInsets.all(8),
                            color: whiteColor,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const SizedBox(
                                    height: Dimensions.PADDING_SIZE_LARGE,
                                  ),
                                  Text(
                                    LocaleKeys.sendPriceOffer.tr(),
                                    style: openSansExtraBold.copyWith(
                                        color: darkGreyColor),
                                  ),
                                  const SizedBox(
                                    height: Dimensions.PADDING_SIZE_LARGE,
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: Dimensions.PADDING_SIZE_DEFAULT,
                                  ),
                                  CustomTextField(
                                    labelText: LocaleKeys.servicePrice.tr(),
                                    keyboardType: TextInputType.number,
                                    controller: priceOfferCubit.orderPriceController,
                                  ),
                                  CustomTextField(
                                    labelText: LocaleKeys.serviceDetails.tr(),
                                    isBig: true,
                                    controller:priceOfferCubit.orderDetailsController,
                                    lines: 9,
                                    maxHeight: context.width * 0.39,
                                    //context.width * 0.39,
                                    minHeight: context.width * 0.39,
                                  ),
                                  Align(
                                      alignment: AlignmentDirectional.topStart,
                                      child: Text(
                                        LocaleKeys.dateLine.tr(),
                                        style: openSansBold.copyWith(
                                            color: darkGreyColor),
                                      )),
                                  Container(
                                    height: context.width * 0.4,
                                    child: CupertinoPicker(
                                        magnification: 1.5,
                                        looping: true,
                                        itemExtent: 20,
                                        onSelectedItemChanged: (int value) {
                                          print(value);
                                          priceOfferCubit
                                              .changeServiceDay(value);
                                        },
                                        children: List.generate(
                                            30,
                                            (index) => Row(
                                            //  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:  EdgeInsetsDirectional.only(end: context.width*0.02.w),
                                                      child: Text(
                                                        index.toString(),
                                                        style: openSansRegular
                                                            .copyWith(
                                                                color:
                                                                    darkGreyColor),
                                                      ),
                                                    ),

                                                    Text(LocaleKeys.day.tr(),
                                                      style: openSansRegular
                                                          .copyWith(
                                                          color:
                                                          darkGreyColor),
                                                    ),
                                                  ],
                                                ))
                                        // [
                                        //   Text(
                                        //     '1',
                                        //     style: openSansRegular.copyWith(
                                        //         color: darkGreyColor),
                                        //   ),
                                        //   Text(
                                        //     '2',
                                        //     style: openSansRegular.copyWith(
                                        //         color: darkGreyColor),
                                        //   ),
                                        //   Text(
                                        //     '3',
                                        //     style: openSansRegular.copyWith(
                                        //         color: darkGreyColor),
                                        //   ),
                                        //   Text(
                                        //     '4',
                                        //     style: openSansRegular.copyWith(
                                        //         color: darkGreyColor),
                                        //   ),
                                        //   Text(
                                        //     '5',
                                        //     style: openSansRegular.copyWith(
                                        //         color: darkGreyColor),
                                        //   ),
                                        // ],
                                        ),
                                  ),
                                  //Spacer(),
                                  SizedBox(
                                    height: context.width * 0.15,
                                  ),
                                  //SizedBox(),
                                  //state is
                                  Align(
                                      alignment:
                                          AlignmentDirectional.bottomCenter,
                                      child: CustomButton(
                                        textButton:
                                            LocaleKeys.sendPriceOffer.tr(),
                                        onPressed: () {
                                          //  Navigator.pop(context);
                                          if (priceOfferCubit.serviceDays ==
                                                  0 ||
                                              priceOfferCubit.serviceDays ==
                                                  null) {
                                            showCustomSnackBar(
                                                message: LocaleKeys
                                                    .enterPriceOfferExpiry
                                                    .tr(),
                                                state: ToastState.ERROR);
                                          } else {
                                            priceOfferCubit.sendPriceOffer(
                                              context: context,
                                              orderId: widget.orderId,
                                              // orderDetails:
                                              //     orderDetailsController.text,
                                              // price: orderPriceController.text,
                                            );
                                          }
                                        },
                                        color: darkGreyColor,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                  // Get.bottomSheet(
                  //
                  //   Container(
                  //     height: context.height*0.8,
                  //     padding: EdgeInsets.all(8),
                  //     color: whiteColor,
                  //     child: SingleChildScrollView(
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.max,
                  //         children: [
                  //           SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
                  //           Text('إرسال عرض السعر',style: openSansExtraBold.copyWith(color: darkGreyColor),),
                  //           SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
                  //           Divider(),
                  //           SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                  //           CustomTextField(labelText: 'سعر الخدمه',keyboardType: TextInputType.number,),
                  //           CustomTextField(
                  //             labelText: 'تفاصيل خاصه بالخدمه',
                  //             isBig: true,
                  //             lines: 9,
                  //             maxHeight: 150.h,
                  //             minHeight: 150.h,
                  //           ),
                  //           Align(alignment: AlignmentDirectional.topStart,
                  //               child: Text('مده عرض السعر',style: openSansBold.copyWith(color: darkGreyColor),)),
                  //           Container(
                  //             height: context.width*0.3,
                  //             child: CupertinoPicker(
                  //               magnification: 1.5,
                  //               looping: true,
                  //               itemExtent: 20,
                  //               onSelectedItemChanged: (int value) {
                  //                 print(value);
                  //               },
                  //               children:List.generate(30, (index) =>Text(index.toString()))
                  //               // [
                  //               //   Text(
                  //               //     '1',
                  //               //     style: openSansRegular.copyWith(
                  //               //         color: darkGreyColor),
                  //               //   ),
                  //               //   Text(
                  //               //     '2',
                  //               //     style: openSansRegular.copyWith(
                  //               //         color: darkGreyColor),
                  //               //   ),
                  //               //   Text(
                  //               //     '3',
                  //               //     style: openSansRegular.copyWith(
                  //               //         color: darkGreyColor),
                  //               //   ),
                  //               //   Text(
                  //               //     '4',
                  //               //     style: openSansRegular.copyWith(
                  //               //         color: darkGreyColor),
                  //               //   ),
                  //               //   Text(
                  //               //     '5',
                  //               //     style: openSansRegular.copyWith(
                  //               //         color: darkGreyColor),
                  //               //   ),
                  //               // ],
                  //             ),
                  //           ),
                  //           SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
                  //           CustomButton(textButton: 'إرسال عرض السعر', onPressed: (){},color: darkGreyColor,)
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  //   ignoreSafeArea: true,
                  //
                  // );
                },
                color: darkGreyColor,
              )),
        );
      },
    );
  }
}
