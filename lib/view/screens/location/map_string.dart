//
// import 'dart:io';
//
// class AppStrings {
//   static String MAPS_API_KEY = Platform.isAndroid
//       ? "AIzaSyAqld28c3M4zNPxKPvXj3eb3WzqrrrDbOY" //android
//       : "AIzaSyAqld28c3M4zNPxKPvXj3eb3WzqrrrDbOY"; //other os
//   static String MAP_BASE_URL = "comgooglemaps";
// }
//map location on the donation details page.
import 'package:aqarat_raqamia/translation/locale_keys.g.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:aqarat_raqamia/view/screens/location/utility.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_constant.dart';

class LocationView extends StatefulWidget {
  final double lat;
  final double lng;

  LocationView(this.lat, this.lng);
  @override
  _LocationViewState createState() {
    return _LocationViewState();
  }
}

class _LocationViewState extends State<LocationView> {
//  String? _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);

    setState(() {
      previewImageUrl = staticMapImageUrl;
    });
  }

  @override
  void initState() {
    super.initState();

    _showPreview(widget.lat, widget.lng);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170.sp,
          width: double.infinity,
          decoration:
          BoxDecoration(border: Border.all(width: 2.sp, color: goldColor)),
          child: previewImageUrl == null
              ? Text(LocaleKeys.setLocation.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.green[700]),
          )
              : Image.network(
            previewImageUrl??'',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
