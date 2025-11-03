import 'package:aqarat_raqamia/bloc/comments_cubit/cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../bloc/ads_by_id_cubit/cubit.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/images.dart';
import '../../../../utils/text_style.dart';
import '../../my_orders/rate/rate_widget.dart';

class ListTileCommentWidget extends StatelessWidget {
  final String name, imageUrl, review;
  final int commentId;
  final double rate;
  const ListTileCommentWidget(
      {super.key,
      required this.rate,
        required this.commentId,
      required this.review,
      required this.imageUrl,
      required this.name});

  @override
  Widget build(BuildContext context) {
    var commentsCubit=context.read<CommentsCubit>();
    var adsByIdCubit = context.read<AdyByIdCubit>();
    return Container(

      child: ListTile(
        leading: CircleAvatar(
          radius: 25.sp,
          backgroundColor: transparentColor,
          child: ClipOval(
            child: FancyShimmerImage(
              imageUrl: imageUrl,
              errorWidget: Image.network(Images.AVATAR_IMAGE),
            ),
          ),
        ),
        title: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: openSansExtraBold.copyWith(color: darkGreysColor),
        ),
        subtitle:Text(review,style: openSansBlack.copyWith(color: darkGreysColor),) ,
        trailing: Container(
          child: FittedBox(
            child: Column(
            //  mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(LocaleKeys.addRate.tr()),
                  onPressed: () {
                    showAdaptiveDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                LocaleKeys.addRate.tr(),
                                style: openSansBold.copyWith(color: darkGreyColor),
                              ),
                              Divider(
                                endIndent: 5.sp,
                                indent: 5.sp,
                                thickness: 2.sp,
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              Image.asset(Images.RATE),
                              StarRating(

                                padding: 10.sp,
                                color: goldColor,
                                size: 30.sp,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  commentsCubit.rateCommentForAd( commentId: commentId);

                                },
                                child: Text(LocaleKeys.send.tr()))
                          ],
                        );
                      },
                    );
                  },
                ),
              //  rate.toStringAsFixed(1)=="0.0"?SizedBox():
                Row(
                  children: [
                    SvgPicture.asset(Images.STAR_SVG),
                    Text(rate.toStringAsFixed(1),style: openSansBlack.copyWith(color: goldColor),)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
