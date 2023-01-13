import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:futo_vote/config/routes.dart';
import 'package:get/get.dart';

class InitialController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (FirebaseAuth.instance.currentUser != null) {
        if (FirebaseAuth.instance.currentUser!.email == 'admin@futovote.com') {
          Get.offAllNamed(Routes.adminCandidatesScreen);
          return;
        }
        Get.offAllNamed(Routes.candidatesScreen);
        return;
      }
      Get.offAllNamed(Routes.loginScreen);
    });
  }
}
