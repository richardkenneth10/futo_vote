import 'package:get/get.dart';

import 'login_binding.dart';
import 'login_view.dart';

final login = GetPage(
  name: '/login',
  page: () => LoginView(),
  binding: LoginBinding(),
);
