import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:aqarat_raqamia/utils/shared_pref.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:aqarat_raqamia/bloc/profile_cubit/state.dart';
import 'package:aqarat_raqamia/model/dynamic_model/profile_model.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:pdf/widgets.dart';
import 'package:restart_app/restart_app.dart';
import '../../model/dynamic_model/intestes_model.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/text_style.dart';
//import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import '../../view/base/lunch_widget.dart';
import '../../view/base/show_toast.dart';
import '../../view/restart_widget/restart_widget.dart';
import '../../view/screens/splash/splash_screen.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(InitialProfileState());

  static ProfileCubit get(context) => BlocProvider.of(context);
  late ProfileModel profileModel;
  late Map<String, dynamic> map;
  bool isGetProfileDate = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whatsappPhoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController visionController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController objectivesController = TextEditingController();
  List<int?> interestsProfile = [];

  initController() {
    nameController =
        TextEditingController(text: profileModel.userProfile?.name);
    phoneController =
        TextEditingController(text: profileModel.userProfile?.phone);
    emailController =
        TextEditingController(text: profileModel.userProfile?.email);
    whatsappPhoneController =
        TextEditingController(text: profileModel.userProfile?.whatsappNumber);
    visionController =
        TextEditingController(text: profileModel.userProfile?.visionary);
    valueController =
        TextEditingController(text: profileModel.userProfile?.value);
    noteController =
        TextEditingController(text: profileModel.userProfile?.notes);
    objectivesController =
        TextEditingController(text: profileModel.userProfile?.objectives);
  }

