import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/text_style.dart';

class GridViewDetails extends StatelessWidget {
  final String purpose, area, vision;
  final String? bedRoomNo,
      toiletNo,
      usage,
      services,
      age,
      additionalRequirements,
      desiredPropertySpecifications,
      livingRooms,
      floorCount,
      commercialUnitsNumber,
      parking,
      wellsNumber,
      landNo,
      streetWidth,
      planNumber,
      treesCount;
  final int id;

  const GridViewDetails({
    super.key,
    required this.purpose,
    required this.area,
    required this.id,
    this.bedRoomNo,
    this.toiletNo,
    required this.vision,
    this.additionalRequirements,
    this.usage,
    this.streetWidth,
    this.landNo,
    this.planNumber,
    this.services,
    this.parking,
    this.age,
    this.commercialUnitsNumber,
    this.desiredPropertySpecifications,
    this.floorCount,
    this.livingRooms,
    this.wellsNumber,
    this.treesCount,
    // this.treesCount,this.wellsNumber
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                text: '${LocaleKeys.purpose.tr()} : ',
                style: openSansBold.copyWith(color: darkGreyColor),
                children: [
              TextSpan(
                text: purpose,
                style: openSansBold.copyWith(color: goldColor),
              )
            ])),
        id == 20
            ? const SizedBox()
            : RichText(
                text: TextSpan(
                    text: '${LocaleKeys.area.tr()} : ',
                    style: openSansBold.copyWith(color: darkGreyColor),
                    children: [
                    TextSpan(
                      text: '$area${LocaleKeys.squareArea.tr()}',
                      style: openSansBold.copyWith(color: goldColor),
                    )
                  ])),
        id == 12 ||
                id == 13 ||
                id == 18 ||
                id == 24 ||
                id == 16 ||
                id == 27 ||
                id == 32 ||
                id == 33 ||
                id == 36 ||
                id == 21 ||
                id == 22 ||
                id == 28
            ? RichText(
                text: TextSpan(
                    text: '${LocaleKeys.roomNo.tr()} : ',
                    style: openSansBold.copyWith(color: darkGreyColor),
                    children: [
                    TextSpan(
                      text: bedRoomNo,
                      style: openSansBold.copyWith(color: goldColor),
                    )
                  ]))
            : const SizedBox(),
        id == 12
            ? RichText(
                text: TextSpan(
                    text: '${LocaleKeys.toiletNo.tr()} : ',
                    style: openSansBold.copyWith(color: darkGreyColor),
                    children: [
                    TextSpan(
                      text: toiletNo,
                      style: openSansBold.copyWith(color: goldColor),
                    )
                  ]))
            : const SizedBox(),
        id == 20 ||
                id == 14 ||
                id == 23 ||
                id == 34 ||
                id == 35 ||
                id == 21 ||
                id == 37
            ? const SizedBox()
            : RichText(
                text: TextSpan(
                    text: '${LocaleKeys.view.tr()} : ',
                    style: openSansBold.copyWith(color: darkGreyColor),
                    children: [
                    TextSpan(
                      text: vision,
                      style: openSansBold.copyWith(color: goldColor),
                    )
                  ])),
        id == 15
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          text: '${LocaleKeys.LandNo.tr()} : ',
                          style: openSansBold.copyWith(color: darkGreyColor),
                          children: [
                        TextSpan(
                          text: landNo,
                          style: openSansBold.copyWith(color: goldColor),
                        )
                      ])),
                  RichText(
                      text: TextSpan(
                          text: '${LocaleKeys.plotNo.tr()} : ',
                          style: openSansBold.copyWith(color: darkGreyColor),
                          children: [
                        TextSpan(
                          text: planNumber,
                          style: openSansBold.copyWith(color: goldColor),
                        )
                      ])),
                  RichText(
                      text: TextSpan(
                          text: '${LocaleKeys.streetWidth.tr()} : ',
                          style: openSansBold.copyWith(color: darkGreyColor),
                          children: [
                        TextSpan(
                          text: streetWidth,
                          style: openSansBold.copyWith(color: goldColor),
                        )
                      ])),
                ],
              )
            : const SizedBox(),
        id == 30
            ? const SizedBox()
            : RichText(
                text: TextSpan(
                    text: '${LocaleKeys.usage.tr()} : ',
                    style: openSansBold.copyWith(color: darkGreyColor),
                    children: [
                    TextSpan(
                      text: usage,
                      style: openSansBold.copyWith(color: goldColor),
                    )
                  ])),
        id == 19
            ? RichText(
                text: TextSpan(
                    text: '${LocaleKeys.PalmsAndTreesNo.tr()} : ',
                    style: openSansBold.copyWith(color: darkGreyColor),
                    children: [
                    TextSpan(
                      text: treesCount,
                      style: openSansBold.copyWith(color: goldColor),
                    )
                  ]))
            : const SizedBox(),
        id == 19
            ? RichText(
                text: TextSpan(
                    text: '${LocaleKeys.wellsNo.tr()} : ',
                    style: openSansBold.copyWith(color: darkGreyColor),
                    children: [
                    TextSpan(
                      text: wellsNumber,
                      style: openSansBold.copyWith(color: goldColor),
                    )
                  ]))
            : const SizedBox(),
        id == 12
            ? RichText(
                text: TextSpan(
                    text: '${LocaleKeys.livingRoomNo.tr()} : ',
                    style: openSansBold.copyWith(color: darkGreyColor),
                    children: [
                    TextSpan(
                      text: livingRooms,
                      style: openSansBold.copyWith(color: goldColor),
                    )
                  ]))
            : const SizedBox(),
        RichText(
            text: TextSpan(
                text: '${LocaleKeys.services.tr()} : ',
                style: openSansBold.copyWith(color: darkGreyColor),
                children: [
              TextSpan(
                text: services,
                style: openSansBold.copyWith(color: goldColor),
              )
            ])),
        id == 15
            ? const SizedBox()
            : RichText(
                text: TextSpan(
                    text: '${LocaleKeys.realEstateAge.tr()} : ',
                    style: openSansBold.copyWith(color: darkGreyColor),
                    children: [
                    TextSpan(
                      text: age,
                      style: openSansBold.copyWith(color: goldColor),
                    )
                  ])),
        additionalRequirements == null
            ? const SizedBox()
            : RichText(
                text: TextSpan(
                    text: '${LocaleKeys.additionalRequirements.tr()} : ',
                    style: openSansBold.copyWith(color: darkGreyColor),
                    children: [
                    TextSpan(
                      text: additionalRequirements,
                      style: openSansBold.copyWith(color: goldColor),
                    )
                  ])),
        id == 16 || id == 27 || id == 13
            ? RichText(
                text: TextSpan(
                  text: '${LocaleKeys.floorNo.tr()} : ',
                  style: openSansBold.copyWith(color: darkGreyColor),
                  children: [
                    TextSpan(
                      text: floorCount,
                      style: openSansBold.copyWith(color: goldColor),
                    )
                  ],
                ),
              )
            : const SizedBox(),
        id == 16
            ? RichText(
                text: TextSpan(
                    text: '${LocaleKeys.commercialNo.tr()} : ',
                    style: openSansBold.copyWith(color: darkGreyColor),
                    children: [
                    TextSpan(
                      text: commercialUnitsNumber,
                      style: openSansBold.copyWith(color: goldColor),
                    )
                  ]))
            : const SizedBox(),
        id == 16 || id == 27 || id == 13
            ? RichText(
                text: TextSpan(
                    text: '${LocaleKeys.parking.tr()} : ',
                    style: openSansBold.copyWith(color: darkGreyColor),
                    children: [
                    TextSpan(
                      text: parking,
                      style: openSansBold.copyWith(color: goldColor),
                    )
                  ]))
            : const SizedBox(),
        desiredPropertySpecifications == null
            ? const SizedBox()
            : RichText(
                text: TextSpan(
                    text: '${LocaleKeys.desiredPropertySpecifications.tr()} : ',
                    style: openSansBold.copyWith(color: darkGreyColor),
                    children: [
                    TextSpan(
                      text: desiredPropertySpecifications,
                      style: openSansBold.copyWith(color: goldColor),
                    )
                  ])),
      ],
    );
  }
}

class FeaturesGridView extends StatelessWidget {
  List featureModel;

  FeaturesGridView({super.key, required this.featureModel});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: featureModel.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: context.width * 0.04.sp,
          mainAxisSpacing: 10.sp,
          mainAxisExtent: 25.sp,
          // childAspectRatio: 3,
          maxCrossAxisExtent: context.height * 0.17.sp,
        ),
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                featureModel[index].image,
              ),
              SizedBox(
                width: context.width * 0.02.w,
              ),
              // Spacer(),
              Expanded(
                child: AutoSizeText(featureModel[index].name,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    presetFontSizes: [13.sp, 12.sp, 8.sp],
                    style: openSansBold.copyWith(color: darkGreyColor)),
              )
            ],
          );
        });
  }
}
