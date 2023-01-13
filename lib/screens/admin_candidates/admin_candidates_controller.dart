import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futo_vote/config/routes.dart';
import 'package:futo_vote/models/candidate.dart';
import 'package:futo_vote/services/auth_service.dart';
import 'package:futo_vote/services/candidates_service.dart';
import 'package:futo_vote/utils/safe_request.dart';
import 'package:get/get.dart';

class AdminCandidatesController extends GetxController {
  RxList<CandidateData> get candidates =>
      Get.find<CandidateService>().organizedCandidates;

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

  void goToAddCandidateScreen() {
    Get.toNamed(Routes.addCandidateScreen);
  }

  @override
  void onInit() {
    super.onInit();
  }

  void removeCandidate(BuildContext context, CandidateData candidateData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: Text(
            'Are you sure you want to remove ${candidateData.fullName}?',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      SafeRequest.run(
                          () => Get.find<CandidateService>()
                              .deleteCandidate(candidateData), onSuccess: () {
                        Get.offAllNamed(Routes.adminCandidatesScreen);
                        Get.rawSnackbar(
                            backgroundColor: Colors.blue,
                            animationDuration: 350.milliseconds,
                            message: '${candidateData.fullName} removed');
                      });
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: Get.back,
                    child: const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
