import 'package:aqarat_raqamia/view/base/riyal_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../../../bloc/services_cubit/cubit.dart';
import '../../../utils/dimention.dart';
import '../../../utils/media_query_value.dart';
import '../../../view/base/auth_header.dart';
import '../../../view/base/lunch_widget.dart';
import '../../../view/screens/details_screen/widget/similar_ads.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/text_style.dart';
import '../request_services/request_Service_screen.dart';

//ignore: must_be_immutable
class SubServicesScreen extends StatelessWidget {
  int serviceIndex;
  String serviceId;
  String title;

  SubServicesScreen(
      {super.key,
      required this.serviceIndex,
      required this.title,
      required this.serviceId});

  @override
  Widget build(BuildContext context) {
    var servicesCubit = context.read<ServicesCubit>();
    return Scaffold(
    //  appBar: AuthHeader(title: title),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(title: title),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT.sp),
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: Dimensions.PADDING_SIZE_DEFAULT.sp,
                    );
                  },
                  itemCount: servicesCubit
                      .serviceModel.data![serviceIndex].subServices!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.zero,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL.r)),
                      elevation: 2,
                      child: SimilarAds(
                        //   height: context.height,
                        onTap: () {
                          servicesCubit.clearImage();
                          navigateForward(RequestServiceScreen(
                            serviceId: serviceId,
                            serviceName: title,
                            subServiceId: servicesCubit.serviceModel.data![serviceIndex]
                                .subServices![index].id,
                            subServiceName: servicesCubit.serviceModel
                                .data![serviceIndex].subServices![index].name,
                          ));
                          //  Get.to(() => );
                        },
                        image: servicesCubit.serviceModel.data![serviceIndex]
                                .subServices![index].image ??
                            '',
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AutoSizeText(
                                    servicesCubit.serviceModel.data![serviceIndex]
                                            .subServices![index].name ??
                                        '',
                                    overflow: TextOverflow.ellipsis,
                                    presetFontSizes: [
                                      context.height * 0.015.sp,
                                      context.height * 0.014.sp,
                                      context.height * 0.013.sp
                                    ],
                                    wrapWords: true,
                                    maxLines: 2,
                                    softWrap: true,
                                    style:
                                        openSansMedium.copyWith(color: darkGreysColor),
                                  ),
                                ),
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      AutoSizeText(
                                        '${servicesCubit.serviceModel.data![serviceIndex].subServices![index].price} ',
                                        style: openSansMedium.copyWith(color: goldColor),
                                        presetFontSizes: [
                                          context.height * 0.015.sp,
                                          context.height * 0.014.sp,
                                          context.height * 0.013.sp
                                        ],
                                        maxLines: 2,
                                        softWrap: true,
                                      ),
                                      SizedBox(width: context.width*0.005.w,),
                                      riyalWidget(context),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            AutoSizeText(
                              servicesCubit.serviceModel.data![serviceIndex]
                                      .subServices![index].notes ??
                                  '',
                              style: openSansRegular.copyWith(
                                color: darkGreyColor,
                              //  fontSize: 12.sp,

                              ),
                              presetFontSizes: [
                                context.height * 0.014.sp,
                                context.height * 0.013.sp,
                                context.height * 0.012.sp
                              ],

                              maxLines:2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),

                            // Html(data:servicesCubit.serviceModel.data![serviceIndex]
                            //     .subServices![index].notes ,shrinkWrap: true,
                            //     style: {
                            //   "body":Style(
                            //     color: darkGreyColor,
                            //     fontSize:FontSize(12.sp) ,
                            //     fontFamily: 'Changa-regular',
                            //    // fontWeight: FontWeight.w400,
                            //     textOverflow: TextOverflow.ellipsis
                            //   ),
                            //   "p": Style(
                            //       color: darkGreyColor,
                            //       fontSize:FontSize(10.sp) ,
                            //       fontFamily: 'Changa-regular',
                            //      // fontWeight: FontWeight.w400,
                            //       textOverflow: TextOverflow.ellipsis
                            //   ),
                            //   "pre":Style(
                            //       color: darkGreyColor,
                            //       fontSize:FontSize(10.sp) ,
                            //       fontFamily: 'Changa-regular',
                            //    //   fontWeight: FontWeight.w400,
                            //       textOverflow: TextOverflow.ellipsis
                            //   ),
                            // }),
                            // AutoSizeText(
                            //   servicesCubit.serviceModel.data![serviceIndex]
                            //           .subServices![index].notes ??
                            //       '',
                            //   presetFontSizes: [
                            //     context.height * 0.013,
                            //     context.height * 0.012,
                            //     context.height * 0.01
                            //   ],
                            //   style: openSansRegular.copyWith(
                            //       fontSize:12.sp ,
                            //       color: darkGreyColor),
                            // ),
                            const  Divider(
                              thickness: 1.2,
                              height: 0,
                            ),
                            AutoSizeText(
                              servicesCubit.serviceModel.data![serviceIndex]
                                      .subServices![index].details ??
                                  '',
                              style: openSansRegular.copyWith(
                                color: goldColor,
                               // fontSize: 10.sp,
                              ),
                              presetFontSizes: [
                                context.height * 0.013.sp,
                                context.height * 0.012.sp,
                                context.height * 0.011.sp
                              ],
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                            // const  SizedBox(
                            //   height: Dimensions.PADDING_SIZE_DEFAULT,
                            // )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
