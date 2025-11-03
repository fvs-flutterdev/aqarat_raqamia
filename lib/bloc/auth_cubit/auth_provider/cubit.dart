import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:aqarat_raqamia/view/restart_widget/restart_widget.dart';
import 'package:restart_app/restart_app.dart';

import '../../../model/dynamic_model/intestes_model.dart';
import '../../../view/screens/splash/splash_screen.dart';
import 'state.dart';
import 'package:aqarat_raqamia/bloc/profile_cubit/cubit.dart';
import '../../../model/dynamic_model/profile_model.dart';
import '../../../bloc/location_cubit/cubit.dart';
import '../../../utils/base_url.dart';
import '../../../utils/dio.dart';
import '../../../view/base/lunch_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../../../model/dynamic_model/get_sub_Services_by_id_model.dart';
import '../../../model/dynamic_model/provider_register_entity_model.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/shared_pref.dart';
import '../../../view/base/show_toast.dart';
import '../../../view/screens/auth/client_auth/verify_screen.dart';
import '../../../view/screens/bottom_navigation/main_screen.dart';

class RegisterProviderCubit extends Cubit<ProviderRegisterState> {
  RegisterProviderCubit() : super(InitialProviderRegisterState());

  static RegisterProviderCubit get(context) => BlocProvider.of(context);

  late ProviderRegisterEntityModel providerRegisterEntityModel;
  bool? isGetServices;

  getProviderEntityRegister() {
    isGetServices = false;
    emit(GetEntityProviderLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.ProviderResourceEntity)
        .then((value) {
      log(value.data.toString());
      providerRegisterEntityModel =
          ProviderRegisterEntityModel.fromJson(value.data);
      isGetServices = true;
      emit(GetEntityProviderSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetEntityProviderErrorState(error: error.toString()));
    });
  }

  late InterestsModel interestsModel;
  bool? isGetInterestsModel;

  getInterests() {
    isGetInterestsModel = false;
    emit(GetInterestsRegisterLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.GetInterests).then((val) {
      log(val.data.toString());
      interestsModel = InterestsModel.fromJson(val.data);
      isGetInterestsModel = true;
      emit(GetInterestsRegisterSuccessState());
    }).catchError((error) {
      isGetInterestsModel = false;
      log(error.toString());
      emit(GetInterestsRegisterErrorState(error: error.toString()));
    });
  }

  int? serviceIdFilter;

  onChangeServiceIdFilter(onChange) {
    serviceIdFilter = onChange;
    emit(OnChangeServiceValueFilterState());
  }

  List<int?> serviceList = [];

  getProfileServices(BuildContext context) {
    context
        .read<ProfileCubit>()
        .profileModel
        .userProfile!
        .services
        ?.forEach((e) {
      serviceList.add(e.id);
      log('<<<<<<<<<<<<<<<<<<<<<<${serviceList.toString()}>>>>>>>>>>>>>>>>>>>>>>');
    });
    emit(state);
  }

  List differentList = [];

  getCustomEntity(BuildContext context) {
    differentList = [
      ...providerRegisterEntityModel.services!.where((item) {
        return !context
            .read<ProfileCubit>()
            .profileModel
            .userProfile!
            .services!
            .any((element) => element.id == item.id);
      }),
      ...context
          .read<ProfileCubit>()
          .profileModel
          .userProfile!
          .services!
          .where((item) {
        return !providerRegisterEntityModel.services!
            .any((element) => element.id == item.id);
      }),
    ];
    jsonEncode(differentList);
    emit(state);
    log('/////////////Different//////////${jsonEncode(differentList).toString()}');
  }

//  List<int?> serviceList = [];

  onAddServiceList(List<int?> onChange) {
    //  newServiceList=onChange;
    serviceList = onChange;
    emit(state);
    // context.read<ProfileCubit>().profileModel.userProfile?.services?.forEach((element) {
    //   serviceList.insert(0, element.id);
    // });
    // //serviceList.addAll()
    // emit(state);
    log('//////////////////New Sub ${serviceList.toString()}');
    // debugPrint('//////////////////New Sub ${newServiceList}');
    //  print('///////////////////${serviceList}');
  }


  List subServiceList = [];
  List<int> idSub = [];

