import '../../../utils/media_query_value.dart';
import '../../../utils/text_style.dart';
import '../../../view/base/adaptive_dialog_loader.dart';
import '../../../view/base/custom_text_field.dart';
import '../../../view/base/main_button.dart';
import '../../../view/base/show_toast.dart';
import '../../../view/base/row_widget_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../bloc/add_real_ads/cubit.dart';
import '../../../bloc/upload_request_cubit/cubit.dart';
import '../../../bloc/upload_request_cubit/state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../base/category_header.dart';
import '../../base/images_grid_view_widget.dart';
import '../../base/main_image_ad_widget.dart';


//ignore: must_be_immutable
class SecondScreenAds extends StatefulWidget {
  String price;
  String location;
  String area;
  String roomNo;
  String bathNo;
  String vision;
  String purpose;
  String adsType;

  SecondScreenAds({
    super.key,
    required this.price,
    required this.location,
    required this.area,
    required this.roomNo,
    required this.bathNo,
    required this.vision,
    required this.purpose,
    required this.adsType,
  });

  @override
  State<SecondScreenAds> createState() => _SecondScreenAdsState();
}

class _SecondScreenAdsState extends State<SecondScreenAds> {
  TextEditingController detailsOfAdsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    //   context.read<LocationCubit>().getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var addRealAdsCubit =context.read<AddRealAdsCubit>();
    var uploadRequestCubit =context.read<UploadRequestCubit>();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: CategoryHeader(
            title: LocaleKeys.realEstateInfo.tr(),
            onTap: () {},
            isFilter: false),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          child: BlocConsumer<UploadRequestCubit, UploadRequestState>(
            listener: (context, state) {
              if (state is CreateAdsLoadingState) {
                adaptiveDialogLoader(context: context);
              }
              if (state is CreateAdsErrorState) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              labelText: LocaleKeys.adsDetails.tr(),
                              isBig: true,
                              lines: 20,
                              length: 2000,
                              maxHeight: context.width * 0.39.sp,
                              minHeight: context.width * 0.39.sp,
                              controller: detailsOfAdsController,
                              validator: (String val) {
                                if (val.isEmpty) {
                                  return LocaleKeys.enterAdsDetails.tr();
                                }
                              },
                            ),
                            BlocConsumer<UploadRequestCubit,
                                UploadRequestState>(
                              listener: (context, state) {
                                // TODO: implement listener
                              },
                              builder: (context, state) {
                                return RowWidgetImage(
                                  title: LocaleKeys.mainImageForAd.tr(),
                                  isListEmpty:
                                      uploadRequestCubit.isPickMainImageForAd ==false
                                          ? true
                                          : false,
                                  clearFun: () =>
                                      uploadRequestCubit.clearMainImageForAd(),
                                );
                              },
                            ),
                            BlocBuilder<UploadRequestCubit, UploadRequestState>(
                              builder: (context, state) {
                                return MainImageAdWidget(
                                  isListEmpty:
                                  uploadRequestCubit.isPickMainImageForAd ==false
                                          ? true
                                          : false,
                                  pickImage: () =>
                                      uploadRequestCubit.pickMainImageForAd(),
                                  imageFile: uploadRequestCubit.mainImageFile,
                                );
                              },
                            ),
                            BlocConsumer<UploadRequestCubit,
                                UploadRequestState>(
                              listener: (context, state) {
                                // TODO: implement listener
                              },
                              builder: (context, state) {
                                return RowWidgetImage(
                                  title: LocaleKeys.max5Images.tr(),
                                  isListEmpty:
                                      uploadRequestCubit.selectedImages.isEmpty,
                                  clearFun: () =>
                                      uploadRequestCubit.clearImage(),
                                );
                              },
                            ),
                            BlocBuilder<UploadRequestCubit, UploadRequestState>(
                              builder: (context, state) {
                                return ImageGridViewWidget(
                                  isListEmpty:
                                      uploadRequestCubit.selectedImages.isEmpty,
                                  pickImage: () =>
                                      uploadRequestCubit.pickImages(),
                                  countImage:
                                      uploadRequestCubit.selectedImages.length,
                                  imageFile: uploadRequestCubit.selectedImages,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<UploadRequestCubit, UploadRequestState>(
                      builder: (context, state) {
                        return Align(
                            alignment: Alignment.bottomCenter,
                            child:
                                // state is CreateAdsLoadingState
                                //     ? CircularProgressIndicator()
                                //     :
                                CustomButton(
                              textButton: LocaleKeys.uploadAd.tr(),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (uploadRequestCubit
                                      .selectedBase64Images.isEmpty) {
                                    showCustomSnackBar(
                                      // context: context,
                                      message: LocaleKeys
                                          .selectImage5maxRequired
                                          .tr(),
                                      state: ToastState.ERROR,
                                      //  isError: false,
                                      //  title: 'إختيار صور'
                                    );
                                  } else {
                                    uploadRequestCubit.createAds(
                                        categoryId: widget.adsType,
                                        roomNo: widget.roomNo,
                                        toiletsNo: widget.bathNo,
                                        space: widget.area,
                                        prolongation: widget.vision,
                                        type: widget.purpose,
                                        address: widget.location,
                                        price: widget.price,
                                        notes: detailsOfAdsController.text,
                                        context: context);
                                  }
                                }
                              },
                              color: goldColor,
                            ));
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
