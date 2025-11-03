import 'package:aqarat_raqamia/bloc/filter_search_add_cubit/cubit.dart';
import 'package:aqarat_raqamia/bloc/location_cubit/cubit.dart';
import 'package:aqarat_raqamia/bloc/location_cubit/state.dart';
import 'package:aqarat_raqamia/bloc/map_ads_cubit/cubit.dart';
import 'package:aqarat_raqamia/bloc/map_ads_cubit/state.dart';
import 'package:aqarat_raqamia/utils/dimention.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:aqarat_raqamia/view/base/adaptive_dialog_loader.dart';
import 'package:aqarat_raqamia/view/base/custom_text_field.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/base/show_toast.dart';
import 'package:aqarat_raqamia/view/error_widget/error_widget.dart';
import 'package:aqarat_raqamia/view/screens/location/map_style/map_style.dart';
import 'package:aqarat_raqamia/view/screens/location/widget/visibility_widget_on_map.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../bloc/add_real_ads/cubit.dart';
import '../../../bloc/region_cubit/cubit.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/images.dart';
import '../../base/back_button.dart';
import '../filter/filter_screen.dart';

//ignore: must_be_immutable
class AdsOnMap extends StatefulWidget {
  String? categoryId;
  String? space;
  String? adsType;

  AdsOnMap({super.key, this.categoryId, this.space, this.adsType});

  @override
  State<AdsOnMap> createState() => _AdsOnMapState();
}

class _AdsOnMapState extends State<AdsOnMap> {
  GoogleMapController? mapController;
  CameraPosition? cameraPositions;
  CarouselController carouselController = CarouselController();
  TextEditingController searchController = TextEditingController();
  TextEditingController searchCityController = TextEditingController();
  TextEditingController searchDistrictController = TextEditingController();

  @override
  void initState() {
    LocationCubit.get(context)
      ..handlePermission()
      ..getCurrentPosition()
      ..toggleServiceStatusStream();
    context.read<AdsOnMapCubit>()
      ..getAllAdsOnMap(
          //  controller: mapController,
          page: 1,
          context: context,
          categoryId: widget.categoryId,
          space: widget.space,
          adsType: widget.adsType,
          minPrice: context.read<FilterSearchAdsCubit>().startVal,
          maxPrice: context.read<FilterSearchAdsCubit>().endVal);
    super.initState();
  }

  final scrollControllerFilter = ScrollController();

