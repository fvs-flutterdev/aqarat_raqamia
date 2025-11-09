import 'package:aqarat_raqamia/bloc/region_cubit/cubit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../bloc/nearby_aqar_cubit/cubit.dart';
import '../../../../../bloc/nearby_aqar_cubit/state.dart';
import '../../../../../utils/dimention.dart';
import '../../../../../utils/media_query_value.dart';
import '../../../../../utils/text_style.dart';
import '../../../../../view/base/lunch_widget.dart';
import '../../../../../view/error_widget/error_widget.dart';
import '../../../../../view/screens/filter/filter_screen.dart';
import '../../../../../view/screens/location/ads_on_map.dart';
import '../../../bloc/add_real_ads/cubit.dart';
import '../../../bloc/ads_by_id_cubit/cubit.dart';
import '../../../bloc/promoted_services_cubit/cubit.dart';
import '../../../bloc/promoted_services_cubit/state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/images.dart';
import '../../base/back_button.dart';
import '../../base/category_header.dart';
import '../../base/custom_text_field.dart';
import '../../base/main_button.dart';
import '../../base/pagination_view.dart';
import '../../base/riyal_widget.dart';
import '../../base/shimmer/ads_shimmer.dart';
import '../details_screen/aqar_details_screen.dart';
import '../details_screen/widget/similar_ads.dart';
import '../promoted/widget/promoted_provider_body.dart';

class NearbyAqarScreen extends StatefulWidget {
  int id;
  final bool? autoFocus;

  NearbyAqarScreen({
    this.autoFocus,
    required this.id,
    super.key,
  });

  @override
  State<NearbyAqarScreen> createState() => _NearbyAqarScreenState();
}

