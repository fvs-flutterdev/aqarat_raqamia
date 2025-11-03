import 'dart:convert';
import 'package:http/http.dart' as http;

//const GOOGLE_API_KEY = 'AIzaSyAqld28c3M4zNPxKPvXj3eb3WzqrrrDbOY';
//const GOOGLE_API_KEY ="AIzaSyBS_WLni5YfR2VHwzTzf50iFsb4hmv9Vw8";
const GOOGLE_API_KEY ="AIzaSyAdMQuOnOTNXKJbBnh46Itl06sMIPQfjgc";
const IOS_API_KEY='AIzaSyAqld28c3M4zNPxKPvXj3eb3WzqrrrDbOY';
class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=15&size=1000x1000&markers=color:red%7Clabel:A%7C$latitude,$longitude&maptype=satellite&key=$GOOGLE_API_KEY';
  }
 // $latitude,$longitude&zoom=15&size=400x400&maptype=satellite&key=$apiKey
  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}