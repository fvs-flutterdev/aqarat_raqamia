import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:aqarat_raqamia/bloc/add_real_ads/cubit.dart';
import 'package:aqarat_raqamia/bloc/location_cubit/cubit.dart';
import 'package:aqarat_raqamia/bloc/upload_request_cubit/state.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_watermark/image_watermark.dart';
import 'package:path/path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../model/dynamic_model/sponsor_ads_details.dart';
import '../../model/dynamic_model/subscribtion_callback_model.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/dio.dart';
import '../../utils/images.dart';
import 'dart:ui' as ui;
import '../../view/base/show_toast.dart';
import '../../view/screens/real_state_Ads/make_ads_spons.dart';
import '../../view/screens/subscribtion_screen/wallet/complete_pay_with_wallet.dart';
import '../../view/screens/subscribtion_screen/web_view_pay/web_view.dart';

class UploadRequestCubit extends Cubit<UploadRequestState> {
  UploadRequestCubit() : super(InitialUploadRequestState());

  static UploadRequestCubit get(context) => BlocProvider.of(context);

  bool isSpecialAds = false;

  changeSpecialAdsState(val) {
    isSpecialAds = val;
    emit(ChangeSpecialAdsState());
  }

  late SubscriptionCallBackModel subscriptionCallBackModel;

  payForSponsoredAd(
      {required int adId,
      String? promoCode,
      required bool isWallet,
      required BuildContext context}) {
    emit(CreateSponsoredAdLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.SponsoredAd,
        token: token,
        data: {
          "ad_id": adId,
          "coupon_code": promoCode ?? '',
          "payment_method": isWallet == true ? "wallet" : "electronic"
        }).then((value) {
      debugPrint(value.data.toString());
      if (isWallet == true) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CompletePayWithWallet(
                      withDrawAmount: value.data['withdrawn_amount'],
                      remainingValue: value.data['remaining_balance'],
                    )));
        // navigateAndRemove(CompletePayWithWallet(amount: 250,));
      } else {
        subscriptionCallBackModel =
            SubscriptionCallBackModel.fromJson(value.data);
        debugPrint(subscriptionCallBackModel.id.toString());
        navigateForward(PaymentWebView(
          subscriptionCallBackModel: subscriptionCallBackModel,
          url: subscriptionCallBackModel.callbackUrl!,
          redirectUrl: subscriptionCallBackModel.url!,
          onError: (error) {
            debugPrint('$error /////////////////');
          },
          onSuccess: (param) {
            debugPrint('//////////////$param');
          },
        ));
      }

