import 'package:get/get.dart';

import 'add_candidates_controller.dart';

class AddCandidatesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddCandidateController());
  }
}