  @override
  void dispose() {
    searchController.dispose();
    mapController?.dispose();
    scrollControllerFilter.dispose();
    searchDistrictController.dispose();
    searchCityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var addRealAdsCubit = context.read<AddRealAdsCubit>();
    var locationCubit = context.read<LocationCubit>();
    var adsOnMapCubit = context.read<AdsOnMapCubit>();
    var regionCubit = context.read<RegionsCubit>();
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
              //   preferredSize: Size.fromHeight(context.width * 0.45),
              preferredSize: Size.fromHeight(context.width * 0.5),
              child: SafeArea(
                  child: Padding(
                padding: const EdgeInsetsDirectional.only(
                    top: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                    start: Dimensions.PADDING_SIZE_DEFAULT,
                    end: Dimensions.PADDING_SIZE_DEFAULT),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(bottom: 18.0.sp),
                          child: BackButtonWidget(
                              color: darkGreyColor, radius: 18),
                        ),
                        const SizedBox(
                          width: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        Expanded(
                          child: CustomTextField(
                            controller: searchController,
                            backgroundColor: whiteColor,
                            labelText: LocaleKeys.search.tr(),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                if (searchController.text.isEmpty) {
                                  () {};
                                } else {
                                  adsOnMapCubit.getAllAdsOnMap(
                                    // controller: mapController,
                                    context: context,
                                  );
                                  searchController.clear();
                                }
                              },
                            ),
                            onSubmit: (val) {
                              setState(() {
                                adsOnMapCubit.adsMarkers.clear();
                                adsOnMapCubit.nearbyAqarModel.data!.clear();
                              });
                              adsOnMapCubit.getAllAdsOnMap(
                                  // controller: mapController,
                                  context: context,
                                  search: searchController.text,
                                  searchCity: searchCityController.text,
                                  searchDistrict:
                                      searchDistrictController.text);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        GestureDetector(
                          onTap: () {
                            addRealAdsCubit.returnAdsTypeToDefault();
                            addRealAdsCubit.returnPurposeStateToDefault();
                            navigateForward(FilterScreen(
                              id: 1,
                            ));
                            //  Get.to(() => );
                          },
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.only(bottom: 18.0.sp),
                            child: SvgPicture.asset(Images.Filter_SVG),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: searchCityController,
                            backgroundColor: whiteColor,
                            labelText: LocaleKeys.city.tr(),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                if (searchCityController.text.isEmpty) {
                                  () {};
                                } else {
                                  adsOnMapCubit.getAllAdsOnMap(
                                    // controller: mapController,
                                    context: context,
                                  );
                                  searchCityController.clear();
                                }
                              },
                            ),
                            onSubmit: (val) {
                              setState(() {
                                adsOnMapCubit.adsMarkers.clear();
                                adsOnMapCubit.nearbyAqarModel.data!.clear();
                              });
                              adsOnMapCubit.getAllAdsOnMap(
                                  // controller: mapController,
                                  context: context,
                                  search: searchController.text,
                                  searchCity: searchCityController.text,
                                  searchDistrict:
                                      searchDistrictController.text);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        Expanded(
                          child: CustomTextField(
                            controller: searchDistrictController,
                            backgroundColor: whiteColor,
                            labelText: LocaleKeys.district.tr(),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                if (searchDistrictController.text.isEmpty) {
                                  () {};
                                } else {
                                  adsOnMapCubit.getAllAdsOnMap(
                                    // controller: mapController,
                                    context: context,
                                  );
                                  searchDistrictController.clear();
                                }
                              },
                            ),
                            onSubmit: (val) {
                              setState(() {
                                adsOnMapCubit.adsMarkers.clear();
                                adsOnMapCubit.nearbyAqarModel.data!.clear();
                              });
                              adsOnMapCubit.getAllAdsOnMap(
                                  // controller: mapController,
                                  context: context,
                                  search: searchController.text,
                                  searchCity: searchCityController.text,
                                  searchDistrict:
                                      searchDistrictController.text);
                            },
                          ),
                        ),
                      ],
                    )
                    //  FilterWidgetDropDown(scrollControllerFilter: scrollControllerFilter,),
                  ],
                ),
              ))),
          body:
              // LocationController.kLocationServicesDisabledMessage ==
              LocationCubit.kLocationServicesDisabledMessage ==
                      'Location services are disabled'
                  ? TextButton(
                      onPressed: () {
                        locationCubit.getCurrentPosition();
                      },
                      child: Text(LocaleKeys.enableLocation.tr()))
                  : GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                      child: BlocConsumer<AdsOnMapCubit, AdsOnMapState>(
                        listener: (context, state) {
                          if (adsOnMapCubit.nearbyAqarModel.data!.isEmpty) {
                            //  return
                            showCustomSnackBar(
                              //context: context,
                              message: LocaleKeys.noRealEstateAvailable.tr(),
                              state: ToastState.ERROR,
                              // title: 'نتائج البحث',isError: false
                            );
                          }
                        },
                        builder: (context, state) {
                          if (adsOnMapCubit.isGetAqarData == false ||
                              locationCubit.position?.latitude == null) {
                            return adaptiveCircleProgress();
                          }
                          if (state is GetAllAdsMapErrorState) {
                            return CustomErrorWidget(reload: () {
                              adsOnMapCubit.getAllAdsOnMap(
                                  //  controller: mapController,
                                  page: 1,
                                  context: context);
                            });
                          }
                          return Stack(
                            children: [
                              GoogleMap(
                                onMapCreated:
                                    (GoogleMapController controller) async {
                                  mapController = controller;
                                  // for (var data in adsOnMapCubit.nearbyAqarModel.data!) {
                                  //  // Future.delayed(Duration(seconds: 1), () async{
                                  //     mapController?.showMarkerInfoWindow(MarkerId(data.id.toString()));
                                  //  // });
                                  // }
                                  controller
                                      .setMapStyle(UtilesMapStyle.mapStyle);
                                  Future.delayed(Duration(seconds: 1), () {
                                    adsOnMapCubit.nearbyAqarModel.data!
                                        .forEach((element) {
                                      print(
                                          '<<<<<<<<<<<<<${element.id.toString()}>>>>>>>>>>>>>');

                                      controller.showMarkerInfoWindow(
                                          MarkerId(element.id.toString()));
                                    });
                                  });

                                  // Future.delayed(Duration(seconds: 1), () {
                                  //   // adsOnMapCubit.nearbyAqarModel.data!.forEach((element) {
                                  //   //   element.id.toString();
                                  //   //
                                  //   // });
                                  //
                                  // });
                                },
                                gestureRecognizers: Set()
                                  ..add(Factory<PanGestureRecognizer>(
                                      () => PanGestureRecognizer())),
                                onCameraMoveStarted: () async {
                                  if (adsOnMapCubit
                                          .nearbyAqarModel.data?.length !=
                                      adsOnMapCubit
                                          .nearbyAqarModel.meta?.total) {
                                    adsOnMapCubit.nearbyAqarModel.data!
                                        .forEach((element) {
                                      mapController?.showMarkerInfoWindow(
                                          MarkerId(element.id.toString()));
                                    });
                                    // adsOnMapCubit.nearbyAqarModel.data!.forEach((element) {
                                    //   mapController?.showMarkerInfoWindow(MarkerId(element.id.toString()));
                                    // });
                                    return await adsOnMapCubit.getAllAdsOnMap(
                                        //  controller: mapController,
                                        page: adsOnMapCubit.pagePaginate++,
                                        context: context);
                                  } else if (adsOnMapCubit
                                          .nearbyAqarModel.links?.next ==
                                      null) {
                                    return null;
                                    //  debugPrint('Hello/////////????????????????');
                                    // }
                                    //  print('object////////////////////////////');
                                  }
                                },

                                ///
                                onCameraIdle: () async {
                                  if (adsOnMapCubit
                                          .nearbyAqarModel.data?.length !=
                                      adsOnMapCubit
                                          .nearbyAqarModel.meta?.total) {
                                    adsOnMapCubit.nearbyAqarModel.data!
                                        .forEach((element) {
                                      mapController?.showMarkerInfoWindow(
                                          MarkerId(element.id.toString()));
                                    });
                                    // adsOnMapCubit.nearbyAqarModel.data!.forEach((element) {
                                    //   mapController?.showMarkerInfoWindow(MarkerId(element.id.toString()));
                                    // });
                                    return await adsOnMapCubit.getAllAdsOnMap(
                                        //   controller: mapController,
                                        page: adsOnMapCubit.pagePaginate++,
                                        context: context);
                                  } else if (adsOnMapCubit
                                          .nearbyAqarModel.links?.next ==
                                      null) {
                                    return null;
                                    //  debugPrint('Hello/////////????????????????');
                                    // }
                                    //  print('object////////////////////////////');
                                  }
                                },

                                ///
                                // onCameraMove: (CameraPosition cameraPosition) async{
                                //   // cameraPositions = cameraPosition;
                                //   // mapController?.getVisibleRegion();
                                //   if(adsOnMapCubit.nearbyAqarModel.data?.length != adsOnMapCubit.nearbyAqarModel.meta?.total){
                                //     return  await adsOnMapCubit.getAllAdsOnMap(
                                //         page: adsOnMapCubit.pagePaginate++,
                                //         context: context);
                                //   }
                                //   else if (adsOnMapCubit.nearbyAqarModel.links?.next == null) {
                                //     return null;
                                //     //  debugPrint('Hello/////////????????????????');
                                //     // }
                                //     //  print('object////////////////////////////');
                                //   }
                                // },
                                // onMapCreated: (GoogleMapController controller) {
                                //
                                // },
                                ///
                                myLocationEnabled: true,
                                onTap: (l) {
                                  setState(() {
                                    adsOnMapCubit.tabbed = 00;
                                  });
                                },
                                markers:
                                    Set<Marker>.of(adsOnMapCubit.adsMarkers),
                                myLocationButtonEnabled: true,
                                initialCameraPosition: CameraPosition(
                                  zoom: 15,
                                  target: LatLng(
                                    locationCubit.position!.latitude,
                                    locationCubit.position!.longitude,
                                  ),
                                ),
                              ),
                              //    ),
                              adsOnMapCubit.nearbyAqarModel.data!.isEmpty
                                  ? const SizedBox()
                                  : VisibilityWidgetOnMap()
                              // Visibility(
                              //         visible: adsOnMapCubit.tabbed != 00,
                              //         child: Align(
                              //           alignment:
                              //               AlignmentDirectional.bottomCenter,
                              //           child: Column(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.end,
                              //             children: [
                              //               Card(
                              //                 elevation: 3,
                              //                 margin: EdgeInsets.all(Dimensions
                              //                     .PADDING_SIZE_SMALL),
                              //                 shape: RoundedRectangleBorder(
                              //                     borderRadius:
                              //                         BorderRadius.circular(
                              //                             Dimensions
                              //                                 .RADIUS_LARGE)),
                              //                 child: SimilarAds(
                              //                   image: adsOnMapCubit
                              //                           .nearbyAqarModel
                              //                           .data![
                              //                               adsOnMapCubit.adsId]
                              //                           .photos!
                              //                           .isEmpty
                              //                       ? Images.AVATAR_IMAGE
                              //                       : adsOnMapCubit
                              //                           .nearbyAqarModel
                              //                           .data![
                              //                               adsOnMapCubit.adsId]
                              //                           .photos!
                              //                           .first,
                              //                   isFavouriteWidget: false,
                              //                   isTabbedFavourite: adsOnMapCubit
                              //                       .nearbyAqarModel
                              //                       .data![adsOnMapCubit.adsId]
                              //                       .isFavorite!,
                              //                   favouriteFunction: () {
                              //                     adsOnMapCubit
                              //                             .nearbyAqarModel
                              //                             .data![adsOnMapCubit
                              //                                 .adsId]
                              //                             .isFavorite!
                              //                         ? adsOnMapCubit.removeFavourite(
                              //                             adsOnMapCubit.adsId,
                              //                             adsOnMapCubit
                              //                                 .nearbyAqarModel
                              //                                 .data![
                              //                                     adsOnMapCubit
                              //                                         .adsId]
                              //                                 .id
                              //                                 .toString(),
                              //                             context)
                              //                         : adsOnMapCubit.addFavourite(
                              //                             adsOnMapCubit.adsId,
                              //                             adsOnMapCubit
                              //                                 .nearbyAqarModel
                              //                                 .data![
                              //                                     adsOnMapCubit
                              //                                         .adsId]
                              //                                 .id
                              //                                 .toString(),
                              //                             context);
                              //                   },
                              //                   onTap: () {
                              //                     context
                              //                         .read<AdyByIdCubit>()
                              //                         .getAdById(
                              //                             id: adsOnMapCubit
                              //                                 .nearbyAqarModel
                              //                                 .data![
                              //                                     adsOnMapCubit
                              //                                         .adsId]
                              //                                 .id!);
                              //                     navigateForward(
                              //                         AqarDetailsScreen(
                              //                       adId: adsOnMapCubit
                              //                           .nearbyAqarModel
                              //                           .data![
                              //                               adsOnMapCubit.adsId]
                              //                           .id!,
                              //                       categoryId: adsOnMapCubit
                              //                           .nearbyAqarModel
                              //                           .data![
                              //                               adsOnMapCubit.adsId]
                              //                           .categoryAds!
                              //                           .id
                              //                           .toString(),
                              //                       // aqarIndex: 0,
                              //                     ));
                              //                   },
                              //                   child: Padding(
                              //                     padding: const EdgeInsets
                              //                         .only(
                              //                         bottom: Dimensions
                              //                             .PADDING_SIZE_EXTRA_SMALL),
                              //                     child: Column(
                              //                       crossAxisAlignment:
                              //                           CrossAxisAlignment
                              //                               .start,
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .center,
                              //                       children: [
                              //                         Row(
                              //                           mainAxisSize:
                              //                               MainAxisSize.max,
                              //                           mainAxisAlignment:
                              //                               MainAxisAlignment
                              //                                   .spaceBetween,
                              //                           children: [
                              //                             Text(
                              //                                 '${adsOnMapCubit.nearbyAqarModel.data?[adsOnMapCubit.adsId].categoryAds?.name ?? ''}',
                              //                                 style: openSansMedium
                              //                                     .copyWith(
                              //                                         color:
                              //                                             darkGreyColor)),
                              //                             //  Spacer(),
                              //
                              //                             Text(
                              //                                 '${adsOnMapCubit.nearbyAqarModel.data?[adsOnMapCubit.adsId].price} ${LocaleKeys.currency.tr()}',
                              //                                 style: openSansMedium
                              //                                     .copyWith(
                              //                                         color:
                              //                                             goldColor))
                              //                           ],
                              //                         ),
                              //                         Row(
                              //                           children: [
                              //                             SvgPicture.asset(Images
                              //                                 .SMALL_LOCATION),
                              //                             SizedBox(
                              //                               width: 5.w,
                              //                             ),
                              //                             Expanded(
                              //                               child: Text(
                              //                                 "${adsOnMapCubit.nearbyAqarModel.data?[adsOnMapCubit.adsId].district}, ${adsOnMapCubit.nearbyAqarModel.data?[adsOnMapCubit.adsId].city}, ${adsOnMapCubit.nearbyAqarModel.data?[adsOnMapCubit.adsId].region}",
                              //                                 // adsOnMapCubit
                              //                                 //         .nearbyAqarModel
                              //                                 //         .data?[
                              //                                 //             adsOnMapCubit
                              //                                 //                 .adsId]
                              //                                 //         .address ??
                              //                                 //     '',
                              //                                 softWrap: true,
                              //                                 overflow:
                              //                                     TextOverflow
                              //                                         .ellipsis,
                              //                                 style: openSansMedium
                              //                                     .copyWith(
                              //                                         color:
                              //                                             darkGreyColor),
                              //                               ),
                              //                             ),
                              //                           ],
                              //                         ),
                              //                         adsOnMapCubit.nearbyAqarModel.data?[adsOnMapCubit.adsId].categoryAds?.id == 12 ||
                              //                                 adsOnMapCubit.nearbyAqarModel.data?[adsOnMapCubit.adsId].categoryAds?.id ==
                              //                                     14 ||
                              //                                 adsOnMapCubit.nearbyAqarModel.data?[adsOnMapCubit.adsId].categoryAds?.id ==
                              //                                     18 ||
                              //                                 adsOnMapCubit
                              //                                         .nearbyAqarModel
                              //                                         .data?[adsOnMapCubit
                              //                                             .adsId]
                              //                                         .categoryAds
                              //                                         ?.id ==
                              //                                     13 ||
                              //                                 adsOnMapCubit
                              //                                         .nearbyAqarModel
                              //                                         .data?[adsOnMapCubit
                              //                                             .adsId]
                              //                                         .categoryAds
                              //                                         ?.id ==
                              //                                     19 ||
                              //                                 adsOnMapCubit
                              //                                         .nearbyAqarModel
                              //                                         .data?[adsOnMapCubit
                              //                                             .adsId]
                              //                                         .categoryAds
                              //                                         ?.id ==
                              //                                     16 ||
                              //                                 adsOnMapCubit
                              //                                         .nearbyAqarModel
                              //                                         .data?[adsOnMapCubit
                              //                                             .adsId]
                              //                                         .categoryAds
                              //                                         ?.id ==
                              //                                     21 ||
                              //                                 adsOnMapCubit
                              //                                         .nearbyAqarModel
                              //                                         .data?[adsOnMapCubit
                              //                                             .adsId]
                              //                                         .categoryAds
                              //                                         ?.id ==
                              //                                     24 ||
                              //                                 adsOnMapCubit
                              //                                         .nearbyAqarModel
                              //                                         .data?[adsOnMapCubit
                              //                                             .adsId]
                              //                                         .categoryAds
                              //                                         ?.id ==
                              //                                     25 ||
                              //                                 adsOnMapCubit
                              //                                         .nearbyAqarModel
                              //                                         .data?[adsOnMapCubit
                              //                                             .adsId]
                              //                                         .categoryAds
                              //                                         ?.id ==
                              //                                     27 ||
                              //                                 adsOnMapCubit
                              //                                         .nearbyAqarModel
                              //                                         .data?[adsOnMapCubit
                              //                                             .adsId]
                              //                                         .categoryAds
                              //                                         ?.id ==
                              //                                     34 ||
                              //                                 adsOnMapCubit
                              //                                         .nearbyAqarModel
                              //                                         .data?[adsOnMapCubit
                              //                                             .adsId]
                              //                                         .categoryAds
                              //                                         ?.id ==
                              //                                     36 ||
                              //                                 adsOnMapCubit.nearbyAqarModel.data?[adsOnMapCubit.adsId].categoryAds?.id == 35 &&
                              //                                     adsOnMapCubit
                              //                                         .nearbyAqarModel
                              //                                         .data![adsOnMapCubit.adsId]
                              //                                         .additionalFeatures!
                              //                                         .isNotEmpty
                              //                             ? Container(
                              //                                 height: adsOnMapCubit
                              //                                         .nearbyAqarModel
                              //                                         .data![adsOnMapCubit
                              //                                             .adsId]
                              //                                         .additionalFeatures!
                              //                                         .isEmpty
                              //                                     ? 0
                              //                                     : 20.sp,
                              //                                 width:
                              //                                     context.width,
                              //                                 child: ListView
                              //                                     .builder(
                              //                                         physics:
                              //                                             NeverScrollableScrollPhysics(),
                              //                                         scrollDirection:
                              //                                             Axis
                              //                                                 .horizontal,
                              //                                         itemCount: adsOnMapCubit.nearbyAqarModel.data![adsOnMapCubit.adsId].additionalFeatures!.length >=
                              //                                                 2
                              //                                             ? 2
                              //                                             : adsOnMapCubit
                              //                                                 .nearbyAqarModel
                              //                                                 .data![adsOnMapCubit
                              //                                                     .adsId]
                              //                                                 .additionalFeatures!
                              //                                                 .length,
                              //                                         itemBuilder:
                              //                                             (context,
                              //                                                 i) {
                              //                                           return FittedBox(
                              //                                             child:
                              //                                                 Row(
                              //                                               mainAxisAlignment:
                              //                                                   MainAxisAlignment.spaceBetween,
                              //                                               mainAxisSize:
                              //                                                   MainAxisSize.max,
                              //                                               children: [
                              //                                                 Image.network(
                              //                                                   adsOnMapCubit.nearbyAqarModel.data![adsOnMapCubit.adsId].additionalFeatures?[i].image ?? 'https://dashboard.redd.sa/dash/additional_features/1717849710.png',
                              //                                                   width: 20.sp,
                              //                                                   height: 20.sp,
                              //                                                 ),
                              //                                                 AutoSizeText(
                              //                                                   adsOnMapCubit.nearbyAqarModel.data![adsOnMapCubit.adsId].additionalFeatures?[i].name ?? '',
                              //                                                   presetFontSizes: [
                              //                                                     12.sp,
                              //                                                     10.sp,
                              //                                                     7.sp
                              //                                                   ],
                              //                                                   style: openSansMedium.copyWith(color: goldColor),
                              //                                                 ),
                              //                                                 SizedBox(
                              //                                                   width: context.width * 0.1,
                              //                                                 ),
                              //                                               ],
                              //                                             ),
                              //                                           );
                              //                                         }),
                              //                               )
                              //                             : SizedBox(),
                              //                         SizedBox(
                              //                           height: Dimensions
                              //                               .PADDING_SIZE_DEFAULT,
                              //                         )
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //               DragabbleWidget(),
                              //             ],
                              //           ),
                              //         ),
                              //       )
                            ],
                          );
                        },
                      ),
                    ),
        );
      },
    );
  }
}
