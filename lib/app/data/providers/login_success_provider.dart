import 'package:get/get.dart';
import 'package:techarea_test/app/config/api/api_config.dart';

import '../models/login_success_model.dart';

class LoginSuccessProvider extends GetConnect {
  Future<LoginSuccess> loginUser(String email, String password) async {
    final response = await post(
      ApiConfig.login,
      {'email': email, 'password': password},
      contentType: 'application/json',
      headers: {'x-api-key': ApiConfig.apiKey},
    );

    if (response.status.isOk) {
      return LoginSuccess.fromJson(response.body);
    } else {
      throw Exception('Failed to login: ${response.statusText}');
    }
  }
}
