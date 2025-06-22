import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../config/constants.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final String baseUrl;

  CustomInterceptor({required this.storage, required this.baseUrl});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await storage.read(key: accessTokenKey);
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshTokenValue = await storage.read(key: refreshTokenKey);
      if (refreshTokenValue == null) {
        return super.onError(err, handler);
      }

      try {
        final refreshDio = Dio(BaseOptions(
          baseUrl: baseUrl,
        ));

        final refreshResponse = await refreshDio.post(
          '/auth/refresh',
          options: Options(
            headers: {'Authorization': 'Bearer $refreshTokenValue'},
          ),
        );

        final newAccessToken = refreshResponse.data['accessToken'];
        final newRefreshToken = refreshResponse.data['refreshToken'];
        await storage.write(key: accessTokenKey, value: newAccessToken);
        await storage.write(key: refreshTokenKey, value: newRefreshToken);

        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        final response = await refreshDio.fetch(err.requestOptions);
        return handler.resolve(response);
      } on DioException {
        return super.onError(err, handler);
      }
    }
    super.onError(err, handler);
  }
}
