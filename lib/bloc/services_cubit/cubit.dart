import 'dart:convert';
import 'dart:io';
//import 'package:aqarat_raqamia/bloc/region_cubit/cubit.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:aqarat_raqamia/bloc/location_cubit/cubit.dart';
import 'package:aqarat_raqamia/bloc/services_cubit/state.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../../model/dynamic_model/service_model.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/text_style.dart';
import '../../view/base/show_toast.dart';
import '../../view/screens/bottom_navigation/main_screen.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(InitialServicesState());



  List<File> selectedImagesFile = [];
  String? base64Images;
  bool isPickedProjectsImage = false;
  List<String> listBase64Images = [];

  pickImages() async {
    final List<XFile>? selectedFiles = await ImagePicker().pickMultiImage(
      imageQuality: 50,
      maxWidth: 1920,
      maxHeight: 1080,
    );
    //&& selectedFiles.length <= 5
    if (selectedFiles != null && selectedFiles.length<=5) {
     // List<File> selectedImage = [];
      List<String> selectedBase64Images = [];

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
        String base64String = base64Encode(result!);
        List<int> imageBytes = await savedImage.readAsBytesSync();
        base64Images = base64Encode(imageBytes);
        selectedImagesFile.add(savedImage);
        selectedBase64Images.add('data:image/jpeg;base64,$base64String');
        listBase64Images.add('data:image/jpeg;base64,$base64String');
      }
      emit(LoopImagesInListUploadRequestState());
      printLongString('>>>>>$base64Images................');
      print('<<<<<<<<<<<<<<<<<<$listBase64Images>>>>>>>>>>>>>>>>>>');
      print('<<<<<<<<<<<<<<<<<<<$selectedImagesFile>>>>>>>>>>>>>>>>>>>');
      isPickedProjectsImage = true;
      emit(AddPickedImagesInListUploadRequestState());
    }else{
      showCustomSnackBar(message:LocaleKeys.max5Images.tr(), state: ToastState.ERROR,
      );
    }
  }

  clearImage() {
    selectedImagesFile.clear();
    listBase64Images.clear();

    emit(ClearImageInUploadRequestState());
  }

  int? service;
  List subServicesList=[];
  onChangeCustomService(onChange,List? subServicesWidget){
    subService=null;
    subServicesList.clear();
    service=onChange;
    subServicesList=subServicesWidget!.where((element) => element.servicesId==onChange).toList();
    // print('<<<<<<<<<<<<<<${subServicesList[0]["name"]}>>>>>>>>>>>>>>');
    // print('<<<<<<subService<<<<<<<<<$service>>>>>>>>>>>>>>>');
    emit(OnchangeCustomServiceState());
  }

  int? subService;
  onChangeCustomSubService(onChange){
    subService=onChange;
    emit(OnchangeCustomSubServiceState());
    print('<<<<<<subService<<<<<<<<<$subService>>>>>>>>>>>>>>>');
  }


  late ServiceModel serviceModel;
  bool isGetServices = false;

  getServicesData({required int page}) {
    isGetServices = false;
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.GetServices, page: page,token: token)
        .then((value) {
      if (page == 1) {
        serviceModel = ServiceModel.fromJson(value.data);
      } else {
        serviceModel.meta?.currentPage =
            ServiceModel.fromJson(value.data).meta?.currentPage;
        serviceModel.meta?.lastPage =
            ServiceModel.fromJson(value.data).meta?.lastPage;
        serviceModel.meta?.total =
            ServiceModel.fromJson(value.data).meta?.total;
        serviceModel.meta?.perPage =
            ServiceModel.fromJson(value.data).meta?.perPage;
        serviceModel.data?.addAll(ServiceModel.fromJson(value.data).data ?? []);
      }
      emit(GetServicesSuccessState());
      isGetServices = true;
    }).catchError((error) {
      print(error.toString());
      emit(GetServicesErrorState(error: error.toString()));
    });
  }

  requestService(
      {required String serviceId,
      required String subServiceId,
      required BuildContext context,
      required String notes,
      int? providerId,
      }) async {
    emit(RequestServicesLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.RequestService,
        token: token,
        data: {
          "services_id": serviceId,
          "sub_services_id": subServiceId,
          "country": context.read<LocationCubit>().districtTextController.text,
          "locations": context.read<LocationCubit>().locationTextController.text,
          "lan":lngAds?? context.read<LocationCubit>().position?.longitude.toString(),
          "lat":latAds?? context.read<LocationCubit>().position?.latitude.toString(),
          "notes": notes,
          "photos": listBase64Images,
          "city_id":context.read<LocationCubit>().cityId??18,
          "notify_to":providerId,
          // "image1": '${image1}',
          // "image2": image2 == null ? null : '${image2}',
          // "image3": image3 == null ? null : '${image3}',
          // "image4": image4 == null ? null : '${image4}',
          // "image5": image5 == null ? null : '${image5}',
        },).then((value) {
      print(value.data);
      navigateForwardReplace(MainScreenNavigation());
      latAds=null;
      lngAds=null;
      showCustomSnackBar(
          message: LocaleKeys.requestServiceSuccess.tr(),
          state: ToastState.SUCCESS,
      );
      emit(RequestServicesSuccessState());
    }).catchError((error) {
      emit(RequestServicesErrorState(error: error.toString()));
      showCustomSnackBar(message: error.toString(), state: ToastState.ERROR);
    });
  }
}
