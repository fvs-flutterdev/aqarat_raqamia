// import 'package:aqarat_raqamia/utils/images.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../../../utils/media_query_value.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../translation/locale_keys.g.dart';
// import '../../../../utils/dimention.dart';
// import '../../../../utils/text_style.dart';
//
// //ignore: must_be_immutable
// class OrderWidget extends StatelessWidget {
//   String? orderTitle;
//   String? orderNumber;
//   String? orderStatus;
//   String? orderDate;
//   int index;
//   bool? isMyOrder = false;
//   String? myOrder;
//   String? providerRate;
//   bool? isCurrent = true;
//   String? name;
//   String? city;
// String?providerName;
//   bool? isSentPriceOffer = false;
//
//   OrderWidget(
//       {super.key,
//       this.orderTitle,
//       this.orderDate,
//       this.orderNumber,
//       this.index = 0,
//       this.providerRate,
//       this.isCurrent,
//       this.orderStatus,
//       this.isMyOrder,
//         this.name,
//         this.providerName,
//         this.city,
//       this.myOrder,
//       this.isSentPriceOffer});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsetsDirectional.symmetric(
//           horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
//       ),
//       child: isMyOrder == true
//           ? ClipRRect(
//               child: Banner(
//                 message: LocaleKeys.myOwnOrder.tr(),
//                 location: BannerLocation.topEnd,
//                 color: redColor,
//                 child: Container(
//                   // margin: EdgeInsetsDirectional.symmetric(
//                   //     horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
//                   height: context.width * 0.36,
//                   decoration: BoxDecoration(
//                     borderRadius:
//                         BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
//                     color: whiteColor,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: context.width * 0.14,
//                         padding: EdgeInsetsDirectional.only(
//                             start: Dimensions.PADDING_SIZE_SMALL.w,
//                             end: Dimensions.PADDING_SIZE_SMALL.w),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(
//                                 Dimensions.PADDING_SIZE_DEFAULT),
//                             color: lightGrey),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(orderTitle!,
//                                 style: openSansBlack.copyWith(
//                                     color: darkGreyColor)),
//                             // Padding(
//                             //   padding:  EdgeInsetsDirectional.only(end:context.width*0.25),
//                             //   child: Text(orderStatus!,
//                             //       style: openSansBlack.copyWith(
//                             //           color: index == 0
//                             //               ? redColor
//                             //               : index == 1
//                             //                   ? goldColor
//                             //                   : darkGreyColor)),
//                             // )
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsetsDirectional.only(
//                             start: Dimensions.PADDING_SIZE_SMALL.w,
//                             end: Dimensions.PADDING_SIZE_SMALL.w,
//                             top: Dimensions.PADDING_SIZE_DEFAULT.h),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               '${LocaleKeys.orderNo.tr()} #$orderNumber',
//                               style: openSansExtraBold.copyWith(
//                                   color: darkGreyColor),
//                             ),
//                             Text(
//                               orderDate!,
//                               style: openSansMedium.copyWith(
//                                   color: whiteGreyColor),
//                             )
//                           ],
//                         ),
//                       ),
//                       orderStatus == LocaleKeys.previousOrder.tr()
//                           ?
//                       Expanded(
//                         child: Padding(
//                           padding:  EdgeInsetsDirectional.only(start: Dimensions.PADDING_SIZE_SMALL.w,),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Flexible(
//                                 child: AutoSizeText.rich(
//                                     presetFontSizes: [15.sp,13.sp,11.sp],
//                                     TextSpan(text: 'أسم مزود الخدمة : ',
//                                         style: openSansBold.copyWith(
//                                             color: goldColor),
//                                         children: [
//                                           TextSpan(
//                                               text: providerName,
//                                               style: openSansBold.copyWith(
//                                                   color: darkGreysColor))
//                                         ])),
//                               ),
//                               Flexible(
//                                 child: AutoSizeText.rich(
//                                     presetFontSizes: [15.sp,13.sp,11.sp],
//                                     TextSpan(text: "الموقع : ",
//                                         style: openSansBold.copyWith(
//                                             color: goldColor),
//                                         children: [
//                                           TextSpan(
//                                               text: city,
//                                               style: openSansBold.copyWith(
//                                                   color: darkGreysColor))
//                                         ])),
//                               ),
//                               // RichText(
//                               //   // textAlign: TextAlign.start,
//                               //   text: TextSpan(
//                               //       text: 'أسم العميل ',
//                               //       style: openSansMedium.copyWith(
//                               //           color: darkGreysColor),
//                               //       children: [
//                               //         TextSpan(
//                               //             text: 'Mohamed',
//                               //             style: openSansMedium.copyWith(
//                               //                 color: darkGreysColor))
//                               //       ]),
//                               // ),
//                             ],
//                           ),
//                         ),
//                       )
//                           : SizedBox(),
//                       isMyOrder == true && isCurrent == true
//                           ? Padding(
//                               padding: EdgeInsetsDirectional.only(
//                                 start: Dimensions.PADDING_SIZE_SMALL.w,
//                                 end: Dimensions.PADDING_SIZE_SMALL.w,
//                                 // top: Dimensions.PADDING_SIZE_DEFAULT.h
//                               ),
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     "${LocaleKeys.averageServiceProviderRatings.tr()} : ",
//                                     style: openSansMedium.copyWith(
//                                         color: darkGreysColor),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "$providerRate",
//                                         style: openSansBlack.copyWith(
//                                             color: goldColor),
//                                       ),
//                                       SvgPicture.asset(Images.STAR_SVG)
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             )
//                           : SizedBox()
//
//                       // RichText(text: TextSpan(text:,children: [
//                       //   TextSpan(text: )
//                       // ]))
//                       // Text('${providerRate}',style: openSansBlack.copyWith(color: goldColor),):SizedBox()
//                       ///
//                       //isMyOrder==true?Text('طلب خاص بي',style: openSansBlack.copyWith(color: goldColor),):SizedBox()
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           : Container(
//               // margin: EdgeInsetsDirectional.symmetric(
//               //     horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
//               height: context.width * 0.36,
//               decoration: BoxDecoration(
//                 borderRadius:
//                     BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
//                 color: whiteColor,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: context.width * 0.14,
//                     padding: EdgeInsetsDirectional.only(
//                         start: Dimensions.PADDING_SIZE_SMALL.w,
//                         end: Dimensions.PADDING_SIZE_SMALL.w),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(
//                             Dimensions.PADDING_SIZE_DEFAULT),
//                         color: lightGrey),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(orderTitle!,
//                             style:
//                                 openSansBlack.copyWith(color: darkGreyColor)),
//                         Text(orderStatus!,
//                             style: openSansBlack.copyWith(
//                                 color: index == 0
//                                     ? redColor
//                                     : index == 1
//                                         ? goldColor
//                                         : darkGreyColor))
//                       ],
//                     ),
//                   ),
//                   isSentPriceOffer == true
//                       ? Padding(
//                     padding: EdgeInsetsDirectional.only(
//                         start: Dimensions.PADDING_SIZE_SMALL.w,),
//                         child: Text(
//                             LocaleKeys.priceOfferSent.tr(),
//                             style: openSansBold.copyWith(color: redColor),
//                           ),
//                       )
//                       : const SizedBox(),
//                   Container(
//                     padding: EdgeInsetsDirectional.only(
//                         start: Dimensions.PADDING_SIZE_SMALL.w,
//                         end: Dimensions.PADDING_SIZE_SMALL.w,
//                         top: Dimensions.PADDING_SIZE_DEFAULT.h),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '${LocaleKeys.orderNo.tr()} #$orderNumber',
//                           style:
//                               openSansExtraBold.copyWith(color: darkGreyColor),
//                         ),
//                         Text(
//                           orderDate!,
//                           style: openSansMedium.copyWith(color: whiteGreyColor),
//                         )
//                       ],
//                     ),
//                   ),
//
//                   isCurrent == true
//                       ?
//                       // Text('معدل تقييم مزود الخدمه  : ${providerRate}',style: openSansBlack.copyWith(color: goldColor),)
//                       Padding(
//                           padding: EdgeInsetsDirectional.only(
//                             start: Dimensions.PADDING_SIZE_SMALL.w,
//                             end: Dimensions.PADDING_SIZE_SMALL.w,
//                             // top: Dimensions.PADDING_SIZE_DEFAULT.h
//                           ),
//                           child: Row(
//                             children: [
//                               Text(
//                                 "${LocaleKeys.averageServiceProviderRatings.tr()} : ",
//                                 style: openSansMedium.copyWith(
//                                     color: darkGreysColor),
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     "$providerRate",
//                                     style: openSansBlack.copyWith(
//                                         color: goldColor),
//                                   ),
//                                   SvgPicture.asset(Images.STAR_SVG)
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       : orderStatus == LocaleKeys.previousOrder.tr()
//                           ?
//                   Expanded(
//                     child: Padding(
//                       padding:  EdgeInsetsDirectional.only(start: Dimensions.PADDING_SIZE_SMALL.w,),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Flexible(
//                             child: AutoSizeText.rich(
//                                 presetFontSizes: [15.sp,13.sp,11.sp],
//                                 TextSpan(text: 'أسم العميل : ',
//                                 style: openSansBold.copyWith(
//                                     color: goldColor),
//                                 children: [
//                                   TextSpan(
//                                       text: name,
//                                       style: openSansBold.copyWith(
//                                           color: darkGreysColor))
//                                 ])),
//                           ),
//                           Flexible(
//                             child: AutoSizeText.rich(
//                                 presetFontSizes: [15.sp,13.sp,11.sp],
//                                 TextSpan(text: "الموقع : ",
//                                 style: openSansBold.copyWith(
//                                     color: goldColor),
//                                 children: [
//                                   TextSpan(
//                                       text: city,
//                                       style: openSansBold.copyWith(
//                                           color: darkGreysColor))
//                                 ])),
//                           ),
//                           // RichText(
//                           //   // textAlign: TextAlign.start,
//                           //   text: TextSpan(
//                           //       text: 'أسم العميل ',
//                           //       style: openSansMedium.copyWith(
//                           //           color: darkGreysColor),
//                           //       children: [
//                           //         TextSpan(
//                           //             text: 'Mohamed',
//                           //             style: openSansMedium.copyWith(
//                           //                 color: darkGreysColor))
//                           //       ]),
//                           // ),
//                         ],
//                       ),
//                     ),
//                   )
//                           : SizedBox(),
//                 ],
//               ),
//             ),
//     );
//   }
// }

import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/images.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/text_style.dart';

//ignore: must_be_immutable
class OrderWidget extends StatelessWidget {
  String? orderTitle;
  String? orderNumber;
  String? orderStatus;
  String? orderDate;
  int index;
  bool? isMyOrder=false;
  String? myOrder;
  String? providerRate;
  bool? isCurrent=true;
  String? name;
  String? city;
  String?providerName;
  bool? isSentPriceOffer=false;
  bool? isFromSponsor = false;

  OrderWidget(
      {super.key,
        this.orderTitle,
        this.orderDate,
        this.orderNumber,
        this.index = 0,
        this.providerRate,
        this.name,
        this.providerName,
        this.city,
        this.isCurrent,
        this.isFromSponsor,
        this.orderStatus,this.isMyOrder,this.myOrder,this.isSentPriceOffer});

  @override
  Widget build(BuildContext context) {
    return Card(

      margin: EdgeInsetsDirectional.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
      ),
      child: isMyOrder==true?
      ClipRRect(
        child: Banner(
          message:LocaleKeys.myOwnOrder.tr(),
          location: BannerLocation.topEnd,
          color: redColor,
          child: Container(
            // margin: EdgeInsetsDirectional.symmetric(
            //     horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            height: context.width * 0.36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
              color: whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(

                  height: context.width * 0.14,
                  padding: EdgeInsetsDirectional.only(
                      start: Dimensions.PADDING_SIZE_SMALL.w,
                      end: Dimensions.PADDING_SIZE_SMALL.w),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
                      color: darkGreyColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(orderTitle!,
                          style: openSansBlack.copyWith(color:lightGrey )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsetsDirectional.only(
                      start: Dimensions.PADDING_SIZE_SMALL.w,
                      end: Dimensions.PADDING_SIZE_SMALL.w,
                      top: Dimensions.PADDING_SIZE_DEFAULT.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${LocaleKeys.orderNo.tr()} #$orderNumber',
                        style: openSansExtraBold.copyWith(color: darkGreyColor),
                      ),
                      Text(
                        orderDate!,
                        style: openSansMedium.copyWith(color: whiteGreyColor),
                      )
                    ],
                  ),
                ),
                orderStatus == LocaleKeys.previousOrder.tr()
                    ?
                Expanded(
                  child: Padding(
                    padding:  EdgeInsetsDirectional.only(start: Dimensions.PADDING_SIZE_SMALL.w,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: AutoSizeText.rich(
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              presetFontSizes: [15.sp,13.sp,11.sp],
                              TextSpan(text: '${LocaleKeys.ProviderName.tr()} : ',
                                  style: openSansBold.copyWith(
                                      color: goldColor),
                                  children: [
                                    TextSpan(
                                        text: providerName,
                                        style: openSansBold.copyWith(
                                            color: darkGreysColor))
                                  ])),
                        ),
                        Flexible(
                          child: AutoSizeText.rich(
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              presetFontSizes: [15.sp,13.sp,11.sp],
                              TextSpan(text: "${LocaleKeys.location.tr()} : ",
                                  style: openSansBold.copyWith(
                                      color: goldColor),
                                  children: [
                                    TextSpan(
                                        text: city,
                                        style: openSansBold.copyWith(
                                            color: darkGreysColor))
                                  ])),
                        ),
                        // RichText(
                        //   // textAlign: TextAlign.start,
                        //   text: TextSpan(
                        //       text: 'أسم العميل ',
                        //       style: openSansMedium.copyWith(
                        //           color: darkGreysColor),
                        //       children: [
                        //         TextSpan(
                        //             text: 'Mohamed',
                        //             style: openSansMedium.copyWith(
                        //                 color: darkGreysColor))
                        //       ]),
                        // ),
                      ],
                    ),
                  ),
                )
                    : SizedBox(),
                isMyOrder==true&&isCurrent==true?
                    ///Edit Here
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: Dimensions.PADDING_SIZE_SMALL.w,
                      end: Dimensions.PADDING_SIZE_SMALL.w,
                      bottom: 0
                      // top: Dimensions.PADDING_SIZE_DEFAULT.h
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: AutoSizeText.rich(
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              presetFontSizes: [15.sp,13.sp,11.sp],
                              TextSpan(text:'${LocaleKeys.ProviderName.tr()} : ',
                                  style: openSansMedium.copyWith(
                                      color: goldColor),
                                  children: [
                                    TextSpan(
                                        text: providerName,
                                        style: openSansMedium.copyWith(
                                            color: darkGreysColor))
                                  ])),
                        ),
                        // Row(
                        //   children: [
                        //    
                        //     // Text("${LocaleKeys.ProviderName.tr()} : ",
                        //     //   style: openSansMedium.copyWith(color: darkGreysColor),),
                        //     // Row(
                        //     //   children: [
                        //     //     Text("$providerName",style: openSansBlack.copyWith(color: goldColor),),
                        //     //     SvgPicture.asset(Images.STAR_SVG)
                        //     //   ],
                        //     // ),
                        //   ],
                        // ),
                        Flexible(
                          child: Row(
                            children: [
                              Text("${LocaleKeys.averageServiceProviderRatings.tr()} : ",
                                style: openSansMedium.copyWith(color:goldColor ),),
                              Row(
                                children: [
                                  Text("$providerRate",style: openSansBlack.copyWith(color: darkGreysColor),),
                                  SvgPicture.asset(Images.STAR_SVG)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ):SizedBox()

                // RichText(text: TextSpan(text:,children: [
                //   TextSpan(text: )
                // ]))
                // Text('${providerRate}',style: openSansBlack.copyWith(color: goldColor),):SizedBox()
                ///
                //isMyOrder==true?Text('طلب خاص بي',style: openSansBlack.copyWith(color: goldColor),):SizedBox()
              ],
            ),
          ),
        ),
      ):
      Container(
        // margin: EdgeInsetsDirectional.symmetric(
        //     horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        height: context.width * 0.36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
          color: whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(


              height: context.width * 0.14,
              padding: EdgeInsetsDirectional.only(
                  start: Dimensions.PADDING_SIZE_SMALL.w,
                  end: Dimensions.PADDING_SIZE_SMALL.w),
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
                  color:darkGreyColor ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(orderTitle!,
                      style: openSansBlack.copyWith(color: lightGrey)),
                  isFromSponsor == true
                      ? AutoSizeText(
                    LocaleKeys.orderFromPromotional.tr(),
                    style: openSansBold.copyWith(color: goldColor),
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  )
                      : Text(orderStatus!,
                      // style: openSansBlack.copyWith(
                      //     color: index == 0
                      //         ? whiteColor
                      //         : index == 1
                      //         ? goldColor
                      //         : darkGreyColor)
                    style: openSansBlack.copyWith(color: whiteColor),
                  )
                ],
              ),

            ),

            isSentPriceOffer == true
                ? Padding(
              padding: EdgeInsetsDirectional.only(
                start: Dimensions.PADDING_SIZE_SMALL.w,),
              child: Text(
                LocaleKeys.priceOfferSent.tr(),
                style: openSansBold.copyWith(color: redColor),
              ),
            )
                : const SizedBox(),
            Container(
              padding: EdgeInsetsDirectional.only(
                  start: Dimensions.PADDING_SIZE_SMALL.w,
                  end: Dimensions.PADDING_SIZE_SMALL.w,
                  top: Dimensions.PADDING_SIZE_DEFAULT.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${LocaleKeys.orderNo.tr()} #$orderNumber',
                    style: openSansExtraBold.copyWith(color: darkGreyColor),
                  ),
                  Text(
                    orderDate!,
                    style: openSansMedium.copyWith(color: whiteGreyColor),
                  )
                ],
              ),
            ),
            orderStatus == LocaleKeys.currentOrder.tr()? Flexible(
              child: Padding(
                padding:  EdgeInsetsDirectional.only(start: Dimensions.PADDING_SIZE_SMALL.w,),
                child: AutoSizeText.rich(
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    presetFontSizes: [15.sp,13.sp,11.sp],
                    TextSpan(text:accountType=="service_applicant"? '${LocaleKeys.ProviderName.tr()} : ':'${LocaleKeys.clientName.tr()} : ',
                        style: openSansBold.copyWith(
                            color: goldColor),
                        children: [
                          TextSpan(
                              text:accountType=="service_applicant"? providerName:name,
                              style: openSansBold.copyWith(
                                  color: darkGreysColor))
                        ])),
              ),
            ):SizedBox(),
            orderStatus == LocaleKeys.previousOrder.tr()
            //&& accountType=="service_applicant"
                ?
            Expanded(
              child: Padding(
                padding:  EdgeInsetsDirectional.only(start: Dimensions.PADDING_SIZE_SMALL.w,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: AutoSizeText.rich(
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          presetFontSizes: [15.sp,13.sp,11.sp],
                          TextSpan(text:accountType=="service_applicant"? '${LocaleKeys.ProviderName.tr()} : ':'${LocaleKeys.clientName.tr()} : ',
                              style: openSansBold.copyWith(
                                  color: goldColor),
                              children: [
                                TextSpan(
                                    text: accountType=="service_applicant"?providerName:name,
                                    style: openSansBold.copyWith(
                                        color: darkGreysColor))
                              ])),
                    ),
                    Flexible(
                      child: AutoSizeText.rich(
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          presetFontSizes: [15.sp,13.sp,11.sp],
                          TextSpan(text: "${LocaleKeys.location.tr()} : ",
                              style: openSansBold.copyWith(
                                  color: goldColor),
                              children: [
                                TextSpan(
                                    text: city,
                                    style: openSansBold.copyWith(
                                        color: darkGreysColor))
                              ])),
                    ),
                  ],
                ),
              ),
            ):SizedBox(),
            isCurrent==true?
            // Text('معدل تقييم مزود الخدمه  : ${providerRate}',style: openSansBlack.copyWith(color: goldColor),)
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: Dimensions.PADDING_SIZE_SMALL.w,
                end: Dimensions.PADDING_SIZE_SMALL.w,
                // top: Dimensions.PADDING_SIZE_DEFAULT.h
              ),
              child: Row(
                children: [
                  Text("${LocaleKeys.averageServiceProviderRatings.tr()} : ",style: openSansMedium.copyWith(color: darkGreysColor),),
                  Row(
                    children: [
                      Text("$providerRate",style: openSansBlack.copyWith(color: goldColor),),
                      SvgPicture.asset(Images.STAR_SVG)
                    ],
                  )
                ],
              ),

            )
            //     :orderStatus == LocaleKeys.previousOrder.tr() && accountType=="service_provider"
            //     ?
            // Expanded(
            //   child: Padding(
            //     padding:  EdgeInsetsDirectional.only(start: Dimensions.PADDING_SIZE_SMALL.w,),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Flexible(
            //           child: AutoSizeText.rich(
            //               softWrap: true,
            //               overflow: TextOverflow.ellipsis,
            //               presetFontSizes: [15.sp,13.sp,11.sp],
            //               TextSpan(text: '${LocaleKeys.clientName.tr()} : ',
            //                   style: openSansBold.copyWith(
            //                       color: goldColor),
            //                   children: [
            //                     TextSpan(
            //                         text: name,
            //                         style: openSansBold.copyWith(
            //                             color: darkGreysColor))
            //                   ])),
            //         ),
            //         Flexible(
            //           child: AutoSizeText.rich(
            //               softWrap: true,
            //               overflow: TextOverflow.ellipsis,
            //               presetFontSizes: [15.sp,13.sp,11.sp],
            //               TextSpan(text: "${LocaleKeys.location.tr()} : ",
            //                   style: openSansBold.copyWith(
            //                       color: goldColor),
            //                   children: [
            //                     TextSpan(
            //                         text: city,
            //                         style: openSansBold.copyWith(
            //                             color: darkGreysColor))
            //                   ])),
            //         ),
            //         // RichText(
            //         //   // textAlign: TextAlign.start,
            //         //   text: TextSpan(
            //         //       text: 'أسم العميل ',
            //         //       style: openSansMedium.copyWith(
            //         //           color: darkGreysColor),
            //         //       children: [
            //         //         TextSpan(
            //         //             text: 'Mohamed',
            //         //             style: openSansMedium.copyWith(
            //         //                 color: darkGreysColor))
            //         //       ]),
            //         // ),
            //       ],
            //     ),
            //   ),
            // )
                :
            SizedBox(),

          ],
        ),
      ),
    );
  }
}
