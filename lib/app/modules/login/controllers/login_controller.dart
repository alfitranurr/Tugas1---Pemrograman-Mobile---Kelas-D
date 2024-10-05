import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Controllers for managing text inputs
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Obx observables for username and password
  var username = ''.obs;
  var password = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize any dependencies or observables
    usernameController.addListener(() {
      username.value = usernameController.text;
    });

    passwordController.addListener(() {
      password.value = passwordController.text;
    });
  }

  @override
  void onClose() {
    // Dispose the controllers when no longer needed
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Function to validate and handle login
  void login() {
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Username and password cannot be empty',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (username.value == 'admin' && password.value == 'admin123') {
      // Example validation logic
      Get.offNamed('/home'); // Navigate to home page if login is successful
    } else {
      Get.snackbar(
        'Login Failed',
        'Invalid username or password',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
