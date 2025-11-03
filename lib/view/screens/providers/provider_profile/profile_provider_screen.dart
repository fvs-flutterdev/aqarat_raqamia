import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../../../../bloc/profile_cubit/cubit.dart';
import '../../../../../bloc/profile_cubit/state.dart';
import '../../../../../utils/media_query_value.dart';
import '../../../../../view/base/adaptive_dialog_loader.dart';
import '../../../../../view/screens/providers/provider_profile/widget/picked_image_with_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/images.dart';
import '../../../../utils/text_style.dart';
import '../../../base/bottom_sheet.dart';
import '../../../base/custom_text_field.dart';
import '../../../base/main_button.dart';
import '../../../base/profile_header.dart';
import '../../../base/row_widget_image.dart';
import '../../../base/shimmer/profile_shimmer.dart';
import '../../profile/pdf_viewer/pdf_viwer.dart';
import 'widget/gallery_image_widget.dart';

class ProfileProviderScreen extends StatefulWidget {
  const ProfileProviderScreen({super.key});

  @override
  State<ProfileProviderScreen> createState() => _ProfileProviderScreenState();
}

class _ProfileProviderScreenState extends State<ProfileProviderScreen> {
  @override
  void initState() {

    super.initState();
    context.read<ProfileCubit>().getProfileInterests();
    context.read<ProfileCubit>().initController();
    // profileCubit?.getProfileInterests();
  }
  @override
  void deactivate() {
    context.read<ProfileCubit>().interestsProfile.clear();
    context.read<ProfileCubit>().disposeController();
    super.deactivate();
  }
  @override
  void dispose() {
    bottomSheetController?.close;

    //  context.read<ProfileCubit>().getProfileInterests();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var profileCubit = context.read<ProfileCubit>();
    return Scaffold(
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is DeleteProfileLoadingState ||
              State is UpdateProfileLoadingState) {
            adaptiveDialogLoader(context: context);
          }
          if (state is DeleteProfileErrorState ||
              state is UpdateProfileErrorState) {
            Navigator.pop(context);
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return profileCubit.isGetProfileDate == false
              ? ProfileShimmer()
              : GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  child: Column(
                    children: [
                      ProfileHeader(
                        isProvider: true,
                        isVerified:
                            profileCubit.profileModel.userProfile?.statusUser ==
                                    'active'
                                ? true
                                : false,
                        name: profileCubit.profileModel.userProfile?.name ?? '',
                        rate: profileCubit.profileModel.userProfile?.rate,
                        rateNo: profileCubit.profileModel.userProfile?.noRate
                            .toString(),
                        pickCamera: () {
                          profileCubit
                              .pickImageFromCamera()
                              .then((value) => Navigator.pop(context));
                        },
                        pickGallery: () {
                          profileCubit
                              .pickImageFromGallery()
                              .then((value) => Navigator.pop(context));
                        },
                        image: profileCubit.isPickImage
                            ? Image.file(profileCubit.file!)
                            : Image.network(
                                profileCubit.profileModel.userProfile?.photo ??
                                    '',
                              ),
                      ),
                      profileCubit.profileModel.userProfile?.statusUser ==
                              'active'
                          ? const SizedBox()
                          : Text(
                              LocaleKeys.accountNotActive.tr(),
                              style: openSansRegular.copyWith(color: redColor),
                            ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 30.sp,
                                ),
                                // TextButton(
                                //   onPressed: () async {
                                //     navigateForward(PdfViewer(
                                //       pdfBytes: await profileCubit.file111
                                //           .readAsBytes(),
                                //     ));
                                //     // profileCubit.showPdf();
                                //   },
                                //   child: Text(
                                //     'الملف الشخصي',
                                //     style: openSansBold.copyWith(
                                //         color: darkGreysColor),
                                //   ),
                                // ),
                                //     TextButton(onPressed: () { generatePDFs(profileCubit.map); }, child: Text('مشاركه'),),
                                CustomTextField(
                                  labelText: LocaleKeys.name.tr(),
                                  controller: profileCubit.nameController,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        labelText: LocaleKeys.phone.tr(),
                                        maxHeight: context.width * 0.2.sp,
                                        minHeight: context.width * 0.15.sp,
                                        controller:
                                            profileCubit.phoneController,
                                        length: 9,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: Dimensions.PADDING_SIZE_DEFAULT,
                                    ),
                                    const FlagTextField(),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        labelText:
                                            LocaleKeys.whatsappNumber.tr(),
                                        controller: profileCubit
                                            .whatsappPhoneController,
                                        maxHeight: context.width * 0.2.sp,
                                        minHeight: context.width * 0.15.sp,
                                        length: 9,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: Dimensions.PADDING_SIZE_DEFAULT,
                                    ),
                                    const FlagTextField(),
                                  ],
                                ),
                                CustomTextField(
                                  labelText: LocaleKeys.email.tr(),
                                  controller: profileCubit.emailController,
                                  maxHeight: context.width * 0.2.sp,
                                  minHeight: context.width * 0.15.sp,
                                  // length: 9,
                                ),
                                CustomTextField(
                                  labelText: LocaleKeys.notesAboutYou.tr(),
                                  isBig: true,
                                  lines: 5,
                                  controller: profileCubit.noteController,
                                  maxHeight: context.width * 0.39.sp,
                                  minHeight: context.width * 0.39.sp,
                                ),
                                CustomTextField(
                                  labelText: LocaleKeys.vision.tr(),
                                  isBig: true,
                                  lines: 5,
                                  controller: profileCubit.visionController,
                                  maxHeight: context.width * 0.39.sp,
                                  minHeight: context.width * 0.39.sp,
                                ),
                                CustomTextField(
                                  labelText: LocaleKeys.value.tr(),
                                  isBig: true,
                                  controller: profileCubit.valueController,
                                  lines: 5,
                                  maxHeight: context.width * 0.39.sp,
                                  minHeight: context.width * 0.39.sp,
                                ),
                                CustomTextField(
                                  labelText: LocaleKeys.Objectives.tr(),
                                  isBig: true,
                                  controller: profileCubit.objectivesController,
                                  lines: 5,
                                  maxHeight: context.width * 0.39.sp,
                                  minHeight: context.width * 0.39.sp,
                                ),
                                MultiSelectDialogField(
                                  // listType: MultiSelectListType.CHIP,

                                  title: Text(
                                    LocaleKeys.interests.tr(),
                                    style:
                                    openSansBold.copyWith(color: darkGreyColor),
                                  ),
                                  buttonText: Text(
                                    LocaleKeys.interests.tr(),
                                    style:
                                    openSansMedium.copyWith(color: darkGreyColor),
                                  ),
                                  searchTextStyle:
                                  openSansMedium.copyWith(color: darkGreyColor),
                                  searchable: true,
                                  searchHintStyle:
                                  openSansMedium.copyWith(color: darkGreyColor),
                                  searchHint: LocaleKeys.search.tr(),
                                  selectedItemsTextStyle:
                                  openSansMedium.copyWith(color: darkGreyColor),
                                  unselectedColor: darkGreyColor,
                                  buttonIcon: Icon(
                                    Icons.arrow_drop_down_outlined,
                                    color: darkGreyColor,
                                  ),
                                  selectedColor: goldColor.withOpacity(0.1),
                                  checkColor: goldColor,
                                  itemsTextStyle: openSansRegular,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: whiteGreyColor),
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.RADIUS_DEFAULT)),
                                  initialValue: profileCubit.interestsProfile,

                                  items: profileCubit.interestsModel.data!.map((e) {
                                    return MultiSelectItem(e.id, e.name ?? '');
                                  }).toList(),
                                  //     registerProviderCubit.mainServices.map((e) {
                                  //   return MultiSelectItem(e['name'], e['name']);
                                  // }).toList(),
                                  onConfirm: (val) {
                                    debugPrint('################${val.toString()}');
                                    profileCubit.onUpdateInterestsProfile(val);
                                    //   registerProviderCubit.getSubServicesById();
                                    // print(
                                    //     '${registerProviderCubit.interestsList} ///////////////////////////////////');
                                  },
                                ),
                                BlocConsumer<ProfileCubit, ProfileState>(
                                  listener: (context, state) {
                                    // TODO: implement listener
                                  },
                                  builder: (context, state) {
                                    return RowWidgetImage(
                                      isPdfFile: true,
                                      isProviderProfile: true,
                                      list: profileCubit
                                          .profileModel.userProfile!.projects!,
                                      title: LocaleKeys.projects.tr(),
                                      isListEmpty: profileCubit
                                          .selectedProjectsFilePdf.isEmpty,
                                      clearFun: () =>
                                          profileCubit.clearProjectsImage(),
                                    );
                                  },
                                ),
                                profileCubit.profileModel.userProfile!.projects!
                                        .isEmpty
                                    ? PickedImageWithDialog(
                                  index: 1,
                                  listString: profileCubit.profileModel.userProfile!.projects!,
                                  isPdfFile: true,
                                        title: LocaleKeys.attachProjects.tr(),
                                        clearImagesFunction: () =>
                                            profileCubit.clearProjectsImage(),
                                        updateFunction: () => profileCubit
                                            .updateProviderProfile()
                                            .then((value) =>
                                                Navigator.pop(context)),
                                        pickedFileImage:
                                            profileCubit.selectedProjectsFilePdf,
                                        pickImagesFunction: () =>
                                            profileCubit.pickProjectsPdf(),
                                      )
                                    : Container(
                                        child: Row(
                                          children: [
                                            FirstImageInProviderProfile(
                                              isPdfFile: true,
                                              imageUrl: profileCubit
                                                  .profileModel
                                                  .userProfile!
                                                  .projects!,
                                            ),
                                            PickedImageWithDialog(
                                              isPdfFile: true,
                                              title: LocaleKeys.attachProjects
                                                  .tr(),
                                              clearImagesFunction: () =>
                                                  profileCubit
                                                      .clearProjectsImage(),
                                              updateFunction: () => profileCubit
                                                  .updateProviderProfile()
                                                  .then((value) =>
                                                      Navigator.pop(context)),
                                              pickedFileImage: profileCubit
                                                  .selectedProjectsFilePdf,
                                              index: 1,
                                              pickImagesFunction: () =>
                                                  profileCubit
                                                      .pickProjectsPdf(), listString: profileCubit.profileModel.userProfile!.projects!,
                                            )
                                          ],
                                        ),
                                      ),
                                SizedBox(
                                  height: 10.sp,
                                ),

                                ///
                                BlocConsumer<ProfileCubit, ProfileState>(
                                  listener: (context, state) {
                                    // TODO: implement listener
                                  },
                                  builder: (context, state) {
                                    return RowWidgetImage(
                                      isPdfFile: true,
                                      isProviderProfile: true,
                                      // images: ,
                                      list: profileCubit.profileModel
                                          .userProfile!.achievements!,
                                      title: LocaleKeys.achievements.tr(),
                                      // isListEmpty: profileCubit
                                      //     .selectedAchievementsImages.isEmpty,
                                      isListEmpty: profileCubit.selectedAchievementsPdf.isEmpty,
                                      clearFun: () => profileCubit
                                          .clearPickAchievementsImage(),
                                    );
                                  },
                                ),
                                profileCubit.profileModel.userProfile!
                                        .achievements!.isEmpty
                                    ? PickedImageWithDialog(
                                  isPdfFile: true,
                                        title:
                                            LocaleKeys.attachAchievements.tr(),
                                        clearImagesFunction: () => profileCubit
                                            .clearPickAchievementsImage(),
                                        updateFunction: () => profileCubit
                                            .updateProviderProfile()
                                            .then((value) =>
                                                Navigator.pop(context)),
                                    pickedFileImage:profileCubit.selectedAchievementsPdf,
                                        // pickedFileImage: profileCubit
                                        //     .selectedAchievementsImages,
                                        pickImagesFunction: () =>
                                            profileCubit.pickAchievementsPdf(),
                                  index: 0,
                                  listString: profileCubit.profileModel.userProfile!.achievements!,
                                      )
                                    : Container(
                                        child: Row(
                                          children: [
                                            FirstImageInProviderProfile(
                                              isPdfFile: true,
                                              imageUrl: profileCubit
                                                  .profileModel
                                                  .userProfile!
                                                  .achievements!,
                                            ),
                                            PickedImageWithDialog(
                                              index: 0,
                                              listString:profileCubit.profileModel.userProfile!.achievements!,
                                              isPdfFile: true,
                                              title: LocaleKeys
                                                  .attachAchievements
                                                  .tr(),
                                              clearImagesFunction: () =>
                                                  profileCubit
                                                      .clearPickAchievementsImage(),
                                              updateFunction: () => profileCubit
                                                  .updateProviderProfile()
                                                  .then((value) =>
                                                      Navigator.pop(context)),
                                              // pickedFileImage: profileCubit
                                              //     .selectedAchievementsImages,
                                              pickedFileImage: profileCubit.selectedAchievementsPdf,
                                              pickImagesFunction: () =>
                                                  profileCubit
                                                      .pickAchievementsPdf(),
                                            )
                                          ],
                                        ),
                                      ),
                                SizedBox(
                                  height: 10.sp,
                                ),
                                BlocConsumer<ProfileCubit, ProfileState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    return RowWidgetImage(
                                      isProviderProfile: true,
                                      // images: ,
                                      list: profileCubit.profileModel
                                          .userProfile!.imagesAlbum!,
                                      title: LocaleKeys.albumImages.tr(),
                                      isListEmpty: profileCubit
                                          .selectedAlbumImages.isEmpty,
                                      clearFun: () =>
                                          profileCubit.clearAlbumImage(),
                                    );
                                  },
                                ),
                                profileCubit.profileModel.userProfile!
                                        .imagesAlbum!.isEmpty
                                    ? PickedImageWithDialog(
                                  index: 2,
                                  listString:profileCubit.profileModel.userProfile?.imagesAlbum??[],
                                        title: LocaleKeys.attachImage.tr(),
                                        clearImagesFunction: () =>
                                            profileCubit.clearAlbumImage(),
                                        updateFunction: () => profileCubit
                                            .updateProviderProfile()
                                            .then((value) =>
                                                Navigator.pop(context)),
                                        pickedFileImage:
                                            profileCubit.selectedAlbumImages,
                                        pickImagesFunction: () =>
                                            profileCubit.pickAlbumImages(),
                                      )
                                    : Container(
                                        child: Row(
                                          children: [
                                            FirstImageInProviderProfile(

                                              imageUrl: profileCubit
                                                  .profileModel
                                                  .userProfile!
                                                  .imagesAlbum!,
                                            ),
                                            PickedImageWithDialog(
                                              index: 2,
                                              listString:profileCubit.profileModel.userProfile?.imagesAlbum??[],
                                              title:
                                                  LocaleKeys.attachImage.tr(),
                                              clearImagesFunction: () =>
                                                  profileCubit
                                                      .clearAlbumImage(),
                                              updateFunction: () => profileCubit
                                                  .updateProviderProfile()
                                                  .then((value) =>
                                                      Navigator.pop(context)),
                                              pickedFileImage: profileCubit
                                                  .selectedAlbumImages,
                                              pickImagesFunction: () =>
                                                  profileCubit
                                                      .pickAlbumImages(),
                                            )
                                          ],
                                        ),
                                      ),
                                SizedBox(
                                  height: context.width * 0.04.sp,
                                ),
                                CustomButton(
                                  textButton: LocaleKeys.update.tr(),
                                  onPressed: () {
                                    profileCubit.updateProviderProfile();
                                  },
                                  color: darkGreyColor,
                                ),
                                SizedBox(
                                  height: 20.sp,
                                ),
                                TextButton(
                                    onPressed: () {
                                      showBottomSheet(
                                          context: context,
                                          backgroundColor: whiteColor,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(
                                              Dimensions.RADIUS_LARGE,
                                            ),
                                            topLeft: Radius.circular(
                                              Dimensions.RADIUS_LARGE,
                                            ),
                                          )),
                                          builder: (context) {
                                            return Container(
                                              padding: const EdgeInsets.all(
                                                  Dimensions
                                                      .PADDING_SIZE_LARGE),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    LocaleKeys.deleteAccount
                                                        .tr(),
                                                    style:
                                                        openSansBold.copyWith(
                                                            color:
                                                                darkGreyColor),
                                                  ),
                                                  const SizedBox(
                                                    height: Dimensions
                                                        .PADDING_SIZE_LARGE,
                                                  ),
                                                  SvgPicture.asset(
                                                      Images.DELETE_ACCOUNT),
                                                  const SizedBox(
                                                    height: Dimensions
                                                        .PADDING_SIZE_LARGE,
                                                  ),
                                                  Text(
                                                    LocaleKeys.wantDeleteAccount
                                                        .tr(),
                                                    style:
                                                        openSansMedium.copyWith(
                                                            color:
                                                                darkGreyColor),
                                                  ),
                                                  const SizedBox(
                                                    height: Dimensions
                                                        .PADDING_SIZE_LARGE,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: CustomButton(
                                                        textButton: LocaleKeys
                                                            .yesDelete
                                                            .tr(),
                                                        onPressed: () {
                                                          profileCubit
                                                              .deleteProfile(
                                                                  context);
                                                        },
                                                        color: redColor,
                                                      )),
                                                      const SizedBox(
                                                        width: Dimensions
                                                            .PADDING_SIZE_LARGE,
                                                      ),
                                                      Expanded(
                                                          child: CustomButton(
                                                        textButton: LocaleKeys
                                                            .noThanks
                                                            .tr(),
                                                        borderColor:
                                                            darkGreyColor,
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        textColor:
                                                            darkGreyColor,
                                                      )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Center(
                                      child: Text(
                                        LocaleKeys.deleteAccount.tr(),
                                        style: openSansExtraBold.copyWith(
                                            color: redColor,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    )),
                                const SizedBox(
                                  height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
        },
      ),
    );
  }
}
