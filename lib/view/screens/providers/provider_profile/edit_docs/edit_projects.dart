import '../../../../../bloc/profile_cubit/cubit.dart';
import '../../../../../bloc/profile_cubit/state.dart';
import '../../../../../utils/media_query_value.dart';
import '../../../../../view/base/auth_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import '../../../../../pdf_widgets/pdf_base64.dart';
import '../../../../../translation/locale_keys.g.dart';
import '../../../../../utils/dimention.dart';
import '../../../../../utils/text_style.dart';
import '../../../../base/lunch_widget.dart';
import '../../../../base/main_button.dart';
import '../../../pdf_view/pdf_view.dart';

class EditProjectsScreen extends StatefulWidget {
  final List<String> projects;

  const EditProjectsScreen({super.key, required this.projects});

  @override
  State<EditProjectsScreen> createState() => _EditProjectsScreenState();
}

class _EditProjectsScreenState extends State<EditProjectsScreen> {
  @override
  void initState() {
  //  context.read<ProfileCubit>().convertedProjects.clear();
    super.initState();
    context.read<ProfileCubit>().networkProjectsToBase64(widget.projects);
  }

  @override
  Widget build(BuildContext context) {
    var profileCubit = context.read<ProfileCubit>();
    return Scaffold(
      // appBar: AuthHeader(
      //   title:LocaleKeys.editProjects.tr(),
      // ),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(title: LocaleKeys.editProjects.tr(),),
          ),
          Expanded(
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          child: GridView.count(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsetsDirectional.only(
                                  top: context.width * 0.02.sp),
                              crossAxisCount: 3,
                              children: List.generate(
                                  profileCubit.convertedProjects.length, (index) {
                                return Stack(
                                  children: [
                                    FocusedMenuHolder(
                                      blurSize: 2,
                                      blurBackgroundColor: Colors.black12,
                                      menuWidth: 200.sp,
                                      duration: const Duration(milliseconds: 200),
                                      onPressed: () {
                                        navigateForward(PdfViewScreen(
                                            url:widget.projects[index],
                                            title: widget.projects[index].substring(55)));
                                      },
                                      menuItems: <FocusedMenuItem>[
                                        FocusedMenuItem(
                                            title: Text(
                                              LocaleKeys.delete.tr(),
                                              style: TextStyle(color: Colors.redAccent),
                                            ),
                                            trailingIcon: Icon(
                                              Icons.delete,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: () {
                                              profileCubit.deleteProjectsIndex(index);
                                            }),
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
                                            top: context.width*0.01.w,
                                            bottom: context.width * 0.02,
                                            start: 0),
                                        child: ClipRRect(
                                          // clipBehavior: Clip.antiAliasWithSaveLayer,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.RADIUS_DEFAULT),
                                          child:
                                          // widget.projects[index].toString().endsWith('.pdf')?
                                          Stack(
                                            children: [
                                              PDFThumbnailBase64Widget(

                                                base64PDF:profileCubit.notAddPathUrlProjectsPdf[index],
                                                //widget.projects[index],
                                              ),
                                              Container(color: whiteGreyColor.withOpacity(0.1),)
                                            ],
                                          )
                                          //       :
                                          // Image.asset(Images.PDFImage),

                                          // child: Image.memory(
                                          //   base64Decode(
                                          //       profileCubit.convertedImages[index]),
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top:-14.h,
                                        left:4.w,
                                        //  textDirection: myLocale=="ar"?TextDirection.RTL:TextDirection.LTR,
                                        child: IconButton(onPressed: (){
                                          profileCubit.deleteProjectsIndex(index);
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
                                profileCubit.pickProjectsPdf();
                              },
                              label: Text(LocaleKeys.addFile.tr(),
                                  style: openSansMedium.copyWith(color: whiteColor)),
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
                                profileCubit.updateProviderProfile().then((value) => Navigator.pop(context));
                                // if (editImages.convertedImages.length <= 0 || editImages.uploadedImages.length <= 0||
                                //     //||
                                //     (editImages.isPickImage==false&&editImages.isPickedImage==false)
                                // // editImages.convertedImages.length == widget.photos.length
                                // // editImages.isPickImage==false&&editImages.isPickedImage==false
                                // ) {
                                //   showCustomSnackBar(
                                //       message: LocaleKeys.takePhotos.tr(),
                                //       state: ToastState.ERROR);
                                // }else if(editImages.isPickImage==false){
                                //   editImages.uploadEditedImageAd(
                                //       context.read<UploadRequestCubit>().adId!,
                                //       context);
                                // } else {
                                //   editImages.uploadEditedImageAd(
                                //       context.read<UploadRequestCubit>().adId!,
                                //       context);
                                //   editImages.updateMainImageForAd(
                                //     context.read<UploadRequestCubit>().adId!,
                                //   );
                                // }
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
