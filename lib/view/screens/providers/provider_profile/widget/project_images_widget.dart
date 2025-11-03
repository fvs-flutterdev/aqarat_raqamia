import '../../../../../utils/media_query_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../utils/dimention.dart';
import '../../../../../utils/images.dart';
import '../../../../../utils/text_style.dart';

class ProjectImagesWidget extends StatelessWidget {
  const ProjectImagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
      return Container(
        height: context.width*0.5,
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return SizedBox(
                width: Dimensions.PADDING_SIZE_SMALL,
              );
            },
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // profileProviderController.isSelectedImageForProject[index] == true
                  //     ? null
                  //     : profileProviderController.pickImagesForProject(index);
                //  profileProviderController.getImageForProject(index);
                },
                child: Stack(
                  children: [
                    Container(
                      margin:const EdgeInsetsDirectional.only(
                        top: 8,
                      ),
                      padding:const EdgeInsetsDirectional.only(end: 10),
                      height: 170.h,
                      // color: Colors.cyan,
                      child: Container(
                        margin: EdgeInsetsDirectional.only(
                          top: 10.h,
                        ),
                        height: 140.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.RADIUS_LARGE),
                          border: Border.all(color: goldColor),
                        ),
                        child:
                        // profileProviderController.uploadProjectsList[index]
                        //     ? ClipRRect(
                        //     borderRadius: BorderRadius.circular(
                        //         Dimensions.RADIUS_LARGE),
                        //     child: Image.file(File(' profileProviderController.imageProjectList[index]')
                        //      ,
                        //       //  fit: BoxFit.fitWidth,
                        //     ))
                        //     :
                        Center(
                          child: SvgPicture.asset(
                            Images.Add_SVG,
                            // width: 12,
                            // height: 12,
                          ),
                        ),
                      ),
                    ),
                    // profileProviderController.uploadProjectsList[index] == true
                    //     ? Positioned.directional(
                    //   top: 12.h,
                    //   end: 1.w,
                    //   textDirection: TextDirection.rtl,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       profileProviderController.clearImageProject(index);
                    //     },
                    //     child: CircleAvatar(
                    //       radius: Dimensions.RADIUS_DEFAULT,
                    //       backgroundColor: darkGreyColor,
                    //       backgroundImage:
                    //       AssetImage(Images.DELETE_GOLD),
                    //     ),
                    //   ),
                    // )
                    //     :
                    const  SizedBox(),
                  ],
                ),
              );
            }),
      );
    //});
  }
}