      emit(CreateSponsoredAdSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateSponsoredAdErrorState(error: error.toString()));
    });
  }

  // promoteAdFromWallet({required String amount, required String coupon}) {
  //   emit(PromoteAdFromWalletLoadingState());
  //   DioHelper.postData(
  //       url: BaseUrl.baseUrl + BaseUrl.payAdFromWallet,
  //       token: token,
  //       data: {
  //         "amount": amount,
  //         "coupon_code": coupon,
  //         "type_withdrawal": "ad_promotion"
  //       }).then((val) {
  //     debugPrint(val.data.toString());
  //     emit(PromoteAdFromWalletSuccessState());
  //   }).catchError((error) {
  //     log(error.toString());
  //     emit(PromoteAdFromWalletErrorState(error: error.toString()));
  //   });
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


  File? mainImageFile;
  bool isPickMainImageForAd = false;
  String? base64MainImageForAd;

  pickMainImageForAd() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 1920,
      maxHeight: 1080,
    );
    mainImageFile = (File(pickedFile!.path));
    List<int> imageBytes = mainImageFile!.readAsBytesSync();
    final fileName = basename(mainImageFile!.path);
    final appDir = await getApplicationDocumentsDirectory();
    final savedImage = await mainImageFile!.copy('${appDir.path}/$fileName');
    var result = await FlutterImageCompress.compressWithFile(
      savedImage.absolute.path,
      minWidth: 1920,
      minHeight: 1080,
      quality: 50,
    );
    final watermarkedImg = await addWatermarkToBottomLeft(result!, Images.SMALL_LOGO_ICON);

    final base64String = base64Encode(watermarkedImg);
    base64MainImageForAd = "data:image/jpeg;base64,$base64String";
    debugPrint('IMAGE IS ${base64MainImageForAd.toString()}');
    debugPrint('IMAGE IS ${mainImageFile.toString()}');
    isPickMainImageForAd = true;
    emit(PickMainImageFromGalleryState());

    debugPrint('afasdasdasds${isPickMainImageForAd.toString()}');
  }

  clearMainImageForAd() {
    mainImageFile = null;
    base64MainImageForAd = null;
    emit(ClearImageInUploadRequestState());
  }

  List<File> selectedImages = [];
  List<String> images = [];
  var base64Image;
  bool isPickedImage = false;
  List<String> selectedBase64Images = [];

  Future<void> pickImages() async {
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

          //  rotate: 90,
        );
        final watermarkedImg = await addWatermarkToBottomLeft(result!, Images.SMALL_LOGO_ICON);

        final base64String = base64Encode(watermarkedImg);

        debugPrint('///////////////////////${base64String.toString()}');
        List<int> imageBytes = await savedImage.readAsBytesSync();
        base64Image = base64Encode(imageBytes);
        selectedImages.add(savedImage);
        selectedBase64Images.add('data:image/jpeg;base64,$base64String');
      }
      emit(LoopImagesInListUploadRequestState());

      ///  setState(() {
      printLongString('>>>>>${selectedBase64Images}................');
      debugPrint('//////////>>>>>>>>>>>>${images.length.toString()}');
      isPickedImage = true;
      emit(AddPickedImagesInListUploadRequestState());
      debugPrint('//////////>>>>>>>>>>>>${images.length.toString()}');
    } else {
      showCustomSnackBar(
        message: LocaleKeys.max5Images.tr(),
        state: ToastState.ERROR,
      );
    }
  }

  clearImage() {
    selectedImages.clear();
    selectedBase64Images.clear();
    images.clear();

    emit(ClearImageInUploadRequestState());
  }

  bool isUploaded = false;
  int? adId;

  createAds(
      {required String categoryId,
      required String roomNo,
      required String toiletsNo,
      required String space,
      required String prolongation,
      required String type,
      required String address,
      required BuildContext context,
      required String price,
      required String notes}) async {
    isUploaded = false;
//////////LATITUDE//21.5574875
// I/flutter ( 8125): ////////LATITUDE//39.1774773
    emit(CreateAdsLoadingState());
    debugPrint('////////${latAds.toString()}');
    debugPrint('////////${lngAds.toString()}');
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.CreateNewAd,
        token: token,
        data: {
          "category_id": categoryId.toString(),
          "space": space.toString(),
          "rooms_number": context
                  .read<AddRealAdsCubit>()
                  .resourceCreateModel
                  .roomsNumber!
                  .last
                  .istabbed
              ? context.read<AddRealAdsCubit>().roomCountController.text
              : roomNo.toString(),
          "toilets_number": context
                  .read<AddRealAdsCubit>()
                  .resourceCreateModel
                  .toiletNumber!
                  .last
                  .istabbed
              ? context.read<AddRealAdsCubit>().bathCountController.text
              : toiletsNo.toString(),
          "living_rooms_number": context
                  .read<AddRealAdsCubit>()
                  .resourceCreateModel
                  .livingRoom!
                  .last
                  .istabbed
              ? context.read<AddRealAdsCubit>().livingRoomCountController.text
              : context.read<AddRealAdsCubit>().livingRoomCount.toString(),
          "prolongation": prolongation.toString(),
          "type": type.toString(),
          "address": address.toString(),
          "region": context.read<LocationCubit>().regionTextController.text,
          "district": context.read<LocationCubit>().districtTextController.text,
          "city": context.read<LocationCubit>().cityTextController.text,
          "name": context.read<AddRealAdsCubit>().adTitleController.text,
          "image": base64MainImageForAd,
          "notes": notes.toString(),
          "price": price.toString(),
          "lan": lngAds == null
              ? context.read<LocationCubit>().position?.longitude.toString()
              : lngAds,
          "lat": latAds == null
              ? context.read<LocationCubit>().position?.latitude.toString()
              : latAds,
          "photos": selectedBase64Images,

          ///
          "street_width":
              context.read<AddRealAdsCubit>().streetWideController.text,
          "wells_number":
              context.read<AddRealAdsCubit>().wellCountController.text,
          "plan_number":
              context.read<AddRealAdsCubit>().plotCountController.text,
          "parcel_number":
              context.read<AddRealAdsCubit>().landNoController.text,
          "trees_and_palms_number":
              context.read<AddRealAdsCubit>().palmCountController.text,
          "additional_requirements": context
              .read<AddRealAdsCubit>()
              .additionalRequirementController
              .text,
          "desired_property_specifications": context
              .read<AddRealAdsCubit>()
              .desiredPropertySpecificationsController
              .text,
          "additional_features": context.read<AddRealAdsCubit>().featureId,
          "age": context.read<AddRealAdsCubit>().realEstateAgeController.text,
          "services": context.read<AddRealAdsCubit>().servicesController.text,
          "usage": context.read<AddRealAdsCubit>().usageController.text,
          "floors_number":
              context.read<AddRealAdsCubit>().floorsCountController.text,
          "parking_spaces":
              context.read<AddRealAdsCubit>().isParking == true ? 1 : 0,
          "commercial_units_number":
              context.read<AddRealAdsCubit>().shopsCountController.text,
        }).then((value) {
      printLongString(value.data.toString());

      printLongString('${value.data['data']['id']}');
      adId = value.data['data']['id'];
      showCustomSnackBar(
        message: LocaleKeys.uploadAdSuccess.tr(),
        state: ToastState.SUCCESS,
        // isError: false,
        // title: 'اخبار جيدة'
      );
      emit(CreateAdsSuccessState());
      // RestartWidget.restartApp(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => MakeSponsoredAds(
                    adId: value.data['data']['id'],
                isComeFromAddAds: true,
                  )),
          (route) => false);
      latAds = null;
      lngAds = null;
      // Get.offUntil(
      //   ,
      //   (route) => false,
      // );
    }).catchError((error) {
      log(error.toString());
      emit(CreateAdsErrorState(error: error.toString()));
    });
  }

  late SponsorAdsDetailsModel sponsorAdsDetailsModel;

  getSponsorDetails() {
    emit(GetSponsorAdsDetailsLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.GetSponsoredAdDetails)
        .then((value) {
      debugPrint(value.data.toString());
      sponsorAdsDetailsModel = SponsorAdsDetailsModel.fromJson(value.data);
      emit(GetSponsorAdsDetailsSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetSponsorAdsDetailsErrorState(error: error.toString()));
    });
  }
}
