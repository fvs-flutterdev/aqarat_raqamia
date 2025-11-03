import 'dart:developer';

import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../bloc/auth_cubit/auth_provider/cubit.dart';
import '../../../../bloc/auth_cubit/auth_provider/state.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/text_style.dart';
import '../../../../view/base/lunch_widget.dart';
import '../../../../view/base/main_button.dart';
import '../../../../view/base/show_toast.dart';
import '../../../../view/error_widget/error_widget.dart';
import '../../../../view/screens/auth/provider_auth/provider_register.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../base/auth_header.dart';
import '../../../base/shimmer/contact_us_shimmer.dart';

class FirstRegisterProviderScreen extends StatelessWidget {
  String? phone;

  FirstRegisterProviderScreen({super.key, this.phone});

  @override
  Widget build(BuildContext context) {
    var registerProviderCubit = context.read<RegisterProviderCubit>();
    return Scaffold(
      // appBar: AuthHeader(),
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
                // TODO: implement listener
              },
              builder: (context, state) {
                return state is GetEntityProviderLoadingState ||
                        state is GetInterestsRegisterLoadingState
                    ? ContactUsShimmer(
                        isServiceProvider: true,
                      )
                    : state is GetEntityProviderErrorState ||
                            state is GetInterestsRegisterErrorState
                        ? CustomErrorWidget(reload: () {
                            registerProviderCubit.getProviderEntityRegister();
                          })
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minWidth: MediaQuery.of(context).size.width,
                                    minHeight:
                                        MediaQuery.of(context).size.height -
                                            context.height * 0.2),
                                child: IntrinsicHeight(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LocaleKeys.registerNewServiceProvider
                                            .tr(),
                                        style: openSansExtraBold.copyWith(
                                            color: darkGreyColor),
                                      ),
                                      Text(
                                        LocaleKeys.helloInAqarat.tr(),
                                        style: openSansRegular.copyWith(
                                            color: darkGreyColor),
                                      ),
                                      SizedBox(
                                        height: Dimensions.PADDING_SIZE_LARGE,
                                      ),
                                      // CustomDropDown(items: items, value: value, fct: fct, hint: hint)

                                      MultiSelectDialogField(
                                        // listType: MultiSelectListType.CHIP,

                                        title: Text(
                                          LocaleKeys.mainServiceType.tr(),
                                          style: openSansBold.copyWith(
                                              color: darkGreyColor),
                                        ),
                                        buttonText: Text(
                                          LocaleKeys.mainServiceType.tr(),
                                          style: openSansMedium.copyWith(
                                              color: darkGreyColor),
                                        ),
                                        searchTextStyle: openSansMedium
                                            .copyWith(color: darkGreyColor),
                                        searchable: true,
                                        searchHintStyle: openSansMedium
                                            .copyWith(color: darkGreyColor),
                                        searchHint: LocaleKeys.search.tr(),
                                        selectedItemsTextStyle: openSansMedium
                                            .copyWith(color: darkGreyColor),
                                        unselectedColor: darkGreyColor,
                                        buttonIcon: Icon(
                                          Icons.arrow_drop_down_outlined,
                                          color: darkGreyColor,
                                        ),
                                        selectedColor:
                                            goldColor.withOpacity(0.1),
                                        checkColor: goldColor,
                                        itemsTextStyle: openSansRegular,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: whiteGreyColor),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.RADIUS_DEFAULT)),
                                        items: registerProviderCubit
                                            .providerRegisterEntityModel
                                            .services!
                                            .map((e) {
                                          return MultiSelectItem(
                                              e.id, e.name ?? '');
                                        }).toList(),
                                        //     registerProviderCubit.mainServices.map((e) {
                                        //   return MultiSelectItem(e['name'], e['name']);
                                        // }).toList(),
                                        onConfirm: (val) {
                                          print('################${val}');
                                          registerProviderCubit
                                              .onAddServiceList(val);
                                          registerProviderCubit
                                              .getSubServicesById();
                                          print(
                                              '${registerProviderCubit.serviceList} ///////////////////////////////////');
                                        },
                                      ),
                                      SizedBox(
                                        height: Dimensions.PADDING_SIZE_LARGE.h,
                                      ),
                                      registerProviderCubit.isGetSubServices ==
                                              false
                                          ? SizedBox()
                                          : MultiSelectDialogField(
                                              // listType: MultiSelectListType.CHIP,
                                              isDismissible: true,
                                              title: Text(
                                                LocaleKeys.subServiceType.tr(),
                                                style: openSansBold.copyWith(
                                                    color: darkGreyColor),
                                              ),
                                              buttonText: Text(
                                                LocaleKeys.subServiceType.tr(),
                                                style: openSansMedium.copyWith(
                                                    color: darkGreyColor),
                                              ),
                                              buttonIcon: Icon(
                                                Icons.arrow_drop_down_outlined,
                                                color: darkGreyColor,
                                              ),
                                              selectedColor:
                                                  goldColor.withOpacity(0.1),
                                              checkColor: goldColor,
                                              searchTextStyle:
                                                  openSansMedium.copyWith(
                                                      color: darkGreyColor),
                                              searchable: true,
                                              searchHintStyle:
                                                  openSansMedium.copyWith(
                                                      color: darkGreyColor),
                                              searchHint:
                                                  LocaleKeys.search.tr(),
                                              selectedItemsTextStyle:
                                                  openSansMedium.copyWith(
                                                      color: darkGreyColor),
                                              //   unselectedColor:darkGreyColor ,
                                              itemsTextStyle: openSansRegular,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: whiteGreyColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions
                                                              .RADIUS_DEFAULT)),
                                              items: registerProviderCubit
                                                  .servicesByIdModel
                                                  .subServices!
                                                  .map((e) {
                                                return MultiSelectItem(
                                                    e, e.name ?? '');
                                              }).toList(),
                                              onConfirm: (val) {
                                                registerProviderCubit
                                                    .onAddSubServiceList(val);
                                                //    print('${registerProviderCubit.subServiceList} ///////////////////////////////////');
                                              },
                                            ),
                                      Spacer(
                                        flex: 3,
                                      ),
                                      CustomButton(
                                        textButton: LocaleKeys.next.tr(),
                                        onPressed: () {
                                          if (registerProviderCubit
                                                  .subServiceList.isEmpty ||
                                              registerProviderCubit
                                                  .serviceList.isEmpty) {
                                            showCustomSnackBar(
                                                message: LocaleKeys
                                                    .selectServiceWhichProvided
                                                    .tr(),
                                                state: ToastState.ERROR);
                                          } else if (registerProviderCubit
                                                  .serviceList.length !=
                                              registerProviderCubit
                                                  .idSub.length) {
                                            print(registerProviderCubit
                                                .serviceList.length);
                                            print(registerProviderCubit
                                                .idSub.length);
                                            showCustomSnackBar(
                                                message: LocaleKeys
                                                    .mainServiceNotLinkedSubService
                                                    .tr(),
                                                state: ToastState.ERROR);
                                          } else {
                                            navigateForward(
                                                ProviderRegister(phone ?? ''));
                                          }
                                        },
                                        color: darkGreyColor,
                                      ),
                                      SizedBox(
                                        height: Dimensions.PADDING_SIZE_SMALL,
                                      )
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
