import 'dart:io';

import 'package:get/get.dart';
import 'package:techarea_test/app/config/api/api_config.dart';
import 'package:techarea_test/app/data/models/login_unsuccess_model.dart';

import '../models/login_success_model.dart';

class LoginProvider extends GetConnect {
  Future<dynamic> loginUser(String email, String password) async {
    try {
      final response = await post(
        ApiConfig.login,
        {'email': email, 'password': password},
        contentType: 'application/json',
        headers: {'x-api-key': ApiConfig.apiKey},
      );

      if (response.statusCode == 200) {
        return LoginSuccess.fromJson(response.body);
      } else if (response.body != 200) {
        return LoginUnsuccess.fromJson(response.body);
      } else {
        return LoginUnsuccess(error: 'Unknown error occurred');
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
