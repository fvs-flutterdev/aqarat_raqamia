import 'package:aqarat_raqamia/view/base/show_toast.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import '../translation/locale_keys.g.dart';
import 'app_constant.dart';
import 'base_url.dart';
import 'new_api_handle/error/exeptions.dart';
import 'new_api_handle/status_code.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: BaseUrl.baseUrl,
      receiveDataWhenStatusError: true,
      headers: {
        'Authorization': "Bearer $token",
        'Accept': 'application/json',
        'Content-Type': 'application/json'
        //'zoneId':zone_ids,
      },
    ));
  }

  static Future getData({
    required String url,
    Map<String, dynamic>? query,
    // int? page,
    String? token,
    String? search,
    int? page,
    String? langId,
    String? categoryId,
    String? minPrice,
    String? maxPrice,
    String? typeId,
    String? lat,
    String? lng,
    String? space,
    String? status,
    String? locale,
    String? city,
    String? district,
    //  List<int?>?cities,
    int? regionId,
    int? isPaginate,
    //  String? name
  }) async {
    dio.options.headers = {
      "Authorization": 'Bearer $token' ?? "",
      'Content-Type': 'application/json'
    };
    dio.options.queryParameters = {
      "lan": lng,
      "lat": lat,
      "category_id": categoryId,
      "min_price": minPrice,
      "max_price": maxPrice,
      'type_id': typeId,
      "search": search,
      "space": space,
      'lang': locale ?? myLocale,
      "page": page,
      "status": status,
      "paginated": isPaginate,
      "region_id": regionId,
      "city":city,
      "district":district,
      // "cities_ids[]":cities,

      // 'search_query': search,
      // 'page': page,
      // 'preferred_language': langId,
      // 'name_or_phone_number': name
    };
    try {
      Response response;
      // return

      response = await dio.get(url,
          queryParameters: dio.options.queryParameters = {
            "lan": lng,
            "lat": lat,
            "category_id": categoryId,
            "min_price": minPrice,
            "max_price": maxPrice,
            'type_id': typeId,
            "search": search,
            "space": space,
            'lang': locale ?? myLocale,
            "page": page,
            "status": status,
            "paginated": isPaginate,
            "region_id": regionId,
            "city":city,
            "district":district,
            // "cities_ids[]":cities,

            // 'search_query': search,
            // 'page': page,
            // 'preferred_language': langId,
            // 'name_or_phone_number': name
          },
          options: Options(
            headers: {
              "Authorization": 'Bearer $token' ?? "",
              'Content-Type': 'application/json'
            },
          ));

      print('RESPONSE:##$response');
      print('STATUS CODE: ${response.statusCode}');

      return response;
    } on DioError catch (error) {
      print(error.response?.statusMessage);
      print(error.response?.statusCode);
      showCustomSnackBar(
        message:
            '${error.response?.statusMessage.toString()} ${error.response?.statusCode.toString()}',
        state: ToastState.ERROR,
        //  context: con
      );
      // showToast(text: error.response!.statusMessage.toString(), state: ToastState.ERROR);
    }

    // var response;
    // try{
    //   response= await dio.get(url, queryParameters: query);
    // }on DioError catch (e){
    //   if (e.response != null) {
    //     response = e.response;
    //     print("response: " + e.response.toString());
    //   } else {}
    // }
    // return handleResponse(response);
  }

  static Future getDataFilter({
    required String url,
    Map<String, dynamic>? query,
    // int? page,
    String? token,
    String? search,
    int? page,
    String? langId,
    String? categoryId,
    String? minPrice,
    String? maxPrice,
    String? typeId,
    String? lat,
    String? lng,
    String? space,
    String? status,
    List<int?>? cities,
    List<int?>? ids,
    int? regionId,
    String? city,
    String? district,
    // int? regionId,
    int? isPaginate,
    //  String? name
  }) async {
    dio.options.headers = {
      "Authorization": 'Bearer $token' ?? "",
      'Content-Type': 'application/json'
    };
    dio.options.queryParameters = {
      "lan": lng,
      "lat": lat,
      "category_id": categoryId,
      "min_price": minPrice,
      "max_price": maxPrice,
      'type_id': typeId,
      "search": search,
      "space": space,
      'lang': myLocale,
      "page": page,
      "status": status,
      "paginated": isPaginate,
      "cities_ids[]": cities,
      "ids[]": ids,
      "region_id": regionId,
      "city":city,
      "district":district,

      // 'search_query': search,
      // 'page': page,
      // 'preferred_language': langId,
      // 'name_or_phone_number': name
    };
    try {
      Response response;
      // return

      response = await dio.get(url,
          queryParameters: dio.options.queryParameters = {
            "lan": lng,
            "lat": lat,
            "category_id": categoryId,
            "min_price": minPrice,
            "max_price": maxPrice,
            'type_id': typeId,
            "search": search,
            "space": space,
            'lang': myLocale,
            "page": page,
            "status": status,
            "paginated": isPaginate,
            "cities_ids[]": cities,
            "ids[]": ids,
            "region_id": regionId,
            "city":city,
            "district":district,
            // 'search_query': search,
            // 'page': page,
            // 'preferred_language': langId,
            // 'name_or_phone_number': name
          },
          options: Options(
            headers: {
              "Authorization": 'Bearer $token' ?? "",
              'Content-Type': 'application/json'
            },
          ));

      print('RESPONSE:##$response');
      print('STATUS CODE: ${response.statusCode}');

      return response;
    } on DioError catch (error) {
      print(error.response?.statusMessage);
      print(error.response?.statusCode);
      showCustomSnackBar(
        message:
            '${error.response?.statusMessage.toString()} ${error.response?.statusCode.toString()}',
        state: ToastState.ERROR,
        //  context: con
      );
      // showToast(text: error.response!.statusMessage.toString(), state: ToastState.ERROR);
    }

    // var response;
    // try{
    //   response= await dio.get(url, queryParameters: query);
    // }on DioError catch (e){
    //   if (e.response != null) {
    //     response = e.response;
    //     print("response: " + e.response.toString());
    //   } else {}
    // }
    // return handleResponse(response);
  }

  static Future<Response> deleteData(
      {required String url, String? token}) async {
    dio.options.headers = {
      "Authorization": 'Bearer $token',
      'Content-Type': 'application/json'
    };
    return await dio.delete(url);

    // try{
    //   var response;
    //   response=await dio.delete(
    //     url,
    //    // queryParameters: query,
    //    // data: data,
    //   );
    // }on DioError catch(e){}
    // var response;
    // try{
    //   response=   await dio.post(
    //     url,
    //     // queryParameters: query,
    //     // data: data,
    //   );
    // }on DioError catch (e){
    //   if (e.response != null) {
    //     response = e.response;
    //     print("response: " + e.response.toString());
    //     print(response);
    //   }
    // }
    // return handleResponse(response);
  }

  static Future postData(
      {required String url,
      Map<String, dynamic>? query,
      String? token,
      bool? showToast,
      Map<String, dynamic>? data}) async {
    // try {
    dio.options.headers = {
      "Authorization": 'Bearer $token',
      'Content-Type': 'application/json'
    };
    try {
      Response response;
      response = await dio.post(
        url,
        queryParameters: query,
        data: data,
        // options: Options(
        //   headers: {
        //     "Authorization": 'Bearer $token' ?? "",
        //     'Content-Type': 'application/json'
        //   },
        // )
      );
      print('RESPONSE:##$response');
      print('STATUS CODE: ${response.statusCode}');

      return response;
    } on DioError catch (error) {
      print(error.toString());
      if (error.response?.statusCode == 500) {
        showCustomSnackBar(
            message: 'حدث خطأ في السيرفر 500', state: ToastState.ERROR);
      } else {
        showToast == false
            ? print(error)
            : showCustomSnackBar(
                message: error.response!.data.toString(),
                state: ToastState.ERROR);
      }

      print(error.response!.data);
      print('${error.response?.statusMessage}.....................');
      print('${error.response?.statusCode}/////////////////////');
      handleDioErrors(error);
    }

    // }on DioError catch (error){
    //   handleDioErrors(error);
    // }
    //  var response;
    // try {
    //   response = await dio.post(url, queryParameters: query);
    // } on DioError catch (e) {
    //   if (e.response != null) {
    //     response = e.response;
    //     print("response: " + e.response.toString());
    //   } else {}
    // }
    // return handleResponse(response);
  }

  static authPostData(
      {required String url,
      Map<String, dynamic>? query,
      String? token,
      Map<String, dynamic>? data}) async {
    dio.options.headers = {
      "Authorization": 'Bearer $token',
      'Content-Type': 'application/json'
    };
    // dio.options.queryParameters={
    //   'lang': myLocale,
    // };
    Response response;

    response = await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
    if (response.statusCode == 200) {
      showCustomSnackBar(message: 'message', state: ToastState.ERROR);
    } else if (response.statusCode == 422) {
      showCustomSnackBar(
          message: LocaleKeys.phoneAlreadyRegistered.tr(),
          state: ToastState.ERROR);
    }
    return response;
  }

  //  static Future<Response> postData(
  //      {required String url,
  //        Map<String, dynamic>? query,
  //        String? token,
  //        Map<String, dynamic>? data}) async {
  //    dio.options.headers = {
  //      "Authorization": 'Bearer $token',
  //      'Content-Type': 'application/json'
  //    };
  //    dio.options.queryParameters={
  //      'lang': myLocale,
  //    };
  //    return await dio.post(
  //      url,
  //      queryParameters: query,
  //      data: data,
  //    );
  //  }
  static DioError handleDioErrors(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw const FetchDataException();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.Unauthorized:
          case StatusCode.Forbidden:
            throw const UnauthorizedException();
          case StatusCode.Conflict:
            throw const ConflictException();
          case StatusCode.NotFound:
            throw const NotFoundException();
          case StatusCode.InternalServerError:
            throw InternalServerErrorException();
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw NoInternetConnectionException();
    }
    return error;
  }
