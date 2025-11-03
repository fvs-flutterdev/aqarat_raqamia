import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AdsShimmer extends StatelessWidget {
  bool isHorizontal;
  bool isCategory;
   AdsShimmer({super.key,this.isHorizontal=false,this.isCategory=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:isHorizontal?context.width*0.15:isCategory?context.width* 0.65: MediaQuery.of(context).size.height,

      child: ListView.separated(
        scrollDirection: isHorizontal?Axis.horizontal:Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            return SizedBox(
              height:isHorizontal?context.width*0.03: context.width*0.38,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height:isHorizontal?context.width*0.03: context.width*0.38,
                  width:isHorizontal?context.width*0.15: MediaQuery.of(context).size.width,
                  margin: EdgeInsetsDirectional.symmetric(horizontal: 13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          }, separatorBuilder: (context,index){
        return SizedBox(height: 10,);
      }, itemCount:isCategory?1: 4),
    );
    // return Column(
    //   children: [
    //     // SizedBox(
    //     //   height: 200,
    //     //   child: Shimmer.fromColors(
    //     //       baseColor: Colors.grey.shade300,
    //     //       highlightColor: Colors.grey.shade100,
    //     //       child: Container(
    //     //         padding: EdgeInsets.zero,
    //     //         height: 150,
    //     //         width:  MediaQuery.of(context).size.width,
    //     //         //  margin: EdgeInsets.all(10),
    //     //         decoration: BoxDecoration(
    //     //           borderRadius: BorderRadius.circular(15),
    //     //           color: Colors.grey,
    //     //         ),
    //     //       )),
    //     // ),
    //     // SizedBox(height: 30,),
    //
    //   ],
    // );
  }
}
