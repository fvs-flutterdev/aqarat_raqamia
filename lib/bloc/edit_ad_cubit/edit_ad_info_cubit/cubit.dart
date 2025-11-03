import 'dart:developer';

import 'package:aqarat_raqamia/bloc/add_real_ads/cubit.dart';
import 'package:aqarat_raqamia/bloc/edit_ad_cubit/edit_ad_info_cubit/state.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/screens/splash/splash_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_app/restart_app.dart';

import '../../../model/dynamic_model/additional_feature_model.dart';
import '../../../model/dynamic_model/ads_by_id_model.dart';
import '../../../model/dynamic_model/resource_ads_create.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/base_url.dart';
import '../../../utils/dio.dart';
import '../../../view/base/show_toast.dart';
import '../../../view/screens/bottom_navigation/main_screen.dart';

class EditAdInfoCubit extends Cubit<EditAdInfoState> {
  EditAdInfoCubit() : super(InitialEditAdInfoState());

  late AdsByIdModel adsByIdModel;
  bool? isGetAdsById;

  TextEditingController locationTextController = TextEditingController();
  TextEditingController districtTextController = TextEditingController();
  TextEditingController cityTextController = TextEditingController();
  TextEditingController regionTextController = TextEditingController();
  TextEditingController adTitleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController additionalRequirementController =
      TextEditingController();
  TextEditingController desiredPropertySpecificationsController =
      TextEditingController();
  TextEditingController roomCountController = TextEditingController();
  TextEditingController bathCountController = TextEditingController();
  TextEditingController usageController = TextEditingController();
  TextEditingController servicesController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController detailsOfAdsController = TextEditingController();

  //TextEditingController shopsCountController=TextEditingController();
  TextEditingController palmCountController = TextEditingController();
  TextEditingController wellCountController = TextEditingController();
  TextEditingController floorsCountController = TextEditingController();
  TextEditingController shopsCountController = TextEditingController();
  TextEditingController LivingRoomCountController = TextEditingController();
  TextEditingController streetWideController = TextEditingController();
  TextEditingController landNoController = TextEditingController();
  TextEditingController plotCountController = TextEditingController();

  getAdById({required int id}) {
    isGetAdsById = false;
    emit(GetAdByIdLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + '/api/ads/show/$id', token: token)
        .then((value) {
      log(value.data.toString());
      adsByIdModel = AdsByIdModel.fromJson(value.data);

      locationTextController =
          TextEditingController(text: adsByIdModel.data?.address??'');
      districtTextController =
          TextEditingController(text: adsByIdModel.data?.district??'');
      cityTextController = TextEditingController(text: adsByIdModel.data?.city??'');
      regionTextController =
          TextEditingController(text: adsByIdModel.data?.region??'');
      desiredPropertySpecificationsController = TextEditingController(
          text: adsByIdModel.data?.desiredPropertySpecifications??'');
      adTitleController = TextEditingController(text: adsByIdModel.data?.name??'');
      priceController = TextEditingController(text: adsByIdModel.data?.price.toString()??'');
      areaController = TextEditingController(text: adsByIdModel.data?.space.toString()??'');
      servicesController=TextEditingController(text:adsByIdModel.data?.services??'' );
      additionalRequirementController = TextEditingController(
          text: adsByIdModel.data?.additionalRequirements??'');
      bathCountController =
          TextEditingController(text: adsByIdModel.data?.toiletsNumber.toString()??'');
      roomCountController =
          TextEditingController(text: adsByIdModel.data?.roomsNumber??'');
      usageController = TextEditingController(text: adsByIdModel.data?.usage??'');
      ageController =
          TextEditingController(text: adsByIdModel.data?.age.toString()??'');
      palmCountController = TextEditingController(
          text: adsByIdModel.data?.treesAndPalmsNumber.toString()??'');
      wellCountController = TextEditingController(
          text: adsByIdModel.data?.wellsNumber.toString()??'');
      shopsCountController = TextEditingController(
          text:adsByIdModel.data?.commercialUnitsNumber.toString()??'');
      floorsCountController = TextEditingController(
          text: adsByIdModel.data?.floorsNumber?.toString()??'');
      LivingRoomCountController = TextEditingController(
          text: adsByIdModel.data?.livingRoomsNumber.toString()??'');
      detailsOfAdsController =
          TextEditingController(text: adsByIdModel.data?.notes??'');
      streetWideController =
          TextEditingController(text: adsByIdModel.data?.streetWidth.toString()??'');
      landNoController =
          TextEditingController(text: adsByIdModel.data?.parcelNumber.toString()??'');
      plotCountController =
          TextEditingController(text: adsByIdModel.data?.planNumber.toString()??'');
      isGetAdsById = true;
      getAdFeaturesForEdit();

      getFeaturesListForEdit();
      getResourceFeatureForEdit();
      print('<<<<<<<<<<<<<<<<<<<<<<Get aDbYiD>>>>>>>>>>>>>>>>>>>>>>');
      emit(GetAdByIdSuccessState());


    }).catchError((error) {
      log(error.toString());
      emit(GetAdByIdErrorState(error: error.toString()));
    });
  }

