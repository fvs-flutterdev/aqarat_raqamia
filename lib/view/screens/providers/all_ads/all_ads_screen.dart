import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../bloc/nearby_aqar_cubit/cubit.dart';
import '../../../../bloc/profile_cubit/cubit.dart';
import '../../../../utils/app_constant.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/images.dart';
import '../../home/widget/header.dart';
import '../../home/widget/horizontal_list_view.dart';

class AllAdsScreen extends StatelessWidget {
  const AllAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var profileCubit = context.read<ProfileCubit>();
    return Column(
      children: [
        HomeHeaderScreen(
            height: context.height * 0.07.sp,
            image: token == null || profileCubit.isGetProfileDate == false
                ? Images.AVATAR_IMAGE
                : profileCubit.profileModel.userProfile!.photo ??
                    Images.AVATAR_IMAGE),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              // Replace this delay with the code to be executed during refresh
              // and return a Future when code finishes execution.
              await Future.delayed(const Duration(seconds: 1));
             // context.read<SponsorAdsCubit>().getSponsorAds(page:1);
              return   context.read<NearbyAqarCubit>().getNearbyAqarData(context: context, page: 1);
            },
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL.sp, vertical: 0.0),
              child: HorizontalNearbyListView(
                isCategory: false,
                height: context.height,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
