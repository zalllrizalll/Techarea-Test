import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techarea_test/app/data/models/login_success_model.dart';
import 'package:techarea_test/app/data/models/login_unsuccess_model.dart';
import 'package:techarea_test/app/data/providers/login_provider.dart';
import 'package:techarea_test/app/routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  RxBool isHidden = true.obs;
  RxBool isLoading = false.obs;

  final box = GetStorage();

  LoginProvider loginProvider = LoginProvider();

  Future<void> login() async {
    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 1));

    try {
      final result = await loginProvider.loginUser(emailC.text, passC.text);

      if (result is LoginSuccess &&
          result.token != null &&
          result.token!.isNotEmpty) {
        // Simpan token dan arahkan ke halaman utama
        box.write('token', result.token);
        Get.offAllNamed(Routes.HOME);
        Get.snackbar('Success', 'Login successful');
      } else if (result is LoginUnsuccess) {
        // Tampilkan pesan error dari server
        Get.snackbar(
          'Login Failed',
          result.error ?? 'Login failed. Please try again.',
        );
      } else {
        Get.snackbar('Login Failed', 'Unexpected response from server.');
      }
    } on SocketException {
      Get.snackbar(
        'Network Error',
        'No internet connection. Please check your network and try again.',
      );
    } on HttpException {
      Get.snackbar('HTTP Error', 'Server error. Please try again later.');
    } on FormatException {
      Get.snackbar(
        'Format Error',
        'Bad response format. Please contact support.',
      );
    } on Exception catch (e) {
      Get.snackbar('Unexpected Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}
