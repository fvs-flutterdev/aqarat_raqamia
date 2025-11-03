import 'dart:async';
import 'package:aqarat_raqamia/bloc/location_cubit/state.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../model/dynamic_model/regions/city_model.dart';
import '../../model/dynamic_model/regions/regions_model.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/base_url.dart';
import '../../utils/dio.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(InitialLocationState());

  static LocationCubit get(context) => BlocProvider.of(context);
  static const String kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String kPermissionDeniedMessage = 'Permission denied.';
  static const String kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String kPermissionGrantedMessage = 'Permission granted.';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  StreamSubscription<Position>? _positionStreamSubscription;
  StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;
  bool positionStreamStarted = false;
  Position? position;
  String address = '';
  TextEditingController locationTextController = TextEditingController();
  TextEditingController cityTextController = TextEditingController();
  TextEditingController regionTextController = TextEditingController();
  TextEditingController districtTextController =
      TextEditingController(text: '');



  late AllRegionsModel allRegionsModel;
  bool? isGetRegion;
  int? regionId;

  getAllRegions() {
    isGetRegion = false;
    emit(GetAllRegionsLoadingState());
    DioHelper.getData(
      url: BaseUrl.baseUrl + BaseUrl.GetRegions,
      locale:"ar"

    ).then((value) async{
      allRegionsModel = AllRegionsModel.fromJson(value.data);
      allRegionsModel.data?.insert(
          0,
          RegionData(
              regionId: 0, istabbed: false, name: LocaleKeys.allRegions.tr()));
      isGetRegion = true;
     // print('<<<<<<<<<<<<<<<<Region ${allRegionsModel.data}>>>>>>>>>>>>>>>>');
      emit(GetAllRegionsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllRegionsErrorState(error: error.toString()));
    });
  }


  int? cityId;

  Future<void> getCurrentPosition() async {
    final hasPermission = await handlePermission();

    if (!hasPermission) {
      print(hasPermission);
      return;
    }
    if (hasPermission == false) {
      getCurrentPosition();
    }

    position = await _geolocatorPlatform.getCurrentPosition(
        locationSettings: LocationSettings(
      accuracy: LocationAccuracy.high,
    ));

    updatePositionList(
      _PositionItemType.position,
      position.toString(),
    );

    print('<<<<<<<<<<<<<<<${position?.latitude}>>>>>>>>>>>>>>>');
    print('<<<<<<<<<<<<<<<${position?.longitude}>>>>>>>>>>>>>>>');
    getPlace(position!);

    emit(GetCurrentLocationState());
    //  update();
  }

  void getPlace(
    Position pos,
  ) async {
    await setLocaleIdentifier('ar');
    List<Placemark> newPlace = await placemarkFromCoordinates(
      pos.latitude,
      pos.longitude,
     // localeIdentifier: "ar-SA",
    );

    Placemark placeMark = newPlace[0];

    String name = placeMark.name.toString();
    String street = placeMark.street.toString();
    String subLocality = placeMark.subLocality.toString();
    String locality = placeMark.locality.toString();
    String postalCode = placeMark.postalCode.toString();
    String country = placeMark.country.toString();
    String administrativeArea = placeMark.administrativeArea.toString();
    address = subLocality +
        ',' +
        street +
        ',' +
        locality +
        ',' +
        postalCode +
        ',' +
        administrativeArea +
        ',' +
        country +
        ',' +
        name;
    cityTextController.text = placeMark.subAdministrativeArea.toString();
    districtTextController.text = placeMark.subLocality.toString();
    regionTextController.text = placeMark.administrativeArea.toString();
    print('address 223 $address');
    locationTextController.text = address;
    latAds = pos.latitude;
    lngAds = pos.longitude;
    print(placeMark.locality.toString());
    emit(GetPlaceLocationState());

    for (var item in allRegionsModel.data!) {
      if (item.name!.contains(regionTextController.text)) {
        regionId = item.regionId;
        currentRegion=item.regionId;
        print('<<<<<<<<<<REGION ID<<<<<<<<<$regionId>>>>>>>>>>>>>>>>>>>');
        print('<<<<<<<<<<CurrentRegion ID<<<<<<<<<$currentRegion>>>>>>>>>>>>>>>>>>>');

      // Future.wait([
      // ]);
        break;
      }
      // Future.delayed(Duration(seconds: 1)).then((value) {
      //   if(item.name!.contains(regionTextController.text)){
      //     currentRegion=item.regionId;
      //     print('<<<<<<<<<<CurrentRegion ID<<<<<<<<<$currentRegion>>>>>>>>>>>>>>>>>>>');
      //
      //   }
      // });
      // break;
    }
    emit(GetPlaceLocationState());
     print('<<<<<<<<<<<<<<<<<<<<<<${regionId}>>>>>>>>>>>>4444>>>>>>>>>>');
    print('<<<<<<<<<<<<<<<<<<<<<<${currentRegion}>>>>>>>>>>>>4444>>>>>>>>>>');
    getCitiesByRegionId(page: 1);
    print('<<<<<<<<<!!!!!!!!!!!<<<<<<<<<<<<<${cityId}>>>>>>>>>>!!!!!!!!!!!!>>>>>>>>>>>>');
    print('<<<<<<//////<<<<<<<<<<$latAds>>>>>>>>>>>>>>>>');
    print('<<<<<<//////<<<<<<<<<<$lngAds>>>>>>>>>>>>>>>>');
    print('Area Location ${districtTextController.text}');
    print('Region Location ${regionTextController.text}');
    print('City Location ${cityTextController.text}');
    print(pos.longitude);
    // for (var item in allRegionsModel.data!) {
    //   if (item.name!.contains(regionTextController.text)) {
    //     regionId = item.regionId;
    //
    //     print('<<<<<<<<<<REGION ID<<<<<<<<<$regionId>>>>>>>>>>>>>>>>>>>');
    //
    //   // Future.wait([
    //   // ]);
    //     break;
    //   }
    // //  Future.delayed(Duration(seconds: 1)).then((value) {
    //   print('<<<<<<<<<<<<${regionTextController.text}>>>>>>>>>>>>');
    //     if(item.name!.contains(regionTextController.text)){
    //       currentRegion=item.regionId;
    //       print('<<<<<<<<<<CurrentRegion ID<<<<<<<<<$currentRegion>>>>>>>>>>>>>>>>>>>');
    //
    //     }
    //   //});
    //   break;
    // }
    print('$currentRegion   issssss');
  }

  String addressFromMap = '';


  getLocationFromMap(cameraPositions,bool? isEdit) async {
    latAds = null;
    lngAds = null;
    lngAdsEdit=null;
    latAdsEdit=null;
    emit(SetLocationFromMapLoadingState());
    await setLocaleIdentifier(myLocale.toString());
    List<Placemark> newPlace = await placemarkFromCoordinates(
        cameraPositions.target.latitude, cameraPositions.target.longitude,
      //  localeIdentifier:"ar-SA"
        //myLocale.toString()
        //myLocale.toString()
        );

    Placemark placeMark = newPlace[0];
    String name = placeMark.name.toString();
    String street = placeMark.street.toString();
    String subLocality = placeMark.subLocality.toString();
    String locality = placeMark.locality.toString();
    String postalCode = placeMark.postalCode.toString();
    String country = placeMark.country.toString();
    String administrativeArea = placeMark.administrativeArea.toString();
    String address = subLocality +
        ',' +
        street +
        ',' +
        locality +
        ',' +
        postalCode +
        ',' +
        administrativeArea +
        ',' +
        country +
        ',' +
        name;
    print(address);
    addressFromMap = address;
    cityTextController.text = placeMark.subAdministrativeArea.toString();
    districtTextController.text = placeMark.subLocality.toString();
    regionTextController.text = placeMark.administrativeArea.toString();
    print(cameraPositions.target.latitude);
    print(cameraPositions.target.longitude);
    latAds = cameraPositions.target.latitude;
    lngAds = cameraPositions.target.longitude;
    if(isEdit==true){
      latAdsEdit=cameraPositions.target.latitude;
      lngAdsEdit=cameraPositions.target.longitude;
    }
    emit(GetLocationFromMapState());
    for (var item in allRegionsModel.data!) {
      if (item.name!.contains(regionTextController.text)) {
        regionId = item.regionId;
        emit(GetLocationFromMapState());
        // Future.wait([
     // await
   //   getCitiesByRegionId(page: page++);
        //  ]);

        break;
      }
    }
    getCitiesByRegionId(page: 1);
    print('<<<<<<<<<<<<<<<<<<<<<<${regionId}>>>>>>>>>>>>>>>>>>>>>>');
    for (var item in cityByRegionIdModel.data!) {
      if (item.name!.contains(cityTextController.text)) {
        cityId = item.cityId;

        break;
      }
    }
    emit(GetLocationFromMapState());
    print(
        '<<<<<<<<<!!!!!!!!!!!<<<<<<<<<<<<<${cityId}>>>>>>>>>>!!!!!!!!!!!!>>>>>>>>>>>>');
    print('<<<<<<<LAT<<<<<<<<<$latAds>>>>>>>>>>>>>>>>');
    print('<<<<<<<LNG<<<<<<<<<$lngAds>>>>>>>>>>>>>>>>');
    print('Area Location ${districtTextController.text}');
    print('Region Location ${regionTextController.text}');
    print('City Location ${cityTextController.text}');
    print('///////////////////////// $addressFromMap');
  }



  late CityByRegionIdModel cityByRegionIdModel;
  bool? isGetCities;