  late ResourceCreateModel resourceCreateModel;
  bool? isGetResourceFeature;

  getResourceFeatureForEdit() {
    isGetResourceFeature = false;
    emit(GetFeatureForEditAdsLoadingState());
    DioHelper.getData(
            url: BaseUrl.baseUrl + BaseUrl.GetAdsFeature, token: token)
        .then((value) {
      log(value.data.toString());
      log('lllllllllllllllllllllll');
      resourceCreateModel = ResourceCreateModel.fromJson(value.data);
      log(
          '///////////////////${resourceCreateModel.roomsNumber?.length.toString()}');
      sameCategory();
      sameVision();
      samePurpose();
      emit(GetFeatureForEditAdsSuccessState());
      isGetResourceFeature = true;
    }).catchError((error) {
      log(error.toString());
      isGetResourceFeature = null;
      log(isGetResourceFeature.toString());
      showCustomSnackBar(
          message: LocaleKeys.errorResponse.tr(), state: ToastState.ERROR);
      emit(GetFeatureForEditAdsErrorState(error: error.toString()));
    });
  }

  String? adsTypeForEdit;
  int? adsIdForEdit;
  bool? isSame;

  sameCategory() {
    resourceCreateModel.adType?.forEach((element) {
      if (adsByIdModel.data?.categoryAds?.id == element.id) {
        element.istabbed = true;
        isSame = element.istabbed;
        adsTypeForEdit = element.name;
        adsIdForEdit = element.id;
      }
    });
    log('<<<<<<<Type<<<<<<<<<<$adsTypeForEdit>>>>>>>>>>>>>>>>>');
    log('<<<<<<<<Id<<<<<<<<<$adsIdForEdit>>>>>>>>>>>>>>>>>');
    log('<<<<<<<<IsTabbed<<<<<<<<<$isSame>>>>>>>>>>>>>>>>>');
    emit(SameCategoryState());
  }

  changeStateOfItemForEdit({required int index}) {
    isSame = false;
    resourceCreateModel.adType?.forEach((element) {
      element.istabbed = false;
    });
    resourceCreateModel.adType![index].istabbed =
        !resourceCreateModel.adType![index].istabbed;
    adsTypeForEdit = resourceCreateModel.adType![index].name;
    adsIdForEdit = resourceCreateModel.adType![index].id;
    // categoryModel[index].isTabbed = !categoryModel[index].isTabbed;
    // debugPrint(categoryModel[index].title);
    log('////////////////////////////////////// $adsIdForEdit');
    emit(ChangeTypeOfCategoryEditAdState());
    //  update();
  }

  String? visionNameForEdit;
  int? visionIdForEdit;
  bool? isSameVision;

