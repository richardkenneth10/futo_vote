import 'package:get/get.dart';

import 'admin_candidates_controller.dart';

class AdminCandidatesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AdminCandidatesController());
  }
}
