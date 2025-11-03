import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:aqarat_raqamia/bloc/edit_ad_cubit/edit_ads_images_cubit/state.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image_watermark/image_watermark.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/images.dart';
import '../../../utils/text_style.dart';
import '../../../view/base/show_toast.dart';
import 'dart:ui' as ui;
import '../../../view/screens/bottom_navigation/main_screen.dart';

class EditAdsImagesCubit extends Cubit<EditAdsImagesState> {
  EditAdsImagesCubit() : super(InitialEditAdsImagesState());

  String? mainImage;
  String? base64MainImageAd;

  Future<void> networkImageToBase64MainImage(String image) async {
    http.Response response = await http.get(Uri.parse(image));
    final bytes = response.bodyBytes;
    log('//////////////////${base64Encode(bytes)}');
    mainImage = '${base64Encode(bytes)}';
    base64MainImageAd = 'data:image/jpeg;base64,${base64Encode(bytes)}';
    emit(ConvertedAdListImagesState());
    // }
  }

  List<String> convertedImages = [];
  List<String> uploadedImages = [];

  Future<void> networkImageToBase64(List photos) async {
    photos.removeAt(0);
    print('<<<<<<<<<<<<<${photos.length}>>>>>>>>>>>>>');

    // Emit initial state (if using a state management solution)
    emit(ConvertedAdListImagesState());

    try {
      final List<Future<String>> futures = photos.map((imageFile) async {
        final response = await http.get(Uri.parse(imageFile));
        if (response.statusCode == 200) {
          final bytes = response.bodyBytes;
          final base64Image = base64Encode(bytes);
          return 'data:image/jpeg;base64,$base64Image';
        } else {
          throw Exception('Failed to load image: $imageFile');
        }
      }).toList();

      // Wait for all requests to complete
      final List<String> base64Images = await Future.wait(futures);

      // Update the lists and emit the final state
      //  setState(() {
      uploadedImages.addAll(base64Images);
      convertedImages
          .addAll(base64Images.map((image) => image.split(',').last));
      //  });

      // Emit final state (if using a state management solution)
      emit(ConvertedAdListImagesState());
    } catch (e) {
      print('Error converting images to base64: $e');
      // Handle the error (e.g., emit an error state)
    }
    // photos.removeAt(0);
    // print('<<<<<<<<<<<<<${photos.length}>>>>>>>>>>>>>');
    // emit(ConvertedAdListImagesState());
    //  for (String imageFile in photos) {
    // //   if(photos.first==true){
    // //     http.Response response = await http.get(Uri.parse(imageFile));
    // //     final bytes = response.bodyBytes;
    // //     print('//////////////////${base64Encode(bytes)}');
    // //     mainImage='${base64Encode(bytes)}';
    // //     base64MainImageAd='data:image/jpeg;base64,${base64Encode(bytes)}';
    // //     emit(state);
    // //   }else{
    //
    //     List<String> selectedImages = [];
    //     http.Response response = await http.get(Uri.parse(imageFile));
    //     final bytes = response.bodyBytes;
    //     print('//////////////////${base64Encode(bytes)}');
    //     uploadedImages.add('data:image/jpeg;base64,${base64Encode(bytes)}');
    //    // print(uploadedImages);
    //   //  print(uploadedImages.length);
    //     selectedImages.add(base64Encode(bytes));
    //     convertedImages.addAll(selectedImages);
    //     emit(ConvertedAdListImagesState());
    // //  }
    //
    // }
  }

  bool isRemoveImage = false;

  deleteImage(int index) {
    convertedImages.removeAt(index);
    uploadedImages.removeAt(index);
    isRemoveImage = true;
    emit(RemoveImageFromListState());
  }

  // deleteMainImage() {
  //  // mainImage=null;
  //   emit(RemoveImageFromListState());
  // }


  Future<Uint8List> addWatermarkToBottomLeft(Uint8List originalImage, String watermarkPath) async {
    // Load the watermark image
    final ByteData imageWater = await rootBundle.load(watermarkPath);
    final Uint8List watermarkBytes = imageWater.buffer.asUint8List();

    // Get the dimensions of the original image
    final ui.Image image = await decodeImageFromList(originalImage);
    final int imageWidth = image.width;
    final int imageHeight = image.height;

    // Get the dimensions of the watermark
    final ui.Image watermark = await decodeImageFromList(watermarkBytes);
    final int watermarkWidth = watermark.width;
    final int watermarkHeight = watermark.height;

    // Calculate the position for bottom left corner
    final int dstX = 20; // 20 pixels from left edge
    final int dstY = imageHeight - watermarkHeight - 20; // 20 pixels from bottom edge

    // Add watermark to the image
    final watermarkedImg = await ImageWatermark.addImageWatermark(
      originalImageBytes: originalImage,
      waterkmarkImageBytes: watermarkBytes,
      imgHeight: 100,
      imgWidth: 100,
      dstX: dstX,
      dstY: dstY,
    );

    return watermarkedImg;
  }


