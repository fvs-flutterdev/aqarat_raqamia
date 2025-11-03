import 'dart:developer';

import '../../bloc/add_real_ads/state.dart';
import '../../utils/app_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/dynamic_model/additional_feature_model.dart';
import '../../model/dynamic_model/resource_ads_create.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/base_url.dart';
import '../../utils/dio.dart';
import '../../view/base/show_toast.dart';

class AddRealAdsCubit extends Cubit<AddRealAdsState> {
  AddRealAdsCubit() : super(InitialAddRealAdsState());

  static AddRealAdsCubit get(context) => BlocProvider.of(context);

  late ResourceCreateModel resourceCreateModel;
  bool? isGetResourceFeature;
  TextEditingController priceController = TextEditingController();
  TextEditingController adTitleController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController roomCountController = TextEditingController();
  TextEditingController floorsCountController = TextEditingController();
  TextEditingController shopsCountController = TextEditingController();
  TextEditingController livingRoomCountController = TextEditingController();
  TextEditingController bathCountController = TextEditingController();
  TextEditingController landNoController = TextEditingController();
  TextEditingController streetWideController = TextEditingController();
  TextEditingController plotCountController = TextEditingController();
  TextEditingController realEstateAgeController = TextEditingController();
  TextEditingController palmCountController = TextEditingController();
  TextEditingController wellCountController = TextEditingController();
  TextEditingController additionalRequirementController =
      TextEditingController();
  TextEditingController desiredPropertySpecificationsController =
      TextEditingController();
  TextEditingController servicesController = TextEditingController();
  TextEditingController usageController = TextEditingController();

  getResourceFeature() {
    isGetResourceFeature = false;
    emit(GetFeatureForCreateAdsLoadingState());
    DioHelper.getData(
            url: BaseUrl.baseUrl + BaseUrl.GetAdsFeature, token: token)
        .then((value) {
      debugPrint(value.data.toString());
      log('lllllllllllllllllllllll');
      resourceCreateModel = ResourceCreateModel.fromJson(value.data);
      log(
          '///////////////////${resourceCreateModel.roomsNumber?.length.toString()}');
      emit(GetFeatureForCreateAdsSuccessState());
      isGetResourceFeature = true;
    }).catchError((error) {
      log(error.toString());
      isGetResourceFeature = null;
      log(isGetResourceFeature.toString());
      showCustomSnackBar(
          message: LocaleKeys.errorResponse.tr(), state: ToastState.ERROR);
      emit(GetFeatureForCreateAdsErrorsState(error: error.toString()));
    });
  }

  String? roomCount;

  changeRoomsCountStatus({required int index}) {
    resourceCreateModel.roomsNumber?.forEach((element) {
      element.istabbed = false;
    });
    resourceCreateModel.roomsNumber?[index].istabbed =
        !resourceCreateModel.roomsNumber![index].istabbed;
    roomCount = resourceCreateModel.roomsNumber![index].title.toString();
    emit(ChangeRoomsCountAddRealAdsState());
  }


 String? CategoryIdFilter;

  onChangeCategoryIdFilter(onChange) {
    CategoryIdFilter = onChange;
    emit(OnChangeCategoryValueFilterState());
  }

  bool isParking = false;

  onChangeParking(bool val) {
    isParking = !isParking;
    log('??????????????isParking : ${isParking.toString()}');
    emit(ChangeIsParkingAddRealAdsState());
  }

  String? bathCount;

  changeBathCountStatus({required int index}) {
    resourceCreateModel.toiletNumber?.forEach((element) {
      element.istabbed = false;
    });
    // bathCountModel.forEach((element) {
    //   element.isTabbed = false;
    // });
    resourceCreateModel.toiletNumber?[index].istabbed =
        !resourceCreateModel.toiletNumber![index].istabbed;
    bathCount = resourceCreateModel.toiletNumber![index].title.toString();
    emit(ChangeBathCountAddRealAdsState());
    //  update();
  }

  String? livingRoomCount;

