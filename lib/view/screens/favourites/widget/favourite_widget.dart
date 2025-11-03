import 'package:aqarat_raqamia/model/dynamic_model/additional_feature_model.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/view/base/riyal_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../model/dynamic_model/my_ads_model.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/images.dart';
import '../../../../utils/text_style.dart';

//ignore: must_be_immutable
class FavouriteWidget extends StatelessWidget {
  String image;
  String title;
  String bathNo;
  int? categoryId;
  List? features;

  // String kitchenNo;
  // String livingNo;
  String adLocation;
  String bedNo;
  String price;
  double? width;
  bool isProvider;
  Function onTap;
  Function? favouriteFunction;
  bool? isAdsActive;
  bool isTabbedFavourite;
  bool isFavourite = true;

  FavouriteWidget({
    required this.title,
    required this.image,
    required this.bathNo,
    required this.bedNo,
    required this.price,
    required this.onTap,
    required this.adLocation,
    this.isProvider = false,
    this.isAdsActive = false,
    this.width,
    this.features,
    this.categoryId,
    this.isFavourite = true,
    this.favouriteFunction,
    required this.isTabbedFavourite,
    // required this.kitchenNo,
    // required this.livingNo
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
        //  Get.to(()=>AqarDetailsScreen());
      },
      child: Card(
        elevation: 3,
        //  borderOnForeground: false,
        color: whiteColor,

        shape: RoundedRectangleBorder(
            side: BorderSide(color: goldColor),
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT.sp)),
        child: Container(
          // margin: EdgeInsetsDirectional.only(end: 10.sp),
          //  height:features!.isEmpty?context.height*0.13.sp: context.height*0.18.sp,
          height: features!.isEmpty ? 250.sp : 280.sp,
          // height: context.height,
          width: width ?? MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT.sp),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 140.sp,
                    // height: context.height*0.13.sp,
                    // height: context.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(image), fit: BoxFit.cover),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.RADIUS_DEFAULT.sp),
                        topLeft: Radius.circular(Dimensions.RADIUS_DEFAULT.sp),
                      ),
                    ),
                  ),
                  //  isProvider
                  //     ? Padding(
                  //         padding: const EdgeInsets.all(
                  //             Dimensions.PADDING_SIZE_DEFAULT),
                  //         child: Align(
                  //           alignment: AlignmentDirectional.bottomEnd,
                  //           child: Container(
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                  //             decoration: BoxDecoration(
                  //                 color: isAdsActive == true
                  //                     ? yellowColor
                  //                     : whiteColor,
                  //                 borderRadius: BorderRadius.circular(
                  //                     Dimensions.RADIUS_SMALL)),
                  //             child: Text(
                  //               LocaleKeys.active.tr(),
                  //               style: openSansMedium.copyWith(
                  //                   color: isAdsActive == true
                  //                       ? whiteColor
                  //                       : darkGreyColor),
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     :
                  isFavourite
                      ? Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_DEFAULT),
                          child: Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: IconButton(
                              //highlightColor:  goldColor,
                              // focusColor:isTabbedFavourite!?goldColor: whiteColor,

                              icon: isTabbedFavourite
                                  ? Icon(
                                      Icons.favorite_outlined,
                                      color: goldColor,
                                    )
                                  : Icon(Icons.favorite_outline_rounded),

                              onPressed: () {
                                favouriteFunction!();
                              },

                              color: whiteColor,
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),

              Padding(
                padding:
                    const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        title,
                        style: openSansExtraBold.copyWith(
                          color: darkGreyColor,
                        ),
                        maxLines: 1,
                        presetFontSizes: [14.sp, 10.sp, 7.sp],
                          overflow: TextOverflow.clip
                      ),
                    ),
                    // Text(
                    //   title,
                    //  style: openSansMedium.copyWith(color: darkGreyColor),
                    // ),
                    Row(
                      children: [
                        Text(
                          '$price',
                          style: openSansBold.copyWith(
                              color: goldColor, overflow: TextOverflow.clip),
                        ),
                        SizedBox(width: context.width*0.005.w,),
                        riyalWidget(context),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                    vertical: 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Images.SMALL_LOCATION),
                        SizedBox(
                          width: 5.w,
                        ),
                        Expanded(
                          child: Text(
                            adLocation,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style:
                                openSansMedium.copyWith(color: lightDarkMain),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.sp,
                    ),
                    categoryId == 12 ||
                            categoryId == 14 ||
                            categoryId == 18 ||
                            categoryId == 13 ||
                            categoryId == 19 ||
                            categoryId == 16 ||
                            categoryId == 21 ||
                            categoryId == 24 ||
                            categoryId == 25 ||
                            categoryId == 27 ||
                            categoryId == 34 ||
                            categoryId == 36 ||
                            categoryId == 35 && features!.isNotEmpty
                        ? Container(
                            height: features!.isEmpty ? 0 : 20.sp,
                            width: context.width,
                            margin: EdgeInsetsDirectional.only(top: context.height*0.02),
                            child: ListView.separated(

                              separatorBuilder: (context,index){
                               // return Spacer();
                                 return SizedBox(width: context.width*0.03,);
                              },
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,

                                scrollDirection: Axis.horizontal,
                                itemCount: features!.length >= 4
                                    ? 4
                                    : features!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Image.network(
                                          features?[index].image ??
                                              'https://dashboard.redd.sa/dash/additional_features/1717849710.png',
                                          width: 20.sp,
                                          height: 20.sp,
                                        ),
                                        SizedBox(
                                          width: context.width * 0.01,
                                        ),
                                        AutoSizeText(
                                          features?[index].name ?? '',
                                          presetFontSizes: [12.sp, 10.sp, 7.sp],
                                          style: openSansMedium.copyWith(
                                              color: goldColor),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        // SizedBox(
                                        //   width: context.width * 0.1,
                                        // ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        : Container(),
                  ],
                ),
              ),
            //  Spacer(),
              ///
              // Padding(
              //   padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       // Row(
              //       //   children: [
              //       //     Text(
              //       //      livingNo,
              //       //       style: openSansMedium.copyWith(color: darkGreyColor),
              //       //     ),
              //       //     SizedBox(
              //       //       width: 5.w,
              //       //     ),
              //       //     SvgPicture.asset(Images.LIVING_ROOM_SVG),
              //       //   ],
              //       // ),
              //       // SizedBox(width: 15.w,),
              //       // Row(
              //       //   children: [
              //       //     Text(
              //       //       kitchenNo,
              //       //       style: openSansMedium.copyWith(color: darkGreyColor),
              //       //     ),
              //       //     SizedBox(
              //       //       width: 5.w,
              //       //     ),
              //       //     SvgPicture.asset(Images.KITCHEN_SVG),
              //       //   ],
              //       // ),
              //       // SizedBox(width:15.w,),
              //       Row(
              //         children: [
              //           Text(
              //             bathNo,
              //             style: openSansMedium.copyWith(color: darkGreyColor),
              //           ),
              //           SizedBox(
              //             width: 5.w,
              //           ),
              //           SvgPicture.asset(Images.BATH_ROOM_SVG),
              //         ],
              //       ),
              //       //  SizedBox(width: 15.w,),
              //       Row(
              //         children: [
              //           Text(
              //             bedNo,
              //             style: openSansMedium.copyWith(color: darkGreyColor),
              //           ),
              //           SizedBox(
              //             width: 5.w,
              //           ),
              //           SvgPicture.asset(Images.BED_ROOM_SVG),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              ///
              // SizedBox(
              //   height: Dimensions.PADDING_SIZE_DEFAULT,
              // )
            ],
          ),
          //),
        ),
      ),
    );
  }
}
