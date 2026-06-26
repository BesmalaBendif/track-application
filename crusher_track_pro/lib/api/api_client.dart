import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../storage/token_storage.dart';
import 'api_constants.dart';

class ApiClient {
  ApiClient._();

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),

      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ),
  )..interceptors.addAll([
      AuthInterceptor(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
      ),
    ]);
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await TokenStorage.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    super.onError(err, handler);
  }
}