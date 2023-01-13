import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futo_vote/config/routes.dart';
import 'package:futo_vote/services/auth_service.dart';
import 'package:futo_vote/utils/safe_request.dart';
import 'package:get/get.dart';

class AdminLoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordVisible = false.obs;

  void login() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.rawSnackbar(
          backgroundColor: Colors.blue,
          animationDuration: 350.milliseconds,
          message: 'Email and Password are required');
      return;
    }

    SafeRequest.run(
      () => Get.find<AuthService>().loginAdmin(
        emailController.text.trim(),
        passwordController.text.trim(),
      ),
      onSuccess: () => Get.offAllNamed(Routes.adminCandidatesScreen),
    );
  }

  void goToSignUpScreen() {
    Get.offNamed(Routes.registerScreen);
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  void goToStudentLoginScreen() {
    Get.offNamed(Routes.loginScreen);
  }
}
