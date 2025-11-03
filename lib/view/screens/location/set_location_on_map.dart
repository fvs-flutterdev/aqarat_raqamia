import 'package:aqarat_raqamia/bloc/location_cubit/cubit.dart';
import 'package:aqarat_raqamia/bloc/location_cubit/state.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/images.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/view/base/adaptive_dialog_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../translation/locale_keys.g.dart';
import '../../../utils/text_style.dart';
import '../../base/back_button.dart';
import '../../base/custom_text_field.dart';

//ignore: must_be_immutable
class SetLocationOnMap extends StatefulWidget {
  int i;
  bool isEdit;
  TextEditingController locationName = TextEditingController();
  TextEditingController? areaName;
  TextEditingController? cityName;
  TextEditingController? regionName;

  SetLocationOnMap({
    required this.i,
    required this.locationName,
    this.areaName,
    this.regionName,
    this.cityName,
    this.isEdit = false,
  });

  @override
  State<SetLocationOnMap> createState() => _SetLocationOnMapState();
}

class _SetLocationOnMapState extends State<SetLocationOnMap> {
  // GoogleMapController? mapController;

  CameraPosition? cameraPositions;

  @override
  Widget build(BuildContext context) {
    var locationCubit = LocationCubit.get(context);
    return BlocConsumer<LocationCubit, LocationState>(
      listener: (context, state) {},
      builder: (context, state) {
        TextEditingController locationName = TextEditingController(
            text: locationCubit.addressFromMap == ''
                ? locationCubit.address
                : locationCubit.addressFromMap);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: darkGreyColor,
            //  iconTheme: IconThemeData(color: whiteColor),
            //  automaticallyImplyLeading: false,
            title: Text(
              widget.i == 1
                  ? LocaleKeys.adsLocationOnMAP.tr()
                  : widget.i == 2
                      ? LocaleKeys.serviceLocationOnMap.tr()
                      : LocaleKeys.setLocation.tr(),
              style: openSansMedium.copyWith(color: whiteColor),
            ),
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BackButtonWidget(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    latAds = null;
                    lngAds = null;
                    latUserRegister = null;
                    latUserRegister = null;
                  });
                  context.read<LocationCubit>().getCurrentPosition();
                  print(
                      '<<<<<<<<<<<<<<<<<${locationCubit.regionId}>>>>>>>>>>>>>>>>>');
                  print(
                      '<<<<<<<<<<<<<<<<<${locationCubit.cityId}>>>>>>>>>>>>>>>>>');
                },
              ),
            ),
            //  leading: BackButtonWidget(radius: 2),
            actions: [
              state is SetLocationFromMapLoadingState
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        widget.locationName.text = locationCubit.addressFromMap;
                        widget.cityName?.text =
                            locationCubit.cityTextController.text;
                        widget.areaName?.text =
                            locationCubit.districtTextController.text;
                        widget.regionName?.text =
                            locationCubit.regionTextController.text;
                        print(
                            '<<<<<<<<<<<<<<<<<<<${widget.cityName?.text}>>>>>>>>>>>>>>>>>>>>');
                        print(
                            '<<<<<<<<<<<<<<<<<<<${widget.areaName?.text}>>>>>>>>>>>>>>>>>>>>');
                        print(
                            '<<<<<<<<<<<<<<<<<<<${widget.regionName?.text}>>>>>>>>>>>>>>>>>>>>');
                        print(
                            '<<<<<<<<<<<<<<<<<<<${widget.locationName.text}>>>>>>>>>>>>>>>>>>>>');
                        print('////////LATITUDE//$latAds');
                        print('////////LATITUDE//$lngAds');
                        if (widget.locationName.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(LocaleKeys.setLocation.tr()),
                            backgroundColor: redColor,
                          ));
                        } else {
                          Navigator.of(context).pop();
                          locationCubit.addressFromMap = '';
                        }
                      },
                      icon: Icon(
                        Icons.check,
                        color: whiteColor,
                      ))
            ],
          ),
          body: locationCubit.position?.latitude == null
              ? adaptiveCircleProgress()
              : Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.hybrid,
                      // onMapCreated: (googleController) {
                      // // cubit.changeMapMode(googleController);
                      // },
                      onCameraMove: (CameraPosition cameraPosition) {
                        cameraPositions = cameraPosition;
                      },
                      initialCameraPosition: CameraPosition(
                          target: LatLng(locationCubit.position!.latitude,
                              locationCubit.position!.longitude),
                          zoom: 16),
                      onCameraIdle: () async {
                        if (widget.isEdit == true) {
                          await locationCubit.getLocationFromMap(
                              cameraPositions, true);
                        } else {
                          await locationCubit.getLocationFromMap(
                              cameraPositions, false);
                        }
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      buildingsEnabled: false,
                    ),
                    //  state is SetLocationFromMapLoadingState?adaptiveCircleProgress():
                    Center(
                      child: Image.asset(Images.MARKER,
                          width: context.width * 0.1),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp)),
                      elevation: 3,
                      child: Container(
                        height: 90.sp,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15.sp),
                                topLeft: Radius.circular(15.sp))),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 1.3.h, left: 1.3.w, right: 1.3.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextField(
                                  lines: 1,
                                  controller: locationName,
                                  isEnabled: false,
                                  labelText: LocaleKeys.locationTitle.tr()),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
