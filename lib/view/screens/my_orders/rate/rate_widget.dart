import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/app_constant.dart';

class StarRating extends StatefulWidget {
  final int starCount;
  final double rating;
  final Color color;
  final double size;
  final double? padding;
  final MainAxisAlignment? mainAxis;

  // final double? paddingTop;

  StarRating(
      {this.starCount = 5,
      this.rating = .0,
      required this.color,
      required this.size,
      this.padding,
      this.mainAxis});

  @override
  _StarRatingState createState() =>
      _StarRatingState(starCount, rating, color, size);
}

class _StarRatingState extends State<StarRating> {
  int starCount;
  double rating;
  Color color;
  double size;

  _StarRatingState(this.starCount, this.rating, this.color, this.size);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: widget.padding ?? 20.h, bottom: widget.padding ?? 20.h),
      child: Row(
        mainAxisAlignment: widget.mainAxis ?? MainAxisAlignment.center,
        children: List.generate(
          starCount,
          (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  rating = index + 1.0;
                  ratingCount = rating;
                });
                debugPrint(rating.toString());
              },
              child: Icon(
                index < rating.floor() ? Icons.star : Icons.star_border,
                size: size,
                color: color,
              ),
            );
          },
        ),
      ),
    );
  }
}
