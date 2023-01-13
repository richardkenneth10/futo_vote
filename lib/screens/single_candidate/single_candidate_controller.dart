import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:futo_vote/models/candidate.dart';
import 'package:futo_vote/services/candidates_service.dart';
import 'package:futo_vote/utils/safe_request.dart';
import 'package:get/get.dart';

class SingleCandidateController extends GetxController {
  final candidateId = Get.arguments as String;

  final isVoting = false.obs;

  void vote() {
    SafeRequest.run(
      () => Get.find<CandidateService>().voteForCandidate(candidateId),
      onBegin: () => isVoting(true),
      onSuccess: () {
        Get.rawSnackbar(
          backgroundColor: Colors.blue,
          animationDuration: 350.milliseconds,
          message: 'Vote added',
          duration: 5.seconds,
        );
      },
      onFinally: () => isVoting(false),
    );
  }

  CandidateData? get candidateData {
    try {
      return Get.find<CandidateService>().candidates().firstWhere(
            (element) => element.id == candidateId,
          );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
