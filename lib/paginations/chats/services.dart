// import 'package:aqarat_raqamia/view/base/show_toast.dart';
// import 'package:dio/dio.dart';
// import '../../model/dynamic_model/get_chat_model.dart';
// import '../../utils/app_constant.dart';
// import '../../utils/base_url.dart';
// import '../../utils/dio.dart';
//
// class GetChatMessageServices {
//   static const FETCH_LIMIT = false;
//   final getChatMessageUrl = BaseUrl.baseUrl + BaseUrl.get_chat_message;
//
//   Future<GetAllMessageModel?> fetchChatMessages({int? page, String? id}) async {
//     try {
//       final response =
//       await DioHelper.getData(url: '$getChatMessageUrl/$id', token: token, page: page);
//       print('GetAllChatMessage ${response.data}');
//       print(response.hashCode);
//       GetAllMessageModel getChatMessagePaginationModel = GetAllMessageModel.fromJson(response.data);
//       return getChatMessagePaginationModel;
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
