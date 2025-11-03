import 'dart:io';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/screens/providers/provider_profile/edit_docs/edit_projects.dart';
import 'package:aqarat_raqamia/view/screens/providers/provider_profile/edit_docs/eidt_albums.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../bloc/profile_cubit/cubit.dart';
import '../../../../../bloc/profile_cubit/state.dart';
import '../../../../../translation/locale_keys.g.dart';
import '../../../../../utils/dimention.dart';
import '../../../../../utils/images.dart';
import '../../../../../utils/text_style.dart';
import '../../../../base/adaptive_dialog_loader.dart';
import '../../../../base/main_button.dart';
import '../edit_docs/edit_achievements.dart';

//ignore: must_be_immutable
class PickedImageWithDialog extends StatelessWidget {
  Function clearImagesFunction;
  Function pickImagesFunction;
  Function updateFunction;
  List<File> pickedFileImage;
  List<String> listString;
  int? index;
  String title;
  bool? isPdfFile;

  PickedImageWithDialog(
      {super.key,
      required this.listString,
      required this.clearImagesFunction,
      required this.updateFunction,
      required this.title,
      required this.pickedFileImage,
      required this.pickImagesFunction,
      this.index,
      this.isPdfFile = false});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileLoadingState) {
          adaptiveDialogLoader(context: context);
        }
        if (state is UpdateProfileSuccessState ||
            state is UpdateProfileErrorState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: context.width * 0.03),
          child: GestureDetector(
            onTap: () {
              if (index == 0) {
                navigateForward(EditAchievementsScreen(
                  achievements: listString,
                ));
              } else if (index == 1) {
                navigateForward(EditProjectsScreen(projects: listString));
              } else {
                navigateForward(
                    EditAlbumsImagesScreen(albumsImage: listString));
              }

              // showModalBottomSheet(
              //     isScrollControlled: true,
              //     context: context,
              //     builder: (context) {
              //       return Container(
              //         margin: EdgeInsets.symmetric(
              //             horizontal: context.width * 0.04),
              //         height: context.height * 0.8,
              //         child: Stack(
              //           children: [
              //             Column(
              //               children: [
              //                 Row(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     RichText(
              //                       text: TextSpan(
              //                           text: title,
              //                           style: openSansMedium.copyWith(
              //                               color: darkGreyColor),
              //                           children: [
              //                             TextSpan(
              //                                 text:isPdfFile==false? LocaleKeys.tenImage.tr():LocaleKeys.threePdf.tr(),
              //                                 style: openSansRegular.copyWith(
              //                                     color: goldColor))
              //                           ]),
              //                     ),
              //                     IconButton(
              //                         onPressed: () => clearImagesFunction(),
              //                         icon: Icon(
              //                           Icons.clear,
              //                           color: redColor,
              //                         ))
              //                   ],
              //                 ),
              //                 SingleChildScrollView(
              //                   //  physics: NeverScrollableScrollPhysics(),
              //
              //                   child: Container(
              //                     height: context.height * 0.7,
              //                     child:
              //                         BlocBuilder<ProfileCubit, ProfileState>(
              //                       builder: (context, state) {
              //                         return pickedFileImage.isEmpty
              //                             ? GridView.builder(
              //                                 shrinkWrap: true,
              //                                 gridDelegate:
              //                                     SliverGridDelegateWithFixedCrossAxisCount(
              //                                         crossAxisCount: 3,
              //                                         childAspectRatio:
              //                                             1 / 0.9),
              //                                 physics:
              //                                     NeverScrollableScrollPhysics(),
              //                                 // separatorBuilder: (context, index) {
              //                                 //   return SizedBox(
              //                                 //     width: Dimensions.PADDING_SIZE_SMALL,
              //                                 //   );
              //                                 // },
              //                                 itemCount: 2,
              //                                 // scrollDirection: Axis.horizontal,
              //                                 itemBuilder: (context, index) {
              //                                   return GestureDetector(
              //                                     onTap: () =>
              //                                         pickImagesFunction(),
              //                                     child: Container(
              //                                       margin:
              //                                           EdgeInsetsDirectional
              //                                               .only(
              //                                         top: context.width * 0.02.sp,
              //                                         end: context.width * 0.02.sp,
              //                                         start:
              //                                             context.width * 0.02.sp,
              //                                       ),
              //                                       // height: context.width * 0.5,
              //                                       // width: context.width * 0.24,
              //                                       height: context.width * 0.3.sp,
              //                                       width: context.width * 0.29.sp,
              //                                       decoration: BoxDecoration(
              //                                         borderRadius: BorderRadius
              //                                             .circular(Dimensions
              //                                                 .RADIUS_LARGE),
              //                                         border: Border.all(
              //                                             color: goldColor),
              //                                       ),
              //                                       child: Center(
              //                                         child: SvgPicture.asset(
              //                                           Images.Add_SVG,
              //                                           // width: 12,
              //                                           // height: 12,
              //                                         ),
              //                                       ),
              //                                     ),
              //                                   );
              //                                 })
              //                             : Stack(
              //                                 //  alignment: Alignment.bottomCenter,
              //                                 children: [
              //                                   SingleChildScrollView(
              //                                     child: Padding(
              //                                       padding: EdgeInsets.all(
              //                                           context.width * 0.01.sp),
              //                                       child: Container(
              //                                         //   height: context.width*1.03,
              //                                         child: GridView.builder(
              //                                             shrinkWrap: true,
              //                                             physics:
              //                                                 NeverScrollableScrollPhysics(),
              //                                             padding: EdgeInsetsDirectional
              //                                                 .only(
              //                                                     top: context
              //                                                             .width *
              //                                                         0.02.sp),
              //                                             gridDelegate:
              //                                                 SliverGridDelegateWithFixedCrossAxisCount(
              //                                                     crossAxisCount:
              //                                                         3,
              //                                                     childAspectRatio:
              //                                                         1 / 1.4),
              //                                             itemCount:
              //                                                 pickedFileImage
              //                                                     .length,
              //                                             itemBuilder:
              //                                                 (context, index) {
              //                                               return Container(
              //                                                 height: context
              //                                                         .width *
              //                                                     0.5.sp,
              //                                                 width: context
              //                                                         .width *
              //                                                     0.24.sp,
              //                                                 decoration: BoxDecoration(
              //                                                     border: Border
              //                                                         .all(
              //                                                             color:
              //                                                                 goldColor),
              //                                                     borderRadius:
              //                                                         BorderRadius.all(Radius.circular(
              //                                                             Dimensions
              //                                                                 .RADIUS_DEFAULT))),
              //                                                 margin:
              //                                                     EdgeInsetsDirectional
              //                                                         .only(
              //                                                   end: context
              //                                                           .width *
              //                                                       0.02.sp,
              //                                                   bottom: context
              //                                                           .width *
              //                                                       0.02.sp,
              //                                                 ),
              //                                                 child: ClipRRect(
              //                                                   borderRadius:
              //                                                       BorderRadius.circular(
              //                                                           Dimensions
              //                                                               .RADIUS_DEFAULT),
              //                                                   child:
              //                                                   isPdfFile==false?  Image.file(
              //                                                     File(pickedFileImage[
              //                                                             index]
              //                                                         .path),
              //                                                     fit: BoxFit
              //                                                         .cover,
              //                                                   ):Image.asset(Images.PDFImage),
              //                                                 ),
              //                                               );
              //                                             }),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ],
              //                               );
              //                       },
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             Align(
              //                 alignment: AlignmentDirectional.bottomCenter,
              //                 child: Padding(
              //                   padding: EdgeInsets.all(8.0),
              //                   child: CustomButton(
              //                     textButton:LocaleKeys.update.tr() ,
              //                     onPressed: () {
              //                       updateFunction();
              //                     },
              //                     color: darkGreyColor,
              //                   ),
              //                 )),
              //           ],
              //         ),
              //       );
              //     });
            },
            child: Container(
              margin: EdgeInsetsDirectional.only(
                end: context.width * 0.02,
                bottom: context.width * 0.02,
              ),
              height: context.width * 0.3,
              width: context.width * 0.29,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                border: Border.all(color: goldColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Images.edit_Profile_Icon,
                    width: 22.w,
                    height: 22.w,
                  ),
                  Text(LocaleKeys.edit.tr(),style: openSansMedium.copyWith(color: goldColor),)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
