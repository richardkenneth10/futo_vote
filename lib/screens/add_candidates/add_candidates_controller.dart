import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futo_vote/config/routes.dart';
import 'package:futo_vote/models/candidate.dart';
import 'package:futo_vote/services/auth_service.dart';
import 'package:futo_vote/services/candidates_service.dart';
import 'package:futo_vote/utils/safe_request.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddCandidateController extends GetxController {
  final isUploaded = false.obs;
  final image = ''.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final deptController = TextEditingController();
  final manifestoController = TextEditingController();
  final positionController = TextEditingController();

  get candidates {
    final candidates = Get.find<CandidateService>().candidates;
    candidates.sort((a, b) => a.votes.compareTo(b.votes));
    return candidates;
  }

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

  Future<void> getImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedImage == null) {
      return;
    }

    const title = 'Crop Candidate Photo';

    final croppedImage = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: const CropAspectRatio(
          ratioX: 1,
          ratioY: 1,
        ),
        compressFormat: ImageCompressFormat.png,
        compressQuality: 50,
        cropStyle: CropStyle.rectangle,
        aspectRatioPresets: [
          CropAspectRatioPreset.square
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: title,
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: title,
          )
        ]);

    if (croppedImage == null) return;

    image(croppedImage.path);

    isUploaded(true);
  }

  void addCandidate() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        deptController.text.isEmpty ||
        manifestoController.text.isEmpty) {
      Get.rawSnackbar(
          backgroundColor: Colors.blue,
          animationDuration: 350.milliseconds,
          message: 'All fields are required');
      return;
    }

    if (image().isEmpty) {
      Get.rawSnackbar(
          backgroundColor: Colors.blue,
          animationDuration: 350.milliseconds,
          message: 'Image is required');
      return;
    }

    SafeRequest.run(
      () async {
        final imageUrl = await uploadImage();

        if (imageUrl == null) return;
        return Get.find<CandidateService>().addCandidate(
          firstNameController.text,
          lastNameController.text,
          deptController.text,
          positionController.text,
          manifestoController.text,
          imageUrl,
        );
      },
      onSuccess: () {
        Get.offAllNamed(Routes.adminCandidatesScreen);
        Get.rawSnackbar(
          backgroundColor: Colors.blue,
          animationDuration: 350.milliseconds,
          message: 'Candidate added',
          duration: 5.seconds,
        );
      },
    );
  }

  Future<String?> uploadImage() async {
    if (image().isEmpty) return null;

    final imageFile = File(image());
    final storageRef = FirebaseStorage.instance.ref().child(
          'candidates_photos/${DateTime.now().millisecondsSinceEpoch}',
        );
    final uploadTask = storageRef.putFile(imageFile);
    final done = await uploadTask;
    final ref = done.ref;
    final imgUrl = await ref.getDownloadURL();
    return imgUrl;
  }

  void removeImage() {
    image('');
    isUploaded(false);
  }
}
