import 'package:flutter/services.dart';
import 'package:futo_vote/services/auth_service.dart';
import 'package:futo_vote/services/candidates_service.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService(), permanent: true);
    Get.lazyPut(() => CandidateService(), fenix: true);
  }
}
