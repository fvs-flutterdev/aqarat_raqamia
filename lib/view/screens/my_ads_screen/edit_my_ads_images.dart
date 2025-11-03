import 'dart:convert';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/screens/my_ads_screen/my_ads_screen.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/media_query_value.dart';
import '../../../view/base/adaptive_dialog_loader.dart';
import '../../../view/base/auth_header.dart';
import '../../../view/base/main_button.dart';
import '../../../view/base/show_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import '../../../bloc/edit_ad_cubit/edit_ads_images_cubit/cubit.dart';
import '../../../bloc/edit_ad_cubit/edit_ads_images_cubit/state.dart';
import '../../../bloc/upload_request_cubit/cubit.dart';
import '../../../utils/dimention.dart';
import '../../../utils/text_style.dart';

class EditMyAdsImagesScreen extends StatefulWidget {
  List<String> photos = [];
  int? adId;

  // EditMyAdsImagesScreen(List<String> images, int i);

  EditMyAdsImagesScreen({super.key, required this.photos, required this.adId});

  @override
  State<EditMyAdsImagesScreen> createState() => _EditMyAdsImagesScreenState();
}

class _EditMyAdsImagesScreenState extends State<EditMyAdsImagesScreen> {
  @override
  void initState() {
    // Future.delayed(
    //   Duration(seconds: 1),
    //   () async {
    //     await context
    //         .read<EditAdsImagesCubit>()
    //         .networkImageToBase64(widget.photos);
    //     //  print(convertedImages.length);
    //   },
    // );
    //   WidgetsBinding.instance.addPostFrameCallback((_) async{
    context.read<EditAdsImagesCubit>().uploadedImages.clear();
    context.read<EditAdsImagesCubit>().selectedBase64Images.clear();
    context.read<EditAdsImagesCubit>().convertedImages.clear();
    context
        .read<EditAdsImagesCubit>()
        .networkImageToBase64MainImage(widget.photos.first);

    context.read<EditAdsImagesCubit>().isPickedImage = false;
    context.read<EditAdsImagesCubit>().isPickImage = false;
    context.read<EditAdsImagesCubit>().base64MainImageAd = null;
    //  });
    super.initState();
    context.read<EditAdsImagesCubit>().networkImageToBase64(widget.photos);
  }

// @override
//   void deactivate() {
//   widget.photos=[];
//   print('<<<<<<<<<<<${widget.photos.length}>>>>>>>>>>>');
//     super.deactivate();
//   }
  // @override
  // void dispose() {
  //   widget.photos=[];
  //   print('<<<<<<<<<<<${widget.photos.length}>>>>>>>>>>>');
  // //  context.read<EditAdsImagesCubit>().mainImage = null;
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var editImages = context.read<EditAdsImagesCubit>();

