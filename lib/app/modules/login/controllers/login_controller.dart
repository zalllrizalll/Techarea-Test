import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techarea_test/app/data/providers/login_success_provider.dart';
import 'package:techarea_test/app/routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  RxBool isHidden = true.obs;
  RxBool isLoading = false.obs;

  final box = GetStorage();

  LoginSuccessProvider loginSuccessProvider = LoginSuccessProvider();

  Future<void> login() async {
    isLoading.value = true;

    try {
      if (emailC.text.isEmpty && passC.text.isEmpty) {
        Get.snackbar('Input Empty', 'Fields cannot be empty');
      } else if (emailC.text.isEmpty) {
        Get.snackbar('Email Empty', 'Email cannot be empty');
      } else if (passC.text.isEmpty) {
        Get.snackbar('Password Empty', 'Password cannot be empty');
      } else {
        await loginSuccessProvider.loginUser(emailC.text, passC.text).then((
          value,
        ) {
          if (value.token!.isNotEmpty) {
            box.write('token', value.token);
            Get.offAllNamed(Routes.HOME);
            Get.snackbar('Success', 'Login successful');
          } else {
            Get.snackbar('Error', 'Login failed');
          }
        });
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
