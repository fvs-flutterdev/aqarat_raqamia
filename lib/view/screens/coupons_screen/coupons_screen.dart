import 'package:aqarat_raqamia/bloc/coupons_cubit/cubit.dart';
import 'package:aqarat_raqamia/bloc/coupons_cubit/state.dart';
import 'package:aqarat_raqamia/translation/locale_keys.g.dart';
import 'package:aqarat_raqamia/utils/dimention.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:aqarat_raqamia/view/base/auth_header.dart';
import 'package:aqarat_raqamia/view/base/riyal_widget.dart';
import 'package:aqarat_raqamia/view/base/shimmer/ads_shimmer.dart';
import 'package:aqarat_raqamia/view/error_widget/error_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/images.dart';
import '../../base/show_toast.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var couponsCubit = context.read<CouponsCubit>();
    return Scaffold(
      // appBar: AuthHeader(
      //   title: LocaleKeys.discountCoupons.tr(),
      // ),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(title: LocaleKeys.discountCoupons.tr()),
          ),
          Expanded(
            child: BlocBuilder<CouponsCubit, CouponsState>(
              builder: (context, state) {
                if (state is GetCouponsLoadingState) {
                  return AdsShimmer();
                } else if (state is GetCouponsErrorState) {
                  return CustomErrorWidget(reload: () => couponsCubit.getCoupons());
                } else {
                  return AnimationLimiter(
                    child: ListView.builder(
                        padding: EdgeInsetsDirectional.all(
                            Dimensions.PADDING_SIZE_SMALL.w),
                        itemCount: couponsCubit.couponsModel.data?.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 370),
                            child: SlideAnimation(
                              verticalOffset: 50,
                              child: FadeInAnimation(
                                child: Container(
                                  margin: EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_EXTRA_SMALL.w),
                                  padding: EdgeInsetsDirectional.all(
                                    Dimensions.PADDING_SIZE_SMALL.w,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: goldColor,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.RADIUS_DEFAULT),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: couponsCubit.couponsModel
                                                      .data?[index].code ??
                                                  '',
                                              style: openSansBold.copyWith(
                                                  color: darkGreysColor),
                                              // children: [
                                              //   TextSpan(
                                              //       text: couponsCubit.couponsModel
                                              //               .data?[index].code ??
                                              //           '',style:openSansBold.copyWith(color: darkGreyColor))
                                              // ]
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                Clipboard.setData(ClipboardData(
                                                    text: couponsCubit.couponsModel
                                                            .data?[index].code ??
                                                        ''));
                                                showCustomSnackBar(
                                                    message: LocaleKeys.copy.tr(),
                                                    state: ToastState.SUCCESS);
                                              },
                                              child: SvgPicture.asset(
                                                Images.Copy,

                                              //  theme: SvgTheme(),
                                                color: darkGreysColor,
                                              ))
                                        ],
                                      ),
                                      couponsCubit.couponsModel.data?[index]
                                                  .discountType ==
                                              "percent"
                                          ? RichText(
                                              text: TextSpan(
                                                  text: LocaleKeys.discountPercentage
                                                      .tr(),
                                                  style: openSansBold.copyWith(
                                                      color: darkGreyColor),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "${couponsCubit.couponsModel.data?[index].discount ?? ''} %",
                                                      style: openSansBold.copyWith(
                                                          color: darkGreyColor),
                                                    )
                                                  ]),
                                            )
                                          : Row(
                                            children: [
                                              RichText(
                                                  text: TextSpan(
                                                      text: LocaleKeys.discountValue.tr(),
                                                      style: openSansBold.copyWith(
                                                          color: goldColor),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              couponsCubit.couponsModel.data?[index].discount ?? '',
                                                          style: openSansBold.copyWith(
                                                              color: goldColor),
                                                        )
                                                      ]),
                                                ),
                                              SizedBox(width: context.width*0.005.w,),
                                              riyalWidget(context),
                                            ],
                                          ),
                                      RichText(
                                        text: TextSpan(
                                            text: LocaleKeys.ExpiredAt.tr(),
                                            style: openSansBold.copyWith(
                                                color: redColor),
                                            children: [
                                              TextSpan(
                                                text: couponsCubit.couponsModel
                                                        .data?[index].expiryDate ??
                                                    '',
                                                style: openSansBold.copyWith(
                                                    color: redColor),
                                              )
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
