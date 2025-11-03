import 'package:flutter/cupertino.dart';

import '../../../bloc/favourite_cubit/favourite_cubit.dart';
import '../../../bloc/favourite_cubit/favourite_state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/images.dart';
import '../../base/guest_widget.dart';
import '../../base/pagination_view.dart';
import '../../../utils/dimention.dart';
import '../../../utils/media_query_value.dart';
import '../../../view/base/auth_header.dart';
import '../../../view/base/lunch_widget.dart';
import '../../../view/base/shimmer/ads_shimmer.dart';
import '../../../view/error_widget/error_widget.dart';
import '../../../view/screens/favourites/widget/favourite_widget.dart';
import 'favourite_details_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    context.read<FavouriteCubit>().getFavouriteData(page: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var favouriteCubit = context.read<FavouriteCubit>();
    return Scaffold(
      // appBar: AuthHeader(
      //   title: LocaleKeys.favourite.tr(),
      //   height: context.height * 0.17.h,
      // ),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(title: LocaleKeys.favourite.tr()),
          ),
          Expanded(
            child: BlocConsumer<FavouriteCubit, FavouriteState>(
              listener: (context, state) {},
              // bloc: favouriteCubit.getFavouriteData(),
              builder: (context, state) {
                if (token == null) {
                  return LoginFirst();
                } else if (favouriteCubit.isGetFav == false) {
                  return AdsShimmer();
                }
                return state is GetFavouriteDataErrorState
                    ? CustomErrorWidget(reload: () {
                        favouriteCubit.getFavouriteData(page: 1);
                      })
                    : favouriteCubit.favouriteModel.data!.isEmpty
                        ? Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(Images.EMPTY_SEARCH),
                                Text(LocaleKeys.noFavouriteItem.tr())
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: PaginatedListView(
                                offset:
                                    favouriteCubit.favouriteModel.meta!.currentPage!,
                                last: favouriteCubit.favouriteModel.meta!.lastPage!,
                                onPaginate: (int offset) async {
                                  print(offset);
                                  await favouriteCubit.getFavouriteData(
                                    page: offset,
                                  );
                                },
                                scrollController: _scrollController,
                                totalSize:
                                    favouriteCubit.favouriteModel.meta?.to ?? 15,
                                enabledPagination: true,
                                productView: AnimationLimiter(
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        favouriteCubit.favouriteModel.data!.length,
                                    itemBuilder: (context, index) {
                                      //Card(
                                      //elevation: 1,
                                      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
                                      //  child:
                                      return AnimationConfiguration.staggeredList(
                                        position: index,
                                        duration: const Duration(milliseconds: 750),
                                        child: SlideAnimation(
                                          verticalOffset: 50.0,
                                          child: FadeInAnimation(
                                            child: FavouriteWidget(

                                              categoryId: favouriteCubit
                                                  .favouriteModel
                                                  .data![index]
                                                  .ads
                                                  ?.categoryAds
                                                  ?.id,
                                              features: favouriteCubit
                                                  .favouriteModel
                                                  .data![index]
                                                  .ads!
                                                  .additionalFeatures,
                                              isTabbedFavourite: favouriteCubit
                                                  .favouriteModel
                                                  .data![index]
                                                  .ads!
                                                  .isFavorite!,
                                              title: favouriteCubit
                                                      .favouriteModel
                                                      .data![index].ads?.name ??
                                                  '',
                                              image: favouriteCubit
                                                      .favouriteModel
                                                      .data![index]
                                                      .ads!
                                                      .photos!
                                                      .isEmpty
                                                  ? Images.AVATAR_IMAGE
                                                  : favouriteCubit
                                                      .favouriteModel
                                                      .data![index]
                                                      .ads!
                                                      .photos!
                                                      .first,
                                              bathNo: favouriteCubit
                                                      .favouriteModel
                                                      .data![index]
                                                      .ads!
                                                      .toiletsNumber ??
                                                  '',
                                              bedNo: favouriteCubit
                                                      .favouriteModel
                                                      .data![index]
                                                      .ads!
                                                      .roomsNumber ??
                                                  '',
                                              price: favouriteCubit.favouriteModel
                                                      .data![index].ads!.price ??
                                                  "",
                                              favouriteFunction: () {
                                                favouriteCubit.removeFavourite(
                                                    index,
                                                    favouriteCubit.favouriteModel
                                                        .data![index].ads!.id
                                                        .toString());
                                              },
                                              adLocation:
                                                  "${favouriteCubit.favouriteModel.data![index].ads?.district}, ${favouriteCubit.favouriteModel.data![index].ads?.city}, ${favouriteCubit.favouriteModel.data![index].ads?.region}",
                                              onTap: () {
                                                navigateForward(FavouriteDetailsScreen(
                                                    //   adId: favouriteCubit.favouriteModel.data![index].id!,
                                                    index: index,
                                                    listMyAds: favouriteCubit.favouriteModel.data!
                                                    //  isFav: true,
                                                    //  aqarIndex: index,
                                                    // photos: favouriteCubit.favouriteModel.data![index].ads!.photos!,
                                                    //  model: favouriteCubit.favouriteModel,
                                                    //  categoryId: favouriteCubit.favouriteModel.data![index].ads!.categoryAds!.id.toString(),,

                                                    ));
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        height: 10.h,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
