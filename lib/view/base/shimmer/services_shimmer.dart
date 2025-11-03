import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/dimention.dart';

class ServicesShimmer extends StatelessWidget {
  const ServicesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisExtent: 200.h,
                  mainAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                 // crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 100.h,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: EdgeInsetsDirectional.symmetric(horizontal: 10),
                        height: 100.h,
                        width: MediaQuery.of(context).size.width,
                       // margin: EdgeInsetsDirectional.symmetric(horizontal: 13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
                //     separatorBuilder: (context,index){
                //   return SizedBox(height: 10,);
                // },
                itemCount: 4),
          )
        ],
      ),
    );
  }
}
