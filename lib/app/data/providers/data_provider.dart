import 'dart:io';

import 'package:get/get.dart';
import 'package:techarea_test/app/config/api/api_config.dart';

import '../models/data_model.dart';

class DataProvider extends GetConnect {
  Future<Data?> postData(String title, String body) async {
    try {
      final response = await post(ApiConfig.postData, {
        'title': title,
        'body': body,
      }, contentType: 'application/json');

      if (response.statusCode == 201) {
        return Data.fromJson(response.body);
      } else {
        throw Exception('Failed to post data: ${response.statusText}');
      }
    } on SocketException {
      rethrow;
    } on HttpException {
      rethrow;
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
