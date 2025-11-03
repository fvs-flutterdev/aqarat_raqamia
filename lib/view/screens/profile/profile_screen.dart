import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../../utils/app_constant.dart';
import '../../../../../utils/dimention.dart';
import '../../../../../utils/media_query_value.dart';
import '../../../../../utils/text_style.dart';
import '../../../../../view/base/adaptive_dialog_loader.dart';
import '../../../../../view/base/custom_text_field.dart';
import '../../../../../view/base/guest_widget.dart';
import '../../../../../view/base/main_button.dart';
import '../../../../../view/base/show_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../bloc/profile_cubit/cubit.dart';
import '../../../bloc/profile_cubit/state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/images.dart';
import '../../base/lunch_widget.dart';
import '../../base/profile_header.dart';
import '../../base/shimmer/profile_shimmer.dart';
import '../../error_widget/error_widget.dart';
import '../auth/provider_auth/first_register_provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // const ProfileScreen({super.key});
  PersistentBottomSheetController? bottomSheetController;
  ProfileCubit? profileCubit;

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
          if (state is UpdateProfileLoadingState ||
              state is DeleteProfileLoadingState) {
            adaptiveDialogLoader(context: context);
          } else if (state is UpdateProfileSuccessState ||
              state is UpdateProfileErrorState ||
              state is DeleteProfileErrorState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (token == null) {
            return LoginFirst();
          }
          if (state is GetProfileLoadingState) {
            return ProfileShimmer();
          }
          if (state is GetProfileErrorState) {
            return CustomErrorWidget(
              reload: () {
                profileCubit.getProfileData();
              },
              //  statusCode: state.statusCode,
            );
          }
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus!.unfocus();
              bottomSheetController?.close();
            },
            child: Column(
              children: [
                ProfileHeader(
                    isVerified: true,
                    rate: profileCubit.profileModel.userProfile?.rate,
                    rateNo: profileCubit.profileModel.userProfile?.noRate
                        .toString(),
                    image: profileCubit.isPickImage
                        ? Image.file(profileCubit.file!)
                        // : profileCubit.profileModel.userProfile?.photo ==
                        //         null
                        //     ? Image.asset(Images.PROFILE_PIC)
                        : Image.network(
                            profileCubit.profileModel.userProfile?.photo ?? '',
                          ),
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
                    name: profileCubit.profileModel.userProfile?.name ?? ''),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30.sp,
                          ),
                          CustomTextField(
                            labelText: LocaleKeys.name.tr(),
                            controller: profileCubit.nameController,
                            maxHeight: context.width * 0.2.sp,
                            minHeight: context.width * 0.15.sp,
                            // controller: TextEditingController(
                            //     text: profileCubit
                            //             .profileModel.userProfile?.name ??
                            //         ''),
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
                                  length: 9,
                                  controller: profileCubit.phoneController,
                                  // TextEditingController(
                                  //     text: profileCubit.profileModel
                                  //             .userProfile?.phone ??
                                  //         ''),
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
                            keyboardType: TextInputType.emailAddress,
                            maxHeight: context.width * 0.2.sp,
                            minHeight: context.width * 0.15.sp,
                          ),
                          //  SizedBox(height: 20.sp),

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
                                border: Border.all(color: darkGreyColor),
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
                          SizedBox(height: 20.sp),

                          CustomButton(
                            textButton: LocaleKeys.update.tr(),
                            onPressed: () {
                              // if (profileCubit.phoneController.text ==
                              //             profileCubit.profileModel.userProfile
                              //                 ?.phone &&
                              //         profileCubit.nameController.text ==
                              //             profileCubit
                              //                 .profileModel.userProfile?.name &&
                              //         profileCubit.isPickImage == false &&
                              //         profileCubit.emailController.text ==
                              //             profileCubit.profileModel.userProfile
                              //                 ?.email ||
                              //     profileCubit
                              //             .profileModel.userProfile?.email ==
                              //         null) {
                              //   showCustomSnackBar(
                              //       message: LocaleKeys.allThingsUpdate.tr(),
                              //       state: ToastState.SUCCESS);
                              // } else {
                                profileCubit.updateUserProfile(
                                    phone: profileCubit.phoneController.text,
                                    name: profileCubit.nameController.text,
                                    email: profileCubit.emailController.text);
                             // }
                            },
                            color: darkGreyColor,
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          TextButton(
                              onPressed: () {
                                // showCustomSnackBar(
                                //     message: 'الخدمه مازالت قيد التطوير',
                                //     state: ToastState.WARNING);
                                navigateForward(FirstRegisterProviderScreen(phone: profileCubit.profileModel.userProfile?.phone??'',));
                              },
                              child: Text(
                                LocaleKeys.upgradeAccountToProvider.tr(),
                                style: openSansExtraBold.copyWith(
                                    color: goldColor,
                                    decoration: TextDecoration.underline),
                              )),
                          SizedBox(
                            height: 20.sp,
                          ),
                          TextButton(
                              onPressed: () {
                                bottomSheetController = Scaffold.of(context)
                                    .showBottomSheet((context) {
                                  return Container(
                                    padding: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_LARGE),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          LocaleKeys.deleteAccount.tr(),
                                          style: openSansBold.copyWith(
                                              color: darkGreyColor),
                                        ),
                                        const SizedBox(
                                          height: Dimensions.PADDING_SIZE_LARGE,
                                        ),
                                        SvgPicture.asset(Images.DELETE_ACCOUNT),
                                        const SizedBox(
                                          height: Dimensions.PADDING_SIZE_LARGE,
                                        ),
                                        Text(
                                          LocaleKeys.wantDeleteAccount.tr(),
                                          style: openSansMedium.copyWith(
                                              color: darkGreyColor),
                                        ),
                                        const SizedBox(
                                          height: Dimensions.PADDING_SIZE_LARGE,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: CustomButton(
                                              textButton:
                                                  LocaleKeys.yesDelete.tr(),
                                              onPressed: () {
                                                profileCubit
                                                    .deleteProfile(context);
                                              },
                                              color: redColor,
                                            )),
                                            const SizedBox(
                                              width:
                                                  Dimensions.PADDING_SIZE_LARGE,
                                            ),
                                            Expanded(
                                                child: CustomButton(
                                              textButton:
                                                  LocaleKeys.noThanks.tr(),
                                              borderColor: darkGreyColor,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              textColor: darkGreyColor,
                                            )),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                });
                              },
                              child: Text(
                                LocaleKeys.deleteAccount.tr(),
                                style: openSansExtraBold.copyWith(
                                    color: redColor,
                                    decoration: TextDecoration.underline),
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
            ),
          );
        },
      ),
    );
  }
}