//  RegisterProviderCubit? registerProviderCubit;
  getProfileData() {
    isGetProfileDate = false;
    emit(GetProfileLoadingState());
    DioHelper.getData(
      url: BaseUrl.baseUrl + BaseUrl.getProfile,
      token: token,
    ).then((value) async {
      debugPrint('//////////////////////${value.data.toString()}');

      profileModel = ProfileModel.fromJson(value.data);
      map = value.data;
      debugPrint('//////////////////////${map.toString()}');

      CacheHelper.saveData(key: 'UserId', value: profileModel.userProfile?.id);
      CacheHelper.saveData(
          key: 'isSubscribed', value: profileModel.userProfile?.isSubscribed);
      isProviderSubscribed = CacheHelper.getData(key: 'isSubscribed');
      userId = CacheHelper.getData(key: 'UserId');
      debugPrint(profileModel.userProfile?.name);
      debugPrint(emailController.text.toString());
    //  generatePdf();
      await getInterests();
      emit(GetProfileSuccessState());
      debugPrint(
          '<<<<<<<<<<<<<<<<<<<<<<${userId.toString()}>>>>>>>>>>>>>>>>>>>>>>');
      debugPrint(
          '<<<<<<<<<<<<<<<<<<<<<<${isProviderSubscribed.toString()}>>>>>>>>>>>>>>>>>>>>>>');
      isGetProfileDate = true;
    }).catchError((error) {
      isGetProfileDate = true;
      debugPrint('<<<<<<<<<<<<<${error.toString()}>>>>>>>>>>>>>');
      emit(GetProfileErrorState(error: error.toString()));
    });
  }

  disposeController() {
    nameController.dispose();
    phoneController.dispose();
    whatsappPhoneController.dispose();
    emailController.dispose();
    visionController.dispose();
    valueController.dispose();
    noteController.dispose();
    objectivesController.dispose();
  }

  late InterestsModel interestsModel;

  getInterests() {
    emit(GetInterestsRegisterLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.GetInterests).then((val) {
      debugPrint(val.data.toString());
      interestsModel = InterestsModel.fromJson(val.data);
      emit(GetInterestsRegisterSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetInterestsRegisterErrorState(error: error.toString()));
    });
  }

  getProfileInterests() {
    profileModel.userProfile?.interests?.forEach((e) {
      interestsProfile.add(e.id);
      debugPrint(
          '<<<<<<<<<<<<<<<<<<<<<<$interestsProfile>>>>>>>>>>>>>>>>>>>>>>');
    });
    emit(state);
  }

  var file111;

  // Future<void> generatePdf() async {
  //   final pdf = pw.Document();
  //
  //   // Load the Arabic font
  //   final fontData = await rootBundle.load('font/Changa-Bold.ttf');
  //   final font = Font.ttf(fontData);
  //
  //   // Create a page with Arabic text
  //
  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) {
  //         return pw.Center(
  //           child: pw.Text(
  //             profileModel.userProfile?.name ?? '',
  //             style: pw.TextStyle(
  //               font: font,
  //               fontSize: 24,
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  //
  //   // Save the PDF to a file
  //   final directory = await getApplicationDocumentsDirectory();
  //   final file = File('${directory.path}/example.pdf');
  //
  //   // Save the PDF to the file
  //   file111 = await file.writeAsBytes(await pdf.save());
  // }



  ///

  //
  // Future<void> showPdf() async {
  //   // final file = File('data.pdf');
  //   // final pdfViewer = SfPdfViewer.file(file);
  //   // navigateForward(pdfViewer);
  //   // await Navigator.push(
  //   //   context,
  //   //   MaterialPageRoute(builder: (context) => pdfViewer),
  //   // );
  //   final directory = await getApplicationDocumentsDirectory();
  //   final file = File('${directory.path}/example.pdf');
  //  // await SfPdfViewer.openFile(file.path);
  //   navigateForward(SfPdfViewer.file(file));
  // }

  // Future<String> uploadPdfToStorage() async {
  //   final pdfFile = await generatePdf(); // Generate the PDF file
  //   final storageRef = FirebaseStorage.instance.ref();
  //   final pdfRef = storageRef.child('pdfs/data.pdf');
  //   await pdfRef.putFile(pdfFile);
  //   final downloadUrl = await pdfRef.getDownloadURL();
  //   print('??????????????????${downloadUrl}');
  //   return downloadUrl; // Return the download URL
  // }

  // Future<Uint8List> generatePdf() async {
  //   final pdf = pw.Document();
  //   pdf.addPage(
  //     pw.Page(
  //       build: (context) {
  //         return pw.Column(
  //           children: [
  //             pw.Text('Hello, World!'),
  //             pw.SizedBox(height: 20),
  //             pw.Text('This is a sample PDF document.'),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  //   return await pdf.save();
  // }
  onUpdateInterestsProfile(List<int?> onChange) {
    interestsProfile = onChange;
    emit(state);
    print('///////////////////${interestsProfile}');
  }

  File? file;
  bool isPickImage = false;
  String? base64Image;

  ///PickImageCamera
  Future pickImageFromCamera() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 1920,
      maxHeight: 1080,
    );
    file = (File(pickedFile!.path));
    List<int> imageBytes = file!.readAsBytesSync();
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
    base64Image = base64Encode(result!);
    print('IMAGE IS $base64Image');
    print('IMAGE IS $file');
    emit(PickImageFromCameraState());
    isPickImage = true;
    print('afasdasdasds$isPickImage');
  }

  ///PickImageGallery
  Future pickImageFromGallery() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 1920,
      maxHeight: 1080,
    );
    file = (File(pickedFile!.path));
    List<int> imageBytes = file!.readAsBytesSync();
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
    base64Image = base64Encode(result!);
    print('IMAGE IS $base64Image');
    print('IMAGE IS $file');
    emit(PickImageFromGalleryState());
    isPickImage = true;
    print('afasdasdasds$isPickImage');
  }

  updateUserProfile(
      {required String phone, required String name, String? email}) async {
    emit(UpdateProfileLoadingState());
    // String url = BaseUrl.baseUrl + BaseUrl.updateProfile;
    // emit(UpdateProfileLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.updateProfile,
        token: token,
        data: {
          "name": name,
          "phone": phone,
          "country_code": "966",
          "email": email,
          "file": isPickImage ? 'data:image/jpeg;base64,$base64Image' : null,
          "interest_ids": interestsProfile
        }).then((value) {
      //  try{
      print(value.data);
      print(value.statusCode);
      profileModel = ProfileModel.fromJson(value.data);
      emit(UpdateProfileSuccessState());
      showCustomSnackBar(
        message: LocaleKeys.profileUpdatedSuccess.tr(),
        state: ToastState.SUCCESS,
        // isError: false,
        // title: 'تحديث البيانات'
      );
      getProfileData();
    }).catchError((error) {
      print(error.toString());
      //  print(value.statusMessage);
      emit(UpdateProfileErrorState(
        error: error.toString(),
        //  statusCode: value.statusCode!
      ));
    });
  }

  deleteProfile(BuildContext context) {
    emit(DeleteProfileLoadingState());
    DioHelper.postData(
            url: BaseUrl.baseUrl + BaseUrl.deleteAccount, token: token)
        .then((value) async {
      await CacheHelper.removeData();
      token = null;
      accountType = null;
      await CacheHelper.sharedPreferences.clear();
      debugPrint(value.data.toString());
      await Restart.restartApp()
          .then((value) => navigateAndRemove(SplashScreen()));
      // RestartWidget.restartApp(context);
      // navigateAndRemove(SplashScreen());
      emit(DeleteProfileSuccessState());
      print('<<<<<<<<<<<<<)${token}>>>>>>>>>>>>>>>>');
    }).catchError((error) {
      print(error.toString());
      emit(DeleteProfileErrorState(error: error.toString()));
    });
  }

  /// PICK Achievements
  List<File> selectedAchievementsPdf = [];
  String? base64AchievementsPdf;
  bool isPickedAchievementsPdf = false;
  List<String> achievementsPdf = [];
  List<String> pdfAchievementsName = [];
  List<String> pdfBase64ListAchievements = [];

  List<String> convertedAchievements = [];
  List<String> notAddPathUrlAchievementsPdf = [];
  String? pdfFileAchievements;

  // pickAchievementsPdf() async {
  //   final List<XFile>? selectedFiles = await ImagePicker().pickMultiImage(
  //     imageQuality: 50,
  //     maxWidth: 1920,
  //     maxHeight: 1080,
  //   );
  //   //&& selectedFiles.length <= 5
  //   if (selectedFiles != null) {
  //     List<File> selectedImage = [];
  //     List<String> selectedBase64pdf = [];
  //
  //     for (var imageFile in selectedFiles) {
  //       final image = File(imageFile.path);
  //
  //       final appDir = await getApplicationDocumentsDirectory();
  //       final fileName = basename(image.path);
  //
  //       final savedImage = await image.copy('${appDir.path}/$fileName');
  //
  //       var result = await FlutterImageCompress.compressWithFile(
  //         savedImage.absolute.path,
  //         minWidth: 1920,
  //         minHeight: 1080,
  //         quality: 50,
  //
  //         //  rotate: 90,
  //       );
  //
  //       //List<int> imageBytesss = await result;
  //       String base64String = base64Encode(result!);
  //       //  final savedImage = await image.copy('/$fileName');
  //       //  List<int> Image64=await image.readAsBytes();
  //       // List<int> imageBytes = await savedImage.readAsBytesSync();
  //       List<int> imageBytes = await savedImage.readAsBytesSync();
  //       base64AchievementsPdf = base64Encode(imageBytes);
  //       //  selectedImage.add(savedImage);
  //       //  images.add(image.path);
  //       selectedAchievementsPdf.add(savedImage);
  //       // selectedBase64Images.add(base64Image!);
  //       selectedBase64pdf.add('data:image/jpeg;base64,$base64String');
  //
  //       // selectedBase64Images.add(base64Image!);
  //
  //       // images.add();
  //       achievementsPdf.add('data:image/jpeg;base64,$base64String');
  //
  //       // printLongString('////####${selectedFiles[0].path}');
  //       // printLongString(base64Image);
  //
  //       // print('///////////////////');
  //       //  printLongString(base64Image!);
  //       // selectedBase64Images.add(base64Image!);
  //       // print('vbvvvvvvvvvv$base64Image');
  //     }
  //     emit(LoopAchievementsImagesInListUpdateProfileState());
  //     // images.addAll(selectedBase64Images);
  //     // update();
  //     //  printLongString('////////////////////${images.toString()}');
  //
  //     ///  setState(() {
  //     printLongString('>>>>>$base64AchievementsPdf................');
  //     print('//////////>>>>>>>>>>>>${achievementsPdf.length}');
  //     print('//////////>>>>>>>>>>>>${achievementsPdf}');
  //     isPickedAchievementsPdf = true;
  //     emit(AddPickedAchievementsImagesInListUpdateProfileState());
  //   }
  // }

  Future<void> pickAchievementsPdf() async {
    try {
      // Pick PDF files
      FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      // Check if files were picked
      if (filePickerResult == null || filePickerResult.files.isEmpty) {
        showCustomSnackBar(
          message: LocaleKeys.attachFile.tr(),
          state: ToastState.ERROR,
        );
        return;
      }

      // Limit the number of files to 3
      if (filePickerResult.files.length > 3) {
        showCustomSnackBar(
          message: 'You can only select up to 3 files.',
          state: ToastState.ERROR,
        );
        return;
      }

      // Clear previous selections
      //  selectedBase64Achievements.clear();
      //   pdfAchievementsName.clear();
      //   selectedAchievementsPdf.clear();
      //   notAddPathUrlAchievementsPdf.clear();
      //   convertedAchievements.clear();
      //   pdfBase64ListAchievements.clear();

      // Process each file
      for (var file in filePickerResult.files) {
        if (file.path == null) continue;

        final pdfFile = File(file.path!);

        // Check file size (2 MB limit)
        final fileSize = await pdfFile.length();
        if (fileSize > 2 * 1024 * 1024) {
          showCustomSnackBar(
            message: '${LocaleKeys.fileIsBig.tr()}',
            state: ToastState.ERROR,
          );
          continue;
        }

        // Get file name
        final fileName = basename(pdfFile.path);
        pdfAchievementsName.add(fileName);
        debugPrint('<<<<<<<<<<<<<${fileName.toString()}>>>>>>>>>>>>>');

        // Save file to app directory
        final appDir = await getApplicationDocumentsDirectory();
        final savedFile = await pdfFile.copy('${appDir.path}/$fileName');
        selectedAchievementsPdf.add(savedFile);

        // Read file as bytes and encode to Base64
        final fileBytes = await savedFile.readAsBytes();
        final base64String = base64Encode(fileBytes);

        // Add Base64 string to lists
        notAddPathUrlAchievementsPdf.add(base64String);
        //  selectedBase64Achievements.add('data:application/pdf;base64,$base64String');
        convertedAchievements.add(base64String);
        pdfBase64ListAchievements
            .add('data:application/pdf;base64,$base64String');
      }

      // Emit state update
      emit(AddPickedProjectsImagesInListUpdateProfileState());

      // Debug logs
      debugPrint('Selected files: ${selectedAchievementsPdf.length}');
      debugPrint('Base64 list: ${pdfBase64ListAchievements.length}');
      debugPrint('First file path: ${selectedAchievementsPdf.first.path}');
      debugPrint('First Base64 string: ${pdfBase64ListAchievements.first}');
    } catch (e) {
      // Handle errors
      debugPrint('Error picking PDF files: $e');
      showCustomSnackBar(
        message: 'An error occurred while picking files.',
        state: ToastState.ERROR,
      );
    } finally {
      // Update state
      isPickedAchievementsPdf = true;
      emit(AddPickedProjectsImagesInListUpdateProfileState());
    }
  }

  Future<void> networkAchievementsToBase64(List<String> photos) async {
    try {
      // Clear previous data
      convertedAchievements.clear();
      pdfBase64ListAchievements.clear();
      //  notAddPathUrlAchievementsPdf.clear();

      // Process each photo URL
      for (String imageUrl in photos) {
        try {
          // Fetch the file from the network
          http.Response response = await http.get(Uri.parse(imageUrl));

          // Check if the request was successful
          if (response.statusCode != 200) {
            debugPrint(
                'Failed to fetch file: $imageUrl (Status: ${response.statusCode})');
            continue;
          }

          // Get the file bytes
          final bytes = response.bodyBytes;

          // Encode to Base64
          final base64String = base64Encode(bytes);

          // Add to lists
          notAddPathUrlAchievementsPdf.add(base64String);
          pdfBase64ListAchievements
              .add('data:application/pdf;base64,$base64String');
          convertedAchievements.add(base64String);

          // Debug logs
          debugPrint('Base64 encoded: $base64String');
        } catch (e) {
          // Handle errors for individual files
          debugPrint('Error processing file: $imageUrl - $e');
        }
      }

      // Emit state update after processing all files
      emit(ConvertedAdListImagesState());

      // Debug logs
      debugPrint('Total files processed: ${convertedAchievements.length}');
      debugPrint('PDF Base64 list: ${pdfBase64ListAchievements.length}');
    } catch (e) {
      // Handle global errors
      debugPrint('Error in networkAchievementsToBase64: $e');
      showCustomSnackBar(
        message: 'An error occurred while processing files.',
        state: ToastState.ERROR,
      );
    }
  }

  deleteAchievements(int index) {
    pdfBase64ListAchievements.removeAt(index);
    convertedAchievements.removeAt(index);
    notAddPathUrlAchievementsPdf.removeAt(index);
    if (pdfBase64ListAchievements.isEmpty) {
      pdfBase64ListAchievements = [''];
    }
    emit(DeleteAchievementsIndexState());
  }

  clearPickAchievementsImage() {
    selectedAchievementsPdf.clear();
    achievementsPdf.clear();
    notAddPathUrlAchievementsPdf.clear();
    emit(ClearImageInPickAchievementsState());
  }

  /// PICK PROJECTS
  // List<File> selectedProjectsImages = [];
  List<File> selectedProjectsFilePdf = [];
  String? base64ProjectsImages;
  bool isPickProjectsPdf = false;

  // bool isPickedProjectsImage = false;
  List<String> projectsImages = [];
  List<String> pdfProjectsName = [];
  List<String> pdfBase64List = [];
  List<String> convertedProjects = [];
  List<String> notAddPathUrlProjectsPdf = [];
  String? pdfFile;

  // pickProjectsImages() async {
  //   final List<XFile>? selectedFiles = await ImagePicker().pickMultiImage(
  //     imageQuality: 50,
  //     maxWidth: 1920,
  //     maxHeight: 1080,
  //   );
  //   //&& selectedFiles.length <= 5
  //   if (selectedFiles != null) {
  //     List<File> selectedImage = [];
  //     List<String> selectedBase64Images = [];
  //
  //     for (var imageFile in selectedFiles) {
  //       final image = File(imageFile.path);
  //
  //       final appDir = await getApplicationDocumentsDirectory();
  //       final fileName = basename(image.path);
  //
  //       final savedImage = await image.copy('${appDir.path}/$fileName');
  //
  //       var result = await FlutterImageCompress.compressWithFile(
  //         savedImage.absolute.path,
  //         minWidth: 1920,
  //         minHeight: 1080,
  //         quality: 50,
  //       );
  //       String base64String = base64Encode(result!);
  //       List<int> imageBytes = await savedImage.readAsBytesSync();
  //       base64ProjectsImages = base64Encode(imageBytes);
  //       selectedProjectsImages.add(savedImage);
  //       selectedBase64Images.add('data:image/jpeg;base64,$base64String');
  //       projectsImages.add('data:image/jpeg;base64,$base64String');
  //     }
  //     emit(LoopProjectsImagesInListUpdateProfileState());
  //     printLongString('>>>>>$base64ProjectsImages................');
  //     print('<<<<<<<<<<<<<<<<<<$projectsImages>>>>>>>>>>>>>>>>>>');
  //     print('<<<<<<<<<<<<<<<<<<<$selectedProjectsImages>>>>>>>>>>>>>>>>>>>');
  //     isPickedProjectsImage = true;
  //     emit(AddPickedProjectsImagesInListUpdateProfileState());
  //   }
  // }

  Future<void> pickProjectsPdf() async {
    try {
      // Pick PDF files
      print('<<<<<<<<${notAddPathUrlProjectsPdf.length}>>>>>>>>');
      FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      // Check if files were picked
      if (filePickerResult == null || filePickerResult.files.isEmpty) {
        showCustomSnackBar(
          message: LocaleKeys.attachFile.tr(),
          state: ToastState.ERROR,
        );
        return;
      }

      // Limit the number of files to 3
      if (filePickerResult.files.length > 3) {
        showCustomSnackBar(
          message: 'You can only select up to 3 files.',
          state: ToastState.ERROR,
        );
        return;
      }

      // Clear previous selections
      // selectedBase64Images.clear();
      //   pdfProjectsName.clear();
      //   selectedProjectsFilePdf.clear();
      //  notAddPathUrlProjectsPdf.clear();
      //   convertedProjects.clear();
      //   pdfBase64List.clear();

      // Process each file
      for (var file in filePickerResult.files) {
        if (file.path == null) continue;

        final pdfFile = File(file.path!);

        // Check file size (2 MB limit)
        final fileSize = await pdfFile.length();
        if (fileSize > 2 * 1024 * 1024) {
          showCustomSnackBar(
            message: '${LocaleKeys.fileIsBig.tr()}',
            state: ToastState.ERROR,
          );
          continue;
        }

        // Get file name
        final fileName = basename(pdfFile.path);
        pdfProjectsName.add(fileName);
        debugPrint('<<<<<<<<<<<<<${fileName.toString()}>>>>>>>>>>>>>');

        // Save file to app directory
        final appDir = await getApplicationDocumentsDirectory();
        final savedFile = await pdfFile.copy('${appDir.path}/$fileName');
        selectedProjectsFilePdf.add(savedFile);

        // Read file as bytes and encode to Base64
        final fileBytes = await savedFile.readAsBytes();
        final base64String = base64Encode(fileBytes);

        // Add Base64 string to lists
        notAddPathUrlProjectsPdf.add(base64String);
        //selectedBase64Images.add('data:application/pdf;base64,$base64String');
        convertedProjects.add(base64String);
        pdfBase64List.add('data:application/pdf;base64,$base64String');
      }

      // Emit state update
      emit(AddPickedProjectsImagesInListUpdateProfileState());

      // Debug logs
      debugPrint('Selected files: ${selectedProjectsFilePdf.length}');
      debugPrint('Base64 list: ${pdfBase64List.length}');
      debugPrint('First file path: ${selectedProjectsFilePdf.first.path}');
      debugPrint('First Base64 string: ${pdfBase64List.first}');
      debugPrint('///////////////////////////////////////////////');
    } catch (e) {
      // Handle errors
      debugPrint('Error picking PDF files: $e');
      showCustomSnackBar(
        message: 'An error occurred while picking files.',
        state: ToastState.ERROR,
      );
    } finally {
      // Update state
      isPickProjectsPdf = true;
      emit(AddPickedProjectsImagesInListUpdateProfileState());
    }
  }

  Future<void> networkProjectsToBase64(List<String> photos) async {
    convertedProjects.clear();
    pdfBase64List.clear();
    //  notAddPathUrlProjectsPdf.clear();

    // Use Future.wait to process images concurrently
    final futures = photos.map((imageFile) async {
      try {
        http.Response response = await http.get(Uri.parse(imageFile));
        if (response.statusCode == 200) {
          final bytes = response.bodyBytes;
          final base64String = base64Encode(bytes);

          // Add to lists
          convertedProjects.add(base64String);
          notAddPathUrlProjectsPdf.add(base64String);
          pdfBase64List.add('data:application/pdf;base64,$base64String');

          // Check if we have processed all images
          if (convertedProjects.length == photos.length) {
            return true; // Break early
          }
        }
      } catch (e) {
        print('Error fetching or converting image: $e');
      }
      return false;
    }).toList();

    // Wait for all futures to complete
    final results = await Future.wait(futures);

    // Emit state only once after all images are processed
    emit(ConvertedAdListImagesState());
  }

  deleteProjectsIndex(int index) {
    pdfBase64List.removeAt(index);
    convertedProjects.removeAt(index);
    notAddPathUrlProjectsPdf.removeAt(index);
    print(pdfBase64List.length);
    if (pdfBase64List.isEmpty) {
      pdfBase64List = [''];
    }
    emit(RemoveAchievementsFromListState());
  }

  clearProjectsImage() {
    selectedProjectsFilePdf.clear();
    projectsImages.clear();
    notAddPathUrlProjectsPdf.clear();

    emit(ClearImageInProjectsState());
  }

  /// PICK ALBUMIMAGES
  List<File> selectedAlbumImages = [];
  String? base64AlbumImages;
  bool isPickedAlbumImage = false;
  List<String> albumImages = [];

  List<String> convertedAlbumImages = [];

  Future<void> networkAlbumImagesToBase64(List photos) async {
    convertedAlbumImages.clear();
    albumImages.clear();
    for (String imageFile in photos) {
      List<String> selectedImages = [];
      http.Response response = await http.get(Uri.parse(imageFile));
      final bytes = response.bodyBytes;
      print('//////////////////${base64Encode(bytes)}');
      albumImages.add('data:image/jpeg;base64,${base64Encode(bytes)}');
      print(albumImages);
      print(
          "<<<<<<<<<convertedProjects.length<<<${albumImages.length}>>>>>>>>>>>>>>");
      print(
          "<<<<<<<<<convertedProjects.length<<<${convertedAlbumImages.length}>>>>>>>>>>>>>>");
      selectedImages.add(base64Encode(bytes));
      convertedAlbumImages.addAll(selectedImages);
      emit(ConvertedAdListImagesState());
    }
  }

  deleteAlbumsIndex(int index) {
    convertedAlbumImages.removeAt(index);
    albumImages.removeAt(index);
    print(albumImages.length);
    if (albumImages.isEmpty) {
      albumImages = [''];
    }
    emit(RemoveAlbumFromListState());
  }

  pickAlbumImages() async {
    final List<XFile>? selectedFiles = await ImagePicker().pickMultiImage(
      imageQuality: 50,
      maxWidth: 1920,
      maxHeight: 1080,
    );
    //&& selectedFiles.length <= 5
    if (selectedFiles != null) {
      List<File> selectedImage = [];
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
        base64AlbumImages = base64Encode(imageBytes);
        selectedAlbumImages.add(savedImage);
        selectedBase64Images.add('data:image/jpeg;base64,$base64String');
        convertedAlbumImages.add('$base64String');
        //  convertedImages.add('data:image/jpeg;base64,$base64String');
        albumImages.add('data:image/jpeg;base64,$base64String');
      }
      emit(LoopAlbumImagesInListUpdateProfileState());
      printLongString(
          '>>>>>>>>>>>>>>>>>${selectedAlbumImages.length}>>>>>>>>>>>>>>>>>>>>$base64AlbumImages................');

      printLongString('>>>>>$base64AlbumImages................');
      print('<<<<<<<<<<<<<<<<<<$albumImages>>>>>>>>>>>>>>>>>>');
      print('<<<<<<<<<<<<<<<<<<<$selectedAlbumImages>>>>>>>>>>>>>>>>>>>');
      // print('//////////>>>>>>>>>>>>${achievementsImages.length}');
      // print('//////////>>>>>>>>>>>>${achievementsImages}');
      isPickedAlbumImage = true;
      emit(AddPickedAlbumImagesInListUpdateProfileState());
    }
  }

  clearAlbumImage() {
    selectedAlbumImages.clear();
    albumImages.clear();

    emit(ClearImageInAlbumImagesState());
  }

  Future updateProviderProfile() async {
    emit(UpdateProfileLoadingState());
    print(
        '<<<<<pdfBase64List<<<<Projects<<<<<<<<<${pdfBase64List.length}>>>>>>>>>>>>>>>>>>');
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.updateProfile,
        token: token,
        data: {
          "file": isPickImage ? 'data:image/jpeg;base64,$base64Image' : null,
          "name": nameController.text,
          "phone": phoneController.text,
          "country_code": '966',
          "email": emailController.text,
          "whatsapp_number": whatsappPhoneController.text,
          "visionary": visionController.text,
          "objectives": objectivesController.text,
          "notes": noteController.text,
          "value": valueController.text,
          "projects": pdfBase64List.isEmpty || pdfBase64List.length == 0
              ? "Nothing"
              : pdfBase64List,
          "achievements": pdfBase64ListAchievements.isEmpty ||
                  pdfBase64ListAchievements.length == 0
              ? "Nothing"
              : pdfBase64ListAchievements,
          "images": albumImages.isEmpty || albumImages.length == 0
              ? "Nothing"
              : albumImages,
        }).then((value) {
      print(value.toString());
      emit(UpdateProfileSuccessState());
      isPickImage = false;
      clearPickAchievementsImage();
      clearProjectsImage();
      clearAlbumImage();
      getProfileData();
    }).catchError((error) {
      print(error.toString());
      clearPickAchievementsImage();
      clearProjectsImage();
      clearAlbumImage();
      isPickImage = false;
      emit(UpdateProfileErrorState(error: error.toString()));
    });
  }

  getServiceList() {
    for (int i = 0; i < profileModel.userProfile!.services!.length; i++) {
      print(profileModel.userProfile!.services![i].name);
      List.generate(
          profileModel.userProfile!.services!.length,
          (index) =>
              print('${profileModel.userProfile!.services![index].name!}-'));
    }
  }

// List<String> convertedImages = [];
// List<String> uploadedImages = [];
//
// Future<void> networkImageToAchievements(List photos) async {
//   for (String imageFile in photos) {
//     List<String> selectedImages = [];
//     http.Response response = await http.get(Uri.parse(imageFile));
//     final bytes = response.bodyBytes;
//     print('//////////////////${base64Encode(bytes)}');
//     uploadedImages.add('data:image/pdf;base64,${base64Encode(bytes)}');
//     print(uploadedImages);
//     print(uploadedImages.length);
//     selectedImages.add(base64Encode(bytes));
//     convertedImages.addAll(selectedImages);
//     emit(ConvertedAdListImagesState());
//   }
// }
}