  sameVision() {
    resourceCreateModel.prolongation?.forEach((element) {
      if (adsByIdModel.data?.prolongation == element.title) {
        element.istabbed = true;
        isSameVision = element.istabbed;
        visionNameForEdit = element.title;
        visionIdForEdit = element.id;
      }
    });
    log('<<<<<<<Vision<<<<<<<<<<$visionNameForEdit>>>>>>>>>>>>>>>>>');
    log('<<<<<<<<Id<<<<<<<<<$visionIdForEdit>>>>>>>>>>>>>>>>>');
    log('<<<<<<<<IsTabbed<<<<<<<<<$isSameVision>>>>>>>>>>>>>>>>>');
    emit(SameVersionState());
  }

//  String? visionEdit;

  changeVisionForEditStatus({required int index}) {
    isSameVision = false;

    resourceCreateModel.prolongation?.forEach((element) {
      element.istabbed = false;
    });

    resourceCreateModel.prolongation?[index].istabbed =
        !resourceCreateModel.prolongation![index].istabbed;
    visionNameForEdit = resourceCreateModel.prolongation?[index].title;
    log('<<<<<<<<<<<<<<$visionNameForEdit>>>>>>>>>>>>>>');
    emit(ChangeVisionStatusEditAdsState());
    //  update();
  }

  String? purposeEdit;
  String? purposeIdEdit;
  bool? isSamePurpose;

  samePurpose() {
    resourceCreateModel.type?.forEach((element) {
      if (adsByIdModel.data?.type?.id == element.id) {
        element.istabbed = true;
        isSamePurpose = element.istabbed;
        purposeEdit = element.name;
        purposeIdEdit = element.id.toString();
      }
    });
    log('<<<<<<<Type<<<<<<<<<<$purposeEdit>>>>>>>>>>>>>>>>>');
    log('<<<<<<<<Id<<<<<<<<<$purposeIdEdit>>>>>>>>>>>>>>>>>');
    log('<<<<<<<<IsTabbed<<<<<<<<<$isSamePurpose>>>>>>>>>>>>>>>>>');
    emit(SamePurposeState());
  }

  changePurposeStatus({required int index}) {
    isSamePurpose = false;
    resourceCreateModel.type?.forEach((element) {
      element.istabbed = false;
    });
    // purposeFilter.forEach((element) {
    //   element.isTabbed = false;
    // });
    resourceCreateModel.type![index].istabbed =
        !resourceCreateModel.type![index].istabbed;
    purposeEdit = resourceCreateModel.type![index].name;
    purposeIdEdit = resourceCreateModel.type![index].id.toString();
    log(
        '<<<<<<<<<<<<purposeIdEdit<<<<<<<<<<<$purposeIdEdit>>>>>>>>>>>>>>>>>>>>>>>');
    emit(ChangePurposeStatusForEditAdState());
    //  update();
  }

  late AdditionalFeatureModel additionalFeatureModel;
  bool? isGetAdditionalFeatures;

  getFeaturesListForEdit() {
    isGetAdditionalFeatures = false;
    emit(GetFeatureListForEditLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.GetFeatureList)
        .then((value) {
      log(value.data.toString());
      additionalFeatureModel = AdditionalFeatureModel.fromJson(value.data);
      isGetAdditionalFeatures = true;
      emit(GetFeatureListForEditSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetFeatureListForEditErrorState(error: error.toString()));
    });
  }

  List<int?> featuresSameId = [];

  // List<Features?> features = [];

  getAdFeaturesForEdit() {
    featuresSameId.clear();
    adsByIdModel.data?.additionalFeatures?.forEach((e) {
      featuresSameId.add(e.id);
      log('<<<<<<<<<<<<<<<<<<<<<<$featuresSameId>>>>>>>>>>>>>>>>>>>>>>');
    });
    emit(GetAdFeatureForEditState());
  }

  onUpdateFeaturesAds(List<int?> onChange) {
    featuresSameId = onChange;
    emit(UpdateFeatureAdState());
    log('///////////////////${featuresSameId}');
  }

