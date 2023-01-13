import 'package:futo_vote/screens/add_candidates/add_candidates.dart';
import 'package:futo_vote/screens/admin_candidates/admin_candidates.dart';
import 'package:futo_vote/screens/admin_login/admin_login.dart';
import 'package:futo_vote/screens/candidates/candidates.dart';
import 'package:futo_vote/screens/login/login.dart';
import 'package:futo_vote/screens/initial/initial.dart';
import 'package:futo_vote/screens/register/register.dart';
import 'package:futo_vote/screens/single_candidate/single_candidate.dart';
import 'package:get/get.dart';

class Routes {
  static final List<GetPage> allRoutes = [
    initial,
    login,
    register,
    adminCandidates,
    candidates,
    singleCandidate,
    adminLogin,
    addCandidate,
  ];

  static String get initialScreen => initial.name;

  static String get adminLoginScreen => adminLogin.name;

  static String get loginScreen => login.name;

  static String get registerScreen => register.name;

  static String get adminCandidatesScreen => adminCandidates.name;

  static String get candidatesScreen => candidates.name;

  static String get singleCandidateScreen => singleCandidate.name;

    static String get addCandidateScreen => addCandidate.name;

}
