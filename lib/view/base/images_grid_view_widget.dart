import 'dart:io';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:pdf/widgets.dart' as pw;
import '../../utils/dimention.dart';
import '../../utils/images.dart';
import '../../utils/text_style.dart';

class ImageGridViewWidget extends StatelessWidget {
  bool isListEmpty;
  Function? pickImage;
  int countImage;
  bool isService;
  bool isProviderRegister;
  List? fileName;

  // double? height;
  // String imagePath;
  List<File> imageFile;

  ImageGridViewWidget(
      {super.key,
      required this.isListEmpty,
      this.fileName,
      this.pickImage,
      required this.countImage,
      this.isProviderRegister = false,
      this.isService = false,
      //  required this.imagePath,
      required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return
        //uploadRequestCubit.selectedImages.isEmpty
        isListEmpty
            ? Container(
                padding:
                    EdgeInsetsDirectional.only(top: context.width * 0.02.sp),
                height: context.height * 0.18.sp,
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
                          pickImage!();
                          //uploadRequestCubit.pickImages();
                          // uploadRequestCubit.isSelected[index] == true
                          //     ? null
                          //     : uploadRequestCubit.pickImages(index);
                          //  uploadRequestCubit.pickImageFromCamera(index);
                        },
                        child: Container(
                          margin: EdgeInsetsDirectional.only(
                            top: context.width * 0.02.sp,
                          ),
                          height: context.height * 0.18.sp,
                          width: context.width * 0.24.sp,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.RADIUS_LARGE),
                            border: Border.all(color: goldColor),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              Images.Add_SVG,
                              // width: 12,
                              // height: 12,
                            ),
                          ),
                        ),
                      );
                    }),
              )
            : Container(
                height: isService
                    ? imageFile.length > 3
                        ? context.height * 0.25.sp
                        : context.height * 0.2.sp
                    : context.height * 0.6.sp,
                child: GridView.builder(
                    physics: imageFile.length > 3
                        ? BouncingScrollPhysics()
                        : NeverScrollableScrollPhysics(),
                    padding: EdgeInsetsDirectional.only(
                        top: context.width * 0.02.sp),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 1,
                        // crossAxisSpacing: 0.1.sp,
                        childAspectRatio: 1.sp / 1.2.sp),
                    itemCount: countImage,
                    itemBuilder: (context, index) {
                      return Container(
                        height: context.height * 0.22.sp,
                        child: Column(
                          children: [
                            Container(
                              height: context.height * 0.15.sp,
                              width: context.width * 0.24.sp,
                              decoration: BoxDecoration(
                                  border: Border.all(color: goldColor),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          Dimensions.RADIUS_DEFAULT))),
                              margin: EdgeInsetsDirectional.only(
                                  end: context.width * 0.02,
                                  bottom: context.width * 0.02,
                                  start: 0),
                              child: ClipRRect(
                                // clipBehavior: Clip.antiAliasWithSaveLayer,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_DEFAULT),
                                child: isProviderRegister == false
                                    ? Image.file(
                                        File(imageFile[index].absolute.path
                                            // uploadRequestCubit.selectedImages[index].path
                                            ),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(Images.PDFImage),
                              ),
                            ),
                            isProviderRegister == false
                                ? SizedBox()
                                : Expanded(
                                    child: Text(
                                      fileName![index] ?? '',
                                      style: openSansRegular.copyWith(
                                        color: darkGreyColor,
                                        fontSize: context.height * 0.009,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      );
                    }),
              );
  }
}