class _NearbyAqarScreenState extends State<NearbyAqarScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    context.read<PromotedServicesCubit>().getPromotedServices();
    context.read<RegionsCubit>().regionIdFilter = null;
    context.read<AddRealAdsCubit>().CategoryIdFilter = null;
    super.initState();
  }

  TextEditingController searchController = TextEditingController();
  TextEditingController searchDistrictController = TextEditingController();
  TextEditingController searchCityController = TextEditingController();
  final scrollControllerFilter = ScrollController();

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    searchCityController.dispose();
    searchDistrictController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var nearbyAqarCubit = context.read<NearbyAqarCubit>();
    var promotedServicesCubit = context.read<PromotedServicesCubit>();
    return BlocBuilder<NearbyAqarCubit, NearbyAqarState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: Scaffold(
            appBar: CategoryHeader(
              isPadding: false,
              scrollController: scrollControllerFilter,
              title: LocaleKeys.nearbyRealAds.tr(),
              changeStatusSearch: () {
                searchController.clear();
                nearbyAqarCubit.changeSearchMode();
              },
              searchWidget: Column(
                children: [
                  CustomTextField(
                    autoFocus: widget.autoFocus ?? false,
                    bottomPadding: 0,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: BackButtonWidget(
                          onTap: () {
                            Navigator.pop(context);
                            nearbyAqarCubit.getNearbyAqarData(
                              page: 1,
                              context: context,
                            );
                            nearbyAqarCubit.changeSearchMode();
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
                          print('//////////////////////@@@@@@@@@@@@@@@');
                          searchController.clear();
                          nearbyAqarCubit.changeSearchMode();
                        } else {
                          nearbyAqarCubit.getNearbyAqarData(
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
                        nearbyAqarCubit.nearbyAqarModel.data?.clear();
                        nearbyAqarCubit.getNearbyAqarData(
                            context: context,
                            search: searchController.text,
                            city: searchCityController.text,
                            district: searchDistrictController.text);
                      }
                    },
                  ),
                  SizedBox(
                    height: context.height * 0.02.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomTextField(
                        //    autoFocus: widget.autoFocus ?? false,
                        bottomPadding: 0,
                        // prefixIcon: Padding(
                        //   padding: EdgeInsets.all(8.0.sp),
                        //   child: BackButtonWidget(
                        //       onTap: () {
                        //         Navigator.pop(context);
                        //         nearbyAqarCubit.getNearbyAqarData(
                        //           page: 1,
                        //           context: context,
                        //         );
                        //         nearbyAqarCubit.changeSearchMode();
                        //         searchController.clear();
                        //       },
                        //       color: darkGreyColor,
                        //       foregroundColor: goldColor,
                        //       radius: 5.sp),
                        // ),
                        maxHeight: context.height * 0.06,
                        minHeight: context.height * 0.06,
                        controller: searchCityController,
                        backgroundColor: whiteColor,
                        labelText: LocaleKeys.city.tr(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: goldColor,
                          ),
                          onPressed: () {
                            if (searchCityController.text.isEmpty) {
                              print('//////////////////////@@@@@@@@@@@@@@@');
                              searchCityController.clear();
                              nearbyAqarCubit.changeSearchMode();
                            } else {
                              nearbyAqarCubit.getNearbyAqarData(
                                page: 1,
                                context: context,
                              );
                              searchCityController.clear();
                            }
                          },
                        ),
                        onSubmit: (val) {
                          if (searchCityController.text.isEmpty) {
                            debugPrint('');
                          } else {
                            nearbyAqarCubit.nearbyAqarModel.data?.clear();
                            nearbyAqarCubit.getNearbyAqarData(
                                context: context,
                                search: searchController.text,
                                city: searchCityController.text,
                                district: searchDistrictController.text);
                          }
                        },
                      )),
                      SizedBox(
                        width: context.width * 0.02.w,
                      ),
                      Expanded(
                          child: CustomTextField(
                        //  autoFocus: widget.autoFocus ?? false,
                        bottomPadding: 0,
                        // prefixIcon: Padding(
                        //   padding: EdgeInsets.all(8.0.sp),
                        //   child: BackButtonWidget(
                        //       onTap: () {
                        //         Navigator.pop(context);
                        //         nearbyAqarCubit.getNearbyAqarData(
                        //           page: 1,
                        //           context: context,
                        //         );
                        //         nearbyAqarCubit.changeSearchMode();
                        //         searchController.clear();
                        //       },
                        //       color: darkGreyColor,
                        //       foregroundColor: goldColor,
                        //       radius: 5.sp),
                        // ),
                        maxHeight: context.height * 0.06,
                        minHeight: context.height * 0.06,
                        controller: searchDistrictController,
                        backgroundColor: whiteColor,
                        labelText: LocaleKeys.district.tr(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: goldColor,
                          ),
                          onPressed: () {
                            if (searchDistrictController.text.isEmpty) {
                              print('//////////////////////@@@@@@@@@@@@@@@');
                              searchDistrictController.clear();
                              nearbyAqarCubit.changeSearchMode();
                            } else {
                              nearbyAqarCubit.getNearbyAqarData(
                                page: 1,
                                context: context,
                              );
                              searchDistrictController.clear();
                            }
                          },
                        ),
                        onSubmit: (val) {
                          if (searchDistrictController.text.isEmpty) {
                            debugPrint('');
                          } else {
                            nearbyAqarCubit.nearbyAqarModel.data?.clear();
                            nearbyAqarCubit.getNearbyAqarData(
                                context: context,
                                search: searchController.text,
                                city: searchCityController.text,
                                district: searchDistrictController.text);
                          }
                        },
                      )),
                    ],
                  )
                ],
              ),
              onTap: () {
                navigateForward(FilterScreen());
                // Get.to(() => );
              },
            ),
            body: BlocBuilder<NearbyAqarCubit, NearbyAqarState>(
              builder: (context, state) {
                if (nearbyAqarCubit.isNearbyAqar == false) {
                  return AdsShimmer();
                }
                return state is GetNearbyAqarErrorState
                    ? CustomErrorWidget(reload: () {
                        nearbyAqarCubit.getNearbyAqarData(
                            context: context, page: 1);
                        // Get.back();
                      })
                    : nearbyAqarCubit.nearbyAqarModel.data!.isEmpty
                        ? Container(
                            alignment: AlignmentDirectional.topCenter,
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: context.width * 0.06.sp),
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
                                offset: nearbyAqarCubit
                                    .nearbyAqarModel.meta!.currentPage!,
                                last: nearbyAqarCubit
                                    .nearbyAqarModel.meta!.lastPage!,
                                onPaginate: (int offset) async {
                                  print(offset);
                                  await nearbyAqarCubit.getNearbyAqarData(
                                    search: searchController.text,
                                    context: context,
                                    page: offset,
                                  );
                                },
                                scrollController: _scrollController,
                                totalSize:
                                    nearbyAqarCubit.nearbyAqarModel.meta?.to ??
                                        15,
                                //reverse: true,
                                enabledPagination: true,
                                productView: Column(
                                  children: [
                                    // FavouriteWidget(
                                    //   categoryId: nearbyAqarCubit
                                    //       .nearbyAqarModel
                                    //       .data
                                    //       ?.first
                                    //       .categoryAds
                                    //       ?.id,
                                    //   features: nearbyAqarCubit.nearbyAqarModel
                                    //       .data?.first.additionalFeatures,
                                    //   adLocation:
                                    //   '${nearbyAqarCubit.nearbyAqarModel.data?.first
                                    //       .district}, ${nearbyAqarCubit.nearbyAqarModel
                                    //       .data?.first.city}, ${nearbyAqarCubit
                                    //       .nearbyAqarModel.data?.first.region}',
                                    //
                                    //   onTap: () {
                                    //     context.read<AdyByIdCubit>().getAdById(
                                    //         id: nearbyAqarCubit.nearbyAqarModel
                                    //             .data!.first.id!);
                                    //     navigateForward(AqarDetailsScreen(
                                    //       adId: nearbyAqarCubit
                                    //           .nearbyAqarModel.data!.first.id!,
                                    //       categoryId: nearbyAqarCubit
                                    //           .nearbyAqarModel
                                    //           .data!
                                    //           .first
                                    //           .categoryAds!
                                    //           .id
                                    //           .toString(),
                                    //     ));
                                    //     // Get.to(() => );
                                    //
                                    //     print('////////////////Gala');
                                    //   },
                                    //   isFavourite: true,
                                    //   isTabbedFavourite: nearbyAqarCubit
                                    //       .nearbyAqarModel
                                    //       .data!
                                    //       .first
                                    //       .isFavorite!,
                                    //   favouriteFunction: () {
                                    //     nearbyAqarCubit.nearbyAqarModel.data!
                                    //         .first.isFavorite!
                                    //         ? nearbyAqarCubit.removeFavourite(
                                    //         0,
                                    //         nearbyAqarCubit.nearbyAqarModel
                                    //             .data!.first.id
                                    //             .toString(),
                                    //         context)
                                    //         : nearbyAqarCubit.addFavourite(
                                    //         0,
                                    //         nearbyAqarCubit.nearbyAqarModel
                                    //             .data!.first.id
                                    //             .toString(),
                                    //         context);
                                    //   },
                                    //   // width:width?? 358.w,
                                    //   title: nearbyAqarCubit.nearbyAqarModel
                                    //       .data?.first.name ??
                                    //       '',
                                    //   image: nearbyAqarCubit.nearbyAqarModel
                                    //       .data!.first.photos!.isEmpty
                                    //       ? '${Images.AVATAR_IMAGE}'
                                    //       : nearbyAqarCubit.nearbyAqarModel
                                    //       .data!.first.photos?.first ??
                                    //       '',
                                    //   bathNo: nearbyAqarCubit.nearbyAqarModel
                                    //       .data?.first.toiletsNumber ??
                                    //       '',
                                    //   bedNo: nearbyAqarCubit.nearbyAqarModel
                                    //       .data?.first.roomsNumber ??
                                    //       '',
                                    //   price: nearbyAqarCubit.nearbyAqarModel
                                    //       .data?.first.price ??
                                    //       '',
                                    //   // kitchenNo: '2', livingNo: '2'
                                    // ),
                                    // SizedBox(
                                    //   height: 10.sp,
                                    // ),
                                    ///
                                    // nearbyAqarCubit.nearbyAqarModel.data!.length > 1
                                    //     ?
                                    Container(
                                      child: ListView.separated(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              margin: EdgeInsets.zero,
                                              elevation: 1,
                                              child: SimilarAds(
                                                isFavouriteWidget: false,
                                                isTabbedFavourite:
                                                    nearbyAqarCubit
                                                        .nearbyAqarModel
                                                        .data![index]
                                                        .isFavorite!,
                                                favouriteFunction: () {
                                                  nearbyAqarCubit
                                                          .nearbyAqarModel
                                                          .data![index]
                                                          .isFavorite!
                                                      ? nearbyAqarCubit
                                                          .removeFavourite(
                                                          index,
                                                          nearbyAqarCubit
                                                              .nearbyAqarModel
                                                              .data![index]
                                                              .id
                                                              .toString(),
                                                          context,
                                                        )
                                                      : nearbyAqarCubit
                                                          .addFavourite(
                                                          index,
                                                          nearbyAqarCubit
                                                              .nearbyAqarModel
                                                              .data![index]
                                                              .id
                                                              .toString(),
                                                          context,
                                                        );
                                                },
                                                onTap: () {
                                                  context
                                                      .read<AdyByIdCubit>()
                                                      .getAdById(
                                                          id: nearbyAqarCubit
                                                              .nearbyAqarModel
                                                              .data![index]
                                                              .id!);
                                                  navigateForward(
                                                      AqarDetailsScreen(
                                                    adId: nearbyAqarCubit
                                                        .nearbyAqarModel
                                                        .data![index]
                                                        .id!,
                                                    categoryId: nearbyAqarCubit
                                                        .nearbyAqarModel
                                                        .data![index]
                                                        .categoryAds!
                                                        .id
                                                        .toString(),
                                                  ));
                                                  // Get.to(() => );
                                                },
                                                image: (nearbyAqarCubit
                                                                .nearbyAqarModel
                                                                .data![index]
                                                                .photos ==
                                                            null ||
                                                        nearbyAqarCubit
                                                            .nearbyAqarModel
                                                            .data![index]
                                                            .photos!
                                                            .isEmpty)
                                                    ? '${Images.AVATAR_IMAGE}'
                                                    : (nearbyAqarCubit
                                                            .nearbyAqarModel
                                                            .data![index]
                                                            .photos!
                                                            .first
                                                            .isEmpty
                                                        ? '${Images.AVATAR_IMAGE}'
                                                        : nearbyAqarCubit
                                                            .nearbyAqarModel
                                                            .data![index]
                                                            .photos!
                                                            .first),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: Dimensions
                                                              .PADDING_SIZE_EXTRA_SMALL),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              '${nearbyAqarCubit.nearbyAqarModel.data?[index].categoryAds?.name ?? ''}',
                                                              style: openSansMedium
                                                                  .copyWith(
                                                                      color:
                                                                          darkGreyColor)),
                                                          //  Spacer(),

                                                          Row(
                                                            children: [
                                                              Text(
                                                                  '${nearbyAqarCubit.nearbyAqarModel.data?[index].price}',
                                                                  style: openSansMedium
                                                                      .copyWith(
                                                                          color:
                                                                              goldColor)),
                                                              SizedBox(
                                                                  width: context
                                                                          .width *
                                                                      0.005.w),
                                                              riyalWidget(
                                                                  context),
                                                            ],
                                                          )
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
                                                                .SMALL_LOCATION,
                                                            height:
                                                                context.height *
                                                                    0.01.h,
                                                            width:
                                                                context.width *
                                                                    0.01.w,
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              '${nearbyAqarCubit.nearbyAqarModel.data?[index].district}, ${nearbyAqarCubit.nearbyAqarModel.data?[index].city}, ${nearbyAqarCubit.nearbyAqarModel.data?[index].region}',
                                                              // nearbyAqarCubit
                                                              //         .nearbyAqarModel
                                                              //         .data?[
                                                              //             index +
                                                              //                 1]
                                                              //         .address ??
                                                              //     '',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              softWrap: true,
                                                              style: openSansMedium
                                                                  .copyWith(
                                                                      color:
                                                                          darkGreyColor),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // SizedBox(
                                                    //   height: 9.sp,
                                                    // ),
                                                    nearbyAqarCubit
                                                                    .nearbyAqarModel
                                                                    .data![
                                                                        index]
                                                                    .categoryAds
                                                                    ?.id ==
                                                                12 ||
                                                            nearbyAqarCubit
                                                                    .nearbyAqarModel
                                                                    .data![
                                                                        index]
                                                                    .categoryAds
                                                                    ?.id ==
                                                                14 ||
                                                            nearbyAqarCubit
                                                                    .nearbyAqarModel
                                                                    .data![
                                                                        index]
                                                                    .categoryAds
                                                                    ?.id ==
                                                                18 ||
                                                            nearbyAqarCubit
                                                                    .nearbyAqarModel
                                                                    .data![
                                                                        index]
                                                                    .categoryAds
                                                                    ?.id ==
                                                                13 ||
                                                            nearbyAqarCubit
                                                                    .nearbyAqarModel
                                                                    .data![
                                                                        index]
                                                                    .categoryAds
                                                                    ?.id ==
                                                                19 ||
                                                            nearbyAqarCubit
                                                                    .nearbyAqarModel
                                                                    .data![
                                                                        index]
                                                                    .categoryAds
                                                                    ?.id ==
                                                                16 ||
                                                            nearbyAqarCubit
                                                                    .nearbyAqarModel
                                                                    .data![
                                                                        index]
                                                                    .categoryAds
                                                                    ?.id ==
                                                                21 ||
                                                            nearbyAqarCubit
                                                                    .nearbyAqarModel
                                                                    .data![
                                                                        index]
                                                                    .categoryAds
                                                                    ?.id ==
                                                                24 ||
                                                            nearbyAqarCubit
                                                                    .nearbyAqarModel
                                                                    .data![
                                                                        index]
                                                                    .categoryAds
                                                                    ?.id ==
                                                                25 ||
                                                            nearbyAqarCubit
                                                                    .nearbyAqarModel
                                                                    .data![
                                                                        index]
                                                                    .categoryAds
                                                                    ?.id ==
                                                                27 ||
                                                            nearbyAqarCubit
                                                                    .nearbyAqarModel
                                                                    .data![
                                                                        index]
                                                                    .categoryAds
                                                                    ?.id ==
                                                                34 ||
                                                            nearbyAqarCubit
                                                                    .nearbyAqarModel
                                                                    .data![
                                                                        index]
                                                                    .categoryAds
                                                                    ?.id ==
                                                                36 ||
                                                            nearbyAqarCubit
                                                                        .nearbyAqarModel
                                                                        .data![
                                                                            index]
                                                                        .categoryAds
                                                                        ?.id ==
                                                                    35 &&
                                                                nearbyAqarCubit
                                                                    .nearbyAqarModel
                                                                    .data![
                                                                        index]
                                                                    .additionalFeatures!
                                                                    .isNotEmpty
                                                        ? Expanded(
                                                            child: Container(
                                                              height: nearbyAqarCubit
                                                                      .nearbyAqarModel
                                                                      .data![
                                                                          index]
                                                                      .additionalFeatures!
                                                                      .isEmpty
                                                                  ? 0
                                                                  : 20.sp,
                                                              width:
                                                                  context.width,
                                                              child: Wrap(
                                                                children: List
                                                                    .generate(
                                                                  nearbyAqarCubit
                                                                              .nearbyAqarModel
                                                                              .data![
                                                                                  index]
                                                                              .additionalFeatures!
                                                                              .length >=
                                                                          4
                                                                      ? 4
                                                                      : nearbyAqarCubit
                                                                          .nearbyAqarModel
                                                                          .data![
                                                                              index]
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
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Image
                                                                              .network(
                                                                            nearbyAqarCubit.nearbyAqarModel.data![index].additionalFeatures?[indexx].image ??
                                                                                'https://dashboard.redd.sa/dash/additional_features/1717849710.png',
                                                                            height:
                                                                                context.height * 0.03,
                                                                            width:
                                                                                context.width * 0.04,
                                                                            // width: 20.sp,
                                                                            // height: 20.sp,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                context.width * 0.01,
                                                                          ),
                                                                          AutoSizeText(
                                                                            nearbyAqarCubit.nearbyAqarModel.data![index].additionalFeatures?[indexx].name ??
                                                                                '',
                                                                            presetFontSizes: [
                                                                              12.sp,
                                                                              10.sp,
                                                                              5.sp
                                                                            ],
                                                                            overflow:
                                                                                TextOverflow.clip,
                                                                            style:
                                                                                openSansMedium.copyWith(color: goldColor),
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
                                                              // child: ListView.separated(
                                                              //
                                                              //         physics:
                                                              //             NeverScrollableScrollPhysics(),
                                                              //         scrollDirection:
                                                              //             Axis
                                                              //                 .horizontal,
                                                              //         itemCount: nearbyAqarCubit.nearbyAqarModel.data![index + 1].additionalFeatures!.length >=
                                                              //                 4
                                                              //             ? 4
                                                              //             : nearbyAqarCubit
                                                              //                 .nearbyAqarModel
                                                              //                 .data![index +
                                                              //                     1]
                                                              //                 .additionalFeatures!
                                                              //                 .length,
                                                              //         itemBuilder:
                                                              //             (context,
                                                              //                 indexx) {
                                                              //           return FittedBox(
                                                              //             child:
                                                              //                 Row(
                                                              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              //               mainAxisSize: MainAxisSize.max,
                                                              //               children: [
                                                              //                 Image.network(
                                                              //                   nearbyAqarCubit.nearbyAqarModel.data![index + 1].additionalFeatures?[indexx].image ?? 'https://dashboard.redd.sa/dash/additional_features/1717849710.png',
                                                              //                   height: context.height*0.02,
                                                              //                   width: context.width*0.02,
                                                              //                   // width: 20.sp,
                                                              //                   // height: 20.sp,
                                                              //                 ),
                                                              //                 SizedBox(
                                                              //                   width: context.width * 0.006,
                                                              //                 ),
                                                              //                 AutoSizeText(
                                                              //                   nearbyAqarCubit.nearbyAqarModel.data![index + 1].additionalFeatures?[indexx].name ?? '',
                                                              //                   presetFontSizes: [
                                                              //                     12.sp,
                                                              //                     10.sp,
                                                              //                     5.sp
                                                              //                   ],
                                                              //                  overflow: TextOverflow.clip,
                                                              //
                                                              //                   style: openSansMedium.copyWith(color: goldColor),
                                                              //                 ),
                                                              //                 // SizedBox(
                                                              //                 //   width: context.width * 0.1.sp,
                                                              //                 // ),
                                                              //               ],
                                                              //             ),
                                                              //           );
                                                              //         }, separatorBuilder: (BuildContext context, int index) {
                                                              //           return  SizedBox(width: context.width*0.03,);
                                                              // },),
                                                            ),
                                                          )
                                                        : Container(),

                                                    ///
                                                    // Row(
                                                    //   children: [
                                                    //     SvgPicture.asset(Images
                                                    //         .SMALL_LOCATION),
                                                    //     SizedBox(
                                                    //       width: 5.w,
                                                    //     ),
                                                    //     Text(
                                                    //       nearbyAqarCubit
                                                    //           .nearbyAqarModel
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
                                                      '',
                                                      // LocaleKeys
                                                      //     .noServiceProvider
                                                      //     .tr(),
                                                      style:
                                                          openSansBold.copyWith(
                                                              color: goldColor),
                                                    ),
                                                  );
                                                } else {
                                                  return promotedServicesCubit
                                                              .serviceProviderPromoted
                                                              .data!
                                                              .length >=
                                                          providerIndex + 1
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
                                          itemCount: nearbyAqarCubit
                                              .nearbyAqarModel.data!.length),
                                    ),
                                    // : const SizedBox(),
                                    nearbyAqarCubit.nearbyAqarModel.meta
                                                    ?.currentPage ==
                                                nearbyAqarCubit.nearbyAqarModel
                                                    .meta?.lastPage ||
                                            nearbyAqarCubit.nearbyAqarModel
                                                    .meta!.currentPage! >
                                                nearbyAqarCubit.nearbyAqarModel
                                                    .meta!.lastPage!
                                        ? BlocBuilder<PromotedServicesCubit,
                                            PromotedServicesState>(
                                            builder: (context, state) {
                                              if (state
                                                      is GetPromotedServicesLoadingState ||
                                                  promotedServicesCubit
                                                          .isGetData ==
                                                      false) {
                                                return AdsShimmer();
                                              } else if (state
                                                  is GetPromotedServicesErrorState) {
                                                return CustomErrorWidget(
                                                    reload: () {
                                                  promotedServicesCubit
                                                      .getPromotedServices();
                                                });
                                              } else if (promotedServicesCubit
                                                  .promotionServicesModel
                                                  .data!
                                                  .isEmpty) {
                                                return Container();
                                                // return Center(
                                                //   child: Text(
                                                //     LocaleKeys.noServiceProvider.tr(),
                                                //     style: openSansBold.copyWith(color: goldColor),
                                                //   ),
                                                // );
                                              } else {
                                                return SingleChildScrollView(
                                                  //       shrinkWrap: true,
                                                  //         physics: NeverScrollableScrollPhysics(),
                                                  child: Container(
                                                    child: ListView.separated(
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemBuilder:
                                                            (context, index) {
                                                          return GestureDetector(
                                                            // onTap: () {
                                                            //   navigateForward(ProviderDetailsScreen(
                                                            //     achievements: promotedServicesCubit.promotionServicesModel
                                                            //                           .data![index].user.
                                                            //         .provider
                                                            //         ?.achievements ??
                                                            //         [],
                                                            //     images_album: promotedServicesCubit
                                                            //         ..promotionServicesModel
                                                            //                           .data![index]
                                                            //         .data?[
                                                            //     index]
                                                            //         .provider
                                                            //         ?.imagesAlbum ??
                                                            //         [],
                                                            //     projects: promotedServicesCubit
                                                            //         ..promotionServicesModel
                                                            //                           .data![index]
                                                            //         .data?[
                                                            //     index]
                                                            //         .provider
                                                            //         ?.projects ??
                                                            //         [],
                                                            //     name: promotedServicesCubit
                                                            //         ..promotionServicesModel
                                                            //                           .data![index]
                                                            //         .data?[
                                                            //     index]
                                                            //         .provider
                                                            //         ?.name ??
                                                            //         '',
                                                            //     rate: promotedServicesCubit
                                                            //         ..promotionServicesModel
                                                            //                           .data![index]
                                                            //         .data?[index]
                                                            //         .provider
                                                            //         ?.rate,
                                                            //     value: TextEditingController(
                                                            //         text: promotedServicesCubit
                                                            //             ..promotionServicesModel
                                                            //                           .data![index]
                                                            //             .provider
                                                            //             ?.value ??
                                                            //             ''),
                                                            //     imageAvatar: promotedServicesCubit
                                                            //         .priceOfferModel
                                                            //         .data?[
                                                            //     index]
                                                            //         .provider
                                                            //         ?.photo ??
                                                            //         '',
                                                            //     noRate: promotedServicesCubit
                                                            //         .priceOfferModel
                                                            //         .data?[index]
                                                            //         .provider
                                                            //         ?.noRate,
                                                            //     notes: TextEditingController(
                                                            //         text: promotedServicesCubit
                                                            //             .priceOfferModel
                                                            //             .data?[
                                                            //         index]
                                                            //             .provider
                                                            //             ?.notes ??
                                                            //             ''),
                                                            //     objectives: TextEditingController(
                                                            //         text: promotedServicesCubit
                                                            //             .priceOfferModel
                                                            //             .data?[
                                                            //         index]
                                                            //             .provider
                                                            //             ?.objectives ??
                                                            //             ''),
                                                            //     visionary: TextEditingController(
                                                            //         text: promotedServicesCubit
                                                            //             .priceOfferModel
                                                            //             .data?[
                                                            //         index]
                                                            //             .provider
                                                            //             ?.visionary ??
                                                            //             ''),
                                                            //   ));
                                                            // },
                                                            child: Card(
                                                                elevation: 3,
                                                                clipBehavior: Clip
                                                                    .antiAliasWithSaveLayer,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(Dimensions
                                                                            .RADIUS_SMALL)),
                                                                child:
                                                                    Container(
                                                                  height: context
                                                                          .height *
                                                                      0.137,
                                                                  width: context
                                                                      .width,
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              goldColor),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              Dimensions.RADIUS_SMALL)),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Stack(
                                                                        alignment:
                                                                            AlignmentDirectional.topEnd,
                                                                        children: [
                                                                          FittedBox(
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                                                                              child: Container(
                                                                                height: context.width * 0.3,
                                                                                width: context.width * 0.3,
                                                                                child: CachedNetworkImage(
                                                                                  imageUrl: promotedServicesCubit.promotionServicesModel.data![index].user!.photo!,
                                                                                  fit: BoxFit.cover,
                                                                                  errorWidget: (context, url, error) => Icon(
                                                                                    Icons.error,
                                                                                    color: redColor,
                                                                                  ),
                                                                                  placeholder: (context, url) => Image.asset(Images.SMALL_LOGO_ICON),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          //   Icon(Icons.favorite_outlined,color: redColor,).paddingOnly(top: context.width*0.02,left: context.width*0.02 ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        width: Dimensions
                                                                            .PADDING_SIZE_DEFAULT,
                                                                      ),
                                                                      Expanded(
                                                                          child:
                                                                              Row(
                                                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                promotedServicesCubit.promotionServicesModel.data![index].user!.name!,
                                                                                style: openSansBold.copyWith(color: darkGreyColor),
                                                                              ),
                                                                              Text(
                                                                                promotedServicesCubit.promotionServicesModel.data![index].service!.name ?? '',
                                                                                style: openSansBold.copyWith(color: goldColor),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          IconButton(
                                                                              onPressed: () {
                                                                                launchCall(context: context, phoneNumber: promotedServicesCubit.promotionServicesModel.data![0].user!.phone ?? '');
                                                                              },
                                                                              icon: Icon(
                                                                                Icons.call,
                                                                                color: goldColor,
                                                                              ))
                                                                        ],
                                                                      ))
                                                                    ],
                                                                  ),
                                                                )),
                                                          );
                                                        },
                                                        separatorBuilder:
                                                            (context, index) {
                                                          return SizedBox(
                                                            height: 10.sp,
                                                          );
                                                        },
                                                        itemCount:
                                                            promotedServicesCubit
                                                                .promotionServicesModel
                                                                .data!
                                                                .length),
                                                  ),
                                                );
                                              }
                                            },
                                          )
                                        // SingleChildScrollView(
                                        //
                                        //   child: Container(
                                        //    // height: context.height*0.5.sp,
                                        //     child: ListView.separated(
                                        //       shrinkWrap: true,
                                        //         physics: NeverScrollableScrollPhysics(),
                                        //         itemCount: 3,
                                        //         itemBuilder: (context,i){
                                        //       return Text('data');
                                        //     }, separatorBuilder: (BuildContext context, int ii) {return SizedBox();},),
                                        //   ),
                                        // )
                                        : const SizedBox(),
                                    widget.id == 2
                                        ? SizedBox()
                                        : Padding(
                                            padding: const EdgeInsets.all(
                                                Dimensions
                                                    .PADDING_SIZE_EXTRA_LARGE),
                                            child: CustomButton(
                                                textButton:
                                                    LocaleKeys.onMap.tr(),
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
              },
            ),
            // BlocBuilder<PromotedServicesCubit, PromotedServicesState>(
            //   // listener: (context, state) {
            //   //   // TODO: implement listener
            //   // },
            //   builder: (context, state) {
            //     if (state is GetPromotedServicesLoadingState) {
            //       return AdsShimmer();
            //     } else {
            //       return
            //           // state is GetPromotedServicesLoadingState?AdsShimmer():
            //
            //     }
            //   },
            // ),
          ),
        );
      },
    );
  }
}