  changeLivingRoomStatus({required int index}) {
    resourceCreateModel.livingRoom?.forEach((element) {
      element.istabbed = false;
    });
    // bathCountModel.forEach((element) {
    //   element.isTabbed = false;
    // });
    resourceCreateModel.livingRoom?[index].istabbed =
        !resourceCreateModel.livingRoom![index].istabbed;
    livingRoomCount = resourceCreateModel.livingRoom![index].title.toString();
    log('/////////////LIVINGROOM. ${livingRoomCount.toString()}');
    emit(ChangeLivingRoomsCountAddRealAdsState());
    //  update();
  }

  late AdditionalFeatureModel additionalFeatureModel;

  getFeaturesList() {
    emit(GetFeatureListLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.GetFeatureList)
        .then((value) {
      print(value.data);
      additionalFeatureModel = AdditionalFeatureModel.fromJson(value.data);
      emit(GetFeatureListSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFeatureListErrorState(error: error.toString()));
    });
  }

  List<int> featureId = [];

  chooseFeatures({required int index}) {
    additionalFeatureModel.data![index].isTabbed =
        !additionalFeatureModel.data![index].isTabbed!;
    if (featureId.isEmpty) {
      additionalFeatureModel.data!.forEach((element) {
        if (element.isTabbed == true) {
          featureId.add(element.id!);
          log(element.name.toString());
        }
      });
    } else {
      additionalFeatureModel.data!.forEach((element) {
        if (element.isTabbed == true) {
          featureId.contains(element.id) ? null : featureId.add(element.id!);
          log(element.name.toString());
        } else if (element.isTabbed == false) {
          featureId.remove(element.id);
        }
      });
    }
    log('${featureId.toString()}////////////////////////');

    emit(ChooseFeatureRealAdsState());
  }

  String? vision;

  changeVisionStatus({required int index}) {
    resourceCreateModel.prolongation?.forEach((element) {
      element.istabbed = false;
    });

    resourceCreateModel.prolongation?[index].istabbed =
        !resourceCreateModel.prolongation![index].istabbed;
    vision = resourceCreateModel.prolongation?[index].title;
    emit(ChangeVisionStatusAddRealAdsState());
    //  update();
  }

  // int selectedMethod = -1;
  //
  // changeVerifyStatus({required int i, bool onChange = false}) {
  //   verifyWay.forEach((element) {
  //     element.isTabbed = false;
  //   });
  //   selectedMethod = i;
  //   verifyWay[i].isTabbed = onChange;
  //   debugPrint('object: ${onChange.toString()}');
  //   emit(ChooseVerifyWayAddRealAdsState());
  //   // update();
  // }

  String? adsType;
  int? adsId;

  changeStateOfItem({required int index}) {
    resourceCreateModel.adType?.forEach((element) {
      element.istabbed = false;
    });
    resourceCreateModel.adType![index].istabbed = !resourceCreateModel.adType![index].istabbed;
    adsType = resourceCreateModel.adType![index].name;
    adsId = resourceCreateModel.adType![index].id;
    // categoryModel[index].isTabbed = !categoryModel[index].isTabbed;
    // debugPrint(categoryModel[index].title);
    log('////////////////////////////////////// ${adsId.toString()}');
    emit(ChangeTypeOfAqarFilterSearchAdsStatee());
    //  update();
  }

  String? purpose;
  String? purposeId;

  changePurposeStatus({required int index}) {
    resourceCreateModel.type?.forEach((element) {
      element.istabbed = false;
    });
    // purposeFilter.forEach((element) {
    //   element.isTabbed = false;
    // });
    resourceCreateModel.type![index].istabbed =
        !resourceCreateModel.type![index].istabbed;
    purpose = resourceCreateModel.type![index].name;
    purposeId = resourceCreateModel.type![index].id.toString();
    emit(ChangePurposeStatusFilterSearchAdsState());
    //  update();
  }

