import 'package:aqarat_raqamia/utils/images.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/dimention.dart';
//ignore: must_be_immutable
class SimilarAds extends StatelessWidget {
  final String image;
  final Widget child;
  final Function onTap;
  double? height;
  double? width;
  Function? favouriteFunction;
  bool? isTabbedFavourite;
  bool isFavouriteWidget;

  SimilarAds(
      {super.key,
      required this.image,
      required this.child,
      required this.onTap,
        this.width,
        this.height,
       this.isTabbedFavourite,
        this.isFavouriteWidget=true,
        this.favouriteFunction
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       onTap();
      },
      child: Container(

        height:height?? context.height * 0.137.sp,
        width: width??context.width,
        padding: EdgeInsetsDirectional.only(end: 7.sp),
        decoration: BoxDecoration(

          border: Border.all(color: goldColor),
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [

                FittedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    child: Container(
                      height:context.width * 0.3.sp,
                      width:context.width * 0.3.sp,
                      child: CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: redColor,
                        ),
                        placeholder: (context, url) =>
                            Image.asset(Images.SMALL_LOGO_ICON),
                      ),
                    ),
                  ),
                ),
                isFavouriteWidget?const SizedBox():  IconButton(


                  //highlightColor:  goldColor,
                  // focusColor:isTabbedFavourite!?goldColor: whiteColor,

                  icon: isTabbedFavourite! ? Icon(Icons.favorite_outlined,color: goldColor,):Icon(Icons.favorite_outline_rounded),

                  onPressed: (){
                    favouriteFunction!();
                  },

                  color: whiteColor,
                ),
             //   Icon(Icons.favorite_outlined,color: redColor,).paddingOnly(top: context.width*0.02,left: context.width*0.02 ),

              ],
            ),
            const  SizedBox(
              width: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            Expanded(child: child)
          ],
        ),
      ),
    );
  }
}
