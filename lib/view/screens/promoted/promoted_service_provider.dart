import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../translation/locale_keys.g.dart';
import '../../../../../view/base/auth_header.dart';
import '../../../../../view/base/shimmer/ads_shimmer.dart';
import '../../../../../view/error_widget/error_widget.dart';
import '../../../../../view/screens/promoted/widget/promoted_provider_body.dart';
import '../../../bloc/promoted_services_cubit/cubit.dart';
import '../../../bloc/promoted_services_cubit/state.dart';
import '../../../utils/text_style.dart';

class PromotedServiceProvider extends StatelessWidget {
  const PromotedServiceProvider({super.key});

  @override
  Widget build(BuildContext context) {
    var promotedServicesCubit = context.read<PromotedServicesCubit>();
    return Scaffold(
      // appBar: AuthHeader(
      //   isCanBack: true,
      //   title: LocaleKeys.PromotedServiceProvider.tr(),
      // ),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(
                isCanBack: true,
                title: LocaleKeys.PromotedServiceProvider.tr()),
          ),
          Expanded(
            child: BlocBuilder<PromotedServicesCubit, PromotedServicesState>(
              builder: (context, state) {
                if (state is GetServiceProviderPromotedLoadingState ||
                    promotedServicesCubit.isGetPromotedProviders == false) {
                  return AdsShimmer();
                } else if (state is GetServiceProviderPromotedErrorState) {
                  return CustomErrorWidget(reload: () {
                    promotedServicesCubit.getProviderPromotion();
                  });
                } else if (promotedServicesCubit
                    .serviceProviderPromoted.data!.isEmpty) {
                  return Center(
                    child: Text(
                      LocaleKeys.noServiceProvider.tr(),
                      style: openSansBold.copyWith(color: goldColor),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ProviderPromotedBody(
                            index: index,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10.sp,
                          );
                        },
                        itemCount: promotedServicesCubit
                            .serviceProviderPromoted.data!.length),
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
