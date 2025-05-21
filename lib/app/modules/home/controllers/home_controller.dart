import 'dart:io';

import 'package:get/get.dart';
import 'package:techarea_test/app/data/models/user_model.dart';
import 'package:techarea_test/app/data/providers/user_provider.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<User> users = <User>[].obs;
  RxString errorMessage = ''.obs;

  UserProvider userProvider = UserProvider();

  @override
  void onInit() async {
    super.onInit();
    await fetchData();
  }

  Future<void> fetchData() async {
  try {
    isLoading.value = true;
    errorMessage.value = ''; // Reset error message

    await Future.delayed(const Duration(seconds: 2));

    users.value = await userProvider.fetchUsers();
  } on SocketException {
    errorMessage.value = 'No internet connection. Please check your network and try again.';
  } on HttpException {
    errorMessage.value = 'Server error. Please try again later.';
  } catch (_) {
    errorMessage.value = 'Something went wrong. Please try again.';
  } finally {
    isLoading.value = false;
  }
}

}