  onAddSubServiceList(onChange) {
    // subServiceList = onChange;
    List<int> id = [];
    subServiceList.clear();
    idSub.clear();
    onChange.forEach((element) {
      subServiceList.add(element.id);
      id.add(element.serviceId);
      idSub = id.toSet().toList();
      print(element.serviceId);
    });
    emit(AddSubServiceIdToListState());
    print(
        '<<<<<<<<subServiceId<<<<<<<<<<<<${subServiceList}>>>>>>>>>>>>>>>>>>>>');
    print('<<<<<<<<<serviceIdForSub<<<<<<<<<<<<<<<<<${idSub}>>>>>>>>>>>>>>>>>>');
    print('<<<service<<<<<<<<<${serviceList}>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    emit(AddSubServiceIdToListState());
  }

  bool isUpdateList = false;
  List<int?> newServiceList = [];

  onUpdateServicesList(List<int?> onChange) {
    // print('<<<<<onChange<<<<<<<<<<<<<<$onChange>>>>>>>>>>>>>>>>>>>');
    serviceList.clear();
    idSub.clear();
    onChange.toSet().toList();
    // onChange.clear();
    log('<<<<<<onChange<<<<<<<<${onChange.toString()}>>>>>>>>>>>>>>');
    log('<<<<<<serviceList<<<<<<<<${serviceList.toString()}>>>>>>>>>>>>>>');
    emit(state);
    serviceList = onChange.toSet().toList();
    emit(state);

    // context.read<ProfileCubit>().profileModel.userProfile?.services?.forEach((element) {
    //   serviceList.add(element.id);
    // });
    //serviceList.addAll()
    emit(state);
    log('//////////////////New Sub ${serviceList.toString()}');
  }

  onUpdateSubServicesList(onChange) {
    // subServiceList = onChange.toSet().toList();
    List<int> id = [];
    subServiceList.clear();
    idSub.clear();
    onChange.forEach((element) {
      subServiceList.add(element.id);
      id.add(element.serviceId);
      idSub=id.toSet().toList();
      print(element.serviceId);
    });
    emit(state);
    print('<<<<<<<<<<<<<<<<<<<<$subServiceList>>>>>>>>>>>>>>>>>>>>');
    print(
        '<<<<<<<<<SUB<<<<<<<<<<<<<<<<<${idSub}>>>>>>>>>>>>>>>');
    print('<<<serviceList<<<<<<<<<${serviceList}>>>>>>>>>>>>');


    emit(state);
    log('////12333//////////////New Sub ${subServiceList.toString()}');
  }

  List<int?> interestsList = [];

  onAddInterestsList(List<int?> onChange) {
    interestsList = onChange.toSet().toList();
    emit(state);
    log('///////////////////${interestsList.toString()}');
  }

  bool isGetSubServices = false;
  late SubServicesByIdModel servicesByIdModel;

  getSubServicesById() {
    isGetSubServices = false;
    emit(GetSubServicesByIdLoadingState());
    DioHelper.getDataFilter(
            url: BaseUrl.baseUrl + BaseUrl.SubServices, ids: serviceList)
        .then((value) {
      log(value.data.toString());
      servicesByIdModel = SubServicesByIdModel.fromJson(value.data);
      emit(GetSubServicesByIdSuccessState());
      isGetSubServices = true;
    }).catchError((error) {
      log(error.toString());
      isGetSubServices = false;
      showCustomSnackBar(
          message: LocaleKeys.error.tr(), state: ToastState.ERROR);
      emit(GetSubServicesByIdErrorState(error: error.toString()));
    });
  }



  String? licenseId;

  onChangeLicense(onChange) {
    licenseId = onChange;
    emit(ChangeLicenceProviderRegisterState());
  }

  String? experienceId;

  onChangeExperience(onChange) {
    experienceId = onChange;
    emit(ChangeLicenceProviderRegisterState());
  }

  updateServicesProvider({required BuildContext context}) {
    emit(UpdateServicesOfProviderLoadingState());
    DioHelper.postData(
            url: BaseUrl.baseUrl + BaseUrl.UpdateServicesOfProvider,
            token: token,
            data: {"services": serviceList, "sub_services": subServiceList})
        .then((value) async {
      log(value.data.toString());
      await Restart.restartApp()
          .then((value) => navigateAndRemove(SplashScreen()));
      // RestartWidget.restartApp(context);
      // navigateAndRemove(SplashScreen());
      emit(UpdateServicesOfProviderSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(UpdateServicesOfProviderErrorState(error: error.toString()));
    });
  }

  List<File> selectedImages = [];

  bool isPickedImage = false;
  List<bool> isSelected = [false, false, false];

  Future<void> pickImages(int index) async {
    final List<XFile>? selectedFiles = await ImagePicker().pickMultiImage();
    if (selectedFiles != null) {
      List<File> selectedImage = [];

      for (var imageFile in selectedFiles) {
        final image = File(imageFile.path);
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = basename(image.path);
        final savedImage = await image.copy('${appDir.path}/$fileName');
        selectedImage.add(savedImage);
      }
      emit(PickImageProviderRegisterState());
      selectedImages.addAll(selectedImage);
      isSelected[index] = true;
      isPickedImage = true;
      emit(AddImageToListProviderRegisterState());
    }
  }

  File? filePdf;
  bool isPickPdf = false;
  List<File> pdfListFile = [];
  List<String> pdfFileName = [];
  List<String> pdfBase64List = [];
  String? pdfFile;
  String? pdfFile2;
  String? pdfFile3;

  Future uploadPdf() async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      // type: FileType.any,
      // allowCompression: false,

      //  allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (filePickerResult != null && filePickerResult.files.length <= 3) {
      // List<File> selectedImage = [];
      List<String> selectedBase64Images = [];

      for (var imageFile in filePickerResult.files) {
        final image = File(imageFile.path!);
        int fileSize = await image.length();
        if (fileSize <= 2 * 1024 * 1024) {
          final appDir = await getApplicationDocumentsDirectory();
          final fileName = basename(image.path);
          pdfFileName.add(fileName);
          log('<<<<<<<<<<<<<${fileName.toString()}>>>>>>>>>>>>>');
          final savedImage = await image.copy('${appDir.path}/$fileName');
          List<int> imageBytes = await savedImage.readAsBytesSync();
          pdfFile = base64Encode(imageBytes);
          pdfListFile.add(savedImage);
          //data:image/jpeg;base64,
          selectedBase64Images.add('data:application/pdf;base64,$pdfFile');
          pdfBase64List.add('data:application/pdf;base64,$pdfFile');
          log('<<<<<<<<<<<<<<<<<<<<${pdfBase64List.toString()}>>>>>>>>>>>>>>>>>>>>');
        } else {
          showCustomSnackBar(
              message: '${LocaleKeys.fileIsBig.tr()}$pdfFileName',
              state: ToastState.ERROR);
        }
      }
      emit(PickImageProviderRegisterState());
    } else {
      showCustomSnackBar(
        message: LocaleKeys.attachFile.tr(),
        state: ToastState.ERROR,
      );
    }
    log(pdfListFile.length.toString());
    log('BASE 64 LENGTH :::: ${pdfBase64List.length.toString()}');
    log('BASE 64 LENGTH :::: ${pdfListFile.length.toString()}');
    log('BASE 64 LENGTH :::: ${pdfListFile.elementAt(0).toString()}');
    log('BASE 64 LENGTH :::: ${pdfBase64List.elementAt(0).toString()}');
    isPickPdf = true;
    emit(PickImageProviderRegisterState());
    // log(pdfFile.toString());
    // log('///////////////////////////////////////////////');
    // log(pdfFile2.toString());
    // log('///////////////////////////////////////////////');
    // log(pdfFile3.toString());
  }

