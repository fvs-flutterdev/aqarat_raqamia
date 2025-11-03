import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 350,
            child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  padding: EdgeInsets.zero,
                  height: 150,
                  width:  MediaQuery.of(context).size.width,
                //  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey,
                  ),
                )),
          ),
          SizedBox(height: 30,),
          Container(
            height: MediaQuery.of(context).size.height,

            child: ListView.separated(
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
          )
        ],
      ),
    );
  }
}
