import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/base/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../bloc/auth_cubit/auth_provider/cubit.dart';
import '../../../../bloc/auth_cubit/auth_provider/state.dart';
import '../../../../view/base/adaptive_dialog_loader.dart';
import '../../../../view/base/auth_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/text_style.dart';
import '../../../base/show_toast.dart';

class EditService extends StatefulWidget {
  const EditService({super.key});

  @override
  State<EditService> createState() => _EditServiceState();
}

class _EditServiceState extends State<EditService> {
  @override
  void initState() {
    context.read<RegisterProviderCubit>().getProfileServices(context);
    context.read<RegisterProviderCubit>().getSubServicesById();
    super.initState();
  }
  @override
  void deactivate() {
    context.read<RegisterProviderCubit>().serviceList.clear();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    var registerProviderCubit = context.read<RegisterProviderCubit>();
    return Scaffold(
      // appBar: AuthHeader(
      //
      // ),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(),
          ),
          Expanded(
            child: BlocBuilder<RegisterProviderCubit, ProviderRegisterState>(
              builder: (context, state) {
                // if (state is UpdateServicesOfProviderLoadingState) {
                //   adaptiveDialogLoader(context: context);
                // } else if (state is UpdateServicesOfProviderErrorState) {
                //   Navigator.pop(context);
                // }
                if (state is GetEntityProviderLoadingState ||
                    registerProviderCubit.isGetServices == false) {
                  return adaptiveCircleProgress();
                } else {
                  return
                      // registerProviderCubit.differentList.isEmpty
                      //   ? Center(
                      //       child: Text(
                      //         LocaleKeys.noServices.tr(),
                      //         style: openSansExtraBold.copyWith(color: darkGreysColor),
                      //       ),
                      //     )
                      //   :
                      Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width,
                            minHeight: MediaQuery.of(context).size.height-context.height*0.2),
                        child: IntrinsicHeight(
                          child: Column(
                           mainAxisSize: MainAxisSize.max,
                            children: [
                              // ListView(
                              //   children: [
                                  MultiSelectDialogField(
                                    //  separateSelectedItems: true,
                                    // listType: MultiSelectListType.CHIP,

                                    title: Text(
                                      LocaleKeys.mainServiceType.tr(),
                                      style: openSansBold.copyWith(color: darkGreyColor),
                                    ),
                                    buttonText: Text(
                                      LocaleKeys.mainServiceType.tr(),
                                      style: openSansMedium.copyWith(color: darkGreyColor),
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
                                    initialValue: registerProviderCubit.serviceList,
                                    itemsTextStyle: openSansRegular,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: whiteGreyColor),
                                        borderRadius:
                                        BorderRadius.circular(Dimensions.RADIUS_LARGE)),
                                    items: registerProviderCubit
                                        .providerRegisterEntityModel.services!
                                        .map((e) {
                                      return MultiSelectItem(e.id, e.name ?? '');
                                    }).toList(),

                                    onConfirm: (val) {
                                      print('<<<<<<<<val<<<<<<<<<<<<$val>>>>>>>>>>>>>>>>>>>>');
                                      //  registerProviderCubit.serviceList.clear();
                                      List<int> intList = val.map((e) => e as int).toList();
                                      print('################${val[0]}');
                                      print('<<<<<<<<<<<<<<${intList}>>>>>>>>>>>>>>');
                                      registerProviderCubit.onUpdateServicesList(intList,);
                                      registerProviderCubit.getSubServicesById();
                                      print('${registerProviderCubit.serviceList} ///////////////////////////////////');
                                      print('${registerProviderCubit.newServiceList} ///////////////////////////////////');
                                    },
                                  ),
                                  const SizedBox(
                                    height: Dimensions.PADDING_SIZE_LARGE,
                                  ),
                                  registerProviderCubit.isGetSubServices == false
                                      ? const SizedBox()
                                      : MultiSelectDialogField(
                                        // listType: MultiSelectListType.CHIP,
                                        isDismissible: true,
                                        title: Text(
                                          LocaleKeys.subServiceType.tr(),
                                          style:
                                          openSansBold.copyWith(color: darkGreyColor),
                                        ),
                                        buttonText: Text(
                                          LocaleKeys.subServiceType.tr(),
                                          style:
                                          openSansMedium.copyWith(color: darkGreyColor),
                                        ),
                                        buttonIcon: Icon(
                                          Icons.arrow_drop_down_outlined,
                                          color: darkGreyColor,
                                        ),
                                        selectedColor: goldColor.withOpacity(0.1),
                                        checkColor: goldColor,
                                        searchTextStyle:
                                        openSansMedium.copyWith(color: darkGreyColor),
                                        searchable: true,
                                        searchHintStyle:
                                        openSansMedium.copyWith(color: darkGreyColor),
                                        searchHint: LocaleKeys.search.tr(),
                                        selectedItemsTextStyle:
                                        openSansMedium.copyWith(color: darkGreyColor),
                                        //   unselectedColor:darkGreyColor ,
                                        itemsTextStyle: openSansRegular,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: whiteGreyColor),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.RADIUS_LARGE)),
                                        items: registerProviderCubit
                                            .servicesByIdModel.subServices!
                                            .map((e) {
                                          return MultiSelectItem(e, e.name ?? '');
                                        }).toList(),
                                        onConfirm: (val) {
                                          print(val);
                                          registerProviderCubit.onUpdateSubServicesList(val);
                                          print('${registerProviderCubit.subServiceList} ///////////////////////////////////');
                                        },

                                      ),
                              //   ],
                              // ),

                              Spacer(flex: 3,),
                              state is UpdateServicesOfProviderLoadingState
                                  ? adaptiveCircleProgress()
                                  : CustomButton(
                                      textButton: LocaleKeys.update.tr(),
                                      color: darkGreysColor,
                                      onPressed: () {
                                        if(registerProviderCubit.serviceList.length != registerProviderCubit.idSub.length){
                                          showCustomSnackBar(message:LocaleKeys.mainServiceNotLinkedSubService.tr(), state: ToastState.ERROR);
                                        }else{
                                          registerProviderCubit.updateServicesProvider(
                                              context: context);
                                        }

                                      })
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