  clearImage() {
    pdfListFile.clear();
    pdfFile = null;
    pdfFile2 = null;
    pdfFile3 = null;
    emit(ClearImageFromListProviderRegisterState());
  }

  providerRegister({
    required BuildContext context,
    required String name,
    required String phone,
  }) {
    emit(ProviderRegisterLoadingState());
    DioHelper.postData(url: BaseUrl.baseUrl + BaseUrl.register, data: {
      "name": name,
      "country_code": "966",
      "phone": phone,
      "status": "service_provider",
      "license_id": licenseId,
      "experience_years": experienceId,
      "location": context.read<LocationCubit>().address,
      "country": context.read<LocationCubit>().cityTextController.text,
      "district": context.read<LocationCubit>().districtTextController.text,
      "lan": lngAds ??
          context.read<LocationCubit>().position?.longitude.toString(),
      "lat":
          latAds ?? context.read<LocationCubit>().position?.latitude.toString(),
      "services": serviceList,
      "sub_services": subServiceList,
      "files_array": pdfBase64List,
      "interest_ids": interestsList,
    }).then((value) {
      log(value.data.toString());
      emit(ProviderRegisterSuccessState());
      navigateForward(VerificationScreen(
        phone: phone,
      ));
      showCustomSnackBar(
        message: LocaleKeys.otpSend.tr(),
        state: ToastState.SUCCESS,
      );
      lngAds = null;
      latAds = null;
    }).catchError((error) {
      log(error.toString());
      emit(ProviderRegisterErrorState(error: error.toString()));
    });
  }

