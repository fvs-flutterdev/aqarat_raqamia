// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
//
// import '../../../../../controller/providers_controller/profile_provider_controller.dart';
// import '../../../../../utils/dimention.dart';
// import '../../../../../utils/images.dart';
// import '../../../../../utils/text_style.dart';
//
// class GalleryImageWidget extends StatelessWidget {
//   const GalleryImageWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//   //  return GetBuilder<ProfileProviderController>(builder: (profileProviderController) {
//       return Container(
//         //padding: EdgeInsetsDirectional.only(top: 10.h),
//         height: 190,
//         child: ListView.separated(
//             physics: NeverScrollableScrollPhysics(),
//             separatorBuilder: (context, index) {
//               return SizedBox(
//                 width: Dimensions.PADDING_SIZE_SMALL,
//               );
//             },
//             itemCount: 3,
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   // profileProviderController.uploadGalleryList[index] == true
//                   //     ? null
//                   //     : profileProviderController.getImageForGallery(index);
//                   //  profileProviderController.pickImageFromCamera(index);
//                 },
//                 child: Stack(
//                   children: [
//                     Container(
//                       margin: EdgeInsetsDirectional.only(
//                         top: 8,
//                       ),
//                       padding: EdgeInsetsDirectional.only(end: 10),
//                       height: 170.h,
//                       // color: Colors.cyan,
//                       child: Container(
//                         margin: EdgeInsetsDirectional.only(
//                           top: 10.h,
//                         ),
//                         height: 140.h,
//                         width: 90.w,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(
//                               Dimensions.RADIUS_LARGE),
//                           border: Border.all(color: goldColor),
//                         ),
//                         child:
//                         // profileProviderController.uploadGalleryList[index]
//                         //     ? ClipRRect(
//                         //   //  clipBehavior: Clip.hardEdge,
//                         //     borderRadius: BorderRadius.circular(
//                         //         Dimensions.RADIUS_LARGE),
//                         //     child: FittedBox(
//                         //       child: Image.file(
//                         //         profileProviderController
//                         //             .imageGalleryList[index],
//                         //         // fit: BoxFit.contain,
//                         //       ),
//                         //     ))
//                         //     :
//                         Center(
//                           child: SvgPicture.asset(
//                             Images.Add_SVG,
//                             // width: 12,
//                             // height: 12,
//                           ),
//                         ),
//                       ),
//                     ),
//                  //   profileProviderController.uploadGalleryList[index] == true
//                      //   ?
//                  Positioned.directional(
//                       top: 12.h,
//                       end: 1.w,
//                       textDirection: TextDirection.rtl,
//                       child: GestureDetector(
//                         onTap: () {
//                        //   profileProviderController.clearImageGallery(index);
//                         },
//                         child: CircleAvatar(
//                           radius: Dimensions.RADIUS_DEFAULT,
//                           backgroundColor: darkGreyColor,
//                           backgroundImage:
//                           AssetImage(Images.DELETE_GOLD),
//                         ),
//                       ),
//                     )
//                         //: SizedBox(),
//                   ],
//                 ),
//               );
//             }),
//       );
//    // });
//   }
// }

import '../../../../../pdf_widgets/pdf_url.dart';
import '../../../../../utils/media_query_value.dart';
import '../../../../../view/base/full_screen_image/full_screen_image.dart';
import '../../../../../view/base/lunch_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/dimention.dart';
import '../../../../../utils/text_style.dart';
import '../../../pdf_view/pdf_view.dart';

//ignore: must_be_immutable
class FirstImageInProviderProfile extends StatelessWidget {
  List<String> imageUrl;
  bool? isPdfFile;

  FirstImageInProviderProfile(
      {super.key, required this.imageUrl, this.isPdfFile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.width * 0.3,
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 1,
          itemBuilder: (context, index) {
            return Container(
              height: context.width * 0.3,
              width: context.width * 0.29,
              decoration: BoxDecoration(
                  border: Border.all(color: goldColor),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(Dimensions.RADIUS_DEFAULT))),
              margin: EdgeInsetsDirectional.only(
                end: context.width * 0.02,
              ),
              child: GestureDetector(
                onLongPress: () {
                  isPdfFile == true
                      ? print('<<<<<<<<<<<<<<object>>>>>>>>>>>>>>')
                      : print('<<<<<<aa<<<<<<<<object>>>>>>>>>>>>');
                },
                onTap: () {
                  print('/////////////////////');
                  print(imageUrl.iterator);
                  if (isPdfFile == true) {
                    navigateForward(PdfViewScreen(
                        url: imageUrl[index],
                        title: imageUrl[index].substring(55)));
                    // launchUrlSocial(imageUrl[index]);
                    //launchUrl(Uri());
                  } else {
                    navigateForward(FullImageListScreen(
                      image: imageUrl,
                      itemCount: imageUrl.length,
                    ));
                  }
                },
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                  child: isPdfFile == false
                      ? Image.network(
                          imageUrl[index],
                          fit: BoxFit.cover,
                        )
                      : Stack(
                          children: [
                            PDFThumbnailWidget(
                              pdfUrl: imageUrl[index],
                            ),
                            Container(
                              color: whiteGreyColor.withOpacity(0.1),
                            )
                          ],
                        ),
                  //Image.asset(Images.PDFImage,fit: BoxFit.cover,),
                ),
              ),
            );
          }),
    );
  }
}
