import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techarea_test/app/config/api/api_config.dart';

import '../models/user_model.dart';

class UserProvider extends GetConnect {
  final box = GetStorage();

  Future<List<User>> fetchUsers() async {
    final String? token = box.read('token');

    if (token == null || token.isEmpty) {
      throw Exception('Token is null or empty');
    }

    try {
      final response = await get(
        ApiConfig.listUsers,
        headers: {
          'Authorization': 'Bearer $token',
          'x-api-key': ApiConfig.apiKey,
        },
      );

      if (response.statusCode == 200 && response.body['data'] != null) {
        return User.fromJsonList(response.body['data']);
      } else {
        throw Exception('Failed to load users: ${response.statusText}');
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
