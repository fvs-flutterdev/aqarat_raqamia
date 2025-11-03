import 'package:aqarat_raqamia/view/base/custom_drop_down.dart';
import 'package:flutter/cupertino.dart';

import '../../../bloc/location_cubit/cubit.dart';
import '../../../bloc/services_cubit/state.dart';
import '../../../utils/dimention.dart';
import '../../../utils/media_query_value.dart';
import '../../../utils/text_style.dart';
import '../../../view/base/adaptive_dialog_loader.dart';
import '../../../view/base/auth_header.dart';
import '../../../view/base/custom_text_field.dart';
import '../../../view/base/guest_widget.dart';
import '../../../view/base/lunch_widget.dart';
import '../../../view/base/main_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../bloc/location_cubit/state.dart';
import '../../../bloc/services_cubit/cubit.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/images.dart';
import '../../base/images_grid_view_widget.dart';
import '../../base/show_toast.dart';
import '../location/set_location_on_map.dart';
import '../../base/row_widget_image.dart';
import '../privacy_policy/privacy_policy_screen.dart';

//ignore: must_be_immutable
class RequestServiceScreen extends StatefulWidget {
  List? services;
  List? subServices;
  String? serviceName;
  String? serviceId;
  String? subServiceName;
  int? subServiceId;
  int? providerId;
  bool? isCustomProvider;

  RequestServiceScreen({
    super.key,
    this.serviceId,
    this.serviceName,
    this.subServiceName,
    this.subServiceId,
    this.providerId,
    this.services,
    this.subServices,
    this.isCustomProvider = false,
  });

  @override
  State<RequestServiceScreen> createState() => _RequestServiceScreenState();
}

class _RequestServiceScreenState extends State<RequestServiceScreen> {
  TextEditingController notesController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<LocationCubit>().getAllRegions();
    context.read<LocationCubit>().getCurrentPosition();
    context.read<ServicesCubit>().subServicesList.clear();
    context.read<ServicesCubit>().service=null;
    context.read<ServicesCubit>().subService=null;