  returnAdsTypeToDefault() {
    resourceCreateModel.adType?.forEach((element) {
      element.istabbed = false;
    });
    roomCount = null;
    bathCount = null;
    adsId = null;
    adsType = null;
    purpose = null;
    purposeId = null;
    vision = null;
    featureId.clear();
    priceController.clear();
    adTitleController.clear();
    areaController.clear();
    roomCountController.clear();
    bathCountController.clear();
    streetWideController.clear();
    floorsCountController.clear();
    shopsCountController.clear();
    livingRoomCountController.clear();
    landNoController.clear();
    plotCountController.clear();
    realEstateAgeController.clear();
    palmCountController.clear();
    wellCountController.clear();
    usageController.clear();
    additionalRequirementController.clear();
    desiredPropertySpecificationsController.clear();
    servicesController.clear();
    emit(AdTypeReturnState());
  }

  returnPurposeStateToDefault() {
    resourceCreateModel.type?.forEach((element) {
      element.istabbed = false;
    });
    roomCount = null;
    bathCount = null;
    adsId = null;
    adsType = null;
    purpose = null;
    purposeId = null;
    vision = null;
    featureId.clear();
    priceController.clear();
    adTitleController.clear();
    areaController.clear();
    roomCountController.clear();
    bathCountController.clear();
    streetWideController.clear();
    floorsCountController.clear();
    shopsCountController.clear();
    livingRoomCountController.clear();
    landNoController.clear();
    plotCountController.clear();
    realEstateAgeController.clear();
    palmCountController.clear();
    wellCountController.clear();
    usageController.clear();
    additionalRequirementController.clear();
    desiredPropertySpecificationsController.clear();
    servicesController.clear();
    emit(AdPurposeReturnState());
  }

  returnAdsVisionToDefault() {
    resourceCreateModel.prolongation?.forEach((element) {
      element.istabbed = false;
    });
    roomCount = null;
    bathCount = null;
    adsId = null;
    adsType = null;
    purpose = null;
    purposeId = null;
    vision = null;
    featureId.clear();
    priceController.clear();
    adTitleController.clear();
    areaController.clear();
    roomCountController.clear();
    bathCountController.clear();
    streetWideController.clear();
    floorsCountController.clear();
    shopsCountController.clear();
    livingRoomCountController.clear();
    landNoController.clear();
    plotCountController.clear();
    realEstateAgeController.clear();
    palmCountController.clear();
    wellCountController.clear();
    usageController.clear();
    additionalRequirementController.clear();
    desiredPropertySpecificationsController.clear();
    servicesController.clear();
    emit(AdVisionReturnState());
  }

  returnRoomStateToDefault() {
    resourceCreateModel.roomsNumber?.forEach((element) {
      element.istabbed = false;
    });
    roomCount = null;
    bathCount = null;
    adsId = null;
    adsType = null;
    purpose = null;
    purposeId = null;
    vision = null;
    featureId.clear();
    priceController.clear();
    adTitleController.clear();
    areaController.clear();
    roomCountController.clear();
    bathCountController.clear();
    streetWideController.clear();
    floorsCountController.clear();
    shopsCountController.clear();
    livingRoomCountController.clear();
    landNoController.clear();
    plotCountController.clear();
    realEstateAgeController.clear();
    palmCountController.clear();
    wellCountController.clear();
    usageController.clear();
    additionalRequirementController.clear();
    desiredPropertySpecificationsController.clear();
    servicesController.clear();
    emit(AdRoomCountReturnState());
  }

  returnToiletStateToDefault() {
    resourceCreateModel.toiletNumber?.forEach((element) {
      element.istabbed = false;
    });
    roomCount = null;
    bathCount = null;
    adsId = null;
    adsType = null;
    purpose = null;
    purposeId = null;
    vision = null;
    featureId.clear();
    priceController.clear();
    adTitleController.clear();
    areaController.clear();
    roomCountController.clear();
    bathCountController.clear();
    streetWideController.clear();
    floorsCountController.clear();
    shopsCountController.clear();
    livingRoomCountController.clear();
    landNoController.clear();
    plotCountController.clear();
    realEstateAgeController.clear();
    palmCountController.clear();
    wellCountController.clear();
    usageController.clear();
    additionalRequirementController.clear();
    desiredPropertySpecificationsController.clear();
    servicesController.clear();
    emit(AdToiletCountState());
  }
}
