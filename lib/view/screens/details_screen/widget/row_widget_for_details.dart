import 'dart:io';
import 'package:aqarat_raqamia/bloc/ads_by_id_cubit/state.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/view/base/adaptive_dialog_loader.dart';
import 'package:aqarat_raqamia/view/base/custom_text_field.dart';
import 'package:aqarat_raqamia/view/base/main_button.dart';
import 'package:aqarat_raqamia/view/base/show_toast.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../bloc/ads_by_id_cubit/cubit.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/images.dart';
import '../../../../utils/text_style.dart';

class RowWidgetForDetails extends StatefulWidget {
  Function fct;
  bool isFav;
  int adsId;
  int categoryId;
  bool isFavouriteScreen;

  RowWidgetForDetails(
      {super.key,
      required this.fct,
      required this.isFav,
      required this.adsId,
      required this.categoryId,this.isFavouriteScreen=false});

  @override
  State<RowWidgetForDetails> createState() => _RowWidgetForDetailsState();
}

class _RowWidgetForDetailsState extends State<RowWidgetForDetails> {
  TextEditingController descriptionReportAdController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    descriptionReportAdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var reportAds = context.read<AdyByIdCubit>();
    return BlocConsumer<AdyByIdCubit, AdsByIdState>(
      listener: (context, state) {
        if (state is ReportAdLoadingState) {
          adaptiveDialogLoader(context: context);
        } else if (state is ReportAdSuccessState ||
            state is ReportAdErrorState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // accountType=='service_applicant'?   Row(
            //      children: [
            //        TextButton(
            //            onPressed: () {},
            //            child: Text(LocaleKeys.report.tr(),style:openSansRegular.copyWith(color: darkGreyColor)))
            //      ],
            //    ):SizedBox(),
            //    SizedBox(
            //      width: Dimensions.PADDING_SIZE_SMALL,
            //    ),
            GestureDetector(
              onTap: () async {
                if (Platform.isIOS) {
                  await Share.share(
                      'https://share.redd.sa/adDetails/?ad=${widget.adsId}&cat=${widget.categoryId}',
                      sharePositionOrigin: Rect.fromPoints(
                          const Offset(2, 2), const Offset(3, 3)));
                } else {
                  await Share.share(
                      'https://share.redd.sa/adDetails/?ad=${widget.adsId}&cat=${widget.categoryId}');
                }
              },
              child: Row(
                children: [
                  SvgPicture.asset(Images.SHARE_SVG),
                  SizedBox(
                    width: 5.w,
                  ),
                  AutoSizeText(
                    LocaleKeys.share.tr(),
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: openSansBold.copyWith(color: darkGreyColor),
                    presetFontSizes: [14.sp, 10.sp, 8.sp],
                  )
                ],
              ),
            ),
            SizedBox(
              width: context.width * 0.01.w,
            ),
            GestureDetector(
              onTap: () {
                showBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: context.height * 0.3.sp,
                        padding: EdgeInsets.all(10.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${LocaleKeys.submitReportOnTheAd.tr()}${widget.adsId}',
                              style:
                                  openSansBold.copyWith(color: darkGreyColor),
                            ),
                            CustomTextField(
                              labelText: LocaleKeys.reasonForReport.tr(),
                              controller: descriptionReportAdController,
                            ),
                            CustomButton(
                                color: goldColor,
                                textButton: LocaleKeys.submitReport.tr(),
                                onPressed: () {
                                  if (descriptionReportAdController
                                      .text.isEmpty) {
                                    showCustomSnackBar(
                                        message: LocaleKeys
                                            .pleaseEnterReasonReport
                                            .tr(),
                                        state: ToastState.ERROR);
                                  } else {
                                    reportAds.reportAd(
                                        context: context,
                                        adId: widget.adsId,
                                        desc:
                                            descriptionReportAdController.text);
                                    descriptionReportAdController.clear();
                                  }
                                }),
                          ],
                        ),
                      );
                    });
              },
              child: Row(
                children: [
                  Icon(
                    Icons.close,
                    color: darkGreyColor,
                  ),
                  // SvgPicture.asset(Images.SHARE_SVG),
                  SizedBox(
                    width: 3.w,
                  ),
                  AutoSizeText(
                    LocaleKeys.report.tr(),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: openSansBold.copyWith(color: darkGreyColor),
                    presetFontSizes: [14.sp, 10.sp, 8.sp],
                  ),
                ],
              ),
            ),
            // TextButton(
            //
            //     onPressed: () {},
            //     child: Text(LocaleKeys.report.tr(),
            //         style: openSansRegular.copyWith(color: darkGreyColor))),
            widget.isFavouriteScreen == false
                ? SizedBox(
              width: context.width * 0.01.w,
            )
                : SizedBox(),
            widget.isFavouriteScreen == false
                ? GestureDetector(
                    onTap: () {
                      widget.fct();
                      print('...........');
                    },
                    child: Row(
                      //  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.isFav == true
                            ? Icon(
                                Icons.favorite_outlined,
                                color: goldColor,
                              )
                            : Icon(
                                Icons.favorite_outline_rounded,
                                color: darkGreyColor,
                              ),
                        //  SvgPicture.asset(isFav?Images.UNFAV_SVG:Images.FAVOURITE_SVG),
                        SizedBox(
                          width: 5.w,
                        ),
                        AutoSizeText(LocaleKeys.save.tr(),
                            presetFontSizes: [14.sp, 10.sp, 8.sp],
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,
                            style: openSansBold.copyWith(
                                color: widget.isFav == true
                                    ? goldColor
                                    : darkGreyColor))
                      ],
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
