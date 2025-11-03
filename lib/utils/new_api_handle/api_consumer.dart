abstract class ApiConsumer {
  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameter, String? token});

  Future<dynamic> post(String path,
      {Map<String, dynamic>? queryParameter,
      Map<String, dynamic> body,
      String? token});

  Future<dynamic> put(String path,
      {Map<String, dynamic>? queryParameter,
      Map<String, dynamic> body,
      String? token});
}
