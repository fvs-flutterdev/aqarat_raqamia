import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/upload_request_cubit/cubit.dart';
import '../../../../utils/media_query_value.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/images.dart';
import '../../../../utils/text_style.dart';
import '../../../base/back_button.dart';
import '../../../base/full_screen_image/full_screen_image.dart';
import '../../../base/lunch_widget.dart';
import '../../my_ads_screen/edit_my_ads_images.dart';
import '../../my_ads_screen/widget/visability_widget.dart';

class SliverAppBarWidget extends StatelessWidget {
  final String name;
  final List<String> images;
  final String? mainImage;
  final CarouselSliderController carouselController;
  final Function carouselFunction;
  final int activeIndex;
  final bool? isSameAd;

  const SliverAppBarWidget({
    super.key,
    required this.name,
    this.mainImage,
    required this.activeIndex,
    required this.carouselController,
    required this.carouselFunction,
    required this.images,
    this.isSameAd=false,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: whiteColor,
      expandedHeight: context.width * 0.9.sp,
      toolbarHeight: context.height * 0.12.sp,
      pinned: true,
      floating: true,
      centerTitle: true,
      snap: true,
      title: SABT(
        child: SafeArea(
          minimum: EdgeInsets.only(
            top: Dimensions.PADDING_SIZE_LARGE.sp,
          ),
          child: AutoSizeText(
            name,
            // adsByIdCubit.adsByIdModel.data?.name ?? '',
            style: openSansExtraBold.copyWith(color: goldColor,fontSize: 18.sp,),
            presetFontSizes: [18.sp,15.sp,],
            softWrap: true,
            maxLines: 2,
          ),
        ),
      ),
      leading: Padding(
        padding: EdgeInsetsDirectional.only(
            // top: 50.sp,
            top: Dimensions.PADDING_SIZE_LARGE.sp,
            start: Dimensions.PADDING_SIZE_LARGE.sp),
        child: BackButtonWidget(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(Dimensions.RADIUS_DEFAULT),
            bottomLeft: Radius.circular(Dimensions.RADIUS_DEFAULT),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GestureDetector(
                onTap: () {
                  navigateForward(FullImageListScreen(
                      image: images,
                      //  adsByIdCubit.adsByIdModel.data?.photos ?? [],
                      itemCount: images.length
                      //adsByIdCubit.adsByIdModel.data!.photos!.length,
                      ));
                },
                child: CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                      height: context.width * 0.9.sp,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (i, reason) {
                        carouselFunction(i, reason);
                        print('????????????????????????????Carousel');
                      }
                      //  filterAdsCubit.changeIndexCarousel(i);
                      ),
                  items: images
                      //adsByIdCubit.adsByIdModel.data!.photos!
                      .map((e) {
                    return Builder(builder: (context) {
                      return Card(
                        margin: EdgeInsets.zero,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            // side: BorderSide(color: goldColor),
                            borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(Dimensions.RADIUS_DEFAULT),
                                bottomRight: Radius.circular(
                                    Dimensions.RADIUS_DEFAULT))),
                        child: Container(
                          width: context.width,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(Dimensions.RADIUS_DEFAULT),
                                bottomRight:
                                    Radius.circular(Dimensions.RADIUS_DEFAULT)),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: images
                                    //  adsByIdCubit.adsByIdModel.data!.photos!
                                    .isEmpty
                                ? Images.AVATAR_IMAGE
                                : e,
                            fit: BoxFit.cover,
                            placeholder: (l, n) {
                              return Image.asset(Images.SMALL_LOGO_ICON);
                            },
                            errorWidget: (z, x, c) {
                              return Image.asset(Images.Error);
                            },
                          ),
                        ),
                      );
                    });
                  }).toList(),
                ),
              ),
              AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                //filterAdsCubit.selectedIndex,
                count: images.length,
                //adsByIdCubit.adsByIdModel.data!.photos!.length,
                effect: WormEffect(
                    activeDotColor: goldColor,
                    dotColor: whiteColor,
                    radius: 20.sp),
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => carouselController.previousPage(
                          duration: const Duration(
                            milliseconds: 800,
                          ),
                          //  curve: Curves.fastLinearToSlowEaseIn
                        ),
                        child: SvgPicture.asset(Images.Back_svg),
                      ),
                      GestureDetector(
                        onTap: () => carouselController.nextPage(
                          duration: const Duration(
                            milliseconds: 800,
                          ),
                          // curve: Curves.fastLinearToSlowEaseIn
                        ),
                        child: SvgPicture.asset(Images.Forward_svg),
                      ),
                    ],
                  ),
                ),
              ),
              isSameAd==true?  GestureDetector(
                onTap: () {
                  navigateForward(EditMyAdsImagesScreen(

                    adId:
                      context.read<UploadRequestCubit>().adId!,
                   photos:images ,
                  ));
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.all(8.0.sp),
                  child: Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Container(
                      padding: EdgeInsets.zero,
                      child: SvgPicture.asset(Images.edit_images_svg),
                    ),
                  ),
                ),
              ):SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
