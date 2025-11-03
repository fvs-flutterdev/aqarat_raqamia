import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../bloc/auth_cubit/auth_client/cubit.dart';
import '../../../../bloc/auth_cubit/auth_client/state.dart';
import '../../../../bloc/auth_cubit/auth_provider/cubit.dart';
import '../../../../bloc/auth_cubit/auth_provider/state.dart';
import '../../../../bloc/location_cubit/cubit.dart';
import '../../../../bloc/location_cubit/state.dart';
import '../../../../utils/app_constant.dart';
import '../../../../utils/media_query_value.dart';
import '../../../../view/base/auth_header.dart';
import '../../../../view/base/custom_text_field.dart';
import '../../../../view/base/lunch_widget.dart';
import '../../../../view/base/main_button.dart';
import '../../../../view/screens/location/set_location_on_map.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/text_style.dart';
import 'login.dart';

//ignore: must_be_immutable
class ClientRegister extends StatelessWidget {
  // const ClientRegister({super.key});
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var locationCubit = context.read<LocationCubit>();
    var authCubit = context.read<ClientAuthCubit>();
    var providerCubit = context.read<RegisterProviderCubit>();
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
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: Dimensions.PADDING_SIZE_DEFAULT,
                      end: Dimensions.PADDING_SIZE_DEFAULT),
                  child: BlocConsumer<ClientAuthCubit, ClientAuthState>(
                    listener: (context, state) {
                      // if(state is RegisterErrorState){
                      //  // showToast(text: state.error, state: ToastState.ERROR);
                      //   showCustomSnackBar(message: state.error,state:ToastState.ERROR);
                      // }
                    },
                    builder: (context, state) {
                      return Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.registerNewClient.tr(),
                              style:
                                  openSansMedium.copyWith(color: darkGreyColor),
                            ),
                            Text(
                              LocaleKeys.helloInAqarat.tr(),
                              style:
                                  openSansMedium.copyWith(color: darkGreyColor),
                            ),
                            const SizedBox(
                              height: Dimensions.PADDING_SIZE_OVER_LARGE,
                            ),
                            CustomTextField(
                              labelText: LocaleKeys.name.tr(),
                              maxHeight: context.width * 0.2,
                              minHeight: context.width * 0.15,
                              controller: nameController,
                              validator: (String val) {
                                if (val.isEmpty) {
                                  return LocaleKeys.pleaseEnterYourName.tr();
                                }
                              },
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: CustomTextField(
                                  labelText: LocaleKeys.phone.tr(),
                                  maxHeight: context.width * 0.2,
                                  minHeight: context.width * 0.15,
                                  length: 9,
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  validator: (String val) {
                                    if (val.isEmpty) {
                                      return LocaleKeys.pleaseEnterPhone.tr();
                                    }
                                  },
                                )),
                                SizedBox(
                                  width: context.height * 0.02,
                                ),
                                const FlagTextField(),
                              ],
                            ),
                            BlocBuilder<LocationCubit, LocationState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: CustomTextField(
                                          labelText: LocaleKeys.location.tr(),
                                          maxHeight: context.width * 0.2,
                                          minHeight: context.width * 0.15,
                                          isEnabled: false,
                                          controller: locationCubit
                                              .locationTextController,
                                          validator: (String val) {
                                            if (val.isEmpty) {
                                              return '';
                                            }
                                          },
                                        )),
                                        const SizedBox(
                                          width:
                                              Dimensions.PADDING_SIZE_DEFAULT,
                                        ),
                                        LocationCard(fct: () {
                                          navigateForward(SetLocationOnMap(
                                              i: 2,
                                              locationName: locationCubit
                                                  .locationTextController));
                                        }),
                                      ],
                                    ),
                                    CustomTextField(
                                      labelText: LocaleKeys.city.tr(),
                                      maxHeight: context.width * 0.2,
                                      minHeight: context.width * 0.15,
                                      // minWidth: double.infinity,
                                      // maxWidth: double.infinity,
                                      isEnabled: false,
                                      controller:
                                          locationCubit.cityTextController,
                                      validator: (String val) {
                                        if (val.isEmpty) {
                                          return '';
                                        }
                                      },
                                    )
                                    // Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    //   children: [
                                    //     Expanded(
                                    //         child: CustomTextField(
                                    //       labelText: LocaleKeys.city.tr(),
                                    //       maxHeight: context.width * 0.2,
                                    //       minHeight: context.width * 0.15,
                                    //       minWidth: double.infinity,
                                    //       maxWidth: double.infinity,
                                    //       isEnabled: false,
                                    //       controller:
                                    //           locationCubit.cityTextController,
                                    //       validator: (String val) {
                                    //         if (val.isEmpty) {
                                    //           return '';
                                    //         }
                                    //       },
                                    //     )),
                                    //     const SizedBox(
                                    //       width: Dimensions.PADDING_SIZE_DEFAULT,
                                    //     ),
                                    //     // LocationCard(fct: (){
                                    //     // //  Get.to(SetLocationOnMap(i:2, locationName: locationCubit.cityTextController));
                                    //     // }),
                                    //   ],
                                    // ),
                                  ],
                                );
                              },
                            ),
                            BlocBuilder<RegisterProviderCubit, ProviderRegisterState>(
                              builder: (context, state) {
                                return providerCubit.isGetInterestsModel==true?MultiSelectDialogField(
                                  // listType: MultiSelectListType.CHIP,

                                  title: Text(
                                    LocaleKeys.interests.tr(),
                                    style: openSansBold.copyWith(
                                        color: darkGreyColor),
                                  ),
                                  buttonText: Text(
                                    LocaleKeys.interests.tr(),
                                    style: openSansMedium.copyWith(
                                        color: darkGreyColor),
                                  ),
                                  searchTextStyle: openSansMedium.copyWith(
                                      color: darkGreyColor),
                                  searchable: true,
                                  searchHintStyle: openSansMedium.copyWith(
                                      color: darkGreyColor),
                                  searchHint: LocaleKeys.search.tr(),
                                  selectedItemsTextStyle: openSansMedium
                                      .copyWith(color: darkGreyColor),
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
                                  items: providerCubit.interestsModel.data!
                                      .map((e) {
                                    return MultiSelectItem(e.id, e.name ?? '');
                                  }).toList(),
                                  //     registerProviderCubit.mainServices.map((e) {
                                  //   return MultiSelectItem(e['name'], e['name']);
                                  // }).toList(),
                                  onConfirm: (val) {
                                    print('################${val}');
                                    providerCubit.onAddInterestsList(val);
                                    //   registerProviderCubit.getSubServicesById();
                                    print(
                                        '${providerCubit.interestsList} ///////////////////////////////////');
                                  },
                                ):SizedBox();
                              },
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_DEFAULT,
                            ),
                            Align(
                              alignment: AlignmentDirectional.center,
                              child: RichText(
                                  text: TextSpan(
                                      style: openSansRegular.copyWith(
                                          color: darkGreyColor),
                                      text: LocaleKeys.whenYouRegisterYouAgree
                                          .tr(),
                                      children: [
                                    TextSpan(
                                        text: LocaleKeys.privacyPolicy.tr(),
                                        style: openSansBold.copyWith(
                                            color: goldColor,
                                            decoration:
                                                TextDecoration.underline))
                                  ])),
                            ),
                            SizedBox(
                              height: context.height * 0.07,
                            ),
                            state is RegisterLoadingState
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CustomButton(
                                    height: context.height * 0.07,
                                    textButton: LocaleKeys.verify.tr(),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        print('object////////////////');
                                        authCubit.clientRegister(
                                            interestsList:
                                                providerCubit.interestsList,
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            location: locationCubit
                                                .locationTextController.text,
                                            city: locationCubit
                                                .cityTextController.text,
                                            lat: latAds.toString(),
                                            lng: lngAds.toString());
                                        // Get.to(() => VerificationScreen(
                                        //     phone: 'phoneNumberController.text'));
                                      }
                                    },
                                    color: darkGreyColor,
                                  ),
                            SizedBox(
                              height: context.height * 0.02,
                            ),
                            CustomButton(
                              height: context.height * 0.07,
                              textButton: LocaleKeys.login.tr(),
                              onPressed: () {
                                navigateForward(ClientLogin(
                                  id: 0,
                                ));
                              },
                              color: goldColor,
                            ),
                            SizedBox(
                              height: context.height * 0.02,
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
                            //   height: context.height*0.02,
                            // ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
