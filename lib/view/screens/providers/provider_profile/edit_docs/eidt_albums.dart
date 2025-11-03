import 'dart:convert';
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
import '../../../../../translation/locale_keys.g.dart';
import '../../../../../utils/dimention.dart';
import '../../../../../utils/text_style.dart';
import '../../../../base/full_screen_image/full_screen_image.dart';
import '../../../../base/lunch_widget.dart';
import '../../../../base/main_button.dart';

class EditAlbumsImagesScreen extends StatefulWidget {
  final List<String> albumsImage;

  const EditAlbumsImagesScreen({super.key, required this.albumsImage});

  @override
  State<EditAlbumsImagesScreen> createState() => _EditAlbumsImagesScreenState();
}

class _EditAlbumsImagesScreenState extends State<EditAlbumsImagesScreen> {
  @override
  void initState() {
    // context.read<ProfileCubit>().convertedAlbumImages.clear();
    super.initState();
    context.read<ProfileCubit>().networkAlbumImagesToBase64(widget.albumsImage);
  }

  @override
  Widget build(BuildContext context) {
    var profileCubit = context.read<ProfileCubit>();
    return Scaffold(
      // appBar: AuthHeader(
      //   title:LocaleKeys.editAlbumImage.tr(),
      // ),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(
              title: LocaleKeys.editAlbumImage.tr(),
            ),
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
                                  profileCubit.convertedAlbumImages.length,
                                  (index) {
                                return Stack(
                                  children: [
                                    FocusedMenuHolder(
                                      blurSize: 2,
                                      blurBackgroundColor: Colors.black12,
                                      menuWidth: 200.sp,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      onPressed: () {
                                        navigateForward(FullImageListScreen(
                                          image: widget.albumsImage,
                                          itemCount: widget.albumsImage.length,
                                        ));
                                      },
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
                                              profileCubit
                                                  .deleteAlbumsIndex(index);
                                            }),
                                      ],
                                      child: Container(
                                        height: context.height * 0.15.sp,
                                        width: context.width * 0.24.sp,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: goldColor),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              Dimensions.RADIUS_DEFAULT,
                                            ),
                                          ),
                                        ),
                                        margin: EdgeInsetsDirectional.only(
                                            end: context.width * 0.02,
                                            top: context.width * 0.01.w,
                                            bottom: context.width * 0.02,
                                            start: 0),
                                        child: ClipRRect(
                                          // clipBehavior: Clip.antiAliasWithSaveLayer,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.RADIUS_DEFAULT),
                                          //   child: Image.asset(Images.PDFImage),
                                          child: Image.memory(
                                            base64Decode(profileCubit
                                                .convertedAlbumImages[index]),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: -14.h,
                                        left: 4.w,
                                        //  textDirection: myLocale=="ar"?TextDirection.RTL:TextDirection.LTR,
                                        child: IconButton(
                                          onPressed: () {
                                            profileCubit
                                                .deleteAlbumsIndex(index);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 25.sp,
                                          ),
                                          color: redColor,
                                        ))
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
                                profileCubit.pickAlbumImages();
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
                                profileCubit
                                    .updateProviderProfile()
                                    .then((value) => Navigator.pop(context));
                              },
                              color: darkGreyColor,
                            )
                          ],
                        ),
                      ),
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
