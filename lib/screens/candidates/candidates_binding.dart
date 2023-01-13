import 'package:futo_vote/screens/initial/initial_controller.dart';
import 'package:get/get.dart';

import 'candidates_controller.dart';

class CandidatesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CandidatesController());
  }
}
