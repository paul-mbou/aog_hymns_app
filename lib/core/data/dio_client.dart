import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final client = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      followRedirects: true,
      maxRedirects: 3,
    ),
  );
  client.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        if (options.uri.scheme != 'https') {
          handler.reject(
            DioException(
              requestOptions: options,
              type: DioExceptionType.badResponse,
              message: 'https-only',
            ),
          );
          return;
        }
        handler.next(options);
      },
    ),
  );
  if (kDebugMode) {
    client.interceptors.add(
      LogInterceptor(requestBody: false, responseBody: false),
    );
  }
  return client;
}
