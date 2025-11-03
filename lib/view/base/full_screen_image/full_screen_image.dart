import 'dart:io';

import 'package:aqarat_raqamia/translation/locale_keys.g.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gal/gal.dart';
//import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/images.dart';
import '../back_button.dart';
import '../show_toast.dart';

class FullImageListScreen extends StatefulWidget {
  // int index;
  List<dynamic> image;
  int itemCount;

  FullImageListScreen(
      {super.key,
      //required this.index,
      required this.itemCount,
      required this.image});

  @override
  State<FullImageListScreen> createState() => _FullImageListScreenState();
}

class _FullImageListScreenState extends State<FullImageListScreen> {
  @override
  initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    // print('/////////////////${widget.image.in}//////////////');
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  bool? isSaved;

  // void saveImageFromUrl(String imageUrl) async {
  //   isSaved = false;
  //   var file = await DefaultCacheManager().getSingleFile(imageUrl);
  //   var response = await ImageGallerySaver.saveFile(file.path);
  //   if (response['isSuccess']) {
  //     isSaved = true;
  //     showCustomSnackBar(
  //         message: LocaleKeys.savedImage.tr(), state: ToastState.SUCCESS);
  //     // Image saved successfully
  //     print('Image saved!');
  //   } else {
  //     // Error saving the image
  //     print('Failed to save image: ${response['errorMessage']}');
  //   }
  // }
  void saveImageFromUrl(String imageUrl) async {
    isSaved = false;

    try {
      // Check if permission is granted
      bool hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        hasAccess = await Gal.requestAccess();
        if (!hasAccess) {
          print('Gallery access denied');
          return;
        }
      }

      var file = await DefaultCacheManager().getSingleFile(imageUrl);

      // Save image using Gal
      await Gal.putImage(file.path);

      isSaved = true;
      showCustomSnackBar(
          message: LocaleKeys.savedImage.tr(),
          state: ToastState.SUCCESS);
      print('Image saved!');

    } on GalException catch (e) {
      print('Gal Exception: ${e.type.message}');
      showCustomSnackBar(
          message: 'Failed to save image: ${e.type.message}',
          state: ToastState.ERROR);
    } catch (e) {
      print('Failed to save image: $e');
      showCustomSnackBar(
          message: 'Failed to save image',
          state: ToastState.ERROR);
    }
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    return Material(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
                child: BackButtonWidget(),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  saveImageFromUrl(widget.image[i]);
                },
                icon: Icon(Icons.download),
                color: darkGreyColor,
              ),
              IconButton(
                onPressed: () async {
                  if (Platform.isIOS) {
                    await Share.share(widget.image[i],
                        sharePositionOrigin: Rect.fromPoints(
                            const Offset(2, 2), const Offset(3, 3)));
                  } else {
                    await Share.share(widget.image[i]);
                  }
                },
                icon: Icon(Icons.share),
                color: darkGreyColor,
              ),
            ],
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PhotoViewGallery.builder(
                // enableRotation: true,

                itemCount: widget.itemCount,

                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 20.0.sp,
                    height: 20.0.sp,
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes!,
                    ),
                  ),
                ),
                scrollPhysics: const BouncingScrollPhysics(),

                builder: (BuildContext context, int index) {
                  i = index;
                  return PhotoViewGalleryPageOptions(
                    maxScale: PhotoViewComputedScale.contained,
                    minScale: PhotoViewComputedScale.contained,
                    // initialScale: PhotoViewComputedScale.contained,
                    imageProvider: NetworkImage(
                      widget.image[index],
                      // prayerTime.prayerModel.data![widget.index].imagepath ?? ''
                    ),
                    //    filterQuality: FilterQuality.high,
                    initialScale: PhotoViewComputedScale.contained * 0.8,
                    heroAttributes:
                        PhotoViewHeroAttributes(tag: widget.image[index]),
                    controller: PhotoViewController(),
                  );
                },
                // loadingBuilder: (context, event) => Center(
                //   child: Container(
                //     width: 20.0,
                //     height: 20.0,
                //     child: CircularProgressIndicator(
                //       value: event == null
                //           ? 0
                //           : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                //     ),
                //   ),
                // ),
              ),
            ),
          ),
          //   Text('${i+1} / ${widget.itemCount}',style: openSansBold.copyWith(color: whiteGreyColor),),
        ],
      ),
    );
  }
}

class FullImageScreen extends StatefulWidget {
  // int index;
  String image;

  //int itemCount;

  FullImageScreen(
      {super.key,
      //required this.index,
      //  required this.itemCount,
      required this.image});

  @override
  State<FullImageScreen> createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {
  @override
  initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  bool? isSaved;
  //
  // void saveImageFromUrl(String imageUrl) async {
  //   isSaved = false;
  //   var file = await DefaultCacheManager().getSingleFile(imageUrl);
  //   var response = await ImageGallerySaver.saveFile(file.path);
  //   if (response['isSuccess']) {
  //     isSaved = true;
  //     showCustomSnackBar(
  //         message: LocaleKeys.savedImage.tr(), state: ToastState.SUCCESS);
  //     // Image saved successfully
  //     print('Image saved!');
  //   } else {
  //     // Error saving the image
  //     print('Failed to save image: ${response['errorMessage']}');
  //   }
  // }
  void saveImageFromUrl(String imageUrl) async {
    isSaved = false;

    try {
      // Check if permission is granted
      bool hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        hasAccess = await Gal.requestAccess();
        if (!hasAccess) {
          print('Gallery access denied');
          return;
        }
      }

      var file = await DefaultCacheManager().getSingleFile(imageUrl);

      // Save image using Gal
      await Gal.putImage(file.path);

      isSaved = true;
      showCustomSnackBar(
          message: LocaleKeys.savedImage.tr(),
          state: ToastState.SUCCESS);
      print('Image saved!');

    } on GalException catch (e) {
      print('Gal Exception: ${e.type.message}');
      showCustomSnackBar(
          message: 'Failed to save image: ${e.type.message}',
          state: ToastState.ERROR);
    } catch (e) {
      print('Failed to save image: $e');
      showCustomSnackBar(
          message: 'Failed to save image',
          state: ToastState.ERROR);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
                child: BackButtonWidget(),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  saveImageFromUrl(widget.image);
                },
                icon: Icon(Icons.save),
                color: darkGreyColor,
              ),
              IconButton(
                onPressed: () async {
                  if (Platform.isIOS) {
                    await Share.share(widget.image,
                        sharePositionOrigin: Rect.fromPoints(
                            const Offset(2, 2), const Offset(3, 3)));
                  } else {
                    await Share.share(widget.image);
                  }
                },
                icon: Icon(Icons.share),
                color: darkGreyColor,
              ),
            ],
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PhotoViewGallery.builder(
                itemCount: 1,
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                      maxScale: PhotoViewComputedScale.contained,
                      minScale: PhotoViewComputedScale.contained,
                      initialScale: PhotoViewComputedScale.contained,
                      imageProvider: NetworkImage(widget.image
                          // prayerTime.prayerModel.data![widget.index].imagepath ?? ''
                          ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
