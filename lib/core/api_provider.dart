import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:post_flutter_practical/core/constanant%20/constants.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final Logger _logger = Logger();
  final List<String> excludedEndpoints = [];
  ApiProvider({bool addLogging = false}) {
    _dio.options.baseUrl = kBaseUrl;
    _dio.options.headers = {
      'Content-Type': 'application/json',
    };
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (addLogging) {
          _logger.d(
              'Request: ${options.method} ${options.baseUrl}${options.path}');
          if (options.data != null) {
            _logger.d('Request data: ${options.data}');
          }
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (addLogging) {
          _logger.d(
              'Response: ${response.statusCode} ${response.requestOptions.path}');
          if (response.data != null) {
            _logger.d('Response data: ${response.data}');
          }
        }
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        if (addLogging) {
          _logger.e('Error: ${e.message}');
        }
        if (e.response?.statusCode == 401) {
          /*final endpoint = e.requestOptions.path;
          // Check if the endpoint is not in the excluded list
          if (!excludedEndpoints.contains(endpoint)) {
            Common().handleSessionExpiration();
          }*/
        }
        return handler.next(e);
      },
    ));
  }

  // Method to set custom headers
  void setHeaders(Map<String, String> headers) {
    _dio.options.headers.addAll(headers);
  }

  void clearHeaders() {
    _dio.options.headers.clear();
  }

  // GET request
  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: params);
      return response;
    } on DioException catch (e) {
      return e.response ??
          Response(
              requestOptions: RequestOptions(path: endpoint),
              statusCode: 500,
              statusMessage: e.message);
    }
  }

  // POST request
  Future<Response> post(String endpoint,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? params,
      ResponseType responseType = ResponseType.json}) async {
    try {
      final response = await _dio.post(endpoint,
          data: data,
          queryParameters: params,
          options: Options(responseType: responseType));
      return response;
    } on DioException catch (e) {
      return e.response ??
          Response(
              requestOptions: RequestOptions(path: endpoint),
              statusCode: 500,
              statusMessage: e.message);
    }
  }

  Future<Response> patch(String endpoint,
      {Map<String, dynamic>? data, Map<String, dynamic>? params}) async {
    try {
      final response =
          await _dio.patch(endpoint, data: data, queryParameters: params);
      return response;
    } on DioException catch (e) {
      return e.response ??
          Response(
              requestOptions: RequestOptions(path: endpoint),
              statusCode: 500,
              statusMessage: e.message);
    }
  }

  Future<Response> put(String endpoint,
      {Map<String, dynamic>? data, Map<String, dynamic>? params}) async {
    try {
      final response =
          await _dio.put(endpoint, data: data, queryParameters: params);
      return response;
    } on DioException catch (e) {
      return e.response ??
          Response(
              requestOptions: RequestOptions(path: endpoint),
              statusCode: 500,
              statusMessage: e.message);
    }
  }

  Future<Response> request(
    String method,
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _dio.request(
        endpoint,
        data: data,
        queryParameters: params,
        options: Options(method: method),
      );
      return response;
    } on DioException catch (e) {
      return e.response ??
          Response(
              requestOptions: RequestOptions(path: endpoint),
              statusCode: 500,
              statusMessage: e.message);
    }
  }

  Future<Response> upload(String method, String endpoint,
      {required Map<String, dynamic> data,
      required String filePath,
      String fileFieldName = 'file'}) async {
    try {
      final formData = FormData.fromMap(data);
      if (filePath.isNotEmpty) {
        formData.files.add(MapEntry(
          fileFieldName,
          await MultipartFile.fromFile(filePath),
        ));
      }

      _logger.d('formData-->${formData.fields}');
      _logger.d('formData-->${formData.files}');
      final response = await _dio.request(
        endpoint,
        data: formData,
        options: Options(method: method),
      );
      return response;
    } on DioException catch (e) {
      return e.response ??
          Response(
              requestOptions: RequestOptions(path: endpoint),
              statusCode: 500,
              statusMessage: e.message);
    }
  }
}
