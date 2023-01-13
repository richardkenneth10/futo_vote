import 'package:futo_vote/screens/initial/initial_binding.dart';
import 'package:futo_vote/screens/initial/initial_view.dart';
import 'package:get/get.dart';

final initial = GetPage(
  name: '/',
  page: () => Initial(),
  binding: InitialBinding(),
);
