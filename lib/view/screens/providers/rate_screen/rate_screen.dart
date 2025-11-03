import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../view/base/auth_header.dart';
import '../../../../../view/base/shimmer/ads_shimmer.dart';
import '../../../../../view/error_widget/error_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../bloc/provider_rate_cubit/cubit.dart';
import '../../../../bloc/provider_rate_cubit/state.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/images.dart';
import '../../../../utils/text_style.dart';
import '../../my_orders/rate/rate_widget.dart';

class RateScreen extends StatelessWidget {
  const RateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var providerRatesCubit = context.read<ProviderRatesCubit>();
    return Scaffold(
        // appBar: AuthHeader(
        //   title: LocaleKeys.customerRate.tr(),
        // ),
        body: Column(
          children: [
            Container(
              height: context.height * 0.17.h,
              margin: EdgeInsets.zero,
              child: AuthHeader(title: LocaleKeys.customerRate.tr(),),
            ),
            Expanded(
              child: BlocBuilder<ProviderRatesCubit, ProviderRatesState>(
                builder: (context, state) {
                  if (state is GetProviderRatesLoadingState) {
                    return AdsShimmer();
                  } else if (state is GetProviderRatesErrorState) {
                    return CustomErrorWidget(reload: () {
                      providerRatesCubit.getProvidersRates();
                    });
                  } else if (providerRatesCubit.providerRatesModel.data!.isEmpty) {
                    return Text(LocaleKeys.noRate.tr());
                  } else {
                    return ListView.builder(
                        //  shrinkWrap: true,
                        //  physics: NeverScrollableScrollPhysics(),
                        itemCount: providerRatesCubit.providerRatesModel.data?.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.all(8.sp),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 25.sp,
                                      backgroundColor: transparentColor,
                                      child: ClipOval(
                                        child: FancyShimmerImage(
                                          imageUrl: providerRatesCubit
                                                  .providerRatesModel
                                                  .data?[index]
                                                  .image ??
                                              '',
                                          errorWidget:
                                              Image.network(Images.AVATAR_IMAGE),
                                        ),
                                      ),
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          providerRatesCubit.providerRatesModel
                                                  .data?[index].username ??
                                              '',
                                          style: openSansBold.copyWith(
                                              color: darkGreyColor),
                                        ),
                                        Text(
                                          providerRatesCubit
                                                  .providerRatesModel
                                                  .data?[index]
                                                  .createDates
                                                  ?.createdAtHuman ??
                                              '',
                                          style: openSansRegular.copyWith(
                                              color: darkGreysColor),
                                        ),
                                      ],
                                    ),
                                    subtitle: StarRating(
                                      mainAxis: MainAxisAlignment.start,
                                      padding: 0,
                                      color: goldColor,
                                      size: 30.sp,
                                      rating: double.parse(providerRatesCubit
                                              .providerRatesModel.data?[index].rate ??
                                          ''),
                                      starCount: int.parse(providerRatesCubit
                                              .providerRatesModel.data?[index].rate ??
                                          ''),
                                    ),
                                    // trailing: Text(
                                    //     providerRatesCubit.providerRatesModel.data?[index].createDates?.createdAtHuman??''
                                    // ,style: openSansRegular.copyWith(color: darkGreysColor),
                                    // ),
                                  ),
                                  Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: 20.sp, bottom: 10.sp, end: 10.sp),
                                      child: Text(
                                        providerRatesCubit.providerRatesModel
                                                .data![index].notes ??
                                            LocaleKeys.noNotes.tr(),
                                        style: openSansRegular.copyWith(
                                            color: darkGreyColor),
                                      ))
                                ],
                              ),
                            ),
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ));
  }
}
