// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:my_crypto_asset/apis/models/genericResponse.dart';
import 'package:my_crypto_asset/constants/app_apiConstants.dart';

class GenericRequest {
  final RequestMethods method;
  final bool authApiCalls;
  final String url;
  final Map<String, dynamic>? body;

  const GenericRequest({
    required this.method,
    required this.authApiCalls,
    required this.url,
    this.body,
  });

  Future<GenericResponse> makeApiCall() async {
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };

      // if (!authApiCalls) {
      //   header['x-access-token'] = (await Utils().getAuthToken())!;
      // }

      BaseOptions opts = BaseOptions(
        //baseUrl: baseUrl,
        responseType: ResponseType.json,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        contentType: 'application/json',
      );

      final dio = Dio(opts);
      final uri = Uri.parse(url);
      late Response response;

      switch (method) {
        case RequestMethods.get:
          response = await dio.get(
            uri.toString(),
            queryParameters: body,
            options: Options(
              headers: header,
              validateStatus: (_) => true,
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json,
            ),
          );
          break;
        case RequestMethods.post:
          response = await dio.post(
            uri.toString(),
            data: body,
            options: Options(
              headers: header,
              validateStatus: (_) => true,
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json,
            ),
          );
          break;
        case RequestMethods.put:
          response = await dio.put(
            uri.toString(),
            data: body,
            options: Options(
              headers: header,
              validateStatus: (_) => true,
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json,
            ),
          );
          break;
        case RequestMethods.patch:
          response = await dio.patch(
            uri.toString(),
            data: body,
            options: Options(
              headers: header,
              validateStatus: (_) => true,
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json,
            ),
          );
          break;

        case RequestMethods.delete:
          response = await dio.delete(
            uri.toString(),
            data: body,
            options: Options(
              headers: header,
              validateStatus: (_) => true,
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json,
            ),
          );
          break;
      }
      return GenericResponse(
        isError: false,
        statusCode: response.statusCode!,
        body: response.data,
      );
    } on DioException catch (e) {
      //await bugsnag.notify(e, stack);
      return GenericResponse(
        isError: true,
        statusCode: e.response?.statusCode ?? 500,
        body: e.response?.data,
      );
    }
  }
}
