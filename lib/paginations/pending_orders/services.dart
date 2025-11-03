// import 'package:aqarat_raqamia/view/base/show_toast.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
//
// import '../../model/dynamic_model/order_provider/all_pending_orders.dart';
// import '../../model/dynamic_model/my_ads_model.dart';
// import '../../utils/app_constant.dart';
// import '../../utils/base_url.dart';
// import '../../utils/dio.dart';
//
// class PendingOrderServices {
//   static const FETCH_LIMIT = false;
//   final pendingOrdersProviderUrl = BaseUrl.baseUrl + BaseUrl.pending_orders_provider;
//
//   Future<AllPendingOrdersProviders?> fetchPendingOrdersProvider({int? page}) async {
//     try {
//       final response =
//       await DioHelper.getData(url: pendingOrdersProviderUrl, token: token, page: page);
//       print('AllPendingOrdersProviders ${response.data}');
//       print(response.hashCode);
//       AllPendingOrdersProviders getPendingOrdersProviderPaginationModel = AllPendingOrdersProviders.fromJson(response.data);
//       return getPendingOrdersProviderPaginationModel;
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
