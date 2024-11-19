import 'dart:convert';
import 'package:dio/dio.dart';

import '../../di/injection.dart';
import '../../errors/exceptions.dart';
import '../dio/network_call.dart';

class NetworkUtils {
  // Reusable network request method
  static Future<Response> makeRequest({
    required String endpoint,
    required Map<String, dynamic>? headers,
    required Map<String, dynamic>? params,
    required Map<String, dynamic>? body,
    required String method,  // Allow dynamic method (GET, POST, etc.)
  }) async {
    try {
      return await instance<NetworkCall>().request(
        endpoint,
        queryParameters: params,
        params: body,
        options: Options(method: method, headers: headers),
      );
    } catch (error) {
      throw ServerException(); // Throw specific exceptions based on error type
    }
  }

  // Reusable response processing method
  static T processResponse<T>(Response response, T Function(Map<String, dynamic>) fromJson) {
    var res = jsonDecode(response.data);

    if ((response.statusCode == 200 || response.statusCode == 201) && res['status'] == "success") {
      return fromJson(res);
    } else {
      throw WrongDataException(res['message'].toString());
    }
  }
}