  // sameFeature() {
  //   resourceCreateModel.features?.forEach((elementResource) {
  //     adsByIdModel.data?.additionalFeatures?.forEach((elementFeatures) {
  //      // if (elementResource.id == elementFeatures.id) {
  //       if (elementResource.id == elementFeatures.id)
  //         featuresSameId.add( elementFeatures.id);
  //        // features.add(elementResource);
  //         // elementResource.istabbed=true;
  //         //  features.addAll()
  //         //  features.add(Features(
  //         //    name: elementFeatures.name,
  //         //    id: elementFeatures.id,
  //         //    photo: elementFeatures.image,
  //         //    istabbed: true,
  //         //  ));
  //     //  }
  //       // else {
  //       //   features.add(Features(
  //       //     name: elementFeatures.name,
  //       //     id: elementFeatures.id,
  //       //     photo: elementFeatures.image,
  //       //     istabbed: false,
  //       //   ));
  //       // }
  //     });
  //     emit(state);
  //     resourceCreateModel.features?.forEach((e){
  //
  //     });
  //    // print('<<<<<<<<Features<<<<<<<<${features.length}>>>>>>>>>>>>>>>>');
  //     print('<<<<<<<<Features<<<<<<<<${featuresSameId.length}>>>>>>>>>>>>>>>>');
  //     // if (adsByIdModel.data?.additionalFeatures?.id == element.id) {
  //     //   element.istabbed = true;
  //     //   isSamePurpose = element.istabbed;
  //     //   purposeEdit = element.name;
  //     //   purposeIdEdit = element.id.toString();
  //     // }
  //   });
  // }
  ///
  // List<int> featureIdForEdit = [];
  //
  // // List<int> featureIdForEdit = [];
  //
  // chooseFeaturesForEdit({required int index}) {
  //   additionalFeatureModel.data![index].isTabbed =
  //       !additionalFeatureModel.data![index].isTabbed!;
  //   if (featureIdForEdit.isEmpty) {
  //     additionalFeatureModel.data!.forEach((element) {
  //       if (element.isTabbed == true) {
  //         featureIdForEdit.add(element.id!);
  //         print(element.name);
  //       }
  //     });
  //   } else {
  //     additionalFeatureModel.data!.forEach((element) {
  //       if (element.isTabbed == true) {
  //         featureIdForEdit.contains(element.id)
  //             ? null
  //             : featureIdForEdit.add(element.id!);
  //         print(element.name);
  //       } else if (element.isTabbed == false) {
  //         featureIdForEdit.remove(element.id);
  //       }
  //     });
  //   }
  //   debugPrint('${featureIdForEdit.toString()}////////////////////////');
  //
  //   emit(ChooseFeatureForEditState());
  // }

