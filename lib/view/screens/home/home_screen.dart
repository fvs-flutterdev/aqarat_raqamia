import 'package:aqarat_raqamia/bloc/add_real_ads/state.dart';
import 'package:aqarat_raqamia/bloc/location_cubit/cubit.dart';
import 'package:aqarat_raqamia/bloc/profile_cubit/cubit.dart';
import 'package:aqarat_raqamia/bloc/profile_cubit/state.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/dimention.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/screens/home/widget/header.dart';
import 'package:aqarat_raqamia/view/screens/home/widget/horizontal_grid_view.dart';
import 'package:aqarat_raqamia/view/screens/home/widget/horizontal_list_response_ad.dart';
import 'package:aqarat_raqamia/view/screens/home/widget/horizontal_list_view.dart';
import 'package:aqarat_raqamia/view/screens/home/widget/row_text_widget.dart';
import 'package:aqarat_raqamia/view/screens/home/widget/service_now.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../bloc/add_real_ads/cubit.dart';
import '../../../bloc/ads_by_id_cubit/cubit.dart';
import '../../../bloc/nearby_aqar_cubit/cubit.dart';
import '../../../bloc/nearby_aqar_cubit/state.dart';
import '../../../bloc/sponsor_ads_cubit/cubit.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/images.dart';
import '../../base/pagination_view.dart';
import '../../base/riyal_widget.dart';
import '../../base/shimmer/ads_shimmer.dart';
import '../../error_widget/error_widget.dart';
import '../details_screen/aqar_details_screen.dart';
import '../details_screen/widget/similar_ads.dart';
import '../favourites/widget/favourite_widget.dart';
import '../nearby_aqar_screen/nearby_aqar_details.dart';
import '../sponsor_ads_screen/sponsor_ads_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   if (token == null) {
  //     debugPrint('');
  //   } else {
  //     context
  //         .read<AddRealAdsCubit>()
  //         .resourceCreateModel
  //         .adType
  //         ?.forEach((element) {
  //       element.istabbed = false;
  //     });
  //   }
  //   super.initState();
  // }
  TextEditingController searchController = TextEditingController();

  final _scrollController = ScrollController();

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var resourceCubit = context.read<AddRealAdsCubit>();
    // var filterSearchCubit = context.read<FilterSearchAdsCubit>();
    var getNearbyData = context.read<NearbyAqarCubit>();
    var profile = context.read<ProfileCubit>();
    LocationCubit.get(context).handlePermission();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return HomeHeaderScreen(
                  image: token == null || profile.isGetProfileDate == false
                      ? Images.AVATAR_IMAGE
                      : profile.profileModel.userProfile!.photo ??
                          Images.AVATAR_IMAGE);
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // Replace this delay with the code to be executed during refresh
                // and return a Future when code finishes execution.
                await Future.delayed(const Duration(seconds: 1));
                context.read<SponsorAdsCubit>().getSponsorAds(page: 1);
                return context
                    .read<NearbyAqarCubit>()
                    .getNearbyAqarData(context: context, page: 1);
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                //  physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ServiceNowWidget(),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    RowMoreWidget(
                        isSponsorAD: true,
                        //  reload:(){context.read<SponsorAdsCubit>().getSponsorAds(page: 1);} ,
                        text: LocaleKeys.distinctiveRealEstate.tr(),
                        navigation: () => navigateForward(SponsorAdsScreen())),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    HorizontalSponsorAdsListView(),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    token == null
                        ? SizedBox()
                        : Text(
                            LocaleKeys.allDepartment.tr(),
                            style: openSansExtraBold.copyWith(
                              color: darkGreyColor,
                              fontSize: 18.sp,
                            ),
                          ),
                    token == null
                        ? const SizedBox()
                        : BlocBuilder<AddRealAdsCubit, AddRealAdsState>(
                            builder: (context, state) {
                              context
                                  .read<AddRealAdsCubit>()
                                  .resourceCreateModel
                                  .adType
                                  ?.forEach((element) {
                                element.istabbed = false;
                              });
                              return HorizontalGridRealEstateType(
                                  isTabExtent: true);
                            },
                          ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    RowMoreWidget(
                        text: LocaleKeys.nearbyRealAds.tr(),
                        // isComment: false,
                        // reload: (){context.read<NearbyAqarCubit>().getNearbyAqarData(context: context, page: 1);},
                        navigation: () => navigateForward(NearbyAqarScreen(id: 0,))),
                    //  HorizontalNearbyListView()

                    BlocBuilder<NearbyAqarCubit, NearbyAqarState>(
                      builder: (context, state) {
                        if (getNearbyData.isNearbyAqar == false) {
                          return AdsShimmer(
                            isCategory: true,
                          );
                        } else if (getNearbyData
                            .nearbyAqarModel.data!.isEmpty) {
                          return Center(
                              child: Text(
                            LocaleKeys.noData.tr(),
                            style:
                                openSansMedium.copyWith(color: darkGreyColor),
                          ));
                        } else if (state is GetNearbyAqarErrorState) {
                          return CustomErrorWidget(reload: () {
                            return getNearbyData.getNearbyAqarData(
                                context: context, page: 1);
                          });
                        } else {
                          return PaginatedListView(
                            offset: getNearbyData
                                .nearbyAqarModel.meta!.currentPage!,
                            last: getNearbyData.nearbyAqarModel.meta!.lastPage!,
                            onPaginate: (int offset) async {
                              print(
                                  '/////////////////////////////////////////////');
                              print(offset);
                              await getNearbyData.getNearbyAqarData(
                                search: searchController.text,
                                context: context,
                                page: offset,
                              );
                            },
                            scrollController: _scrollController,
                            totalSize:
                                getNearbyData.nearbyAqarModel.meta?.to ?? 15,

                            //reverse: true,
                            enabledPagination: true,
                            productView: ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: Dimensions.PADDING_SIZE_DEFAULT,
                                  );
                                },
                                //  scrollDirection: Axis.horizontal,
                                itemCount:
                                    getNearbyData.nearbyAqarModel.data!.length,
                                itemBuilder: (context, index) {
                                  return SimilarAds(
                                    isFavouriteWidget: false,
                                    isTabbedFavourite: getNearbyData
                                        .nearbyAqarModel
                                        .data![index]
                                        .isFavorite!,
                                    favouriteFunction: () {
                                      getNearbyData.nearbyAqarModel.data![index]
                                              .isFavorite!
                                          ? getNearbyData.removeFavourite(
                                              index,
                                              getNearbyData.nearbyAqarModel
                                                  .data![index].id
                                                  .toString(),
                                              context)
                                          : getNearbyData.addFavourite(
                                              index,
                                              getNearbyData.nearbyAqarModel
                                                  .data![index].id
                                                  .toString(),
                                              context);
                                    },
                                    image: getNearbyData.nearbyAqarModel
                                                .data![index].photos!.isEmpty ||
                                            getNearbyData.nearbyAqarModel
                                                    .data![index].photos ==
                                                null
                                        ? Images.AVATAR_IMAGE
                                        : getNearbyData.nearbyAqarModel
                                            .data![index].photos!.first,
                                    onTap: () {
                                      // navigateForward(
                                      context.read<AdyByIdCubit>().getAdById(
                                          id: getNearbyData.nearbyAqarModel
                                              .data![index].id!);
                                      navigateForward(
                                        AqarDetailsScreen(
                                          adId: getNearbyData
                                              .nearbyAqarModel.data![index].id!,
                                          categoryId: getNearbyData
                                              .nearbyAqarModel
                                              .data![index]
                                              .categoryAds!
                                              .id
                                              .toString(),
                                        ),
                                      );
                                      //  );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  '${getNearbyData.nearbyAqarModel.data?[index].categoryAds?.name ?? ''}',
                                                  style: openSansExtraBold
                                                      .copyWith(
                                                          color:
                                                              darkGreyColor)),
                                              //  Spacer(),

                                              Row(
                                                children: [
                                                  Text(
                                                      '${getNearbyData.nearbyAqarModel.data?[index].price}',
                                                      style: openSansBold.copyWith(
                                                          color: goldColor)),
                                                  SizedBox(width:context.width*0.005.w),
                                                  riyalWidget(context),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                Images.SMALL_LOCATION,
                                                height: context.height * 0.01.h,
                                                width: context.width * 0.01.w,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${getNearbyData.nearbyAqarModel.data?[index].district}, ${getNearbyData.nearbyAqarModel.data?[index].city}, ${getNearbyData.nearbyAqarModel.data?[index].region}" ??
                                                      '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  style:
                                                      openSansMedium.copyWith(
                                                          color: darkGreyColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        getNearbyData
                                                        .nearbyAqarModel
                                                        .data?[index]
                                                        .categoryAds
                                                        ?.id ==
                                                    12 ||
                                                getNearbyData
                                                        .nearbyAqarModel
                                                        .data?[index]
                                                        .categoryAds
                                                        ?.id ==
                                                    14 ||
                                                getNearbyData
                                                        .nearbyAqarModel
                                                        .data?[index]
                                                        .categoryAds
                                                        ?.id ==
                                                    18 ||
                                                getNearbyData
                                                        .nearbyAqarModel
                                                        .data?[index]
                                                        .categoryAds
                                                        ?.id ==
                                                    13 ||
                                                getNearbyData
                                                        .nearbyAqarModel
                                                        .data?[index]
                                                        .categoryAds
                                                        ?.id ==
                                                    19 ||
                                                getNearbyData
                                                        .nearbyAqarModel
                                                        .data?[index]
                                                        .categoryAds
                                                        ?.id ==
                                                    16 ||
                                                getNearbyData
                                                        .nearbyAqarModel
                                                        .data?[index]
                                                        .categoryAds
                                                        ?.id ==
                                                    21 ||
                                                getNearbyData
                                                        .nearbyAqarModel
                                                        .data?[index]
                                                        .categoryAds
                                                        ?.id ==
                                                    24 ||
                                                getNearbyData
                                                        .nearbyAqarModel
                                                        .data?[index]
                                                        .categoryAds
                                                        ?.id ==
                                                    25 ||
                                                getNearbyData
                                                        .nearbyAqarModel
                                                        .data?[index]
                                                        .categoryAds
                                                        ?.id ==
                                                    27 ||
                                                getNearbyData
                                                        .nearbyAqarModel
                                                        .data?[index]
                                                        .categoryAds
                                                        ?.id ==
                                                    34 ||
                                                getNearbyData
                                                        .nearbyAqarModel
                                                        .data?[index]
                                                        .categoryAds
                                                        ?.id ==
                                                    36 ||
                                                getNearbyData
                                                            .nearbyAqarModel
                                                            .data?[index]
                                                            .categoryAds
                                                            ?.id ==
                                                        35 &&
                                                    getNearbyData
                                                        .nearbyAqarModel
                                                        .data![index]
                                                        .additionalFeatures!
                                                        .isNotEmpty
                                            ? Expanded(
                                                child: Container(
                                                  height: getNearbyData
                                                          .nearbyAqarModel
                                                          .data![index]
                                                          .additionalFeatures!
                                                          .isEmpty
                                                      ? 0
                                                      : 20.sp,
                                                  width: context.width,
                                                  child: Wrap(
                                                    children: List.generate(
                                                      getNearbyData
                                                                  .nearbyAqarModel
                                                                  .data![index]
                                                                  .additionalFeatures!
                                                                  .length >=
                                                              4
                                                          ? 4
                                                          : getNearbyData
                                                              .nearbyAqarModel
                                                              .data![index]
                                                              .additionalFeatures!
                                                              .length,
                                                      (indexx) {
                                                        return Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .only(
                                                            end: context.width *
                                                                0.02,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Image.network(
                                                                getNearbyData
                                                                        .nearbyAqarModel
                                                                        .data![
                                                                            index]
                                                                        .additionalFeatures?[
                                                                            indexx]
                                                                        .image ??
                                                                    'https://dashboard.redd.sa/dash/additional_features/1717849710.png',
                                                                height: context
                                                                        .height *
                                                                    0.03,
                                                                width: context
                                                                        .width *
                                                                    0.04,
                                                                // width: 20.sp,
                                                                // height: 20.sp,
                                                              ),
                                                              SizedBox(
                                                                width: context
                                                                        .width *
                                                                    0.01,
                                                              ),
                                                              AutoSizeText(
                                                                getNearbyData
                                                                        .nearbyAqarModel
                                                                        .data![
                                                                            index]
                                                                        .additionalFeatures?[
                                                                            indexx]
                                                                        .name ??
                                                                    '',
                                                                presetFontSizes: [
                                                                  12.sp,
                                                                  10.sp,
                                                                  5.sp
                                                                ],
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                style: openSansMedium
                                                                    .copyWith(
                                                                        color:
                                                                            goldColor),
                                                              ),
                                                              // SizedBox(
                                                              //   width: context.width * 0.1.sp,
                                                              // ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  // ListView.builder(
                                                  //     physics: NeverScrollableScrollPhysics(),
                                                  //     scrollDirection: Axis.horizontal,
                                                  //     itemCount: getSponsorAdsCubit.sponsorAdsModel.data![index].additionalFeatures!.length >= 2 ? 2 : getSponsorAdsCubit.sponsorAdsModel.data?[index].additionalFeatures!.length,
                                                  //     itemBuilder: (context, i) {
                                                  //       return FittedBox(
                                                  //         child: Row(
                                                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  //           mainAxisSize: MainAxisSize.max,
                                                  //           children: [
                                                  //             Image.network(
                                                  //               similarAdsCubit.similarAdsModel.data?[index].additionalFeatures?[i].image ?? 'https://dashboard.redd.sa/dash/additional_features/1717849710.png',
                                                  //               width: 20.sp,
                                                  //               height: 20.sp,
                                                  //             ),
                                                  //             AutoSizeText(
                                                  //               similarAdsCubit.similarAdsModel.data?[index].additionalFeatures?[i].name ?? '',
                                                  //               presetFontSizes: [
                                                  //                 12.sp,
                                                  //                 10.sp,
                                                  //                 7.sp
                                                  //               ],
                                                  //               style: openSansMedium.copyWith(color: goldColor),
                                                  //             ),
                                                  //             SizedBox(
                                                  //               width: context.width * 0.1,
                                                  //             ),
                                                  //           ],
                                                  //         ),
                                                  //       );
                                                  //     }),
                                                ),
                                              )
                                            : const SizedBox(),
                                        const SizedBox(
                                          height:
                                              Dimensions.PADDING_SIZE_DEFAULT,
                                        )
                                      ],
                                    ),
                                  );
                                  // return FavouriteWidget(
                                  //   categoryId: getNearbyData.nearbyAqarModel
                                  //       .data![index].categoryAds?.id,
                                  //   features: getNearbyData.nearbyAqarModel
                                  //       .data![index].additionalFeatures,
                                  //
                                  //   isTabbedFavourite: getNearbyData
                                  //       .nearbyAqarModel
                                  //       .data![index]
                                  //       .isFavorite!,
                                  //   favouriteFunction: () {
                                  //     getNearbyData.nearbyAqarModel.data![index]
                                  //             .isFavorite!
                                  //         ? getNearbyData.removeFavourite(
                                  //             index,
                                  //             getNearbyData.nearbyAqarModel
                                  //                 .data![index].id
                                  //                 .toString(),
                                  //             context,
                                  //           )
                                  //         : getNearbyData.addFavourite(
                                  //             index,
                                  //             getNearbyData.nearbyAqarModel
                                  //                 .data![index].id
                                  //                 .toString(),
                                  //             context,
                                  //           );
                                  //   },
                                  //   // favouriteFunction: () {
                                  //   //   filterSearchCubit.searchResultModel.data!.first.isFavourite! ? filterSearchCubit.removeFavourite(0, filterSearchCubit.searchResultModel.data!.first.id.toString())
                                  //   //       : filterSearchCubit.addFavourite(
                                  //   //       0,
                                  //   //       filterSearchCubit
                                  //   //           .searchResultModel.data!.first.id
                                  //   //           .toString());
                                  //   // },
                                  //   onTap: () {
                                  //     //RestartWidget.restartApp(context);
                                  //     context.read<AdyByIdCubit>().getAdById(
                                  //         id: getNearbyData.nearbyAqarModel
                                  //             .data![index].id!);
                                  //     navigateForward(AqarDetailsScreen(
                                  //       adId: getNearbyData
                                  //           .nearbyAqarModel.data![index].id!,
                                  //       categoryId: getNearbyData
                                  //           .nearbyAqarModel
                                  //           .data![index]
                                  //           .categoryAds!
                                  //           .id
                                  //           .toString(),
                                  //     ));
                                  //   },
                                  //   width: context.width * 0.8.sp,
                                  //   adLocation:
                                  //       '${getNearbyData.nearbyAqarModel.data![index].district}, ${getNearbyData.nearbyAqarModel.data![index].city}, ${getNearbyData.nearbyAqarModel.data![index].region}',
                                  //   // adLocation:
                                  //   //     getNearbyData.nearbyAqarModel.data![index].address ??
                                  //   //         '',
                                  //   title: getNearbyData.nearbyAqarModel
                                  //           .data![index].name ??
                                  //       '',
                                  //   image: getNearbyData.nearbyAqarModel
                                  //           .data![index].photos?.first ??
                                  //       Images.AVATAR_IMAGE,
                                  //   bathNo: getNearbyData.nearbyAqarModel
                                  //           .data![index].toiletsNumber ??
                                  //       '',
                                  //   bedNo: getNearbyData.nearbyAqarModel
                                  //           .data![index].roomsNumber ??
                                  //       '',
                                  //   price:
                                  //       '${getNearbyData.nearbyAqarModel.data![index].price}',
                                  //   //  kitchenNo: '2', livingNo: '2'
                                  // );
                                }),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
