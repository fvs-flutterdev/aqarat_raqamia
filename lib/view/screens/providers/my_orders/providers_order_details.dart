import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../bloc/provider_orders_cubit/price_offer_cubit/cubit.dart';
import '../../../../../utils/dimention.dart';
import '../../../../../utils/media_query_value.dart';
import '../../../../../utils/text_style.dart';
import '../../../../../view/base/auth_header.dart';
import '../../../../../view/base/custom_text_field.dart';
import '../../../../../view/base/full_screen_image/full_screen_image.dart';
import '../../../../../view/base/lunch_widget.dart';
import '../../../../../view/base/main_button.dart';
import '../../../../../view/screens/providers/my_orders/widget/current_order_widget.dart';
import '../../../../../view/screens/providers/my_orders/widget/send_offer_price.dart';
import '../../../../bloc/provider_orders_cubit/cubit.dart';
import '../../../../bloc/provider_orders_cubit/provider_old_orders_cubit/cubit.dart';
import '../../../../bloc/provider_orders_cubit/provider_old_orders_cubit/state.dart';
import '../../../../bloc/provider_orders_cubit/state.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/app_constant.dart';
import '../../../../utils/images.dart';
import '../../../base/adaptive_dialog_loader.dart';
import '../../../base/carousel_slider_widget.dart';
import '../../../base/show_toast.dart';
import '../../location/map_string.dart';
import '../../my_orders/rate/rate_widget.dart';

//ignore: must_be_immutable
class OrderDetailsProvidersScreen extends StatefulWidget {
  dynamic orderId;

  OrderDetailsProvidersScreen({
    required this.orderId,
  });

  @override
  State<OrderDetailsProvidersScreen> createState() =>
      _OrderDetailsProvidersScreenState();
}

