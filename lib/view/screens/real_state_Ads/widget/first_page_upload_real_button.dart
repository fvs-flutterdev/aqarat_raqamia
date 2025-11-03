import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/add_real_ads/cubit.dart';
import '../../../../bloc/location_cubit/cubit.dart';
import '../../../../bloc/upload_request_cubit/cubit.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/text_style.dart';
import '../../../base/lunch_widget.dart';
import '../../../base/main_button.dart';
import '../../../base/show_toast.dart';
import '../second_screen_ads.dart';

//ignore: must_be_immutable
class FirstPageUploadRealButton extends StatelessWidget {
  GlobalKey<FormState> formKey;

  FirstPageUploadRealButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    var addRealAdsCubit = context.read<AddRealAdsCubit>();
    var locationCubit = LocationCubit.get(context);
    return CustomButton(
      textButton: LocaleKeys.next.tr(),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          if (context.read<AddRealAdsCubit>().purposeId == null) {
            showCustomSnackBar(
                // context: context,
                message: LocaleKeys.enterAdsPurpose.tr(),
                state: ToastState.ERROR);
          } else if (context.read<AddRealAdsCubit>().adsId == null) {
            showCustomSnackBar(
                // context: context,
                message: LocaleKeys.pleaseSelectAdType.tr(),
                state: ToastState.ERROR);
            //first if real not have bath
          } else if (addRealAdsCubit.adsId != 20 &&
                  addRealAdsCubit.adsId != 35 &&
                  addRealAdsCubit.adsId != 37 &&
                  addRealAdsCubit.adsId != 21 &&
                  addRealAdsCubit.adsId != 30 &&
                  addRealAdsCubit.adsId != 31 &&
                  addRealAdsCubit.adsId != 27 &&
                  addRealAdsCubit.adsId != 25 &&
                  addRealAdsCubit.adsId != 29 &&
                  addRealAdsCubit.adsId != 34 &&
                  addRealAdsCubit.adsId != 33 &&
                  addRealAdsCubit.adsId != 36 &&
                  addRealAdsCubit.adsId != 32 &&
                  addRealAdsCubit.adsId != 19 &&
                  addRealAdsCubit.adsId != 26 &&
                  addRealAdsCubit.adsId != 28 &&
                  addRealAdsCubit.adsId != 18 &&
                  addRealAdsCubit.adsId != 23 &&
                  addRealAdsCubit.adsId != 15 &&
                  addRealAdsCubit.adsId != 17 &&
                  addRealAdsCubit.adsId != 22 &&
                  addRealAdsCubit.adsId != 14 &&
                  addRealAdsCubit.adsId != 16 &&
                  addRealAdsCubit.adsId != 24 &&
                  addRealAdsCubit.bathCount == null &&
                  addRealAdsCubit.adsId != 13 &&
                  addRealAdsCubit.bathCountController.text.isEmpty ||
              addRealAdsCubit.adsId != 15 &&
                  addRealAdsCubit.adsId != 17 &&
                  addRealAdsCubit.adsId != 24 &&
                  addRealAdsCubit.adsId != 18 &&
                  context.read<AddRealAdsCubit>().roomCount == null &&
                  addRealAdsCubit.roomCountController.text.isEmpty &&
                  addRealAdsCubit.adsId != 22 &&
                  addRealAdsCubit.adsId != 19 &&
                  addRealAdsCubit.adsId != 20 &&
                  addRealAdsCubit.adsId != 23 &&
                  addRealAdsCubit.adsId != 25 &&
                  addRealAdsCubit.adsId != 16 &&
                  addRealAdsCubit.adsId != 26 &&
                  addRealAdsCubit.adsId != 29 &&
                  addRealAdsCubit.adsId != 27 &&
                  addRealAdsCubit.adsId != 31 &&
                  addRealAdsCubit.adsId != 34 &&
                  addRealAdsCubit.adsId != 37 &&
                  addRealAdsCubit.adsId != 30 &&
                  addRealAdsCubit.adsId != 35) {
            showCustomSnackBar(
                // context: context,
                message: LocaleKeys.pleaseFeatureAd.tr(),
                state: ToastState.ERROR);
          } else if (addRealAdsCubit.vision == null &&
              addRealAdsCubit.adsId != 20 &&
              addRealAdsCubit.adsId != 21 &&
              addRealAdsCubit.adsId != 37 &&
              addRealAdsCubit.adsId != 14 &&
              addRealAdsCubit.adsId != 23 &&
              addRealAdsCubit.adsId != 34 &&
              addRealAdsCubit.adsId != 35) {
            showCustomSnackBar(
                // context: context,
                message: LocaleKeys.pleaseSelectEstateProlongation.tr(),
                state: ToastState.ERROR);
          }
          // else if(addRealAdsCubit.adsId==19 && addRealAdsCubit.palmCountController.text.isEmpty){
          //   showCustomSnackBar(message: 'من فضلك ادخل عدد الإشحار والنخيل في المزرعه', state: ToastState.ERROR);
          // }else if(addRealAdsCubit.adsId==19 && addRealAdsCubit.wellCountController.text.isEmpty){
          //   showCustomSnackBar(message: 'من فضلك ادخل الآبار في المزرعه', state: ToastState.ERROR);
          // }
          else if (addRealAdsCubit.adsId == 12 &&
              addRealAdsCubit.livingRoomCountController.text.isEmpty &&
              addRealAdsCubit.livingRoomCount == null) {
            showCustomSnackBar(
                // context: context,
                message: LocaleKeys.livingRoomRequired.tr(),
                state: ToastState.ERROR);
          } else {
            navigateForward(SecondScreenAds(
              adsType: context.read<AddRealAdsCubit>().adsId.toString(),
              price: addRealAdsCubit.priceController.text,
              area: addRealAdsCubit.areaController.text,
              // area:context.read<FilterSearchAdsCubit>().selectedAre! ,
              bathNo: addRealAdsCubit
                      .resourceCreateModel.toiletNumber!.last.istabbed
                  ? addRealAdsCubit.bathCountController.text
                  : context.read<AddRealAdsCubit>().bathCount ?? '',
              location: locationCubit.locationTextController.text,
              purpose: context.read<AddRealAdsCubit>().purposeId ?? '',
              roomNo: addRealAdsCubit
                      .resourceCreateModel.toiletNumber!.last.istabbed
                  ? addRealAdsCubit.roomCountController.text
                  : context.read<AddRealAdsCubit>().roomCount ?? '',
              vision: context.read<AddRealAdsCubit>().vision ?? '',
            ));
            context.read<UploadRequestCubit>().clearImage();
          }
        }
      },
      color: goldColor,
    );
  }
}