int page=1;
  Future getCitiesByRegionId(
      {required int page, bool isNotPaginate = false}) async {
    isGetCities = false;
   // cityId=null;
    DioHelper.getData(
      url: '${BaseUrl.baseUrl}${BaseUrl.GetCities}/$regionId',
      isPaginate: 0,
      locale: "ar",
      //isNotPaginate ? 0 : 1,
      page: page,
    ).then((value) {
      if (page == 1) {
        cityByRegionIdModel = CityByRegionIdModel.fromJson(value.data);
        for (var item in cityByRegionIdModel.data!) {
          if (item.name!.contains(cityTextController.text)) {
            cityId = item.cityId;
            // emit(GetPlaceLocationState());
            print('<<<<<<<<<<<<<<<CITYiD IS<<<<<$cityId>>>>>>>>>>>>>>>>>>>>');
            emit(GetPlaceLocationState());
            break;
          }
        }

      } else {
        cityByRegionIdModel.meta?.currentPage =
            CityByRegionIdModel.fromJson(value.data).meta?.currentPage;
        cityByRegionIdModel.meta?.lastPage =
            CityByRegionIdModel.fromJson(value.data).meta?.lastPage;
        cityByRegionIdModel.meta?.total =
            CityByRegionIdModel.fromJson(value.data).meta?.total;
        cityByRegionIdModel.meta?.perPage =
            CityByRegionIdModel.fromJson(value.data).meta?.perPage;
        cityByRegionIdModel.data
            ?.addAll(CityByRegionIdModel.fromJson(value.data).data ?? []);
      }
      isGetCities = true;
      print('//////////////////////$isGetCities');
      for (var item in cityByRegionIdModel.data!) {
        if (item.name!.contains(cityTextController.text)) {
          cityId = item.cityId;
          // emit(GetPlaceLocationState());
          print('<<<<<<<<<<<<<<<CITYiD IS<<<<<$cityId>>>>>>>>>>>>>>>>>>>>');
           emit(GetPlaceLocationState());
          break;
        }
      }
      emit(GetAllCitiesByRegionIdSuccessState());
    }).catchError((error) {
      print(error.toString());
      isGetCities = false;
      emit(GetAllCitiesByRegionIdErrorState(error: error.toString()));
    });
  }

  getStringAddress(
      {required int i, required TextEditingController controller}) {
    controller.text = addressFromMap;
    locationTextController.text = addressFromMap;
    emit(GetStringLocationFromMapState());
    // update();
    addressFromMap = '';
  }

  Future<bool> handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _geolocatorPlatform.getCurrentPosition();
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      updatePositionList(
        _PositionItemType.log,
        kLocationServicesDisabledMessage,
      );
      print(
          '<<<<<<<<<<<<<<<<<<<<<<<<${_PositionItemType.log}>>>>>>>>>>>>>>>>>>>>>>>>');
      print(
          '<<<<<<<<<<<<<<<<$kLocationServicesDisabledMessage>>>>>>>>>>>>>>>>');

      return true;
    }
    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        updatePositionList(
          _PositionItemType.log,
          kPermissionDeniedMessage,
        );
        print(
            '<<<<<<<<<<<<<<<<<<<<<<<<${_PositionItemType.log}>>>>>>>>>>>>>>>>>>>>>>>>');
        print(
            '<<<<<<<<<<<<<<<<$kLocationServicesDisabledMessage>>>>>>>>>>>>>>>>');

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      updatePositionList(
        _PositionItemType.log,
        kPermissionDeniedForeverMessage,
      );
      print(
          '<<<<<<<<<<<<<<<<<<<<<<<<${_PositionItemType.log}>>>>>>>>>>>>>>>>>>>>>>>>');
      print(
          '<<<<<<<<<<<<<<<<$kLocationServicesDisabledMessage>>>>>>>>>>>>>>>>');
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    updatePositionList(
      _PositionItemType.log,
      kPermissionGrantedMessage,
    );
    print(
        '<<<<<<<<<<<<<<<<<<<<<<<<${_PositionItemType.log}>>>>>>>>>>>>>>>>>>>>>>>>');
    print('<<<<<<<<<<<<<<<<$kLocationServicesDisabledMessage>>>>>>>>>>>>>>>>');
    return true;
  }

  void updatePositionList(_PositionItemType type, String displayValue) {
    _positionItems.add(_PositionItem(type, displayValue));
    emit(UpdatePositionLocationState());
    // update();
  }

  bool _isListening() => !(_positionStreamSubscription == null ||
      _positionStreamSubscription!.isPaused);

  Color _determineButtonColor() {
    return _isListening() ? Colors.green : Colors.red;
  }

  void toggleServiceStatusStream() {
    if (_serviceStatusStreamSubscription == null) {
      final serviceStatusStream = _geolocatorPlatform.getServiceStatusStream();
      _serviceStatusStreamSubscription =
          serviceStatusStream.handleError((error) {
        _serviceStatusStreamSubscription?.cancel();
        _serviceStatusStreamSubscription = null;
      }).listen((serviceStatus) {
        String serviceStatusValue;
        if (serviceStatus == ServiceStatus.enabled) {
          if (positionStreamStarted) {
            _toggleListening();
          }
          serviceStatusValue = 'enabled';
        } else {
          if (_positionStreamSubscription != null) {
            // setState(() {
            _positionStreamSubscription?.cancel();
            _positionStreamSubscription = null;
            updatePositionList(
                _PositionItemType.log, 'Position Stream has been canceled');
            emit(GetServiceStreamLocationState());
            //  update();
            //  });
          }
          serviceStatusValue = 'disabled';
        }
        updatePositionList(
          _PositionItemType.log,
          'Location service has been $serviceStatusValue',
        );
      });
    }
  }

  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      final positionStream = _geolocatorPlatform.getPositionStream();
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription?.cancel();
        _positionStreamSubscription = null;
      }).listen((position) => updatePositionList(
            _PositionItemType.position,
            position.toString(),
          ));
      _positionStreamSubscription?.pause();
    }

    // setState(() {
    if (_positionStreamSubscription == null) {
      return;
    }

    String statusDisplayValue;
    if (_positionStreamSubscription!.isPaused) {
      _positionStreamSubscription!.resume();
      statusDisplayValue = 'resumed';
    } else {
      _positionStreamSubscription!.pause();
      statusDisplayValue = 'paused';
    }

    updatePositionList(
      _PositionItemType.log,
      'Listening for position updates $statusDisplayValue',
    );
    //  update();
    // });
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription!.cancel();
      _positionStreamSubscription = null;
    }

    // super.dispose();
  }

  void _getLastKnownPosition() async {
    final position = await _geolocatorPlatform.getLastKnownPosition();
    if (position != null) {
      updatePositionList(
        _PositionItemType.position,
        position.toString(),
      );
    } else {
      updatePositionList(
        _PositionItemType.log,
        'No last known position available',
      );
    }
  }

  void _getLocationAccuracy() async {
    final status = await _geolocatorPlatform.getLocationAccuracy();
    _handleLocationAccuracyStatus(status);
  }

  void _requestTemporaryFullAccuracy() async {
    final status = await _geolocatorPlatform.requestTemporaryFullAccuracy(
      purposeKey: "TemporaryPreciseAccuracy",
    );
    _handleLocationAccuracyStatus(status);
  }

  void _handleLocationAccuracyStatus(LocationAccuracyStatus status) {
    String locationAccuracyStatusValue;
    if (status == LocationAccuracyStatus.precise) {
      locationAccuracyStatusValue = 'Precise';
    } else if (status == LocationAccuracyStatus.reduced) {
      locationAccuracyStatusValue = 'Reduced';
    } else {
      locationAccuracyStatusValue = 'Unknown';
    }
    updatePositionList(
      _PositionItemType.log,
      '$locationAccuracyStatusValue location accuracy granted.',
    );
  }

  void _openAppSettings() async {
    final opened = await _geolocatorPlatform.openAppSettings();
    String displayValue;

    if (opened) {
      displayValue = 'Opened Application Settings.';
    } else {
      displayValue = 'Error opening Application Settings.';
    }

    updatePositionList(
      _PositionItemType.log,
      displayValue,
    );
  }

  void openLocationSettings() async {
    final opened = await _geolocatorPlatform.openLocationSettings();
    String displayValue;

    if (opened) {
      displayValue = 'Opened Location Settings';
    } else {
      displayValue = 'Error opening Location Settings';
    }

    updatePositionList(
      _PositionItemType.log,
      displayValue,
    );
  }
}

enum _PositionItemType {
  log,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}
