import 'dart:convert';
import 'dart:io';
import 'package:aqarat_raqamia/injection_container.dart' as di;
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/new_api_handle/api_consumer.dart';
import 'package:aqarat_raqamia/utils/new_api_handle/error/exeptions.dart';
import 'package:aqarat_raqamia/utils/new_api_handle/status_code.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'app_interceptors.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    client.options
      ..baseUrl = BaseUrl.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status != StatusCode.InternalServerError;
      };
    // client.interceptors.add(di.sl<AppInterceptors>());
    // if (kDebugMode) {
    //   client.interceptors.add(di.sl<LogInterceptor>());
    // }
  }

  @override
  Future get(String path,
      {Map<String, dynamic>? queryParameter, String? token}) async {
    try {
      final response = await client.get(path,
          queryParameters: queryParameter,
          options: Options(headers: {"Authorization": 'Bearer $token' ?? ""}));
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post(
    String path, {
    Map<String, dynamic>? queryParameter,
    Map<String, dynamic>? body,
    bool formDataIsEnable = false,
    String? token,
  }) async {
    try {
      final response = await client.post(path,
          queryParameters: queryParameter,
          data: formDataIsEnable ? FormData.fromMap(body!) : body,
          options: Options(headers: {"Authorization": 'Bearer $token' ?? ""}));
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? body,
      String? token}) async {
    try {
      final response = await client.put(path,
          queryParameters: queryParameter,
          data: body,
          options: Options(headers: {"Authorization": 'Bearer $token' ?? ""}));
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    final responseJson = jsonDecode(response.data);
    return responseJson;
  }

  dynamic _handleDioError(DioError error) {
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
  }
}
