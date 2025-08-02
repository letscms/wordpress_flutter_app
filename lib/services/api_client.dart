import 'package:dio/dio.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late final Dio dio;

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl:'https://wprest.vxinfosystem.com/wp-json',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          'User-Agent': 'Mozilla/5.0 (Flutter; Dart)',
        },
      ),

    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add headers or logging here
          // options.headers['Authorization'] = 'Bearer ';
          // print('Request: ${options.baseUrl} ${options.method} ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // print('Response: ${response} ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print('Error: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }
}