class _OrderDetailsProvidersScreenState
    extends State<OrderDetailsProvidersScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrdersProviderCubit>().getOrderById(id: widget.orderId);
    });

    super.initState();
  }

  // @override
  // void dispose() {
  //     if(mounted) {
  //       context
  //           .read<OldProviderOrdersCubit>()
  //           .rateNotesController
  //           .dispose();
  //     }
  //  // context.read<OldProviderOrdersCubit>.rateNotesController.dispose();
  //   super.dispose();
  // }

  // @override
  // void deactivate() {
  //   if(mounted) {
  //     context
  //         .read<OldProviderOrdersCubit>()
  //         .rateNotesController
  //         .dispose();
  //   }
  //   super.deactivate();
  // }

  @override
  Widget build(BuildContext context) {
    var ordersProviderCubit = context.read<OrdersProviderCubit>();
    var offerPrice = context.read<SendOfferPriceCubit>();
    var oldProviderCubit = context.read<OldProviderOrdersCubit>();
    return BlocConsumer<OrdersProviderCubit, ProviderOrdersState>(
      listener: (context, state) {
        if (state is FinishOrderLoadingState) {
          adaptiveDialogLoader(context: context);
        } else if (state is FinishOrderErrorState) {
          Navigator.pop(context);
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          // appBar: AuthHeader(
          //   title: '${LocaleKeys.orderNo.tr()} ${widget.orderId}',
          // ),
          body: ordersProviderCubit.isGetOrderById == false
              ? adaptiveCircleProgress()
              : Column(
                  children: [
                    Container(
                      height: context.height * 0.17.h,
                      margin: EdgeInsets.zero,
                      child: AuthHeader(
                          title:
                              '${LocaleKeys.orderNo.tr()} ${widget.orderId}'),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ordersProviderCubit.orderByIdModel.data?.isSent ==
                                        true &&
                                    ordersProviderCubit
                                            .orderByIdModel.data?.status ==
                                        'pending'
                                //   widget.isSent == true
                                ? Container(
                                    width: double.infinity,
                                    height: context.width * 0.1.sp,
                                    color: redColor.withOpacity(0.1),
                                    child: Center(
                                        child: Text(
                                          LocaleKeys.priceOfferSent.tr(),
                                      style: openSansBold.copyWith(
                                          color: redColor),
                                    )),
                                  )
                                : const SizedBox(),
                            ordersProviderCubit.orderByIdModel.data?.isSent ==
                                        true &&
                                    ordersProviderCubit
                                            .orderByIdModel.data?.status ==
                                        'pending'
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            top: context.height * 0.02,
                                            bottom: context.height * 0.00,
                                            start: context.height * 0.02),
                                        child: Text(
                                          LocaleKeys.previousPriceOffer.tr(),
                                          style: openSansExtraBold.copyWith(
                                              color: redColor),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsetsDirectional.symmetric(
                                            horizontal:
                                                Dimensions.PADDING_SIZE_SMALL),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.r)),
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: ordersProviderCubit
                                                .orderByIdModel
                                                .data
                                                ?.priceOffers
                                                ?.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                elevation: 2,
                                                color: whiteColor,
                                                child: Container(
                                                  padding: EdgeInsetsDirectional
                                                      .only(
                                                          // bottom:
                                                          //     context.height *
                                                          //         0.02,
                                                          end: context.height *
                                                              0.01,
                                                          start:
                                                              context.height *
                                                                  0.01),
                                                  // margin: EdgeInsetsDirectional
                                                  //     .only(
                                                  //         bottom:
                                                  //             context.height *
                                                  //                 0.01),
                                                  color: whiteColor,
                                                  child: Column(
                                                    // crossAxisAlignment:
                                                    //     CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CustomTextField(
                                                        backgroundColor:
                                                            lightGrey,
                                                        topPadding:
                                                            context.height *
                                                                0.02.h,
                                                        labelText:
                                                            "${LocaleKeys.previousPrice.tr()}",
                                                        controller: TextEditingController(
                                                            text: ordersProviderCubit
                                                                .orderByIdModel
                                                                .data
                                                                ?.priceOffers?[
                                                                    index]
                                                                .price
                                                                .toString()),
                                                        isEnabled: false,
                                                        style: openSansMedium
                                                            .copyWith(
                                                                color:
                                                                    darkGreyColor),
                                                      ),

                                                      CustomTextField(
                                                        backgroundColor:
                                                            lightGrey,
                                                        labelText: LocaleKeys
                                                            .previousDescriptionOfPriceOffer
                                                            .tr(),
                                                        style: openSansMedium
                                                            .copyWith(
                                                                color:
                                                                    darkGreyColor),
                                                        controller: TextEditingController(
                                                            text: ordersProviderCubit
                                                                    .orderByIdModel
                                                                    .data
                                                                    ?.priceOffers?[
                                                                        index]
                                                                    .serviceDetails ??
                                                                LocaleKeys
                                                                    .noDescriptions
                                                                    .tr()),
                                                        isEnabled: false,
                                                      ),
                                                      //   CustomTextField(labelText: LocaleKeys.previousPrice.tr(),controller: TextEditingController(text: ordersProviderCubit.orderByIdModel.data?.priceOffers?[index].price.toString()),isEnabled: false,),
                                                      CustomTextField(
                                                        backgroundColor:
                                                            lightGrey,
                                                        labelText: LocaleKeys
                                                            .status
                                                            .tr(),
                                                        style: ordersProviderCubit
                                                                    .orderByIdModel
                                                                    .data
                                                                    ?.priceOffers?[
                                                                        index]
                                                                    .bidDuration
                                                                    ?.remainingTime ==
                                                                "0"
                                                            ? openSansMedium
                                                                .copyWith(
                                                                    color:
                                                                        redColor)
                                                            : openSansMedium
                                                                .copyWith(
                                                                    color: Colors
                                                                        .green),
                                                        controller: TextEditingController(
                                                            text: ordersProviderCubit
                                                                        .orderByIdModel
                                                                        .data
                                                                        ?.priceOffers?[
                                                                            index]
                                                                        .bidDuration
                                                                        ?.remainingTime ==
                                                                    "0"
                                                                ? LocaleKeys
                                                                    .expired
                                                                    .tr()
                                                                : LocaleKeys
                                                                    .active
                                                                    .tr()),
                                                        isEnabled: false,
                                                      ),
                                                      // RichText(text:TextSpan(text: '${LocaleKeys.previousPrice.tr()} : ',style: openSansBold.copyWith(color: darkGreyColor),children: [
                                                      //   TextSpan(text: '${ordersProviderCubit.orderByIdModel.data?.priceOffers?[index].price}',style: openSansBold.copyWith(color: darkGreyColor),)
                                                      //
                                                      // ])),
                                                      // RichText(text:TextSpan(text: '${LocaleKeys.previousDescriptionOfPriceOffer.tr()} : ',style: openSansBold.copyWith(color: darkGreyColor),children: [
                                                      //   TextSpan(text: ordersProviderCubit.orderByIdModel.data?.priceOffers?[index].serviceDetails??LocaleKeys.noDescriptions.tr(),style: openSansBold.copyWith(color: darkGreyColor),)
                                                      //
                                                      // ])),
                                                      // RichText(text:TextSpan(text: '${LocaleKeys.status.tr()} : ',style: openSansBold.copyWith(color: darkGreyColor),children: [
                                                      //   ordersProviderCubit
                                                      //       .orderByIdModel.data?.priceOffers?[index].bidDuration?.remainingTime=="0"?
                                                      //   TextSpan(text: '${LocaleKeys.expired.tr()}',style: openSansBold.copyWith(color: redColor),)
                                                      //       :
                                                      //   TextSpan(text: '${LocaleKeys.active.tr()}',style: openSansBold.copyWith(color: Colors.green),)
                                                      //
                                                      // ])),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: context.height * 0.01.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_DEFAULT),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    labelText: LocaleKeys.mainService.tr(),
                                    controller: TextEditingController(
                                        text: ordersProviderCubit.orderByIdModel
                                            .data?.servicesId?.name
                                        // widget.serviceName ?? ''
                                        ),
                                    backgroundColor: lightGrey,
                                    isEnabled: false,
                                  ),
                                  CustomTextField(
                                    labelText: LocaleKeys.subService.tr(),
                                    controller: TextEditingController(
                                        text: ordersProviderCubit.orderByIdModel
                                            .data?.subServicesId?.name
                                        // widget.subServiceName ?? ''
                                        ),
                                    backgroundColor: lightGrey,
                                    isEnabled: false,
                                  ),

                                  CustomTextField(
                                    labelText:
                                        LocaleKeys.serviceDescription.tr(),
                                    isBig: true,
                                    lines: 9,
                                    maxHeight: context.width * 0.39.sp,
                                    minHeight: context.width * 0.39.sp,
                                    controller: TextEditingController(
                                        text: ordersProviderCubit
                                            .orderByIdModel.data?.notes
                                        // widget.note
                                        ),
                                    isEnabled: false,
                                  ),
                                  Text(
                                    LocaleKeys.location.tr(),
                                    style: openSansMedium.copyWith(
                                        color: darkGreyColor),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (ordersProviderCubit.orderByIdModel
                                                      .data?.lat ==
                                                  null ||
                                              ordersProviderCubit.orderByIdModel
                                                      .data?.lan ==
                                                  null
                                          // widget.lat == null || widget.lng == null
                                          ) {
                                        showCustomSnackBar(
                                            message: LocaleKeys.error.tr(),
                                            state: ToastState.ERROR);
                                      } else {
                                        if (Platform.isIOS) {
                                          await launchUrl(Uri.parse(
                                              "comgooglemaps://?q=${ordersProviderCubit.orderByIdModel.data?.lat},"
                                              "${ordersProviderCubit.orderByIdModel.data?.lan}&key=AIzaSyAqld28c3M4zNPxKPvXj3eb3WzqrrrDbOY"));
                                        } else {
                                          await launchUrl(Uri.parse(
                                              'https://www.google.com/maps/search/?api=1&query='
                                              '${ordersProviderCubit.orderByIdModel.data?.lat}, '
                                              '${ordersProviderCubit.orderByIdModel.data?.lan}'
                                              '&key=AIzaSyAqld28c3M4zNPxKPvXj3eb3WzqrrrDbOY'));
                                        }
                                      }
                                    },
                                    child: LocationView(
                                        double.parse(ordersProviderCubit
                                                    .orderByIdModel.data?.lat ??
                                                ''
                                            //     widget.lat??''
                                            ),
                                        double.parse(ordersProviderCubit
                                                    .orderByIdModel.data?.lan ??
                                                ''
                                            // widget.lng??''
                                            )),
                                  ),
                                  SizedBox(
                                    height: 20.sp,
                                  ),
                                  // widget.photos!.isEmpty
                                  ordersProviderCubit
                                          .orderByIdModel.data!.photos!.isEmpty
                                      ? const SizedBox()
                                      : Text(
                                          LocaleKeys.attachments.tr(),
                                          style: openSansMedium.copyWith(
                                              color: darkGreyColor),
                                        ),
                                  // SizedBox(
                                  //   height: 20.sp,
                                  // ),
                                  // widget.photos!.isEmpty
                                  ordersProviderCubit
                                          .orderByIdModel.data!.photos!.isEmpty
                                      ? const SizedBox()
                                      : GestureDetector(
                                          onTap: () {
                                            navigateForward(FullImageListScreen(
                                                itemCount: ordersProviderCubit
                                                    .orderByIdModel
                                                    .data!
                                                    .photos!
                                                    .length,
                                                image: ordersProviderCubit
                                                    .orderByIdModel
                                                    .data!
                                                    .photos!));
                                          },
                                          child: CustomCarouselSliderWidget(
                                            photos: ordersProviderCubit
                                                .orderByIdModel.data!.photos!,
                                            height: context.height * 0.25.sp,
                                            count: ordersProviderCubit
                                                .orderByIdModel
                                                .data!
                                                .photos!
                                                .length,
                                            selectedIndex:
                                                offerPrice.selectedIndex,
                                            changeIndexFunction: (i) {
                                              offerPrice.changeIndexCarousel(i);
                                            },
                                          ),
                                        ),
                                  SizedBox(
                                    height: 20.sp,
                                  ),
                                  ordersProviderCubit
                                              .orderByIdModel.data!.status ==
                                          'pending'
                                      // widget.orderStatus == 0
                                      ? SendOfferPriceButton(
                                          orderId: widget.orderId.toString(),
                                        )
                                      : UserInfoWidget(
                                          //id: widget.userId,
                                          id: ordersProviderCubit.orderByIdModel
                                              .data!.userRequestServices?.id,
                                          isPrevious: true,
                                          isUser: true,
                                          //  name: widget.name ?? '',
                                          name: ordersProviderCubit
                                              .orderByIdModel
                                              .data!
                                              .userRequestServices
                                              ?.name,
                                          // image: widget.photo ?? '',
                                          image: ordersProviderCubit
                                              .orderByIdModel
                                              .data!
                                              .userRequestServices
                                              ?.photo,
                                        ),
                                  // widget.orderStatus == 1?
                                  ordersProviderCubit
                                              .orderByIdModel.data!.status ==
                                          'accepted'
                                      ? Column(
                                          children: [
                                            CustomButton(
                                              textButton:
                                                  LocaleKeys.finishService.tr(),
                                              onPressed: () {
                                                ordersProviderCubit.finishOrder(
                                                    context: context,
                                                    orderId: int.parse(
                                                        widget.orderId));
                                              },
                                              color: darkGreyColor,
                                            ),
                                          ],
                                        )
                                      : ordersProviderCubit.orderByIdModel.data!
                                                      .status ==
                                                  "finished" ||
                                              ordersProviderCubit.orderByIdModel
                                                      .data!.status ==
                                                  "declined"
                                          ? BlocConsumer<OldProviderOrdersCubit,
                                              OldProviderOrdersState>(
                                              listener: (context, state) {
                                                if (state
                                                    is RateClientLoadingState) {
                                                  adaptiveDialogLoader(
                                                      context: context);
                                                } else if (state
                                                        is RateClientSuccessState ||
                                                    state
                                                        is RateClientErrorState) {
                                                  Navigator.pop(context);
                                                }
                                              },
                                              builder: (context, state) {
                                                return CustomButton(
                                                    textButton: LocaleKeys
                                                        .rateClient
                                                        .tr(),
                                                    color: darkGreyColor,
                                                    onPressed: () {
                                                      showBottomSheet(
                                                          context: context,
                                                          builder: (context) {
                                                            return GestureDetector(
                                                              onTap: () {
                                                                FocusManager
                                                                    .instance
                                                                    .primaryFocus!
                                                                    .unfocus();
                                                              },
                                                              child: Container(
                                                                height: context
                                                                        .height *
                                                                    0.5.sp,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(8
                                                                            .sp),
                                                                color:
                                                                    whiteColor,
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Text(
                                                                        LocaleKeys
                                                                            .rateClient
                                                                            .tr(),
                                                                        style: openSansBold.copyWith(
                                                                            color:
                                                                                darkGreyColor),
                                                                      ),
                                                                      Divider(
                                                                        endIndent:
                                                                            15.sp,
                                                                        indent:
                                                                            15.sp,
                                                                        thickness:
                                                                            2.sp,
                                                                      ),
                                                                      Image.asset(
                                                                          Images
                                                                              .RATE),
                                                                      StarRating(
                                                                        color:
                                                                            goldColor,
                                                                        size: 30
                                                                            .sp,
                                                                      ),
                                                                      //Spacer(),
                                                                      SizedBox(
                                                                        height: context.width *
                                                                            0.07.sp,
                                                                      ),
                                                                      CustomTextField(
                                                                        labelText: LocaleKeys
                                                                            .notes
                                                                            .tr(),
                                                                        controller:
                                                                            oldProviderCubit.rateNotesController,
                                                                        isBig:
                                                                            true,
                                                                        lines:
                                                                            5,
                                                                      ),
                                                                      SizedBox(
                                                                        height: context.width *
                                                                            0.1.sp,
                                                                      ),
                                                                      Align(
                                                                          alignment: AlignmentDirectional
                                                                              .bottomCenter,
                                                                          child:
                                                                              CustomButton(
                                                                            textButton:
                                                                                LocaleKeys.send.tr(),
                                                                            onPressed:
                                                                                () {
                                                                              if (ratingCount == 0.0) {
                                                                                showCustomSnackBar(message: LocaleKeys.rateRequired.tr(), state: ToastState.ERROR);
                                                                              } else {
                                                                                oldProviderCubit.rateClient(
                                                                                  context: context,
                                                                                  clientId: ordersProviderCubit.orderByIdModel.data!.userRequestServices!.id.toString(),
                                                                                  //  description: rateNotesController.text
                                                                                );
                                                                              }
                                                                            },
                                                                            color:
                                                                                darkGreyColor,
                                                                          ))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    });
                                              },
                                            )
                                          // SizedBox(height: context.height*0.02,)
                                          // BlocConsumer<OldProviderOrdersCubit,
                                          //             OldProviderOrdersState>(
                                          //             listener: (context, state) {
                                          //               if (state
                                          //                   is RateClientLoadingState) {
                                          //                 adaptiveDialogLoader(
                                          //                     context: context);
                                          //               } else if (state
                                          //                       is RateClientSuccessState ||
                                          //                   state is RateClientErrorState) {
                                          //                 Navigator.pop(context);
                                          //               }
                                          //             },
                                          //             builder: (context, state) {
                                          //               return CustomButton(
                                          //                   textButton: LocaleKeys.rateProvider.tr(),
                                          //                   color: darkGreyColor,
                                          //                   onPressed: () {
                                          //                     showBottomSheet(
                                          //                         context: context,
                                          //                         builder: (context) {
                                          //                           return GestureDetector(
                                          //                             onTap: () {
                                          //                               FocusManager
                                          //                                   .instance
                                          //                                   .primaryFocus!
                                          //                                   .unfocus();
                                          //                             },
                                          //                             child: Container(
                                          //                               height:
                                          //                                   context.height *
                                          //                                       0.5.sp,
                                          //                               padding:
                                          //                                   EdgeInsets.all(
                                          //                                       8.sp),
                                          //                               color: whiteColor,
                                          //                               child:
                                          //                                   SingleChildScrollView(
                                          //                                 child: Column(
                                          //                                   mainAxisSize:
                                          //                                       MainAxisSize
                                          //                                           .max,
                                          //                                   children: [
                                          //                                     Text(
                                          //                                       LocaleKeys
                                          //                                           .rateProvider
                                          //                                           .tr(),
                                          //                                       style: openSansBold
                                          //                                           .copyWith(
                                          //                                               color:
                                          //                                                   darkGreyColor),
                                          //                                     ),
                                          //                                     Divider(
                                          //                                       endIndent:
                                          //                                           15.sp,
                                          //                                       indent:
                                          //                                           15.sp,
                                          //                                       thickness:
                                          //                                           2.sp,
                                          //                                     ),
                                          //                                     Image.asset(
                                          //                                         Images
                                          //                                             .RATE),
                                          //                                     StarRating(
                                          //                                       color:
                                          //                                           goldColor,
                                          //                                       size: 30.sp,
                                          //                                     ),
                                          //                                     //Spacer(),
                                          //                                     SizedBox(
                                          //                                       height: context
                                          //                                               .width *
                                          //                                           0.07.sp,
                                          //                                     ),
                                          //                                     CustomTextField(
                                          //                                       labelText:
                                          //                                           LocaleKeys
                                          //                                               .notes
                                          //                                               .tr(),
                                          //                                       controller:
                                          //                                           rateNotesController,
                                          //                                       isBig: true,
                                          //                                       lines: 5,
                                          //                                     ),
                                          //                                     SizedBox(
                                          //                                       height: context
                                          //                                               .width *
                                          //                                           0.1.sp,
                                          //                                     ),
                                          //                                     Align(
                                          //                                         alignment:
                                          //                                             AlignmentDirectional
                                          //                                                 .bottomCenter,
                                          //                                         child:
                                          //                                             CustomButton(
                                          //                                           textButton: LocaleKeys
                                          //                                               .send
                                          //                                               .tr(),
                                          //                                           onPressed:
                                          //                                               () {
                                          //                                             if (ratingCount ==
                                          //                                                 0.0) {
                                          //                                               showCustomSnackBar(
                                          //                                                   message: LocaleKeys.rateRequired.tr(),
                                          //                                                   state: ToastState.ERROR);
                                          //                                             } else {
                                          //                                               oldProviderCubit.rateClient(
                                          //                                                   context: context,
                                          //                                                   clientId: ordersProviderCubit.orderByIdModel.data!.userRequestServices!.id.toString(),
                                          //                                                   description: rateNotesController.text);
                                          //                                             }
                                          //                                           },
                                          //                                           color:
                                          //                                               darkGreyColor,
                                          //                                         ))
                                          //                                   ],
                                          //                                 ),
                                          //                               ),
                                          //                             ),
                                          //                           );
                                          //                         });
                                          //                   });
                                          //             },
                                          //           )
                                          : const SizedBox(),
                                  ordersProviderCubit.orderByIdModel.data!
                                                  .status ==
                                              "pending" &&
                                          ordersProviderCubit
                                                  .orderByIdModel
                                                  .data!
                                                  .userRequestServices
                                                  ?.id ==
                                              userId
                                      ? CustomButton(
                                          textButton:
                                              LocaleKeys.deleteOrder.tr(),
                                          onPressed: () {
                                            showAdaptiveDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        '${LocaleKeys.sureDeleteOrder.tr()} ${ordersProviderCubit.orderByIdModel.data?.id.toString()}'),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {},
                                                          child: Text(
                                                            LocaleKeys.yesDelete
                                                                .tr(),
                                                            style: openSansBold
                                                                .copyWith(
                                                                    color:
                                                                        redColor),
                                                          )),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            LocaleKeys.noThanks
                                                                .tr(),
                                                            style: openSansBold
                                                                .copyWith(
                                                                    color:
                                                                        darkGreyColor),
                                                          )),
                                                    ],
                                                  );
                                                });
                                          },
                                          color: redColor,
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                            // SizedBox(height: con,)

                            // Stack(
                            //   alignment: Alignment.bottomCenter,
                            //   children: [
                            //     CarouselSlider(
                            //       options: CarouselOptions(
                            //           height: mediaQuery.size.height * 0.25,
                            //           aspectRatio: 16 / 9,
                            //           viewportFraction: 1,
                            //           initialPage: 0,
                            //           enableInfiniteScroll: true,
                            //           reverse: false,
                            //           //  autoPlay: true,
                            //           autoPlayAnimationDuration:
                            //           const Duration(milliseconds: 800),
                            //           autoPlayInterval: const Duration(seconds: 3),
                            //           enlargeCenterPage: true,
                            //           autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                            //           scrollDirection: Axis.horizontal,
                            //           onPageChanged: (i, reason) {
                            //             ordersProviderCubit.changeIndexCarousel(i);
                            //           }),
                            //       items: ordersProvider[index].photos!
                            //           .map((e) {
                            //         return Builder(builder: (context) {
                            //           return Card(
                            //             elevation: 3,
                            //             shape: RoundedRectangleBorder(
                            //                 borderRadius: BorderRadius.all(
                            //                     Radius.circular(
                            //
                            //
                            //
                            //                         Dimensions.RADIUS_EXTRA_LARGE))),
                            //             child: Container(
                            //               // margin: EdgeInsets.symmetric(horizontal: Dimensions.RADIUS_SMALL),
                            //               width: mediaQuery.size.width,
                            //               decoration: BoxDecoration(
                            //                 image: DecorationImage(
                            //                     image: NetworkImage(e),
                            //                     fit: BoxFit.cover),
                            //                 borderRadius: BorderRadius.all(
                            //                     Radius.circular(
                            //                         Dimensions.RADIUS_EXTRA_LARGE)
                            //                   // topRight: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
                            //                   // topLeft: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
                            //                 ),
                            //               ),
                            //               // child: Image.network(e,fit: BoxFit.contain),
                            //             ),
                            //           );
                            //         });
                            //       }).toList(),
                            //     ),
                            //     // PageView.builder(
                            //     //   controller: pageController,
                            //     //   itemBuilder: (context,index){
                            //     //    return CarouselSlider(
                            //     //   //carouselController: pageController,
                            //     //       options: CarouselOptions(height: context.height * 0.35,
                            //     //         aspectRatio: 16 / 9,
                            //     //         viewportFraction: 1,
                            //     //         initialPage: 0,
                            //     //         enableInfiniteScroll: true,
                            //     //         reverse: false,
                            //     //         //  autoPlay: true,
                            //     //         autoPlayAnimationDuration:
                            //     //         const Duration(milliseconds: 800),
                            //     //         autoPlayInterval: const Duration(seconds: 3),
                            //     //         enlargeCenterPage: true,
                            //     //         autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                            //     //         scrollDirection: Axis.horizontal,
                            //     //       ),
                            //     //       items: listMyAds[index].photos!.map((e) {
                            //     //         return Builder(builder: (context) {
                            //     //           return Card(
                            //     //             elevation: 3,
                            //     //             shape: RoundedRectangleBorder(
                            //     //                 borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_EXTRA_LARGE))
                            //     //             ),
                            //     //             child: Container(
                            //     //               // margin: EdgeInsets.symmetric(horizontal: Dimensions.RADIUS_SMALL),
                            //     //               width: context.width,
                            //     //               decoration: BoxDecoration(
                            //     //                 image: DecorationImage(
                            //     //                     image: NetworkImage(e),
                            //     //                     fit: BoxFit.cover),
                            //     //                 borderRadius: BorderRadius.all(
                            //     //                     Radius.circular(Dimensions.RADIUS_EXTRA_LARGE)
                            //     //                   // topRight: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
                            //     //                   // topLeft: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
                            //     //                 ),
                            //     //               ),
                            //     //               // child: Image.network(e,fit: BoxFit.contain),
                            //     //             ),
                            //     //           );
                            //     //         });
                            //     //       }).toList(),
                            //     //     );
                            //     //   },
                            //     //
                            //     // ),
                            //
                            //     AnimatedSmoothIndicator(
                            //       activeIndex: ordersProviderCubit.selectedIndex,
                            //       count: ordersProvider[index].photos!.length,
                            //       effect: WormEffect(
                            //           activeDotColor: goldColor,
                            //           dotColor: whiteColor,
                            //           radius: 20.sp),
                            //     ),
                            //   ],
                            // ),
                            // HorizontalImageList(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
