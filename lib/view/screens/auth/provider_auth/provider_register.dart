import 'package:flutter/cupertino.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../bloc/auth_cubit/auth_provider/cubit.dart';
import '../../../../bloc/auth_cubit/auth_provider/state.dart';
import '../../../../bloc/location_cubit/cubit.dart';
import '../../../../bloc/location_cubit/state.dart';
import '../../../../utils/app_constant.dart';
import '../../../../utils/media_query_value.dart';
import '../../../../view/base/adaptive_dialog_loader.dart';
import '../../../../view/base/auth_header.dart';
import '../../../../view/base/custom_drop_down.dart';
import '../../../../view/base/custom_text_field.dart';
import '../../../../view/base/lunch_widget.dart';
import '../../../../view/base/main_button.dart';
import '../../../../view/screens/privacy_policy/privacy_policy_screen.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/text_style.dart';
import '../../../base/images_grid_view_widget.dart';
import '../../../base/row_widget_image.dart';
import '../../location/set_location_on_map.dart';
import '../client_auth/login.dart';

//ignore: must_be_immutable
class ProviderRegister extends StatelessWidget {
  String? phone;
  TextEditingController providerPhoneController = TextEditingController();
  TextEditingController providerNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ProviderRegister(this.phone);

  @override
  Widget build(BuildContext context) {
    var registerProviderCubit = context.read<RegisterProviderCubit>();
    var locationCubit = context.read<LocationCubit>();
    return Scaffold(
      //  appBar: AuthHeader(),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(),
          ),
          Expanded(
            child: BlocConsumer<RegisterProviderCubit, ProviderRegisterState>(
              listener: (context, state) {
                if (state is ProviderRegisterLoadingState ||
                    state is UpgradeProfileLoadingState) {
                  adaptiveDialogLoader(context: context);
                } else if (state is ProviderRegisterErrorState ||
                    state is UpgradeProfileErrorState) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: Dimensions.PADDING_SIZE_DEFAULT,
                          end: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.registerNewServiceProvider.tr(),
                              style: openSansExtraBold.copyWith(
                                  color: darkGreyColor),
                            ),
                            Text(
                              LocaleKeys.helloInAqarat.tr(),
                              style: openSansRegular.copyWith(
                                  color: darkGreyColor),
                            ),
                            const SizedBox(
                              height: Dimensions.PADDING_SIZE_OVER_LARGE,
                            ),
                            token == null
                                ? CustomTextField(
                                    labelText: LocaleKeys.name.tr(),
                                    controller: providerNameController,
                                    maxHeight: context.width * 0.2,
                                    minHeight: context.width * 0.15,
                                    validator: (String val) {
                                      if (val.isEmpty) {
                                        return LocaleKeys.pleaseEnterYourName
                                            .tr();
                                      }
                                    },
                                  )
                                : const SizedBox(),

                            token == null
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: LocaleKeys.phone.tr(),
                                          maxHeight: context.width * 0.2,
                                          minHeight: context.width * 0.15,
                                          length: 9,
                                          controller: providerPhoneController,
                                          keyboardType: TextInputType.number,
                                          validator: (String val) {
                                            if (val.isEmpty) {
                                              return LocaleKeys.pleaseEnterPhone
                                                  .tr();
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: Dimensions.PADDING_SIZE_DEFAULT,
                                      ),
                                      const FlagTextField(),
                                    ],
                                  )
                                : const SizedBox(),

                            CustomDropDown(
                                items: registerProviderCubit
                                    .providerRegisterEntityModel.licenses!
                                    .map((e) {
                                  return DropdownMenuItem(
                                    child: Text(e.name ?? ''),
                                    value: e.id.toString(),
                                  );
                                }).toList(),
                                value: registerProviderCubit.licenseId,
                                fct: (onChange) {
                                  registerProviderCubit
                                      .onChangeLicense(onChange);
                                  print(onChange);
                                },
                                hint: LocaleKeys.licenceType.tr()),
                            CustomDropDown(
                                items: registerProviderCubit
                                    .providerRegisterEntityModel.experience!
                                    .map((e) {
                                  return DropdownMenuItem(
                                    child: Text(e.title ?? ''),
                                    value: e.title,
                                  );
                                }).toList(),
                                value: registerProviderCubit.experienceId,
                                fct: (onChange) {
                                  registerProviderCubit
                                      .onChangeExperience(onChange);
                                  print(onChange);
                                },
                                hint: LocaleKeys.yearsOfExperience.tr()),
                            SizedBox(
                              height: context.width * 0.06,
                            ),
                            BlocBuilder<LocationCubit, LocationState>(
                                builder: (builder, state) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Container(
                                    // margin: EdgeInsetsDirectional.only(top: context.width*0.05),
                                    child: CustomTextField(
                                      controller:
                                          locationCubit.locationTextController,
                                      labelText: LocaleKeys.serviceArea.tr(),
                                      maxHeight: context.width * 0.2,
                                      minHeight: context.width * 0.15,
                                      isEnabled: false,
                                      validator: (String val) {
                                        if (val.isEmpty) {
                                          return '';
                                        }
                                      },
                                    ),
                                  )),
                                  const SizedBox(
                                    width: Dimensions.PADDING_SIZE_DEFAULT,
                                  ),
                                  LocationCard(fct: () {
                                    navigateForward(SetLocationOnMap(
                                      areaName:
                                          locationCubit.districtTextController,
                                      cityName:
                                          locationCubit.cityTextController,
                                      i: 0,
                                      locationName:
                                          locationCubit.locationTextController,
                                    ));
                                  }),
                                ],
                              );
                            }),
                            BlocBuilder<LocationCubit, LocationState>(
                                builder: (builder, state) {
                              return CustomTextField(
                                controller: locationCubit.cityTextController,
                                labelText: LocaleKeys.city.tr(),
                                maxHeight: context.width * 0.2,
                                minHeight: context.width * 0.15,
                                isEnabled: false,
                                validator: (String val) {
                                  if (val.isEmpty) {
                                    return '';
                                  }
                                },
                              );
                            }),
                            BlocBuilder<LocationCubit, LocationState>(
                                builder: (builder, state) {
                              return CustomTextField(
                                controller:
                                    locationCubit.districtTextController,
                                labelText: LocaleKeys.district.tr(),
                                maxHeight: context.width * 0.2,
                                minHeight: context.width * 0.15,
                                isEnabled: false,
                                validator: (String val) {
                                  if (val.isEmpty) {
                                    return '';
                                  }
                                },
                              );
                            }),

                            ///
                            // MultiSelectDialogField(
                            //   // listType: MultiSelectListType.CHIP,
                            //
                            //   title: Text(
                            //     LocaleKeys.city.tr(),
                            //     style: openSansBold.copyWith(color: darkGreyColor),
                            //   ),
                            //   buttonText: Text(
                            //     LocaleKeys.city.tr(),
                            //     style: openSansMedium.copyWith(color: darkGreyColor),
                            //   ),
                            //   searchTextStyle:
                            //       openSansMedium.copyWith(color: darkGreyColor),
                            //   searchable: true,
                            //   searchHintStyle:
                            //       openSansMedium.copyWith(color: darkGreyColor),
                            //   searchHint: LocaleKeys.search.tr(),
                            //   selectedItemsTextStyle:
                            //       openSansMedium.copyWith(color: darkGreyColor),
                            //   unselectedColor: darkGreyColor,
                            //   buttonIcon: Icon(
                            //     Icons.arrow_drop_down_outlined,
                            //     color: darkGreyColor,
                            //   ),
                            //   selectedColor: goldColor.withOpacity(0.1),
                            //   checkColor: goldColor,
                            //   itemsTextStyle: openSansRegular,
                            //   decoration: BoxDecoration(
                            //       border: Border.all(color: darkGreyColor),
                            //       borderRadius: BorderRadius.circular(
                            //           Dimensions.RADIUS_DEFAULT)),
                            //   items: locationCubit.cityByRegionIdModel.data!.map((e) {
                            //     return MultiSelectItem(e.cityId, e.name ?? '');
                            //   }).toList(),
                            //   //     registerProviderCubit.mainServices.map((e) {
                            //   //   return MultiSelectItem(e['name'], e['name']);
                            //   // }).toList(),
                            //   onConfirm: (val) {
                            //     print('################${val}');
                            //     // registerProviderCubit.onAddInterestsList(val);
                            //     //   registerProviderCubit.getSubServicesById();
                            //     print(
                            //         '${registerProviderCubit.interestsList} ///////////////////////////////////');
                            //   },
                            // ),
                            ///
                            MultiSelectDialogField(
                              // listType: MultiSelectListType.CHIP,

                              title: Text(
                                LocaleKeys.interests.tr(),
                                style:
                                    openSansBold.copyWith(color: darkGreyColor),
                              ),
                              buttonText: Text(
                                LocaleKeys.interests.tr(),
                                style: openSansMedium.copyWith(
                                    color: darkGreyColor),
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
                              items: registerProviderCubit.interestsModel.data!
                                  .map((e) {
                                return MultiSelectItem(e.id, e.name ?? '');
                              }).toList(),
                              //     registerProviderCubit.mainServices.map((e) {
                              //   return MultiSelectItem(e['name'], e['name']);
                              // }).toList(),
                              onConfirm: (val) {
                                print('################${val}');
                                registerProviderCubit.onAddInterestsList(val);
                                //   registerProviderCubit.getSubServicesById();
                                print(
                                    '${registerProviderCubit.interestsList} ///////////////////////////////////');
                              },
                            ),
                            // Text(
                            //   'إرفاق ملف',
                            //   style: openSansExtraBold.copyWith(color: goldColor),
                            // ),
                            ///Pdf Loaded File
                            BlocConsumer<RegisterProviderCubit,
                                ProviderRegisterState>(
                              listener: (context, state) {
                                // TODO: implement listener
                              },
                              builder: (context, state) {
                                return RowWidgetImage(
                                  isProviderProfile: false,
                                  title: LocaleKeys.attachFile.tr(),
                                  isListEmpty:
                                      registerProviderCubit.pdfListFile.isEmpty,
                                  clearFun: () =>
                                      registerProviderCubit.clearImage(),
                                );
                                // return Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     RichText(
                                //         text: TextSpan(
                                //             text: 'إرفاق صور',
                                //             style:
                                //             openSansBold.copyWith(color: goldColor),
                                //             children: [
                                //               TextSpan(
                                //                   text: ' "حد اقصى 5 صور للأعلان"',
                                //                   style: openSansMedium.copyWith(
                                //                       color: darkGreyColor, fontSize: 10))
                                //             ])),
                                //     uploadRequestCubit.selectedImages.isEmpty
                                //         ? SizedBox()
                                //         : IconButton(
                                //         onPressed: () {
                                //           uploadRequestCubit.clearImage();
                                //         },
                                //         icon: Icon(
                                //           Icons.clear,
                                //           color: redColor,
                                //         ))
                                //   ],
                                // );
                              },
                            ),
                            BlocBuilder<RegisterProviderCubit,
                                ProviderRegisterState>(
                              builder: (context, state) {
                                return ImageGridViewWidget(
                                  isProviderRegister: true,
                                  isService: true,
                                  isListEmpty:
                                      registerProviderCubit.pdfListFile.isEmpty,
                                  pickImage: () =>
                                      registerProviderCubit.uploadPdf(),
                                  countImage:
                                      registerProviderCubit.pdfListFile.length,
                                  imageFile: registerProviderCubit.pdfListFile,
                                  fileName: registerProviderCubit.pdfFileName,
                                );
                                // return uploadRequestCubit.selectedImages.isEmpty
                                //     ? Container(
                                //         padding: EdgeInsetsDirectional.only(
                                //             top: context.width * 0.02),
                                //         height: context.width * 0.5,
                                //         child: ListView.separated(
                                //             physics: NeverScrollableScrollPhysics(),
                                //             separatorBuilder: (context, index) {
                                //               return SizedBox(
                                //                 width: Dimensions.PADDING_SIZE_SMALL,
                                //               );
                                //             },
                                //             itemCount: 3,
                                //             scrollDirection: Axis.horizontal,
                                //             itemBuilder: (context, index) {
                                //               return GestureDetector(
                                //                 onTap: () {
                                //                   uploadRequestCubit.pickImages();
                                //                   // uploadRequestCubit.isSelected[index] == true
                                //                   //     ? null
                                //                   //     : uploadRequestCubit.pickImages(index);
                                //                   //  uploadRequestCubit.pickImageFromCamera(index);
                                //                 },
                                //                 child: Container(
                                //                   margin: EdgeInsetsDirectional.only(
                                //                     top: context.width * 0.02,
                                //                   ),
                                //                   height: context.width * 0.5,
                                //                   width: context.width * 0.24,
                                //                   decoration: BoxDecoration(
                                //                     borderRadius: BorderRadius.circular(
                                //                         Dimensions.RADIUS_LARGE),
                                //                     border:
                                //                         Border.all(color: goldColor),
                                //                   ),
                                //                   child: Center(
                                //                     child: SvgPicture.asset(
                                //                       Images.Add_SVG,
                                //                       // width: 12,
                                //                       // height: 12,
                                //                     ),
                                //                     // uploadRequestCubit
                                //                     //         .isSelected[index]
                                //                     //     ? ClipRRect(
                                //                     //         borderRadius:
                                //                     //             BorderRadius.circular(
                                //                     //                 Dimensions
                                //                     //                     .RADIUS_SMALL),
                                //                     //         child: Image.file(
                                //                     //           uploadRequestCubit
                                //                     //               .selectedImages[index],
                                //                     //           fit: BoxFit.fitWidth,
                                //                     //         ))
                                //                     //     :
                                //                   ),
                                //                 ),
                                //               );
                                //             }),
                                //       )
                                //     : Expanded(
                                //         child: GridView.builder(
                                //             padding: EdgeInsetsDirectional.only(
                                //                 top: context.width * 0.02),
                                //             gridDelegate:
                                //                 SliverGridDelegateWithFixedCrossAxisCount(
                                //                     crossAxisCount: 3,
                                //                     childAspectRatio: 1 / 1.4),
                                //             itemCount: uploadRequestCubit
                                //                 .selectedImages.length,
                                //             // itemCount: uploadRequestCubit.somePickedImage.length,
                                //             itemBuilder: (context, index) {
                                //               return Container(
                                //                 height: context.width * 0.5,
                                //                 width: context.width * 0.24,
                                //                 decoration: BoxDecoration(
                                //                     border:
                                //                         Border.all(color: goldColor),
                                //                     borderRadius: BorderRadius.all(
                                //                         Radius.circular(Dimensions
                                //                             .RADIUS_DEFAULT))),
                                //                 margin: EdgeInsetsDirectional.only(
                                //                   end: context.width * 0.02,
                                //                   bottom: context.width * 0.02,
                                //                 ),
                                //                 child: ClipRRect(
                                //                   // clipBehavior: Clip.antiAliasWithSaveLayer,
                                //                   borderRadius: BorderRadius.circular(
                                //                       Dimensions.RADIUS_DEFAULT),
                                //                   child: Image.file(
                                //                     File(uploadRequestCubit
                                //                         .selectedImages[index].path),
                                //                     fit: BoxFit.cover,
                                //                   ),
                                //                 ),
                                //               );
                                //             }),
                                //       );
                                // return ;
                              },
                            ),
                            const SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            Align(
                              alignment: AlignmentDirectional.center,
                              child: GestureDetector(
                                onTap: () =>
                                    navigateForward(PrivacyPolicyScreen()),
                                child: RichText(
                                  text: TextSpan(
                                    style: openSansRegular.copyWith(
                                        color: darkGreyColor),
                                    text:
                                        LocaleKeys.whenYouRegisterYouAgree.tr(),
                                    children: [
                                      TextSpan(
                                          text: LocaleKeys.privacyPolicy.tr(),
                                          style: openSansBold.copyWith(
                                              color: goldColor,
                                              decoration:
                                                  TextDecoration.underline))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: context.width * 0.07.h,
                            ),
                            //   state is ProviderRegisterLoadingState?Center(child: CircularProgressIndicator(),):
                            CustomButton(
                              height: context.height * 0.07.h,
                              textButton: token == null
                                  ? LocaleKeys.verify.tr()
                                  : LocaleKeys.upgradeAccountToProvider.tr(),
                              onPressed: () {
                                if (token == null) {
                                  if (_formKey.currentState!.validate()) {
                                    registerProviderCubit.providerRegister(
                                      context: context,
                                      phone: providerPhoneController.text,
                                      name: providerNameController.text,
                                    );
                                  }
                                } else {
                                  if (_formKey.currentState!.validate()) {
                                    registerProviderCubit
                                        .upgradeAccountToProvider(
                                            context: context,
                                            phone: phone ?? '');
                                  }
                                }

                                // Get.to(() => VerificationScreen(
                                //     phone: 'phoneNumberController.text'));
                              },
                              color: darkGreyColor,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            token == null
                                ? CustomButton(
                                    height: context.height * 0.07.h,
                                    textButton: LocaleKeys.login.tr(),
                                    onPressed: () {
                                      navigateForward(ClientLogin(
                                        id: 1,
                                      ));
                                    },
                                    color: goldColor,
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 20,
                            ),
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: Text(
                            //     'الدخول كزائر',
                            //     style: openSansBold.copyWith(
                            //         color: goldColor,
                            //         decoration: TextDecoration.underline),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 30,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
