import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:techarea_test/app/data/models/user_model.dart';
import 'package:techarea_test/app/data/providers/data_provider.dart';
import 'package:techarea_test/app/data/providers/user_provider.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<User> users = <User>[].obs;
  RxString errorMessage = ''.obs;

  TextEditingController titleC = TextEditingController();
  TextEditingController bodyC = TextEditingController();

  UserProvider userProvider = UserProvider();
  DataProvider dataProvider = DataProvider();

  @override
  void onInit() async {
    super.onInit();
    await fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await Future.delayed(const Duration(seconds: 1));

      users.value = await userProvider.fetchUsers();
    } on SocketException {
      errorMessage.value =
          'No internet connection. Please check your network and try again.';
    } on HttpException {
      errorMessage.value = 'Server error. Please try again later.';
    } catch (_) {
      errorMessage.value = 'Something went wrong. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addData() async {
    try {
      isLoading.value = true;

      if (titleC.text.isEmpty && bodyC.text.isEmpty) {
        Get.snackbar('Fields Empty', 'Fields cannot be empty');
      } else if (titleC.text.isEmpty) {
        Get.snackbar('Title Empty', 'Field title cannot be empty');
      } else if (bodyC.text.isEmpty) {
        Get.snackbar('Body Empty', 'Field body cannot be empty');
      } else {
        final result = await dataProvider.postData(titleC.text, bodyC.text);

        if (result != null) {
          Get.back();
          // Handle successful data posting
          Get.snackbar('Success', 'Data ${result.id} posted successfully');

          titleC.clear();
          bodyC.clear();
        } else {
          Get.snackbar('Failed Post', 'Failed to post data. Please try again.');
        }
      }
    } on SocketException {
      Get.snackbar(
        'Network Error',
        'No internet connection. Please check your network and try again.',
      );
    } on HttpException {
      Get.snackbar('HTTP Error', 'Server error. Please try again later.');
    } catch (_) {
      Get.snackbar(
        'Unexpected Error',
        'Something went wrong. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleC.dispose();
    bodyC.dispose();
    super.onClose();
  }
}
