// import 'package:aqarat_raqamia/view/base/show_toast.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
//
// import '../../model/dynamic_model/my_ads_model.dart';
// import '../../utils/app_constant.dart';
// import '../../utils/base_url.dart';
// import '../../utils/dio.dart';
//
// class MyAdsServices {
//   static const FETCH_LIMIT = false;
//   final MyAdsUrl = BaseUrl.baseUrl + BaseUrl.GetMyAds;
//
//   Future<MyAdsModel?> fetchMyAds({int? page}) async {
//     try {
//       final response =
//           await DioHelper.getData(url: MyAdsUrl, token: token, page: page);
//       print('response.data ${response.data}');
//       print(response.hashCode);
//       MyAdsModel getMyAdsPaginationModel = MyAdsModel.fromJson(response.data);
//       return getMyAdsPaginationModel;
//       // return jsonDecode(response.data) as List<dynamic>;
//     }on DioError catch (e) {
//       print('000000000000000000000000000${e.toString()}');
//       showCustomSnackBar(message: e.response?.statusMessage??'', state: ToastState.ERROR);
//
//       print(' some thing go error');
//       return null;
//     }
//   }
// }
