import 'package:get/get.dart';

import 'add_candidates_binding.dart';
import 'add_candidates_view.dart';

final addCandidate = GetPage(
  name: '/add-candidate',
  page: () => AddCandidateView(),
  binding: AddCandidatesBinding(),
);
