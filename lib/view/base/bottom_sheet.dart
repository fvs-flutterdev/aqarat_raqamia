import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/services_cubit/cubit.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/dimention.dart';
import '../../utils/images.dart';
import '../../utils/text_style.dart';
import 'main_button.dart';

PersistentBottomSheetController? bottomSheetController;

void openBottomSheet(
    {required String title,
    required String subTitle,
    required Function fct,
    required int id,
    required BuildContext context}) {
  // showModalBottomSheet(context: context,
  //
  //     builder: (context){
  //   return ConstrainedBox(
  //     constraints:  BoxConstraints(
  //       maxHeight: (2 / 3) * MediaQuery.of(context).size.height,
  //     ),
  //     child: Padding(
  //       padding: EdgeInsetsDirectional.only(
  //           top: Dimensions.PADDING_SIZE_LARGE.sp,
  //           start: Dimensions.PADDING_SIZE_DEFAULT.sp,
  //           end: Dimensions.PADDING_SIZE_DEFAULT.sp,
  //           bottom: Dimensions.PADDING_SIZE_DEFAULT.sp
  //       ),
  //       child: Stack(
  //         alignment: AlignmentDirectional.bottomCenter,
  //         children: [
  //           Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   IconButton(
  //                       onPressed: () {
  //                         Navigator.pop(context);
  //                       },
  //                       icon: Icon(
  //                         Icons.close,
  //                         color: redColor,
  //                       )),
  //                   Text(
  //                     title,
  //                     textAlign: TextAlign.center,
  //                     style: openSansExtraBold.copyWith(color: goldColor),
  //                   ),
  //                   IconButton(
  //                       onPressed: () {Navigator.pop(context);},
  //                       icon: Icon(
  //                         Icons.close,
  //                         color: transparentColor,
  //                       )),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: Dimensions.PADDING_SIZE_EXTRA_SMALL.sp,
  //               ),
  //               Text(
  //                 '${LocaleKeys.weAreHappyToProvideService.tr()}${title}',
  //                 style: openSansExtraBold.copyWith(color: darkGreyColor),
  //               ),
  //               Divider(
  //                 endIndent: Dimensions.PADDING_SIZE_DEFAULT.sp,
  //                 thickness: 1.2,
  //               ),
  //               Text(
  //                 subTitle,
  //                 style: openSansMedium.copyWith(color: goldColor),
  //                 textAlign: TextAlign.center,
  //               ),
  //               Expanded(
  //                 child: GridView.builder(
  //                   physics: BouncingScrollPhysics(),
  //                   shrinkWrap: true,
  //                   itemCount: context
  //                       .read<ServicesCubit>()
  //                       .serviceModel
  //                       .data![id]
  //                       .photos!
  //                       .length,
  //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                       mainAxisSpacing:
  //                       Dimensions.PADDING_SIZE_EXTRA_SMALL.sp,
  //                       crossAxisSpacing:
  //                       Dimensions.PADDING_SIZE_EXTRA_SMALL.sp,
  //                       childAspectRatio: 16 / 9,
  //                       crossAxisCount: 2),
  //                   itemBuilder: (context, index) {
  //                     return Padding(
  //                       padding: EdgeInsets.all(8.0.sp),
  //                       child: FancyShimmerImage(
  //                         imageUrl: context
  //                             .read<ServicesCubit>()
  //                             .serviceModel
  //                             .data![id]
  //                             .photos![index],
  //                         errorWidget: Image.asset(Images.LOGO_SPLASH),
  //                       ),
  //                     );
  //
  //                     //  Image.network(
  //                     //  authorityModel[index].image
  //                     //);
  //                   },
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: context.width * 0.14.sp,
  //               )
  //             ],
  //           ),
  //           Padding(
  //             padding:  EdgeInsetsDirectional.only(bottom: context.height*0.05),
  //             child: CustomButton(
  //
  //               textButton: LocaleKeys.requestServiceNow.tr(),
  //               onPressed: () {
  //                 fct();
  //               },
  //               color: darkGreyColor,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // });
  ///
 bottomSheetController = Scaffold.of(context).showBottomSheet(
    // constraints: BoxConstraints(
    //   maxHeight: context.height*0.8,
    //   minHeight: context.height*0.2,
    // ),

    (context) {
      return ConstrainedBox(
            constraints:  BoxConstraints(
              maxHeight: (2 / 3) * context.height,
            ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              top: Dimensions.PADDING_SIZE_LARGE.sp,
              start: Dimensions.PADDING_SIZE_DEFAULT.sp,
              end: Dimensions.PADDING_SIZE_DEFAULT.sp,
              bottom: Dimensions.PADDING_SIZE_DEFAULT.sp
          ),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: redColor,
                          )),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: openSansExtraBold.copyWith(color: goldColor),
                      ),
                      IconButton(
                          onPressed: () {Navigator.pop(context);},
                          icon: Icon(
                            Icons.close,
                            color: transparentColor,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_SMALL.sp,
                  ),
                  Text(
                    '${LocaleKeys.weAreHappyToProvideService.tr()}${title}',
                    style: openSansExtraBold.copyWith(color: darkGreyColor),
                  ),
                  Divider(
                    endIndent: Dimensions.PADDING_SIZE_DEFAULT.sp,
                    thickness: 1.2,
                  ),
                  Text(
                    subTitle,
                    style: openSansMedium.copyWith(color: goldColor),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: context
                          .read<ServicesCubit>()
                          .serviceModel
                          .data![id]
                          .photos!
                          .length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing:
                              Dimensions.PADDING_SIZE_EXTRA_SMALL.sp,
                          crossAxisSpacing:
                              Dimensions.PADDING_SIZE_EXTRA_SMALL.sp,
                          childAspectRatio: 16 / 9,
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: FancyShimmerImage(
                            imageUrl: context
                                .read<ServicesCubit>()
                                .serviceModel
                                .data![id]
                                .photos![index],
                            errorWidget: Image.asset(Images.LOGO_SPLASH),
                          ),
                        );

                        //  Image.network(
                        //  authorityModel[index].image
                        //);
                      },
                    ),
                  ),
                  SizedBox(
                    height: context.width * 0.14.sp,
                  )
                ],
              ),
              CustomButton(
                textButton: LocaleKeys.requestServiceNow.tr(),
                onPressed: () {
                  fct();
                },
                color: darkGreyColor,
              ),
            ],
          ),
        ),
      );
    },
    //context: context,
    backgroundColor: whiteColor,

    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE.sp),
      topRight: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE.sp),
    )),
  );
  ///
  // showBottomSheet(
  //     context: context,
  //     backgroundColor: whiteColor,
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE.sp),
  //           topRight: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE.sp),
  //         )),
  //     builder: (context) {
  //
  //     });
}
