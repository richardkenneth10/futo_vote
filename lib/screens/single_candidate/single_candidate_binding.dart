import 'package:get/get.dart';

import 'single_candidate_controller.dart';

class SingleCandidateBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SingleCandidateController());
  }
}
