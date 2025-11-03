import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/dimention.dart';
import '../../utils/text_style.dart';

class CustomCarouselSliderWidget extends StatelessWidget {
  List<String> photos;
  double height;
  int count;
  int selectedIndex;
  Function changeIndexFunction;

  CustomCarouselSliderWidget(
      {super.key,
      required this.photos,
      required this.height,
      required this.count,
      required this.selectedIndex,
      required this.changeIndexFunction});

  @override
  Widget build(BuildContext context) {
    //  final mediaQuery = context.mediaQuery;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: height,
              // height: mediaQuery.size.height * 0.25,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              //  autoPlay: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayInterval: const Duration(seconds: 3),
              enlargeCenterPage: true,
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              scrollDirection: Axis.horizontal,
              onPageChanged: (i, reason) {
                changeIndexFunction(i);
                //  ordersProviderCubit.changeIndexCarousel(i);
              }),
          items: photos
              //ordersProvider[index].photos!
              .map((e) {
            return Builder(builder: (context) {
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.RADIUS_SMALL.sp),),),
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: Dimensions.RADIUS_SMALL),
                  width: context.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(e,
                            errorListener: (ctx) => Icon(Icons.error)),
                        //NetworkImage(e),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.RADIUS_SMALL.sp)
                        // topRight: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
                        // topLeft: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
                        ),
                  ),
                  // child: Image.network(e,fit: BoxFit.contain),
                ),
              );
            });
          }).toList(),
        ),
        AnimatedSmoothIndicator(
          activeIndex: selectedIndex,
          //  activeIndex: ordersProviderCubit.selectedIndex,
          count: count,
          //  count: ordersProvider[index].photos!.length,
          effect: WormEffect(
              activeDotColor: goldColor, dotColor: whiteColor, radius: 20.sp),
        ),
      ],
    );
  }
}
