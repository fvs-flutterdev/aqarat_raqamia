import '../../../bloc/filter_search_add_cubit/cubit.dart';
import '../../../bloc/filter_search_add_cubit/state.dart';
import '../../../utils/dimention.dart';
import '../../../utils/media_query_value.dart';
import '../../../utils/text_style.dart';
import '../../../view/base/lunch_widget.dart';
import '../../../view/base/pagination_view.dart';
import '../../../view/error_widget/error_widget.dart';
import '../../../view/screens/filter/filter_screen.dart';
import '../../../view/screens/location/ads_on_map.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../bloc/ads_by_id_cubit/cubit.dart';
import '../../../bloc/promoted_services_cubit/cubit.dart';
import '../../../bloc/promoted_services_cubit/state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/images.dart';
import '../../base/back_button.dart';
import '../../base/category_header.dart';
import '../../base/custom_text_field.dart';
import '../../base/main_button.dart';
import '../../base/riyal_widget.dart';
import '../../base/shimmer/ads_shimmer.dart';
import '../details_screen/aqar_details_screen.dart';
import '../details_screen/widget/similar_ads.dart';
import '../favourites/widget/favourite_widget.dart';
import '../promoted/widget/promoted_provider_body.dart';

class CategoryScreen extends StatefulWidget {
  final int? index;
  final String? nameOfCategory;