  late ProfileModel profileModel;

  verifyProvider({required String phone, required String otp}) {
    emit(VerifyProviderRegisterLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.checkOtpLogin,
        data: {"phone": phone, "code": otp}).then((value) {
      log(value.data.toString());
      profileModel = ProfileModel.fromJson(value.data);
      CacheHelper.saveData(key: 'token', value: value.data['access_token']);
      CacheHelper.saveData(key: 'status', value: value.data['user']['status']);
      accountType = CacheHelper.getData(key: 'status');
      token = CacheHelper.getData(key: 'token');
      log('<<<<<<<<<<<<<<<<<<<${token.toString()}>>>>>>>>>>>>>>>>>>>>');
      log('<<<<<<<<<<<<<<<<<<<${accountType.toString()}>>>>>>>>>>>>>>>>>>>>');
      emit(VerifyProviderRegisterSuccessState());
      navigateAndRemove(MainScreenNavigation());
      sendFcmToken(accessToken: value.data['access_token'].toString());
    }).catchError((error) {
      log(error.toString());
      emit(VerifyProviderRegisterErrorState(error: error.toString()));
    });
  }

  sendFcmToken({required String accessToken}) {
    emit(SendFcmTokenLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.sendFcmToken,
        token: accessToken,
        data: {"fcm_token": CacheHelper.getData(key: 'fcmToken')}).then((value) {
      log(value.data.toString());
      emit(SendFcmTokenSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(SendFcmTokenErrorState(error: error.toString()));
    });
  }

  upgradeAccountToProvider(
      {required BuildContext context, required String phone}) {
    emit(UpgradeProfileLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.UpgradeAccountStatus,
        token: token,
        data: {
          "phone": phone,
          "status": "service_provider",
          "location": context.read<LocationCubit>().address,
          "country": context.read<LocationCubit>().cityTextController.text,
          "country_code": "966",
          "lan": lngAds ??
              context.read<LocationCubit>().position?.longitude.toString(),
          "lat": latAds ??
              context.read<LocationCubit>().position?.latitude.toString(),
          "experience_years": experienceId,
          "license_id": licenseId,
          "district": context.read<LocationCubit>().districtTextController.text,
          "services": serviceList,
          "sub_services": subServiceList,
          "interest_ids": interestsList,
          "files_array": pdfBase64List,
        }).then((value) async {
      log(value.data.toString());
      // CacheHelper.saveData(key: 'token', value: value.data['access_token']);
      CacheHelper.saveData(
          key: 'status', value: value.data['userProfile']['status']);
      accountType = CacheHelper.getData(key: 'status');
      //   token = CacheHelper.getData(key: 'token');
      //  debugPrint('<<<<<<<<<<<<<<<<<<<${token.toString()}>>>>>>>>>>>>>>>>>>>>');
      log('<<<<<<<<<<<<<<<<<<<${accountType.toString()}>>>>>>>>>>>>>>>>>>>>');
      emit(UpgradeProfileSuccessState());
      // RestartWidget.restartApp(context);
      // navigateAndRemove(SplashScreen());
      await Restart.restartApp()
          .then((value) => navigateAndRemove(SplashScreen()));
    }).catchError((error) {
      log(error.toString());
      emit(UpgradeProfileErrorState(error: error.toString()));
    });
  }

// providerSendOtpLogin({
//   required String phoneNumber,
// }) async {
//   emit(SendOtpLoginLoadingState());
//   DioHelper.postData(
//       url: BaseUrl.baseUrl + BaseUrl.login,
//       data: {"phone": "$phoneNumber","status":AppConstant.account_type}).then((value) {
//     debugPrint(value.data);
//
//     emit(SendOtpLoginSuccessState());
//     Get.to(() => VerificationScreen(phone: phoneNumber));
//     // response=value.statusCode.;
//   }).catchError((error) {
//     debugPrint(error.toString());
//     emit(SendOtpLoginErrorState(error: error.toString()));
//   });
// }
}
