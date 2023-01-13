import 'package:get/get.dart';

import 'admin_login_binding.dart';
import 'admin_login_view.dart';

final adminLogin = GetPage(
  name: '/admin-login',
  page: () => AdminLoginView(),
  binding: AdminLoginBinding(),
);
