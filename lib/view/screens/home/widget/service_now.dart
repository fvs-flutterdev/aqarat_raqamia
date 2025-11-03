import '../../../../utils/media_query_value.dart';
import '../../../../view/error_widget/error_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../bloc/banner_cubit/cubit.dart';
import '../../../../bloc/banner_cubit/state.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/images.dart';
import '../../../base/shimmer/ads_shimmer.dart';

class ServiceNowWidget extends StatelessWidget {
  const ServiceNowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var carouselBannersCubit = context.read<BannersCarouselCubit>();
    return GestureDetector(
      onTap: () {
      //  navigateForward(ServicesScreen());
      },
      child: Container(
        height: 160.sp,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(Dimensions.RADIUS_LARGE),

          // color: Colors.deepOrangeAccent
        ),
        child: BlocBuilder<BannersCarouselCubit, CarouselBannersState>(
          builder: (context, state) {
            if(state is GetCarouselBannersLoadingState){
              return AdsShimmer(
                isCategory: true,
              );
            }else if (state is GetCarouselBannersErrorState){
              return CustomErrorWidget(reload: (){carouselBannersCubit.getBanners();});
            }else {
              return Stack(
                children: [
                  Container(
                    height: 140.sp,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius:const BorderRadius.only(
                            topLeft:
                            Radius.circular(Dimensions.RADIUS_LARGE),
                            topRight:
                            Radius.circular(Dimensions.RADIUS_LARGE)),
                    //    color: Colors.black
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          Dimensions.RADIUS_LARGE),
                      child: CarouselSlider(
                        //  carouselController: carouselController,
                        options: CarouselOptions(
                            height: context.height * 0.35.sp,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            //  autoPlay: true,
                            autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                            autoPlayInterval: const Duration(seconds: 3),
                            enlargeCenterPage: true,
                            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (i, reason) {
                              // myAdsCubit.changeIndexCarousel(i);
                            }),
                        items: carouselBannersCubit.carouselBannerModel.data!
                            .map((e) {
                          return Builder(builder: (context) {
                            return Card(
                              elevation: 3,
                              shape:const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          Dimensions.RADIUS_DEFAULT),
                                      bottomLeft: Radius.circular(
                                          Dimensions
                                              .RADIUS_DEFAULT))),
                              child: Container(
                                // margin: EdgeInsets.symmetric(horizontal: Dimensions.RADIUS_SMALL),
                                width: context.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(e),
                                      fit: BoxFit.cover),
                                  borderRadius:const BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          Dimensions.RADIUS_DEFAULT),
                                      bottomLeft: Radius.circular(
                                          Dimensions.RADIUS_DEFAULT)
                                    // topRight: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
                                    // topLeft: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
                                  ),
                                ),
                                child: FancyShimmerImage(imageUrl: e,boxFit: BoxFit.cover,errorWidget:  Image.asset(Images.Error)),
                                // child: Image.network(e,fit: BoxFit.contain),
                              ),
                            );
                          });
                        }).toList(),
                      ),
                      // Image.asset(
                      //   Images.SERVICE_NOW,
                      //   fit: BoxFit.fitWidth,
                      //   width: double.infinity,
                      // )

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        end: Dimensions.PADDING_SIZE_DEFAULT),
                    child: Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Image.asset(
                        Images.SMALL_LOGO_ICON,
                        height: 40.sp,
                        width: 40.sp,
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
