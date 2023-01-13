import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futo_vote/config/routes.dart';
import 'package:futo_vote/services/auth_service.dart';
import 'package:futo_vote/utils/safe_request.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordVisible = false.obs;

  void login() {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      Get.rawSnackbar(
          backgroundColor: Colors.blue,
          animationDuration: 350.milliseconds,
          message: 'Reg no and Password are required');
      return;
    }
    if (usernameController.text.length != 11) {
      Get.rawSnackbar(
          backgroundColor: Colors.blue,
          animationDuration: 350.milliseconds,
          message: 'Invalid Reg no');
      return;
    }
    if (passwordController.text.length < 6) {
      Get.rawSnackbar(
          backgroundColor: Colors.blue,
          animationDuration: 350.milliseconds,
          message: 'Password should be up to 6 characters long');
      return;
    }
    SafeRequest.run(
      () => Get.find<AuthService>().loginUser(
        usernameController.text.trim(),
        passwordController.text.trim(),
      ),
      onSuccess: () => Get.offAllNamed(Routes.candidatesScreen),
    );
  }

  void goToSignUpScreen() {
    Get.offNamed(Routes.registerScreen);
  }

  @override
  void onClose() {
    super.onClose();
    usernameController.dispose();
    passwordController.dispose();
  }

  void goToAdminLoginScreen() {
    Get.offNamed(Routes.adminLoginScreen);
  }
}
