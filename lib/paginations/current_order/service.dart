// import 'package:aqarat_raqamia/view/base/show_toast.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
//
// import '../../model/dynamic_model/order_provider/all_current_provider.dart';
// import '../../model/dynamic_model/order_provider/all_old_orders.dart';
// import '../../model/dynamic_model/order_provider/all_pending_orders.dart';
// import '../../model/dynamic_model/my_ads_model.dart';
// import '../../utils/app_constant.dart';
// import '../../utils/base_url.dart';
// import '../../utils/dio.dart';
//
// class CurrentOrderServices {
//   static const FETCH_LIMIT = false;
//   final currentOrdersProviderUrl = BaseUrl.baseUrl + BaseUrl.current_orders_provider;
//
//   Future<AllCurrentOrdersProvider?> fetchCurrentOrdersProvider({int? page}) async {
//     try {
//       final response =
//       await DioHelper.getData(url: currentOrdersProviderUrl, token: token, page: page);
//       print('AllCurrentOrdersProviders ${response.data}');
//       print(response.hashCode);
//       AllCurrentOrdersProvider getCurrentOrdersProviderPaginationModel = AllCurrentOrdersProvider.fromJson(response.data);
//       return getCurrentOrdersProviderPaginationModel;
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
