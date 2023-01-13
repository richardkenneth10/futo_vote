import 'package:get/get.dart';

import 'candidates_binding.dart';
import 'candidates_view.dart';

final candidates = GetPage(
  name: '/candidates',
  page: () => CandidatesView(),
  binding: CandidatesBinding(),
);
