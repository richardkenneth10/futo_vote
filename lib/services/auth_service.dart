import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:futo_vote/app_bindings.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<User?> loginUser(String regNo, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
        email: '$regNo@futovote.com', password: password);
    return userCredential.user;
  }

  Future<User?> loginAdmin(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user;
  }

  Future<User?> registerUser(
      String firstName, String lastName, String regNo, String password) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
        email: '$regNo@futovote.com', password: password);
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'first_name': firstName,
      'last_name': lastName,
      'reg_no': regNo,
    });
    return userCredential.user;
  }

  Future logOut() async {
    await _auth.signOut();
    await Get.deleteAll(force: true);
    AppBindings().dependencies();
  }
}
