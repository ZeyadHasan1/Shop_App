import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static Future<Response> getdata({
    required String method,
    required dynamic query,
  }) async {
    return await dio!.get(method, queryParameters: query);
  }

  static Future<Response> insertdata({
    required String method,
    dynamic query,
    required dynamic data,
  }) async {
    return dio!.post(
      method,
      queryParameters: query,
      data: data,
    );
  }
}
