import 'package:get/get.dart';

import 'register_binding.dart';
import 'register_view.dart';

final register = GetPage(
  name: '/register',
  page: () => RegisterView(),
  binding: RegisterBinding(),
);
