// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import '../../../../utils/dimention.dart';
// import '../../../../utils/images.dart';
// import '../../../../utils/text_style.dart';
//
// class OfferPriceWidget extends StatelessWidget {
//   final String image;
//   final String name;
//   final String price;
//   final String rate;
//   final String rateCount;
//   final String daysServices;
//   final bool isAccepted;
//   Function? accept;
//   Function? refuse;
//
//   OfferPriceWidget(
//       {super.key,
//       required this.name,
//       required this.image,
//       required this.price,
//       required this.daysServices,
//       required this.rate,
//       required this.rateCount,
//       required this.isAccepted,
//       this.accept,
//       this.refuse});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE)),
//       child: Container(
//         padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//         // height: 200,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
//             color: whiteColor),
//         child: Column(
//           children: [
//             ListTile(
//               leading: Image.asset(
//                 image,
//               ),
//               title: AutoSizeText(
//                 name,
//                 style: openSansExtraBold.copyWith(color: darkGreyColor),
//               ),
//               subtitle: Row(
//                 children: [
//                   SvgPicture.asset(Images.STAR_SVG),
//                   RichText(
//                       text: TextSpan(
//                           text: rate,
//                           style: openSansRegular.copyWith(color: darkGreyColor),
//                           children: [
//                         TextSpan(
//                             text: '($rateCount)',
//                             style: openSansRegular.copyWith(
//                                 decoration: TextDecoration.underline,
//                                 color: darkGreyColor))
//                       ]))
//                 ],
//               ),
//               trailing: Text(
//                 '$price ريال',
//                 style: openSansExtraBold.copyWith(color: goldColor),
//               ),
//             ),
//             Divider(),
//             Padding(
//               padding: EdgeInsetsDirectional.only(
//                   start: Dimensions.PADDING_SIZE_DEFAULT),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   AutoSizeText(
//                     '$daysServices يوم',
//                     style: openSansExtraBold.copyWith(color: darkGreyColor),
//                   ),
//                   isAccepted
//                       ? SizedBox()
//                       : Row(
//                           children: [
//                             TextButton(
//                                 onPressed: () {
//                                   print('accept');
//                                   accept!();
//                                 },
//                                 child: Text(
//                                   'قبول',
//                                   style: openSansMedium.copyWith(
//                                       color: Colors.green),
//                                 )),
//                             TextButton(
//                                 onPressed: () {
//                                   print('refuse');
//                                   refuse!();
//                                 },
//                                 child: Text(
//                                   'رفض',
//                                   style:
//                                       openSansMedium.copyWith(color: redColor),
//                                 )),
//                           ],
//                         )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:aqarat_raqamia/view/base/riyal_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/media_query_value.dart';
import '../../../../../view/base/lunch_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../pusher_config/pusher.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/images.dart';
import '../../../../utils/text_style.dart';
import '../../chat/chat_with_client.dart';

class OfferPriceWidget extends StatelessWidget {
  final String? image, name, rate, priceOffer, serviceDetails,status,dateLine,remainingTime;
  final Function? accept, refuse;
final int? id;

  OfferPriceWidget(
      {super.key,
       this.image,
       this.name,
        this.dateLine,
       this.rate,
        this.id,
        this.status,
        this.remainingTime,
       this.priceOffer,
       this.serviceDetails,
       this.accept,
       this.refuse});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular( Dimensions.RADIUS_LARGE)),
      child: Container(
        //  padding: EdgeInsets.all(5),
        //height: 200,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: ClipOval(
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child:FancyShimmerImage(imageUrl:image??'' ,errorWidget:Image.asset( Images.LOGO_SPLASH)),),
              ),
              title: Text(
                name??'',
                // ordersClientCubit.priceOfferModel.data?[index].provider?.name ?? '',
                style: openSansBold.copyWith(color: darkGreyColor),
              ),
              subtitle: Row(
                children: [
                  SvgPicture.asset(Images.STAR_SVG),
                  Text(
                    rate??'',
                    // ordersClientCubit.priceOfferModel.data?[index].providerRate
                    //         .toString() ??
                    //     '',
                    style: openSansRegular.copyWith(color: darkGreyColor),
                  )
                ],
              ),
              trailing:  status=='pending'?
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: '${LocaleKeys.priceOffer.tr()} : ',
                            style: openSansRegular.copyWith(color: darkGreyColor),
                            children: [
                              TextSpan(
                                text: '${priceOffer} ',
                                style: openSansRegular.copyWith(color: goldColor),
                              )
                            ])),
                       // SizedBox(width: context.width*0.005.w,),
                        riyalWidget(context),
                  ],
                ),
              )
              // Row(
              //   children: [
              //     RichText(
              //         text: TextSpan(
              //             text: '${LocaleKeys.priceOffer.tr()}\n',
              //             style: openSansRegular.copyWith(color: darkGreyColor),
              //             children: [
              //           TextSpan(
              //             text: '${priceOffer} ',
              //             style: openSansRegular.copyWith(color: goldColor),
              //           )
              //         ])),
              //     // SizedBox(width: context.width*0.005.w,),
              //     // riyalWidget(context),
              //   ],
              // )
                  :GestureDetector(
                onTap: () {
                 // print(id.toString());
                  LaravelEcho.init(token: id.toString());
                  navigateForward(ChatWithCustomerScreen(
                    name: name??'',
                    channelId:id.toString() ,
                  ));
                },
                child: Container(
                  padding: EdgeInsets.all(18),
                  child: SvgPicture.asset(
                    Images.CHAT_SVG,
                  ),
                  decoration: BoxDecoration(
                      color: lightGrey,
                      borderRadius:
                      BorderRadius.circular(Dimensions.RADIUS_LARGE)),
                ),
              ),
            ),
            status=='pending'?   Padding(
              padding:  EdgeInsets.only(
                  right: context.width * 0.05, left: context.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          text: LocaleKeys.priceOfferDetails.tr(),
                          style: openSansRegular.copyWith(color: darkGreyColor),
                          children: [
                        TextSpan(
                          text: '${serviceDetails
                              // ordersClientCubit.priceOfferModel.data?[index].serviceDetails.toString()
                              }',
                          style: openSansRegular.copyWith(color: goldColor),
                        )
                      ])),
                  //remainingTime!="0"?
                  RichText(
                      text: TextSpan(
                          text: '${LocaleKeys.dateLine.tr()} :',
                          style: openSansRegular.copyWith(color: darkGreyColor),
                          children: [
                            TextSpan(
                              text:remainingTime!="0"? '${dateLine}':'${LocaleKeys.expirePriceOffer.tr()}',
                              style: openSansRegular.copyWith(color: goldColor),
                            )
                          ]))
        //:SizedBox(),
                ],
              ),
            ):const SizedBox(),
            status=='pending'&&remainingTime!="0"?   Padding(
              padding:  EdgeInsets.only( right: context.width * 0.05, left: context.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      accept!();
                    },
                    label: Text(
                      LocaleKeys.accept.tr(),
                      style: openSansBold.copyWith(color: Colors.green),
                    ),
                    icon: Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      refuse!();
                    },
                    label: Text(
                      LocaleKeys.refuse.tr(),
                      style: openSansBold.copyWith(color: redColor),
                    ),
                    icon: Icon(
                      Icons.close,
                      color: redColor,
                    ),
                  ),
                ],
              ),
            ):const SizedBox()
          ],
        ),
      ),
    );
  }
}