  updateAdInfo({required BuildContext context}) {
    emit(EditAdInfoLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + '/api/ads/edit/${adsByIdModel.data?.id}',
        token: token,
        data: {
          "category_id": adsIdForEdit,
          //  "city_id":adsByIdModel.data?.ci,
          "name": adTitleController.text.toString(),
          "space": areaController.text.toString(),
          "rooms_number": roomCountController.text.toString(),
          "toilets_number": bathCountController.text.toString(),
          "prolongation": visionNameForEdit,
          "type": purposeIdEdit,
          "address": locationTextController.text.toString(),
          "notes": detailsOfAdsController.text.toString(),
          "price": priceController.text.toString(),
          "lan":lngAdsEdit?? adsByIdModel.data?.lan,
          "lat":latAdsEdit?? adsByIdModel.data?.lat,
          "usage": usageController.text.toString(),
          // "frontage":,
           "services":servicesController.text.toString(),
          "age": ageController.text.toString(),
          "district": districtTextController.text.toString(),
          "city": cityTextController.text.toString(),
          "region": regionTextController.text.toString(),
          "additional_requirements": additionalRequirementController.text.toString(),
          "additional_features":featuresSameId,
          "desired_property_specifications":
              desiredPropertySpecificationsController.text.toString(),
          "plan_number": plotCountController.text.toString(),
          "street_width": streetWideController.text.toString(),
          "floors_number": floorsCountController.text.toString(),
          "parking_spaces": context.read<AddRealAdsCubit>().isParking,
          "trees_and_palms_number": palmCountController.text??'',
          "wells_number": wellCountController.text.toString(),
          "commercial_units_number": shopsCountController.text.toString(),
          "parcel_number": landNoController.text.toString(),
        }).then((value) async {
      log(value.data.toString());
      emit(EditAdInfoSuccessState());
      showCustomSnackBar(message:LocaleKeys.adUpdatedSuccess.tr(),state:ToastState.SUCCESS);
      navigateAndRemove(MainScreenNavigation());
    }).catchError((error) {
      emit(EditAdInfoErrorState(error: error.toString()));
//       debugPrint('<<<<regionTextController.text.toString(<<<<<<<<${regionTextController.text}>>>>>>>>>>>>>');
//       debugPrint('<<<<cityTextController.text<<<<<<<<${cityTextController.text}>>>>>>>>>>>>>');
//       debugPrint('<<<<districtTextController.text<<<<<<<<${districtTextController.text}>>>>>>>>>>>>>');
//       debugPrint('<<<<ageController.text<<<<<<<<${ageController.text}>>>>>>>>>>>>>');
//       debugPrint('<<<<usageController.text<<<<<<<<${usageController.text}>>>>>>>>>>>>>');
//       debugPrint('<<<<adsByIdModel.data?.lat<<<<<<<<${adsByIdModel.data?.lat}>>>>>>>>>>>>>');
//       debugPrint('<<<<adsByIdModel.data?.lan<<<<<<<<${adsByIdModel.data?.lan}>>>>>>>>>>>>>');
//
//       debugPrint('<<<<category_id<<<<<<<<${adsIdForEdit}>>>>>>>>>>>>>');
//
//       debugPrint('<<<<visionNameForEdit.text<<<<<<<<${visionNameForEdit}>>>>>>>>>>>>>');
//       debugPrint('<<<<bathCountController.text<<<<<<<<${bathCountController.text}>>>>>>>>>>>>>');
//       debugPrint('<<<<roomCountController.text<<<<<<<<${roomCountController.text}>>>>>>>>>>>>>');
//       debugPrint('<<<<areaController<<<<<<<<${areaController.text}>>>>>>>>>>>>>');
//       debugPrint('<<<<adTitleController<<<<<<<<${adTitleController.text}>>>>>>>>>>>>>');
// ///
//       debugPrint('<<<<priceController.text<<<<<<<<${priceController.text}>>>>>>>>>>>>>');
//       debugPrint('<<<<detailsOfAdsController<<<<<<<<${detailsOfAdsController.text}>>>>>>>>>>>>>');
//       debugPrint('<<<<locationTextController.text<<<<<<<<${locationTextController.text}>>>>>>>>>>>>>');
//       debugPrint('<<<<purposeIdEdit<<<<<<<<${purposeIdEdit}>>>>>>>>>>>>>');
//       ///
//       debugPrint('<<<<landNoController.text<<<<<<<<${landNoController.text}>>>>>>>>>>>>>');
//       debugPrint('<<<<shopsCountController.text<<<<<<<<${shopsCountController.text}>>>>>>>>>>>>>');
//       debugPrint('<<<<wellCountController.text<<<<<<<<${wellCountController.text}>>>>>>>>>>>>>');
//       debugPrint('<<<<palmCountController.text<<<<<<<<${palmCountController.text.toString()}>>>>>>>>>>>>>');
//       debugPrint('<<<<context.read<AddRealAdsCubit>().isParking<<<<<<<<${context.read<AddRealAdsCubit>().isParking}>>>>>>>>>>>>>');
//       debugPrint('<<<<floorsCountController.text<<<<<<<<${floorsCountController.text}>>>>>>>>>>>>>');
//       debugPrint('<<<<streetWideController.text<<<<<<<<${streetWideController.text}>>>>>>>>>>>>>');
//       debugPrint('<<<<plotCountController.text<<<<<<<<${plotCountController.text}>>>>>>>>>>>>>');
//       debugPrint('<<<<desiredPropertySpecificationsController.text<<<<<<<<${desiredPropertySpecificationsController.text}>>>>>>>>>>>>>');
//       debugPrint('<<<<featuresSameId.text<<<<<<<<${featuresSameId}>>>>>>>>>>>>>');

    });
  }
}
