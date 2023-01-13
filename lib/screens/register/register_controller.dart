import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futo_vote/config/routes.dart';
import 'package:futo_vote/services/auth_service.dart';
import 'package:futo_vote/utils/safe_request.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final regNoController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  final isPasswordVisible = false.obs;

  void goToSignInScreen() {
    Get.offNamed(Routes.loginScreen);
  }

  void signUp() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        regNoController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.rawSnackbar(
          backgroundColor: Colors.blue,
          animationDuration: 350.milliseconds,
          message: 'All fields are required');
      return;
    }
    if (regNoController.text.length != 11) {
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
      () => Get.find<AuthService>().registerUser(
        firstNameController.text,
        lastNameController.text,
        regNoController.text.trim(),
        passwordController.text.trim(),
      ),
      onSuccess: () => Get.offAllNamed(Routes.candidatesScreen),
    );
  }

  @override
  void onClose() {
    super.onClose();

    regNoController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
  }
}