  File? file;
  bool isPickImage = false;

  // String? base64Image;

  ///data:image/jpeg;base64,
  Future pickMainImageFroAd() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 1920,
      maxHeight: 1080,
    );
    file = (File(pickedFile!.path));
    //  List<int> imageBytes = file!.readAsBytesSync();
    final fileName = basename(file!.path);
    final appDir = await getApplicationDocumentsDirectory();
    final savedImage = await file!.copy('${appDir.path}/$fileName');
    var result = await FlutterImageCompress.compressWithFile(
      savedImage.absolute.path,
      minWidth: 1920,
      minHeight: 1080,
      quality: 50,

      //  rotate: 90,
    );
    final watermarkedImg = await addWatermarkToBottomLeft(result!, Images.SMALL_LOGO_ICON);
    final base64String = base64Encode(watermarkedImg);
    base64MainImageAd =  base64String;
    log('IMAGE IS $base64MainImageAd');
    log('IMAGE IS $file');
    isPickImage = true;
    emit(PickMainImageFrAdState());

    log('afasdasdasds$isPickImage');
  }

  // List<File> selectedImages = [];
//  List<String> images = [];
  var base64Image;
  bool isPickedImage = false;
  List<String> selectedBase64Images = [];

  Future<void> pickImages(//  int index
      ) async {
    final List<XFile>? selectedFiles = await ImagePicker().pickMultiImage(
      imageQuality: 50,
      maxWidth: 1920,
      maxHeight: 1080,
    );
    if (selectedFiles != null && selectedFiles.length <= 5) {
      List<File> selectedImage = [];

      for (var imageFile in selectedFiles) {
        final image = File(imageFile.path);

        final appDir = await getApplicationDocumentsDirectory();
        final fileName = basename(image.path);

        final savedImage = await image.copy('${appDir.path}/$fileName');

        var result = await FlutterImageCompress.compressWithFile(
          savedImage.absolute.path,
          minWidth: 1920,
          minHeight: 1080,
          quality: 50,
        );
        isPickedImage = true;
        final watermarkedImg = await addWatermarkToBottomLeft(result!, Images.SMALL_LOGO_ICON);
        final base64String = base64Encode(watermarkedImg);
        //  String base64String = base64Encode(result!);
        List<int> imageBytes = await savedImage.readAsBytesSync();
        base64Image = base64Encode(imageBytes);
        convertedImages.add(base64Image);
        uploadedImages.add('data:image/jpeg;base64,$base64String');
        // selectedImages.add(savedImage);
        selectedBase64Images.add('data:image/jpeg;base64,$base64String');
      }
      emit(LoopImagesInListEditRequestState());
      printLongString('>>>>>$base64Image................');
      // print('//////////>>>>>>>>>>>>${images.length}');
      print('//////////>>>>>>>>>>>>${convertedImages.length}');

      log('${convertedImages.length}');
      log('////@@@/////$uploadedImages');
      log('////@@@/////${uploadedImages.length}');

      emit(AddPickedImagesInListEditRequestState());
      // print('//////////>>>>>>>>>>>>${images.length}');
    } else {
      showCustomSnackBar(
        message: LocaleKeys.max5Images.tr(),
        state: ToastState.ERROR,
      );
    }
  }

  Future<void> updateMainImageForAd(int id) async {
    emit(UpdateMainAdImagesLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + '/api/ads/edit-image/$id',
        token: token,
        data: {"image": "data:image/jpeg;base64,$base64MainImageAd"}).then((value) {
      isPickImage = false;
      emit(UpdateMainAdImagesSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(UpdateMainAdImagesErrorState(error: error.toString()));
    });
  }

  Future<void> uploadEditedImageAd(int id, BuildContext context) async {
    emit(UploadEditedAdImagesLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + '/api/ads/edit-photo/$id',
        token: token,
        data: {
          "image": uploadedImages,
        }).then((value) {
      log(value.data.toString());
      uploadedImages.clear();
      convertedImages.clear();
      selectedBase64Images.clear();
      showCustomSnackBar(
          message: LocaleKeys.adUpdatedSuccess.tr(), state: ToastState.SUCCESS);
      navigateAndRemove(MainScreenNavigation());
      // Navigator.pushAndRemoveUntil(context,
      //     MaterialPageRoute(
      //         builder: (ctx) => MainScreenNavigation()), (
      //         route) => false);
      emit(UploadEditedAdImagesSuccessState());
    }).catchError((error) {
      log(error.toString());
      showCustomSnackBar(message: error.toString(), state: ToastState.ERROR);
      emit(UploadEditedAdImagesErrorState(error: error.toString()));
    });
  }
}