    super.initState();
  }

  //final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    TextEditingController serviceController =
        TextEditingController(text: widget.serviceName);
    TextEditingController subServiceController =
        TextEditingController(text: widget.subServiceName);
    var uploadServiceCubit = context.read<ServicesCubit>();
    //  var regionCubit = context.read<RegionsCubit>();
    //UploadRequestCubit.get(context);
    var locationCubit = LocationCubit.get(context);
    // regionCubit.regionId = null;
    // regionCubit.isGetCities = false;
    // Get.find<UploadRequestController>();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        // appBar: AuthHeader(
        //   title: LocaleKeys.requestService.tr(),
        // ),
        body: Column(
          children: [
            Container(
              height: context.height * 0.17.h,
              margin: EdgeInsets.zero,
              child: AuthHeader(title: LocaleKeys.requestService.tr(),),
            ),
            Expanded(
              child: BlocConsumer<ServicesCubit, ServicesState>(
                listener: (context, state) {
                  if (state is RequestServicesLoadingState) {
                    adaptiveDialogLoader(context: context);
                  } else if (state is RequestServicesErrorState) {
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.isCustomProvider == false
                              ? const SizedBox()
                              : CustomDropDown(
                              items: widget.services!.map((e) {
                                return DropdownMenuItem(
                                  child: Text(e.name),
                                  value: e.id,
                                );
                              }).toList(),
                              value: uploadServiceCubit.service,
                              fct: (val) {
                                uploadServiceCubit.onChangeCustomService(val,widget.subServices);
                                // setState(() {
                                //
                                // });

                              },
                              hint: LocaleKeys.mainService.tr()),
                          widget.isCustomProvider == false
                              ? const SizedBox()
                              :uploadServiceCubit.subServicesList.isEmpty?SizedBox(): Padding(
                            padding:  EdgeInsetsDirectional.only(bottom: context.height*0.02),
                            child: CustomDropDown(
                                items: uploadServiceCubit.subServicesList.map((e) {
                                  return DropdownMenuItem(
                                    child: Text(e.name),
                                    value: e.id,
                                  );
                                }).toList(),
                                // items: widget.subServices!.map((e) {
                                //   return DropdownMenuItem(
                                //     child: Text(e.name),
                                //     value: e.id,
                                //   );
                                // }).toList(),
                                value: uploadServiceCubit.subService,
                                fct: (val) {
                                  uploadServiceCubit
                                      .onChangeCustomSubService(val);
                                },
                                hint: LocaleKeys.subService.tr()),
                          ),
                          widget.isCustomProvider == false
                              ? CustomTextField(
                            maxHeight: context.width * 0.2,
                            minHeight: context.width * 0.15,
                            labelText: LocaleKeys.mainService.tr(),
                            controller: serviceController,
                            isEnabled: false,
                            validator: (String val) {
                              if (val.isEmpty) {
                                return '';
                              }
                            },
                          )
                              : const SizedBox(),
                          widget.isCustomProvider == false
                              ? CustomTextField(
                            maxHeight: context.width * 0.2,
                            minHeight: context.width * 0.15,
                            controller: subServiceController,
                            labelText: LocaleKeys.subService.tr(),
                            validator: (String val) {
                              if (val.isEmpty) {
                                return '';
                              }
                            },
                            isEnabled: false,
                          )
                              : const SizedBox(),
                          BlocConsumer<LocationCubit, LocationState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      controller:
                                      locationCubit.locationTextController,
                                      labelText: LocaleKeys.location.tr(),
                                      maxHeight: context.width * 0.2,
                                      minHeight: context.width * 0.15,
                                      isEnabled: false,
                                      validator: (String val) {
                                        if (val.isEmpty) {
                                          return '';
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: Dimensions.PADDING_SIZE_DEFAULT,
                                  ),
                                  LocationCard(fct: () {
                                    navigateForward(SetLocationOnMap(
                                      i: 2,
                                      locationName:
                                      locationCubit.locationTextController,
                                      // areaName:
                                      //     locationCubit.locationTextController,
                                      // cityName:
                                      //     locationCubit.locationTextController,
                                    ));
                                  }),
                                ],
                              );
                              ;
                            },
                          ),
                          // BlocBuilder<RegionsCubit, RegionState>(
                          //     builder: (context, state) {
                          //   return regionCubit.isGetRegion == false
                          //       ? SizedBox()
                          //       : Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Text(
                          //               LocaleKeys.selectCityRegion.tr(),
                          //               style: openSansBold.copyWith(
                          //                   color: goldColor),
                          //             ),
                          //             FilterDropDown(
                          //               isRequestService: true,
                          //               fct: (onChange) async {
                          //                 regionCubit.onChangeRegionId(onChange);
                          //                 print(
                          //                     '??????????????????${regionCubit.regionId}');
                          //                 regionCubit.getCitiesByRegionId(
                          //                     page: 1,
                          //                     context: context,
                          //                     isNotPaginate: true);
                          //               },
                          //               hint: LocaleKeys.region.tr(),
                          //               isFlag: false,
                          //               items: regionCubit.allRegionsModel.data!
                          //                   .map((e) => DropdownMenuItem(
                          //                         child: Text(e.name.toString()),
                          //                         value: e.regionId,
                          //                       ))
                          //                   .toList(),
                          //             ),
                          //             regionCubit.regionId == null ||
                          //                     regionCubit.isGetCities == false
                          //                 ? SizedBox()
                          //                 : FilterDropDown(
                          //                     isRequestService: true,
                          //                     fct: (val) {
                          //                       regionCubit.onChangeCityId(val);
                          //                       print(val);
                          //                       print(
                          //                           '${regionCubit.cityId}///////////////////%%%%%%%%%%%%%');
                          //                     },
                          //                     hint: LocaleKeys.city.tr(),
                          //                     isFlag: false,
                          //                     items: regionCubit
                          //                         .cityByRegionIdModel.data!
                          //                         .map((e) => DropdownMenuItem(
                          //                               child: Text(
                          //                                   e.name.toString()),
                          //                               value: e.cityId,
                          //                             ))
                          //                         .toList())
                          //           ],
                          //         );
                          // }),
                          CustomTextField(
                            labelText: LocaleKeys.serviceDetails.tr(),
                            isBig: true,
                            controller: notesController,
                            lines: 20,
                            length: 2000,
                            validator: (String val) {
                              if (val.isEmpty) {
                                return LocaleKeys.serviceDescriptionRequired.tr();
                              }
                            },
                            //  lines: 9,
                            maxHeight: context.width * 0.39,
                            minHeight: context.width * 0.39,
                          ),
                          BlocConsumer<ServicesCubit, ServicesState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              return RowWidgetImage(
                                title: LocaleKeys.attachedImageMax5.tr(),
                                isListEmpty:
                                uploadServiceCubit.selectedImagesFile.isEmpty,
                                clearFun: () => uploadServiceCubit.clearImage(),
                              );
                            },
                          ),
                          SizedBox(
                            height: context.width * 0.02,
                          ),
                          BlocBuilder<ServicesCubit, ServicesState>(
                            builder: (context, state) {
                              return ImageGridViewWidget(
                                isProviderRegister: false,
                                isService: true,
                                isListEmpty:
                                uploadServiceCubit.selectedImagesFile.isEmpty,
                                pickImage: () => uploadServiceCubit.pickImages(),
                                countImage:
                                uploadServiceCubit.selectedImagesFile.length,
                                imageFile: uploadServiceCubit.selectedImagesFile,
                              );
                            },
                          ),
                          SizedBox(
                            height: context.width * 0.04,
                          ),
                          GestureDetector(
                            onTap: () => navigateForward(PrivacyPolicyScreen()),
                            child: ListTile(
                              leading: SvgPicture.asset(Images.PRIVACY_SVG),
                              title: AutoSizeText(
                                LocaleKeys.reviewTermsOfService.tr(),
                                style:
                                openSansBold.copyWith(color: darkGreyColor),
                              ),
                              trailing: Icon(
                                myLocale == "ar"
                                    ? Icons.arrow_back_ios_new_outlined
                                    : Icons.arrow_forward_ios,
                                color: darkGreyColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: context.width * 0.07.sp,
                          ),
                          // BlocBuilder<ServicesCubit, ServicesState>(
                          //   builder: (context, state) {
                          //     if(state is RequestServicesLoadingState){
                          //       adaptiveDialogLoader(context: context);
                          //     }
                          //     return
                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child:
                            // state is RequestServicesLoadingState
                            //     ? CircularProgressIndicator()
                            //     :
                            CustomButton(
                              textButton: LocaleKeys.requestServiceNow.tr(),
                              onPressed: () {
                                if (token == null) {
                                  showCustomSnackBar(message: LocaleKeys.loginFirst.tr(), state: ToastState.ERROR);
                                  // showBottomSheet(
                                  //     context: context,
                                  //     builder: (context) {
                                  //       return Container(
                                  //         child: LoginFirst(),
                                  //       );
                                  //     });
                                }
                                else if (_formKey.currentState!.validate()) {
                                  // if (uploadServiceCubit
                                  //     .selectedImagesFile.isEmpty) {
                                  //   showCustomSnackBar(
                                  //     //  context: context,
                                  //     message:
                                  //         LocaleKeys.selectImage5maxRequired.tr(),
                                  //     state: ToastState.ERROR,
                                  //     // isError: false,
                                  //     //  title: 'إختيار صور'
                                  //   );
                                  // }else
                                  // if (regionCubit.cityId == null) {
                                  //   showCustomSnackBar(
                                  //     //  context: context,
                                  //     message: LocaleKeys.pleaseSelectRegion.tr(),
                                  //     state: ToastState.ERROR,
                                  //     // isError: false,
                                  //     //  title: 'إختيار صور'
                                  //   );
                                  // } else {
                                  uploadServiceCubit.requestService(
                                    serviceId: widget.isCustomProvider == false
                                        ? widget.serviceId.toString()
                                        : uploadServiceCubit.service.toString(),
                                    subServiceId: widget.isCustomProvider == false
                                        ? widget.subServiceId.toString()
                                        : uploadServiceCubit.subService
                                        .toString(),
                                    context: context,
                                    notes: notesController.text,
                                    providerId: widget.providerId,
                                  );
                                }
                              },
                              color: darkGreyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  // return Stack(
                  //   alignment: AlignmentDirectional.bottomCenter,
                  //   children: [
                  //
                  //   ],
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