// static Future<Response> handleResponse(
//     Response response,
//     ) async {
//   if (response.data.runtimeType == String) {
//     return Response(
//       statusCode: 102,
//       data: {
//         "mainCode": 0,
//         "code": 102,
//         "data": null,
//         "error": [
//           {"key": "internet", "value": "هناك خطا يرجي اعادة المحاولة"}
//         ]
//       },
//       requestOptions: RequestOptions(),
//     );
//   } else {
//     final int? statusCode = response.statusCode;
//     print("response: " + response.toString());
//     print("statusCode" + statusCode.toString());
//
//     if (statusCode! >= 200 && statusCode < 300) {
//       //showToast(text: response.data['status']!, state: ToastState.SUCCESS);
//       return response;
//     } else if (statusCode == 401) {
//       // showToast(text: response.statusMessage!, state: ToastState.ERROR);
//       // CacheHelper.removeData(key: 'token');
//       // CacheHelper.removeData(key: 'user_type');
//       // navigateForwardReplace(BoardingScreen());
//       // navigateAndFinish(myContext(), LoginScreen());
//       return Response(
//         statusCode: 401,
//         data: {
//           "mainCode": 0,
//           "code": 401,
//           "data": null,
//           "error": [
//             {"key": "internet", "value": "انتهت مده التسجيل"}
//           ]
//         },
//         requestOptions: RequestOptions(),
//         // requestOptions: null
//       );
//     } else {
//       return response;
//     }
//   }
// }
}
// dio.options.headers= {
//   "Authorization":'$token'??"",
//   'Content-Type': 'application/json'
//   // "zoneId":zone
// };
// dio.options.headers= {"Authorization":'$token',};
