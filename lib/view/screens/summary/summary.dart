import 'package:aqarat_raqamia/bloc/summary_bloc/cubit.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:aqarat_raqamia/view/base/shimmer/ads_shimmer.dart';
import 'package:aqarat_raqamia/view/error_widget/error_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/summary_bloc/state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../base/auth_header.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var summaryCubit = context.read<SummaryCubit>();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              // margin:
              // EdgeInsets.only(bottom: context.height * 0.01.sp),
              height: context.height * 0.17.h,
              child: AuthHeader(
                isCanBack: true,
                title: LocaleKeys.summary.tr(),
              )),
          Expanded(
            child: BlocBuilder<SummaryCubit, SummaryState>(
              builder: (context, state) {
                if (state is GetSummaryLoadingState) {
                  return AdsShimmer();
                } else if (state is GetSummaryErrorState) {
                  return CustomErrorWidget(reload: () {
                    summaryCubit.getSummary();
                  });
                } else {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.width * 0.05.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          accountType == "service_applicant"
                              ? SizedBox()
                              : AutoSizeText(
                                  '* ${LocaleKeys.clientOrder.tr()}',
                                  style: openSansExtraBold.copyWith(
                                      color: goldColor),
                                ),
                          accountType == "service_applicant"
                              ? SizedBox()
                              : Padding(
                            padding:  EdgeInsetsDirectional.only(start: context.width*0.03.w,top: context.height*0.01.h),
                                child: AutoSizeText.rich(
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    maxLines: 2,
                                    TextSpan(
                                      text: "- ${LocaleKeys.current.tr()} : ",
                                      style: openSansBold.copyWith(
                                          color: darkGreysColor),
                                      children: [
                                        TextSpan(
                                            text: summaryCubit
                                                .providerSummaryModel
                                                .provider
                                                ?.acceptedRequests
                                                .toString(),
                                            style: openSansBold.copyWith(
                                                color: redColor))
                                      ],
                                    ),
                                  ),
                              ),
                          accountType == "service_applicant"
                              ? SizedBox()
                              : Padding(
                            padding:  EdgeInsetsDirectional.only(start: context.width*0.03.w,top: context.height*0.01.h),
                                child: AutoSizeText.rich(
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    maxLines: 2,
                                    TextSpan(
                                      text: "- ${LocaleKeys.previous.tr()} : ",
                                      style: openSansBold.copyWith(
                                          color: darkGreysColor),
                                      children: [
                                        TextSpan(
                                            text: summaryCubit
                                                .providerSummaryModel
                                                .provider
                                                ?.finishedRequests
                                                .toString(),
                                            style: openSansBold.copyWith(
                                                color: redColor))
                                      ],
                                    ),
                                  ),
                              ),
                          accountType == "service_applicant"
                              ? SizedBox()
                              : Padding(
                            padding:  EdgeInsetsDirectional.only(start: context.width*0.03.w,top: context.height*0.01.h),
                                child: AutoSizeText.rich(
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    maxLines: 2,
                                    TextSpan(
                                      text:
                                          "- ${LocaleKeys.priceOfferNotResponse.tr()} : ",
                                      style: openSansBold.copyWith(
                                          color: darkGreysColor),
                                      children: [
                                        TextSpan(
                                            text: summaryCubit
                                                .providerSummaryModel
                                                .provider
                                                ?.priceOffersNotAccepted
                                                .toString(),
                                            style: openSansBold.copyWith(
                                                color: redColor))
                                      ],
                                    ),
                                  ),
                              ),
                          accountType == "service_applicant"
                              ? SizedBox()
                              : Divider(
                                  thickness: 2.sp,
                                ),
                          AutoSizeText(
                            '* ${LocaleKeys.myOrders.tr()}',
                            style: openSansExtraBold.copyWith(color: goldColor),
                          ),
                          Padding(
                            padding:  EdgeInsetsDirectional.only(start: context.width*0.03.w,top: context.height*0.01.h),
                            child: AutoSizeText.rich(
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 2,
                              TextSpan(
                                text: "- ${LocaleKeys.New.tr()} : ",
                                style:
                                    openSansBold.copyWith(color: darkGreysColor),
                                children: [
                                  accountType == "service_applicant"
                                      ? TextSpan(
                                          text: summaryCubit.clientSummaryModel
                                              .applicant?.pendingRequests
                                              .toString(),
                                          style: openSansBold.copyWith(
                                              color: redColor))
                                      : TextSpan(
                                          text: summaryCubit
                                              .providerSummaryModel
                                              .provider
                                              ?.providerRequests
                                              ?.pendingRequests
                                              .toString(),
                                          style: openSansBold.copyWith(
                                              color: redColor))
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsetsDirectional.only(start: context.width*0.03.w,top: context.height*0.01.h),
                            child: AutoSizeText.rich(
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 2,
                              TextSpan(
                                text: "- ${LocaleKeys.current.tr()} : ",
                                style:
                                    openSansBold.copyWith(color: darkGreysColor),
                                children: [
                                  accountType == "service_applicant"
                                      ? TextSpan(
                                          text: summaryCubit.clientSummaryModel
                                              .applicant?.acceptedRequests
                                              .toString(),
                                          style: openSansBold.copyWith(
                                              color: redColor))
                                      : TextSpan(
                                          text: summaryCubit
                                              .providerSummaryModel
                                              .provider
                                              ?.providerRequests
                                              ?.acceptedRequests
                                              .toString()
                                              .toString(),
                                          style: openSansBold.copyWith(
                                              color: redColor))
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsetsDirectional.only(start: context.width*0.03.w,top: context.height*0.01.h),
                            child: AutoSizeText.rich(
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 2,
                              TextSpan(
                                text: "- ${LocaleKeys.previous.tr()} : ",
                                style:
                                    openSansBold.copyWith(color: darkGreysColor),
                                children: [
                                  accountType == "service_applicant"
                                      ? TextSpan(
                                          text: summaryCubit.clientSummaryModel
                                              .applicant?.finishedRequests
                                              .toString(),
                                          style: openSansBold.copyWith(
                                              color: redColor))
                                      : TextSpan(
                                          text: summaryCubit
                                              .providerSummaryModel
                                              .provider
                                              ?.providerRequests
                                              ?.finishedRequests
                                              .toString()
                                              .toString(),
                                          style: openSansBold.copyWith(
                                              color: redColor))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
