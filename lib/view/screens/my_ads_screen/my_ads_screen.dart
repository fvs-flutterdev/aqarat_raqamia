import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/my_ads_cubit/cubit.dart';
import '../../../bloc/my_ads_cubit/state.dart';
import '../../../utils/app_constant.dart';
import '../../../view/base/guest_widget.dart';
import '../../../view/base/lunch_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/images.dart';
import '../../base/auth_header.dart';
import '../../base/pagination_view.dart';
import '../../base/shimmer/ads_shimmer.dart';
import '../../error_widget/error_widget.dart';
import '../favourites/widget/favourite_widget.dart';
import 'my_ad_details_screen.dart';

class MyAdsScreen extends StatefulWidget {
  MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  @override
  void initState() {
    context.read<MyAdsCubit>().loadedMyAds(
          page: 1,
        );
    super.initState();
  }

  final _scrollController = ScrollController();

  // void setupScrollController(context) {
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.atEdge) {
  //       if (_scrollController.position.pixels != 0) {
  //         // context.read<MyAdsCubit>().;
  //         BlocProvider.of<MyAdsCubit>(context).loadedMyAds();
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var getMyAdsCubit = context.read<MyAdsCubit>();
    // setupScrollController(context);
    // getMyAdsCubit.loadedMyAds();
    return Scaffold(
      // appBar: AuthHeader(
      //   title: LocaleKeys.myAds.tr(),
      //   // isCanBack: accountType == 'service_provider' ? false : true,
      // ),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(title: LocaleKeys.myAds.tr()),
          ),
          Expanded(
            child: BlocBuilder<MyAdsCubit, MyAdsState>(
              builder: (context, state) {
                if (token == null) {
                  return LoginFirst();
                } else if (getMyAdsCubit.isMyAdsGet == false) {
                  return AdsShimmer();
                } else if (state is GetMyAdsErrorState) {
                  return CustomErrorWidget(reload: () {
                    getMyAdsCubit.loadedMyAds(page: 1);
                  });
                } else if (getMyAdsCubit.getMyAdsPaginationModel.data!.isEmpty) {
                  return Center(
                    child: Text(LocaleKeys.noData.tr()),
                  );
                }
                // if (state is GetMyAdsLoadingState && state.isFirstFetch) {
                //   return AdsShimmer();
                // }
                // List<MyAdsData> myAdsData = [];
                // if (state is GetMyAdsLoadingState) {
                //   myAdsData = state.oldMyAds;
                // } else if (state is GetMyAdsLoadedState) {
                //   myAdsData = state.myAdsPagination;
                //   print(myAdsData.length);
                // }
                return state is GetMyAdsErrorState
                    ? CustomErrorWidget(reload: () {
                        getMyAdsCubit.loadedMyAds(page: 1);
                      })
                    : SingleChildScrollView(
                        controller: _scrollController,
                        child: PaginatedListView(
                          last: getMyAdsCubit.getMyAdsPaginationModel.meta!.lastPage!,
                          offset: getMyAdsCubit
                              .getMyAdsPaginationModel.meta!.currentPage!,

                          onPaginate: (int offset) async {
                            print(offset);
                            await getMyAdsCubit.loadedMyAds(
                              page: offset,
                            );
                          },
                          scrollController: _scrollController,
                          totalSize:
                              getMyAdsCubit.getMyAdsPaginationModel.meta?.to ?? 15,
                          //   reverse: true,
                          enabledPagination: true,
                          productView: AnimationLimiter(
                            child: ListView.builder(
                                // reverse: true,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: getMyAdsCubit
                                    .getMyAdsPaginationModel.data?.length,
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: Duration(milliseconds: 370),
                                      child: SlideAnimation(
                                        verticalOffset: 50,
                                        child: FadeInAnimation(
                                          child: FavouriteWidget(
                                            features: getMyAdsCubit
                                                .getMyAdsPaginationModel
                                                .data![index]
                                                .additionalFeatures,
                                            categoryId: getMyAdsCubit
                                                .getMyAdsPaginationModel
                                                .data![index]
                                                .categoryAds!
                                                .id!,
                                            onTap: () {
                                              navigateForward(MyAdsDetailsScreen(
                                                categoryId: getMyAdsCubit
                                                    .getMyAdsPaginationModel
                                                    .data![index]
                                                    .categoryAds!
                                                    .id!,
                                                adId: getMyAdsCubit
                                                    .getMyAdsPaginationModel
                                                    .data![index]
                                                    .id!,
                                                index: index,
                                                listMyAds: getMyAdsCubit
                                                    .getMyAdsPaginationModel.data!,
                                              ));
                                            },
                                            isFavourite: false,
                                            title: getMyAdsCubit
                                                    .getMyAdsPaginationModel
                                                    .data![index].name ??
                                                '',
                                            image: getMyAdsCubit
                                                    .getMyAdsPaginationModel
                                                    .data![index]
                                                    .photos
                                                    ?.first ??
                                                Images.AVATAR_IMAGE,
                                            bathNo: getMyAdsCubit
                                                    .getMyAdsPaginationModel
                                                    .data![index]
                                                    .toiletsNumber ??
                                                '',
                                            bedNo: getMyAdsCubit
                                                    .getMyAdsPaginationModel
                                                    .data![index]
                                                    .roomsNumber ??
                                                '',
                                            price: getMyAdsCubit
                                                    .getMyAdsPaginationModel
                                                    .data![index]
                                                    .price ??
                                                '',
                                            // adLocation: getMyAdsCubit
                                            //         .getMyAdsPaginationModel
                                            //         .data![index]
                                            //         .district ??
                                            //     '',
                                            adLocation:
                                                '${getMyAdsCubit.getMyAdsPaginationModel.data![index].district}, ${getMyAdsCubit.getMyAdsPaginationModel.data![index].city}, ${getMyAdsCubit.getMyAdsPaginationModel.data![index].region}',
                                            isTabbedFavourite: false,
                                            isProvider:
                                                accountType == 'service_provider'
                                                    ? true
                                                    : false,
                                            isAdsActive: getMyAdsCubit
                                                        .getMyAdsPaginationModel
                                                        .data?[index]
                                                        .status ==
                                                    'notActive'
                                                ? false
                                                : true,
                                            // kitchenNo: 'dsada',
                                            // livingNo: 'dsadsd',
                                          ),
                                        ),
                                      ));
                                }),
                          ),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
