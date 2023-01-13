import 'package:get/get.dart';

import 'single_candidate_binding.dart';
import 'single_candidate_view.dart';

final singleCandidate = GetPage(
  name: '/single_candidate',
  page: () => SingleCandidateView(),
  binding: SingleCandidateBinding(),
);
