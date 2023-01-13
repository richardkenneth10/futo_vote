import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:futo_vote/config/routes.dart';
import 'package:futo_vote/models/candidate.dart';
import 'package:futo_vote/services/auth_service.dart';
import 'package:futo_vote/services/candidates_service.dart';
import 'package:get/get.dart';

class CandidatesController extends GetxController {
  final candidates = Get.find<CandidateService>().candidates;
  void logOut() {
    Get.find<AuthService>().logOut();
    Get.offAllNamed(Routes.loginScreen);
  }

  void goToSingleCandidateScreen(String id) {
    Get.toNamed(
      Routes.singleCandidateScreen,
      arguments: id,
    );
  }
}
