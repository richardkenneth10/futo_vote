import 'package:get/get.dart';

import 'admin_login_controller.dart';

class AdminLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AdminLoginController());
  }
}
