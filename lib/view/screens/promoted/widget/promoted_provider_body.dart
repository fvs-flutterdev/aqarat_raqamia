import 'package:aqarat_raqamia/view/screens/request_services/request_Service_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../translation/locale_keys.g.dart';
import '../../../../../utils/media_query_value.dart';
import '../../../../bloc/promoted_services_cubit/cubit.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/images.dart';
import '../../../../utils/text_style.dart';
import '../../../base/lunch_widget.dart';
import '../../providers/provider_profile/provider_details_screen.dart';

//ignore: must_be_immutable
class ProviderPromotedBody extends StatefulWidget {
  int index;

  ProviderPromotedBody({super.key, required this.index});

  @override
  State<ProviderPromotedBody> createState() => _ProviderPromotedBodyState();
}

class _ProviderPromotedBodyState extends State<ProviderPromotedBody> {
  @override
  Widget build(BuildContext context) {
    var promotedServicesCubit = context.read<PromotedServicesCubit>();
    return GestureDetector(
      onTap: () {
        navigateForward(ProviderDetailsScreen(
          id: promotedServicesCubit.serviceProviderPromoted
              .data![widget.index].userAds?.id.toString(),
          achievements: promotedServicesCubit.serviceProviderPromoted
                  .data![widget.index].userAds?.achievements ??
              [],
          images_album: promotedServicesCubit.serviceProviderPromoted
                  .data![widget.index].userAds?.imagesAlbum ??
              [],
          projects: promotedServicesCubit.serviceProviderPromoted
                  .data![widget.index].userAds?.projects ??
              [],
          name: promotedServicesCubit
                  .serviceProviderPromoted.data![widget.index].userAds?.name ??
              '',
          rate: promotedServicesCubit
                  .serviceProviderPromoted.data![widget.index].userAds?.rate
                  ?.toStringAsFixed(1) ??
              '',
          value: TextEditingController(
              text: promotedServicesCubit.serviceProviderPromoted
                      .data![widget.index].userAds?.value ??
                  ''),
          imageAvatar: promotedServicesCubit
                  .serviceProviderPromoted.data![widget.index].userAds?.photo ??
              '',
          noRate: promotedServicesCubit
              .serviceProviderPromoted.data![widget.index].userAds?.rate,
          notes: TextEditingController(
              text: promotedServicesCubit.serviceProviderPromoted
                      .data![widget.index].userAds?.notes ??
                  ''),
          objectives: TextEditingController(
              text: promotedServicesCubit.serviceProviderPromoted
                      .data![widget.index].userAds?.objectives ??
                  ''),
          visionary: TextEditingController(
              text: promotedServicesCubit.serviceProviderPromoted
                      .data![widget.index].userAds?.visionary ??
                  ''),
        ));
      },
      child: Card(
        margin: EdgeInsets.zero,
          elevation: 1,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
          child: Container(
          // p: EdgeInsetsDirectional.only(start: 50),
            height: context.width * 0.3.sp,
            // width: context.width,
            decoration: BoxDecoration(
                border: Border.all(color: goldColor),
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                FittedBox(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: context.width * 0.3.sp,
                          minHeight: context.width * 0.3.sp,
                          minWidth: context.width * 0.3.sp,
                          maxHeight: context.width * 0.3.sp),
                      // height: context.width * 0.3.sp,
                      //   width: context.width * 0.3.sp,
                      // decoration: BoxDecoration(image: DecorationImage(image: image)),
                      child: CachedNetworkImage(
                        imageUrl: promotedServicesCubit.serviceProviderPromoted
                            .data![widget.index].userAds!.photo!,
                        fit: BoxFit.fitWidth,
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: redColor,
                        ),
                        placeholder: (context, url) =>
                            Image.asset(Images.SMALL_LOGO_ICON),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                promotedServicesCubit.serviceProviderPromoted
                                    .data![widget.index].userAds!.name!,
                                style: openSansBold.copyWith(
                                    color: darkGreyColor, fontSize: 12.sp),
                                softWrap: true,
                                maxLines: 3,
                                presetFontSizes: [12.sp, 10.sp, 7.sp],
                              ),
                              Flexible(
                                child: Wrap(
                                  children: List.generate(
                                    promotedServicesCubit.serviceProviderPromoted
                                        .data![widget.index].services!.length,
                                    (indexx) {
                                      return AutoSizeText(
                                        '${promotedServicesCubit.serviceProviderPromoted.data![widget.index].services![indexx].name!} - ',
                                        style: openSansMedium.copyWith(
                                            color: goldColor, fontSize: 10.sp),
                                        softWrap: true,
                                        maxLines: 3,
                                        presetFontSizes: [10.sp, 8.sp, 5.sp],
                                        overflow: TextOverflow.ellipsis,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              navigateForward(RequestServiceScreen(
                                isCustomProvider: true,
                                services:promotedServicesCubit.serviceProviderPromoted.data![widget.index].services ,
                                subServices:promotedServicesCubit.serviceProviderPromoted.data![widget.index].subServicesPromo,

                                providerId: promotedServicesCubit
                                    .serviceProviderPromoted
                                    .data![widget.index]
                                    .id,
                                subServiceName: promotedServicesCubit
                                    .serviceProviderPromoted
                                    .data![widget.index]
                                    .subServicesPromo![0]
                                    .name,
                                serviceName: promotedServicesCubit
                                    .serviceProviderPromoted
                                    .data![widget.index]
                                    .services![0]
                                    .name,
                                serviceId: promotedServicesCubit
                                    .serviceProviderPromoted
                                    .data![widget.index]
                                    .services![0]
                                    .id
                                    .toString(),
                                subServiceId: promotedServicesCubit
                                    .serviceProviderPromoted
                                    .data![widget.index]
                                    .subServicesPromo![0]
                                    .id,
                              ));
                              // launchWhatsapp(
                              //     phone: promotedServicesCubit
                              //             .serviceProviderPromoted
                              //             .data![widget.index]
                              //             .userAds
                              //             ?.phone ??
                              //         '',
                              //     context: context,
                              //     text: '');
                            },
                            child: AutoSizeText(
                              LocaleKeys.applyNow.tr(),
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              presetFontSizes: [10.sp, 9.sp, 6.sp],
                              style: openSansMedium.copyWith(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue),
                            ))
                        // IconButton(
                        //     onPressed: () {
                        //       launchCall(
                        //           context: context,
                        //           phoneNumber: promotedServicesCubit
                        //                   .serviceProviderPromoted
                        //                   .data![widget.index]
                        //                   .userAds!
                        //                   .phone ??
                        //               '');
                        //     },
                        //     icon: Icon(
                        //       Icons.call,
                        //       color: goldColor,
                        //     ))
                      ],
                    ))
              ],
            ),
          )),
      // Card(
      //   child: Container(
      //       margin: EdgeInsets.all(2.sp),
      //       //  padding: EdgeInsets.symmetric(horizontal: 2.sp),
      //       // width: context.width * 0.5.sp,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(10.sp),
      //         // color: blackColor.withOpacity(0.2),
      //       ),
      //       child: ListTile(
      //         // leading: FittedBox(
      //         //   //  flex: 1,
      //         //   child: Container(
      //         //     decoration: BoxDecoration(
      //         //         image: DecorationImage(
      //         //             image: CachedNetworkImageProvider(
      //         //       promotedServicesCubit.serviceProviderPromoted
      //         //           .data![widget.index].userAds!.photo!,
      //         //               errorListener: (E){
      //         //                 Image.network(Images.AVATAR_IMAGE);
      //         //               }
      //         //     ),
      //         //
      //         //         )),
      //         //     // child: FancyShimmerImage(
      //         //     //     boxFit: BoxFit.fitWidth,
      //         //     //     imageUrl: promotedServicesCubit.serviceProviderPromoted
      //         //     //         .data![widget.index].userAds!.photo!,
      //         //     //     errorWidget: Image.network(Images.AVATAR_IMAGE)),
      //         //   ),
      //         // ),
      //
      //         leading: Flexible(
      //           flex:1 ,
      //           child: ClipRRect(
      //             borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
      //             child: Container(
      //               // height:context.width * 0.3.sp,
      //               // width:context.width * 0.3.sp,
      //               child: CachedNetworkImage(
      //                 imageUrl:  promotedServicesCubit.serviceProviderPromoted.data![widget.index].userAds!.photo!,
      //                 fit: BoxFit.cover,
      //                 errorWidget: (context, url, error) => Icon(
      //                   Icons.error,
      //                   color: redColor,
      //                 ),
      //                 placeholder: (context, url) =>
      //                     Image.asset(Images.SMALL_LOGO_ICON),
      //               ),
      //             ),
      //           ),
      //         ),
      //         title: Text(
      //           promotedServicesCubit
      //               .serviceProviderPromoted.data![widget.index].userAds!.name!,
      //           style: openSansBold.copyWith(color: darkGreyColor),
      //         ),
      //         subtitle: Wrap(
      //           children: List.generate(
      //             promotedServicesCubit.serviceProviderPromoted
      //                 .data![widget.index].services!.length,
      //             (indexx) {
      //               return AutoSizeText(
      //                 '${promotedServicesCubit.serviceProviderPromoted.data![widget.index].services![indexx].name!} - ',
      //                 style: openSansMedium.copyWith(
      //                   color: goldColor,
      //                 ),
      //                 softWrap: true,
      //                 maxLines: 3,
      //                 presetFontSizes: [12.sp, 9.sp, 5.sp],
      //                 overflow: TextOverflow.visible,
      //               );
      //             },
      //           ),
      //         ),
      //         trailing: IconButton(
      //             onPressed: () {
      //               launchCall(
      //                   context: context,
      //                   phoneNumber: promotedServicesCubit
      //                           .serviceProviderPromoted
      //                           .data![widget.index]
      //                           .userAds!
      //                           .phone ??
      //                       '');
      //             },
      //             icon: Icon(
      //               Icons.call,
      //               color: goldColor,
      //             )),
      //       )),
      // ),
    );
  }
}
