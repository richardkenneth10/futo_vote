import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loading {
  static Future show() {
    return showDialog(
      context: (Get.context ?? Get.overlayContext)!,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => const Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
