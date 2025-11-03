import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/dimention.dart';
import '../../../utils/text_style.dart';

class ContactUsShimmer extends StatelessWidget {
  bool isServiceProvider;
   ContactUsShimmer({super.key, this.isServiceProvider=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isServiceProvider?   Text(
            'تسجيل مقدم خدمة جديد',
            style: openSansExtraBold.copyWith(
                color: darkGreyColor),
          ):SizedBox(),
          isServiceProvider?  Text(
            'مرحبا بك في عقارات الرقمية',
            style: openSansRegular.copyWith(
                color: darkGreyColor),
          ):SizedBox(),
          SizedBox(
            height: Dimensions.PADDING_SIZE_LARGE,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return SizedBox(
                  height: 50,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
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
          }, itemCount: 4),
        ],
      ),
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
