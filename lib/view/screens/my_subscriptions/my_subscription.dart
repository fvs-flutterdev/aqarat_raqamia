import 'package:aqarat_raqamia/bloc/summary_bloc/cubit.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:aqarat_raqamia/view/base/main_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/summary_bloc/state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../base/auth_header.dart';
import '../../base/shimmer/ads_shimmer.dart';
import '../../error_widget/error_widget.dart';

class MySubscriptionScreen extends StatelessWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var summaryCubit = context.read<SummaryCubit>();
    return Scaffold(
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.zero,
              height: context.height * 0.17.h,
              child: AuthHeader(
                isCanBack: true,
                title: LocaleKeys.subscriptions.tr(),
              )),
          Expanded(child: BlocBuilder<SummaryCubit, SummaryState>(
            builder: (context, state) {
              if (state is GetSummaryLoadingState) {
                return AdsShimmer();
              } else if (state is GetSummaryErrorState) {
                return CustomErrorWidget(reload: () {
                  summaryCubit.getSummary();
                });
              } else {
                return ListView.separated(
                    itemCount: summaryCubit
                        .providerSummaryModel.provider!.subscriptions!.length,
                    separatorBuilder: (context, index) {
                      return summaryCubit.providerSummaryModel.provider
                                  ?.subscriptions?[index].isExpired ==
                              false
                          ? SizedBox()
                          : CustomButton(
                              color: darkGreysColor,
                              textButton:
                                  'تجديد الباقه مبلغ ${summaryCubit.providerSummaryModel.provider?.subscriptions?[index].price}',
                              onPressed: () {});
                    },
                    padding: EdgeInsetsDirectional.only(
                        start: context.width * 0.03.w,
                        end: context.width * 0.03.w),
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(summaryCubit
                              .providerSummaryModel
                              .provider
                              ?.subscriptions?[index]
                              .expirationDate ??
                          '');
                      String date =
                          "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
                      // String time =
                      //     "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r)),
                        elevation: 2,
                        child: Container(
                          padding:
                              EdgeInsetsDirectional.all(context.width * 0.02.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                summaryCubit
                                        .providerSummaryModel
                                        .provider
                                        ?.subscriptions?[index]
                                        .subscriptionName ??
                                    '',
                                style: openSansExtraBold.copyWith(
                                    color: darkGreyColor),
                              ),
                              AutoSizeText.rich(
                                TextSpan(
                                  text: "${LocaleKeys.ExpiredAt.tr()}",
                                  style: openSansBold.copyWith(
                                      color: darkGreysColor),
                                  children: [
                                    TextSpan(
                                      text: date ?? '',
                                      style: openSansBold.copyWith(
                                          color: redColor),
                                    )
                                  ],
                                ),
                              ),
                              AutoSizeText.rich(TextSpan(
                                  text: "${LocaleKeys.status.tr()} : ",
                                  style: openSansBold.copyWith(
                                      color: darkGreysColor),
                                  children: [
                                    summaryCubit
                                                .providerSummaryModel
                                                .provider
                                                ?.subscriptions?[index]
                                                .isExpired ==
                                            false
                                        ? TextSpan(
                                            text: 'فعال',
                                            style: openSansBold.copyWith(
                                                color: Colors.green))
                                        : TextSpan(
                                            text: "منتهي",
                                            style: openSansBold.copyWith(
                                                color: redColor))
                                  ])),
                            ],
                          ),
                        ),
                      );
                    });
              }
            },
          ))
        ],
      ),
    );
  }
}