    return Scaffold(
      // appBar: AuthHeader(
      //   title: LocaleKeys.editImage.tr(),
      //   onTap: () {
      //     widget.photos.clear();
      //     //   Navigator.pop(context);
      //     navigateForwardReplace(MyAdsScreen());
      //   },
      // ),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(
              title: LocaleKeys.editImage.tr(),
              onTap: () {
                widget.photos.clear();
                //   Navigator.pop(context);
                navigateForwardReplace(MyAdsScreen());
              },
            ),
          ),
          Expanded(
            child: BlocConsumer<EditAdsImagesCubit, EditAdsImagesState>(
              listener: (context, state) {
                if (state is UploadEditedAdImagesLoadingState) {
                  adaptiveDialogLoader(context: context);
                }
              },
              builder: (context, state) {
                return state is InitialEditAdsImagesState
                    //||editImages.convertedImages.length<widget.photos.length
                    // ||editImages.mainImage==null
                    ? adaptiveCircleProgress()
                    : Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.mainImageForAd.tr(),
                              style:
                                  openSansBold.copyWith(color: darkGreysColor),
                            ),
                            editImages.mainImage == null
                                ? SizedBox()
                                : FocusedMenuHolder(
                                    blurSize: 2,
                                    blurBackgroundColor: Colors.black12,
                                    menuWidth: 200.sp,
                                    duration: const Duration(milliseconds: 200),
                                    onPressed: () {
                                      editImages.pickMainImageFroAd();
                                    },
                                    menuItems: <FocusedMenuItem>[
                                      //  FocusedMenuItem(
                                      // title: Text(
                                      //   LocaleKeys.delete.tr(),
                                      //   style: TextStyle(color: Colors.redAccent),
                                      // ),
                                      // trailingIcon: Icon(
                                      //   Icons.delete,
                                      //   color: Colors.redAccent,
                                      // ),
                                      // onPressed: () {
                                      //   // editImages.deleteMainImage();
                                      // }
                                      // ),
                                    ],
                                    child: Container(
                                      height: context.height * 0.15.sp,
                                      width: context.width * 0.24.sp,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: goldColor),
                                          borderRadius: const BorderRadius.all(
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

                                        child: Image.memory(
                                          base64Decode(editImages.isPickImage ==
                                                  false
                                              ? editImages.mainImage ?? ''
                                              : editImages.base64MainImageAd ??
                                                  ''),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                            Text(
                              LocaleKeys.subImages.tr(),
                              style: openSansBold.copyWith(color: goldColor),
                            ),
                            Expanded(
                              child: Container(
                                child: GridView.count(
                                    physics: BouncingScrollPhysics(),
                                    //  physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsetsDirectional.only(
                                        top: context.width * 0.02.sp),
                                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    //     crossAxisCount: 3,
                                    //     crossAxisSpacing: 1,
                                    //     // crossAxisSpacing: 0.1.sp,
                                    //     childAspectRatio: 1.sp / 1.2.sp),
                                    // itemCount: editImages.convertedImages.length,
                                    crossAxisCount: 3,
                                    children: List.generate(
                                        editImages.convertedImages.length,
                                        (index) {
                                      return Stack(
                                        children: [
                                          FocusedMenuHolder(
                                            blurSize: 2,
                                            blurBackgroundColor: Colors.black12,
                                            menuWidth: 200.sp,
                                            duration:
                                                const Duration(milliseconds: 200),
                                            onPressed: () {},
                                            menuItems: <FocusedMenuItem>[
                                              FocusedMenuItem(
                                                  title: Text(
                                                    LocaleKeys.delete.tr(),
                                                    style: TextStyle(
                                                        color: Colors.redAccent),
                                                  ),
                                                  trailingIcon: Icon(
                                                    Icons.delete,
                                                    color: Colors.redAccent,
                                                  ),
                                                  onPressed: () {
                                                    editImages.deleteImage(index);
                                                  }),
                                            ],
                                            child: Container(
                                              height: context.height * 0.15.sp,
                                              width: context.width * 0.24.sp,
                                              decoration: BoxDecoration(
                                                  border:
                                                      Border.all(color: goldColor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(Dimensions
                                                              .RADIUS_DEFAULT))),
                                              margin: EdgeInsetsDirectional.only(
                                                  end: context.width * 0.02,
                                                  top: context.width*0.01.w,
                                                  bottom: context.width * 0.02,
                                                  start: 0),
                                              child: ClipRRect(
                                                // clipBehavior: Clip.antiAliasWithSaveLayer,
                                                borderRadius: BorderRadius.circular(
                                                    Dimensions.RADIUS_DEFAULT),

                                                child: Image.memory(
                                                  base64Decode(editImages
                                                      .convertedImages[index]),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              top:-14.h,
                                              left:4.w,
                                            //  textDirection: myLocale=="ar"?TextDirection.RTL:TextDirection.LTR,
                                              child: IconButton(onPressed: (){
                                                editImages.deleteImage(index);
                                              }, icon: Icon(Icons.delete,size: 25.sp,),color: redColor,))
                                        ],
                                      );
                                    })),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  FloatingActionButton.extended(
                                    // hoverColor: darkGreysColor,
                                    splashColor: darkGreysColor,
                                    backgroundColor: goldColor,

                                    onPressed: () {
                                      editImages.pickImages();
                                    },
                                    label: Text(LocaleKeys.addImages.tr(),
                                        style: openSansMedium.copyWith(
                                            color: whiteColor)),
                                    icon: Icon(
                                      Icons.add,
                                      color: whiteColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  CustomButton(
                                    textButton: LocaleKeys.save.tr(),
                                    onPressed: () {
                                      if (
                                      //editImages.convertedImages.length <= 0 || editImages.uploadedImages.length <= 0 ||
                                              //||
                                              (editImages.isPickImage == false && editImages.isPickedImage == false && editImages.isRemoveImage==false)
                                          // editImages.convertedImages.length == widget.photos.length
                                          // editImages.isPickImage==false&&editImages.isPickedImage==false
                                          ) {
                                        showCustomSnackBar(
                                            message: LocaleKeys.takePhotos.tr(),
                                            state: ToastState.ERROR);
                                      } else if (editImages.isPickImage == false) {
                                        editImages.uploadEditedImageAd(
                                            context
                                                .read<UploadRequestCubit>()
                                                .adId!,
                                            context);
                                      } else {
                                        editImages.uploadEditedImageAd(
                                            context
                                                .read<UploadRequestCubit>()
                                                .adId!,
                                            context);
                                        editImages.updateMainImageForAd(
                                          context
                                              .read<UploadRequestCubit>()
                                              .adId!,
                                        );
                                      }
                                    },
                                    color: darkGreyColor,
                                  )
                                ],
                              ),
                            ),
                            // Stack(
                            //   children: [
                            //
                            //     GridView.count(
                            //         physics: BouncingScrollPhysics(),
                            //       //  physics: NeverScrollableScrollPhysics(),
                            //         padding: EdgeInsetsDirectional.only(
                            //             top: context.width * 0.02.sp),
                            //         // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //         //     crossAxisCount: 3,
                            //         //     crossAxisSpacing: 1,
                            //         //     // crossAxisSpacing: 0.1.sp,
                            //         //     childAspectRatio: 1.sp / 1.2.sp),
                            //         // itemCount: editImages.convertedImages.length,
                            //         crossAxisCount: 3,
                            //         children: List.generate(editImages.convertedImages.length,
                            //             (index) {
                            //           return FocusedMenuHolder(
                            //             blurSize: 2,
                            //             blurBackgroundColor: Colors.black12,
                            //             menuWidth: 200.sp,
                            //             duration: const Duration(milliseconds: 200),
                            //             onPressed: () {},
                            //             menuItems: <FocusedMenuItem>[
                            //               FocusedMenuItem(
                            //                   title: Text(
                            //                     LocaleKeys.delete.tr(),
                            //                     style: TextStyle(color: Colors.redAccent),
                            //                   ),
                            //                   trailingIcon: Icon(
                            //                     Icons.delete,
                            //                     color: Colors.redAccent,
                            //                   ),
                            //                   onPressed: () {
                            //                     editImages.deleteImage(index);
                            //                   }),
                            //             ],
                            //             child: Container(
                            //               height: context.height * 0.15.sp,
                            //               width: context.width * 0.24.sp,
                            //               decoration: BoxDecoration(
                            //                   border: Border.all(color: goldColor),
                            //                   borderRadius: const BorderRadius.all(
                            //                       Radius.circular(Dimensions.RADIUS_DEFAULT))),
                            //               margin: EdgeInsetsDirectional.only(
                            //                   end: context.width * 0.02,
                            //                   bottom: context.width * 0.02,
                            //                   start: 0),
                            //               child: ClipRRect(
                            //                 // clipBehavior: Clip.antiAliasWithSaveLayer,
                            //                 borderRadius: BorderRadius.circular(
                            //                     Dimensions.RADIUS_DEFAULT),
                            //
                            //                 child: Image.memory(base64Decode(
                            //                     editImages.convertedImages[index])),
                            //               ),
                            //             ),
                            //           );
                            //         })),
                            //     Align(
                            //       alignment: AlignmentDirectional.bottomEnd,
                            //       child: Column(
                            //         mainAxisAlignment: MainAxisAlignment.end,
                            //         crossAxisAlignment: CrossAxisAlignment.end,
                            //         children: [
                            //           FloatingActionButton.extended(
                            //             // hoverColor: darkGreysColor,
                            //             splashColor: darkGreysColor,
                            //             backgroundColor: goldColor,
                            //
                            //             onPressed: () {
                            //               editImages.pickImages();
                            //             },
                            //             label: Text(LocaleKeys.addImages.tr(),
                            //                 style: openSansMedium.copyWith(color: whiteColor)),
                            //             icon: Icon(
                            //               Icons.add,
                            //               color: whiteColor,
                            //             ),
                            //           ),
                            //           SizedBox(
                            //             height: 10.sp,
                            //           ),
                            //           CustomButton(
                            //             textButton: LocaleKeys.save.tr(),
                            //             onPressed: () {
                            //               if (editImages.convertedImages.length <= 0 ||
                            //                   editImages.uploadedImages.length <= 0) {
                            //                 showCustomSnackBar(
                            //                     message: LocaleKeys.takePhotos.tr(),
                            //                     state: ToastState.ERROR);
                            //               } else {
                            //                 editImages.uploadEditedImageAd(
                            //                     context.read<UploadRequestCubit>().adId!,
                            //                     context);
                            //               }
                            //             },
                            //             color: darkGreyColor,
                            //           )
                            //         ],
                            //       ),
                            //     )
                            //     // Column(
                            //     //   children: [
                            //     //
                            //     //   ],
                            //     // )
                            //   ],
                            // ),
                          ],
                        ),
                      );
                // itemBuilder: (context, index) {
                //   return Container(
                //     height: context.height * 0.22.sp,
                //     child: Column(
                //       children: [
                //         Stack(
                //           children: [
                //             Container(
                //               height: context.height * 0.15.sp,
                //               width: context.width * 0.24.sp,
                //               decoration: BoxDecoration(
                //                   border: Border.all(color: goldColor),
                //                   borderRadius: BorderRadius.all(
                //                       Radius.circular(Dimensions.RADIUS_DEFAULT))),
                //               margin: EdgeInsetsDirectional.only(
                //                   end: context.width * 0.02,
                //                   bottom: context.width * 0.02,
                //                   start: 0),
                //               child: ClipRRect(
                //                 // clipBehavior: Clip.antiAliasWithSaveLayer,
                //                 borderRadius:
                //                 BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                //
                //                 child: Image.memory(base64Decode(editImages.convertedImages[index])),
                //               ),
                //             ),
                //
                //           ],
                //         ),
                //       ],
                //     ),
                //   );
                // }, );
              },
            ),
          ),
        ],
      ),
    );
  }
}