  CategoryScreen(
      {super.key, required this.index, required this.nameOfCategory});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _scrollController = ScrollController();

  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var filterSearchCubit = context.read<FilterSearchAdsCubit>();
    var promotedServicesCubit = context.read<PromotedServicesCubit>();
    return BlocBuilder<FilterSearchAdsCubit, FilterSearchAdsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CategoryHeader(
            title: widget.nameOfCategory ?? LocaleKeys.all.tr(),
            onTap: () {
              navigateForward(FilterScreen());
            },
            changeStatusSearch: () {
              searchController.clear();
              filterSearchCubit.changeSearchMode();
            },
            searchWidget: CustomTextField(
              bottomPadding: 0,
              prefixIcon: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: BackButtonWidget(
                    onTap: () {
                      Navigator.pop(context);
                   //   Navigator.po
                   //  navigateForwardReplace();
                      filterSearchCubit.searchAdsById(
                        categoryId: widget.index.toString(),
                        page: 1,
                        context: context,
                      );
                      filterSearchCubit.changeSearchMode();
                      searchController.clear();
                    },
                    color: darkGreyColor,
                    foregroundColor: goldColor,
                    radius: 5.sp),
              ),
              maxHeight: context.height * 0.06,
              minHeight: context.height * 0.06,
              controller: searchController,
              backgroundColor: whiteColor,
              labelText: LocaleKeys.search.tr(),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: goldColor,
                ),
                onPressed: () {
                  if (searchController.text.isEmpty) {
                    debugPrint('//////////////////////@@@@@@@@@@@@@@@');
                    searchController.clear();
                    filterSearchCubit.changeSearchMode();
                  } else {
                    filterSearchCubit.searchAdsById(
                      categoryId: widget.index.toString(),
                      // search: searchController.text,
                      page: 1,
                      context: context,
                    );
                    searchController.clear();
                  }
                },
              ),
              onSubmit: (val) {
                if (searchController.text.isEmpty) {
                  debugPrint('');
                } else {
                  filterSearchCubit.searchResultModel.data?.clear();
                  filterSearchCubit.searchAdsById(
                      categoryId: widget.index.toString(),
                      context: context,
                      search: searchController.text);
                }
              },
            ),
          ),
          body: BlocBuilder<FilterSearchAdsCubit, FilterSearchAdsState>(
            builder: (context, state) {
              if (filterSearchCubit.isGetFilter == false) {
                return AdsShimmer();
              } else {
                return state is SearchAdsByIdErrorState
                    ? CustomErrorWidget(reload: () {
                        filterSearchCubit.searchAdsById(
                            categoryId: widget.index.toString(),
                            context: context,
                            page: 1);
                        // Get.back();
                      })
                    : filterSearchCubit.searchResultModel.data!.isEmpty
                        ? Container(
                            alignment: AlignmentDirectional.topCenter,
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: context.width * 0.06),
                                  child: Image.asset(
                                    Images.EMPTY_SEARCH,
                                    width: context.width * 0.8,
                                  ),
                                ),
                                Text(
                                  LocaleKeys.noSearchResult.tr(),
                                  style: openSansExtraBold.copyWith(
                                      color: darkGreyColor),
                                )
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_SMALL),
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: PaginatedListView(
                                offset: filterSearchCubit
                                    .searchResultModel.meta!.currentPage!,
                                last: filterSearchCubit
                                    .searchResultModel.meta!.lastPage!,
                                onPaginate: (int offset) async {
                                  print(offset);
                                  await filterSearchCubit.searchAdsById(
                                    search: searchController.text,
                                    context: context,
                                    categoryId: widget.index.toString(),
                                    page: offset,
                                  );
                                },
                                scrollController: _scrollController,
                                totalSize: filterSearchCubit
                                        .searchResultModel.meta?.to ??
                                    15,
                                //reverse: true,
                                enabledPagination: true,
                                productView: Column(
                                  children: [
                                    // FavouriteWidget(
                                    //   categoryId: filterSearchCubit
                                    //       .searchResultModel
                                    //       .data
                                    //       ?.first
                                    //       .categoryAds
                                    //       ?.id,
                                    //   // adLocation: filterSearchCubit
                                    //   //         .searchResultModel
                                    //   //         .data
                                    //   //         ?.first
                                    //   //         .address ??
                                    //   //     '',
                                    //   adLocation:
                                    //       "${filterSearchCubit.searchResultModel.data?.first.district}, ${filterSearchCubit.searchResultModel.data?.first.city}, ${filterSearchCubit.searchResultModel.data?.first.region}",
                                    //   features: filterSearchCubit
                                    //       .searchResultModel
                                    //       .data!
                                    //       .first
                                    //       .additionalFeatures,
                                    //   onTap: () {
                                    //     context.read<AdyByIdCubit>().getAdById(
                                    //         id: filterSearchCubit
                                    //             .searchResultModel
                                    //             .data!
                                    //             .first
                                    //             .id!);
                                    //     navigateForward(AqarDetailsScreen(
                                    //       adId: filterSearchCubit
                                    //           .searchResultModel
                                    //           .data!
                                    //           .first
                                    //           .id!,
                                    //       categoryId: filterSearchCubit
                                    //           .searchResultModel
                                    //           .data!
                                    //           .first
                                    //           .categoryAds!
                                    //           .id
                                    //           .toString(),
                                    //     ));
                                    //   },
                                    //   isFavourite: true,
                                    //   isTabbedFavourite: filterSearchCubit
                                    //       .searchResultModel
                                    //       .data!
                                    //       .first
                                    //       .isFavorite!,
                                    //   favouriteFunction: () {
                                    //     filterSearchCubit.searchResultModel
                                    //             .data!.first.isFavorite!
                                    //         ? filterSearchCubit.removeFavourite(
                                    //             0,
                                    //             filterSearchCubit
                                    //                 .searchResultModel
                                    //                 .data!
                                    //                 .first
                                    //                 .id
                                    //                 .toString(),
                                    //             // context
                                    //           )
                                    //         : filterSearchCubit.addFavourite(
                                    //             0,
                                    //             filterSearchCubit
                                    //                 .searchResultModel
                                    //                 .data!
                                    //                 .first
                                    //                 .id
                                    //                 .toString(),
                                    //             // context
                                    //           );
                                    //   },
                                    //   // width:width?? 358.w,
                                    //   title: filterSearchCubit.searchResultModel
                                    //           .data?.first.name ??
                                    //       '',
                                    //   image: filterSearchCubit.searchResultModel
                                    //           .data!.first.photos!.isEmpty
                                    //       ? '${Images.AVATAR_IMAGE}'
                                    //       : filterSearchCubit.searchResultModel
                                    //               .data!.first.photos?.first ??
                                    //           '',
                                    //   bathNo: filterSearchCubit
                                    //           .searchResultModel
                                    //           .data
                                    //           ?.first
                                    //           .toiletsNumber ??
                                    //       '',
                                    //   bedNo: filterSearchCubit.searchResultModel
                                    //           .data?.first.roomsNumber ??
                                    //       '',
                                    //   price: filterSearchCubit.searchResultModel
                                    //           .data?.first.price ??
                                    //       '',
                                    //   // kitchenNo: '2', livingNo: '2'
                                    // ),
                                    // SizedBox(
                                    //   height: 10.sp,
                                    // ),
                                    // filterSearchCubit.searchResultModel.data!
                                    //             .length >
                                    //         1
                                    //     ?
                                    Container(
                                            child: ListView.separated(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return SimilarAds(
                                                    isFavouriteWidget: false,
                                                    isTabbedFavourite:
                                                        filterSearchCubit
                                                            .searchResultModel
                                                            .data![index ]
                                                            .isFavorite!,
                                                    favouriteFunction: () {
                                                      filterSearchCubit
                                                              .searchResultModel
                                                              .data![index ]
                                                              .isFavorite!
                                                          ? filterSearchCubit
                                                              .removeFavourite(
                                                              index ,
                                                              filterSearchCubit
                                                                  .searchResultModel
                                                                  .data![
                                                                      index ]
                                                                  .id
                                                                  .toString(),
                                                              // context,
                                                            )
                                                          : filterSearchCubit
                                                              .addFavourite(
                                                              index ,
                                                              filterSearchCubit
                                                                  .searchResultModel
                                                                  .data![
                                                                      index ]
                                                                  .id
                                                                  .toString(),
                                                              // context,
                                                            );
                                                    },
                                                    onTap: () {
                                                      context
                                                          .read<AdyByIdCubit>()
                                                          .getAdById(
                                                              id: filterSearchCubit
                                                                  .searchResultModel
                                                                  .data![
                                                                      index ]
                                                                  .id!);
                                                      navigateForward(
                                                          AqarDetailsScreen(
                                                        adId: filterSearchCubit
                                                            .searchResultModel
                                                            .data![index ]
                                                            .id!,
                                                        // favouriteFunction: () {
                                                        //   filterSearchCubit
                                                        //           .searchResultModel
                                                        //           .data![
                                                        //               index ]
                                                        //           .isFavorite!
                                                        //       ? filterSearchCubit
                                                        //           .removeFavourite(
                                                        //           index ,
                                                        //           filterSearchCubit
                                                        //               .searchResultModel
                                                        //               .data![
                                                        //                   index +
                                                        //                       1]
                                                        //               .id
                                                        //               .toString(),
                                                        //           //  context,
                                                        //         )
                                                        //       : filterSearchCubit
                                                        //           .addFavourite(
                                                        //           index ,
                                                        //           filterSearchCubit
                                                        //               .searchResultModel
                                                        //               .data![
                                                        //                   index +
                                                        //                       1]
                                                        //               .id
                                                        //               .toString(),
                                                        //           // context,
                                                        //         );
                                                        // },
                                                        // isFav: filterSearchCubit
                                                        //     .searchResultModel
                                                        //     .data![index ]
                                                        //     .isFavorite!,
                                                        // photos: filterSearchCubit
                                                        //         .searchResultModel
                                                        //         .data![
                                                        //             index ]
                                                        //         .photos ??
                                                        //     [],
                                                        // model: filterSearchCubit
                                                        //     .searchResultModel,
                                                        categoryId:
                                                            filterSearchCubit
                                                                .searchResultModel
                                                                .data![
                                                                    index]
                                                                .categoryAds!
                                                                .id
                                                                .toString(),
                                                        //  aqarIndex: index ,
                                                      ));
                                                      // Get.to(() => );
                                                    },
                                                    image: filterSearchCubit
                                                            .searchResultModel
                                                            .data![index]
                                                            .photos!
                                                            .isEmpty
                                                        ? '${Images.AVATAR_IMAGE}'
                                                        : filterSearchCubit
                                                                .searchResultModel
                                                                .data![
                                                                    index]
                                                                .photos
                                                                ?.first ??
                                                            '',
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(
                                                              bottom: Dimensions
                                                                  .PADDING_SIZE_EXTRA_SMALL),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  '${filterSearchCubit.searchResultModel.data?[index ].categoryAds?.name ?? ''}',
                                                                  style: openSansMedium
                                                                      .copyWith(
                                                                          color:
                                                                              darkGreyColor)),
                                                              //  Spacer(),

                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    '${filterSearchCubit.searchResultModel.data?[index ].price}',
                                                                    style:
                                                                        openSansMedium
                                                                            .copyWith(
                                                                      color:
                                                                          goldColor,
                                                                    ),
                                                                  ),
                                                                  SizedBox(width:context.width*0.005.w),
                                                                  riyalWidget(context),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(
                                                              bottom: Dimensions
                                                                  .PADDING_SIZE_EXTRA_SMALL),
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                  Images
                                                                      .SMALL_LOCATION, height:
                                                                context.height * 0.01.h,
                                                                width:
                                                                context.width * 0.01.w,),
                                                              SizedBox(
                                                                width: 5.w,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  "${filterSearchCubit.searchResultModel.data?[index ].district}, "
                                                                      "${filterSearchCubit.searchResultModel.data?[index ].city},"
                                                                      " ${filterSearchCubit.searchResultModel.data?[index ].region}" ??
                                                                      '',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  softWrap:
                                                                      true,
                                                                  style: openSansMedium
                                                                      .copyWith(
                                                                          color:
                                                                              darkGreyColor),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),

                                                        filterSearchCubit.searchResultModel.data?[index ].categoryAds?.id == 12 ||
                                                                filterSearchCubit.searchResultModel.data?[index].categoryAds?.id ==
                                                                    14 ||
                                                                filterSearchCubit.searchResultModel.data?[index].categoryAds?.id ==
                                                                    18 ||
                                                                filterSearchCubit.searchResultModel.data?[index].categoryAds?.id ==
                                                                    13 ||
                                                                filterSearchCubit.searchResultModel.data?[index].categoryAds?.id ==
                                                                    19 ||
                                                                filterSearchCubit
                                                                        .searchResultModel
                                                                        .data?[index]
                                                                        .categoryAds
                                                                        ?.id ==
                                                                    16 ||
                                                                filterSearchCubit
                                                                        .searchResultModel
                                                                        .data?[index]
                                                                        .categoryAds
                                                                        ?.id ==
                                                                    21 ||
                                                                filterSearchCubit
                                                                        .searchResultModel
                                                                        .data?[index]
                                                                        .categoryAds
                                                                        ?.id ==
                                                                    24 ||
                                                                filterSearchCubit
                                                                        .searchResultModel
                                                                        .data?[index]
                                                                        .categoryAds
                                                                        ?.id ==
                                                                    25 ||
                                                                filterSearchCubit
                                                                        .searchResultModel
                                                                        .data?[index]
                                                                        .categoryAds
                                                                        ?.id ==
                                                                    27 ||
                                                                filterSearchCubit
                                                                        .searchResultModel
                                                                        .data?[index]
                                                                        .categoryAds
                                                                        ?.id ==
                                                                    34 ||
                                                                filterSearchCubit
                                                                        .searchResultModel
                                                                        .data?[index]
                                                                        .categoryAds
                                                                        ?.id ==
                                                                    36 ||
                                                                filterSearchCubit.searchResultModel.data?[index].categoryAds?.id == 35 &&
                                                                    filterSearchCubit
                                                                        .searchResultModel
                                                                        .data![index]
                                                                        .additionalFeatures!
                                                                        .isNotEmpty
                                                            ? Expanded(
                                                              child: Container(
                                                                  height: filterSearchCubit
                                                                          .searchResultModel
                                                                          .data![
                                                                              index]
                                                                          .additionalFeatures!
                                                                          .isEmpty
                                                                      ? 0
                                                                      : 20.sp,
                                                                  width: context
                                                                      .width,
                                                                  child:Wrap(
                                                                    children: List.generate(
                                                                        filterSearchCubit.searchResultModel.data![index].additionalFeatures!.length>=4?4:
                                                                        filterSearchCubit.searchResultModel.data![index].additionalFeatures!.length,(i){
                                                                      return Padding(
                                                                        padding: EdgeInsetsDirectional.only(
                                                                          end: context.width * 0.02,
                                                                          bottom:0,
                                                                        ),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                          mainAxisSize: MainAxisSize.min,
                                                                          children: [
                                                                            Image.network(
                                                                              filterSearchCubit.searchResultModel
                                                                                  .data?[index].additionalFeatures?[i]
                                                                                  .image ?? 'https://dashboard.redd.sa/dash/additional_features/1717849710.png',
                                                                              height: context.height * 0.03,
                                                                              width: context.width * 0.04,
                                                                            ),
                                                                            SizedBox(
                                                                              width: context.width * 0.01,
                                                                            ),
                                                                            AutoSizeText(
                                                                              filterSearchCubit.searchResultModel.data?[index].additionalFeatures?[i].name ?? '',
                                                                              presetFontSizes: [
                                                                                12.sp,
                                                                                10.sp,
                                                                                7.sp
                                                                              ],
                                                                              style: openSansMedium.copyWith(color: goldColor),
                                                                            ),

                                                                          ],
                                                                        ),
                                                                      );
                                                                    }
                                                                    ),
                                                                  ),


                                                                  // ListView
                                                                  //     .builder(
                                                                  //         physics:
                                                                  //             NeverScrollableScrollPhysics(),
                                                                  //         scrollDirection:
                                                                  //             Axis
                                                                  //                 .horizontal,
                                                                  //         itemCount: ,
                                                                  //         itemBuilder:
                                                                  //             (context,
                                                                  //                 i) {
                                                                  //           return Row(
                                                                  //                                                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  //                                                                                           mainAxisSize: MainAxisSize.max,
                                                                  //                                                                                           children: [
                                                                  //           Image.network(
                                                                  //             filterSearchCubit.searchResultModel
                                                                  //                 .data?[index].additionalFeatures?[i]
                                                                  //                 .image ?? 'https://dashboard.redd.sa/dash/additional_features/1717849710.png',
                                                                  //             height: context.height * 0.03,
                                                                  //             width: context.width * 0.04,
                                                                  //           ),
                                                                  //           AutoSizeText(
                                                                  //             filterSearchCubit.searchResultModel.data?[index].additionalFeatures?[i].name ?? '',
                                                                  //             presetFontSizes: [
                                                                  //               12.sp,
                                                                  //               10.sp,
                                                                  //               7.sp
                                                                  //             ],
                                                                  //             style: openSansMedium.copyWith(color: goldColor),
                                                                  //           ),
                                                                  //           SizedBox(
                                                                  //             width: context.width * 0.1,
                                                                  //           ),
                                                                  //                                                                                           ],
                                                                  //                                                                                         );
                                                                  //         }),
                                                                ),
                                                            )
                                                            : const SizedBox(),

                                                        // ?
                                                        //     : Container(),
                                                        ///
                                                        // Row(
                                                        //   children: [
                                                        //     SvgPicture.asset(Images
                                                        //         .SMALL_LOCATION),
                                                        //     SizedBox(
                                                        //       width: 5.w,
                                                        //     ),
                                                        //     Text(
                                                        //       filterSearchCubit
                                                        //           .searchResultModel
                                                        //           .data?[
                                                        //       index +
                                                        //           1]
                                                        //           .address ??
                                                        //           '',
                                                        //       overflow: TextOverflow.ellipsis,
                                                        //       softWrap: true,
                                                        //       style: openSansMedium
                                                        //           .copyWith(
                                                        //           color:
                                                        //           darkGreyColor),
                                                        //     ),
                                                        //   ],
                                                        // ).paddingSymmetric(
                                                        //     horizontal: Dimensions
                                                        //         .PADDING_SIZE_EXTRA_SMALL,
                                                        //     vertical: 0),
                                                        const SizedBox(
                                                          height: Dimensions
                                                              .PADDING_SIZE_DEFAULT,
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, providerIndex) {
                                                  return BlocBuilder<
                                                      PromotedServicesCubit,
                                                      PromotedServicesState>(
                                                    builder: (context, state) {
                                                      if (state
                                                              is GetServiceProviderPromotedLoadingState ||
                                                          promotedServicesCubit
                                                                  .isGetPromotedProviders ==
                                                              false) {
                                                        return AdsShimmer();
                                                      } else if (state
                                                          is GetServiceProviderPromotedErrorState) {
                                                        return CustomErrorWidget(
                                                            reload: () {
                                                          promotedServicesCubit
                                                              .getProviderPromotion();
                                                        });
                                                      } else if (promotedServicesCubit
                                                          .serviceProviderPromoted
                                                          .data!
                                                          .isEmpty) {
                                                        return Center(
                                                          child: Text(
                                                            LocaleKeys
                                                                .noServiceProvider
                                                                .tr(),
                                                            style: openSansBold
                                                                .copyWith(
                                                                    color:
                                                                        goldColor),
                                                          ),
                                                        );
                                                      } else {
                                                        return promotedServicesCubit
                                                                    .serviceProviderPromoted
                                                                    .data!
                                                                    .length >=
                                                                providerIndex +
                                                                    1
                                                            ? Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            10.0.sp),
                                                                child:
                                                                    ProviderPromotedBody(
                                                                  index:
                                                                      providerIndex,
                                                                ),
                                                              )
                                                            : SizedBox(
                                                                height: 10.sp,
                                                              );
                                                      }
                                                    },
                                                  );
                                                  // return SizedBox(
                                                  //   height: 10.h,
                                                  // );
                                                },
                                                itemCount: filterSearchCubit
                                                        .searchResultModel
                                                        .data!
                                                        .length),
                                          ),
                                     //   : const SizedBox(),
                                    Padding(
                                      padding: const EdgeInsets.all(
                                          Dimensions.PADDING_SIZE_EXTRA_LARGE),
                                      child: CustomButton(
                                          textButton: LocaleKeys.onMap.tr(),
                                          onPressed: () {
                                            navigateForward(AdsOnMap());
                                          },
                                          color: darkGreyColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
              }
            },
          ),
        );
      },
    );
  }
}
