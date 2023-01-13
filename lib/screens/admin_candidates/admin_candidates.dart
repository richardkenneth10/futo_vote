import 'package:get/get.dart';

import 'admin_candidates_binding.dart';
import 'admin_candidates_view.dart';

final adminCandidates = GetPage(
  name: '/admin-candidates',
  page: () => AdminCandidatesView(),
  binding: AdminCandidatesBinding(),
);
