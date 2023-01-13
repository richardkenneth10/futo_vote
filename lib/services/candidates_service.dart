import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:futo_vote/models/candidate.dart';
import 'package:futo_vote/models/futo_vote_exception.dart';
import 'package:futo_vote/utils/safe_request.dart';
import 'package:get/get.dart';

class CandidateService extends GetxService {
  final _firestore = FirebaseFirestore.instance;

  final candidates = <CandidateData>[].obs;
  final organizedCandidates = <CandidateData>[].obs;

  CandidateData? getSingleCandidate(String id) {
    try {
      final res = candidates.firstWhere((p0) => p0.id == id);
      return res;
    } on StateError catch (e) {
      debugPrint(e.message);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    try {
      final res =
          await FirebaseFirestore.instance.collection('candidates').get();
      candidates.value = res.docs.map((e) => CandidateData.fromDB(e)).toList();

      final toBeSorted = res.docs.map((e) => CandidateData.fromDB(e)).toList();

      toBeSorted.sort((a, b) => b.votes.compareTo(a.votes));
      organizedCandidates.value = toBeSorted;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> voteForCandidate(String candidateId) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    late DocumentSnapshot votes;
    try {
      votes = await FirebaseFirestore.instance
          .collection('votes')
          .doc(candidateId)
          .get();
    } catch (e) {
      log(e.toString());
    }

    if (votes.exists && votes.data().toString().contains(user.uid)) {
      throw const FutoVoteException(
          'You can only vote once for a given candidate');
    }
    await FirebaseFirestore.instance
        .collection('votes')
        .doc(candidateId)
        .set({user.uid: 1}, SetOptions(merge: true));
    await FirebaseFirestore.instance
        .collection('candidates')
        .doc(candidateId)
        .update({'votes': FieldValue.increment(1)});
    final data = candidates().firstWhere((e) => e.id == candidateId).votes++;
  }

  Future addCandidate(String firstName, String lastName, String dept,
      String position, String manifesto, String image) async {
    await _firestore.collection('candidates').doc().set({
      'first_name': firstName,
      'last_name': lastName,
      'image': image,
      'position': position,
      'manifesto': manifesto,
      "dept": dept,
      "votes": 0,
    });

    final newCandidates = await _firestore.collection('candidates').get();
    candidates.value = newCandidates.docs
        .map(
          (e) => CandidateData.fromDB(e),
        )
        .toList();
    final toBeSorted =
        newCandidates.docs.map((e) => CandidateData.fromDB(e)).toList();

    toBeSorted.sort((a, b) => b.votes.compareTo(a.votes));
    organizedCandidates.value = toBeSorted;
  }

  Future deleteCandidate(CandidateData candidateData) async {
    await _firestore.collection('votes').doc(candidateData.id).delete();
    await _firestore.collection('candidates').doc(candidateData.id).delete();

    FirebaseStorage.instance.refFromURL(candidateData.image).delete();
    candidates().removeWhere((e) => e.id == candidateData.id);
    organizedCandidates().removeWhere((e) => e.id == candidateData.id);
  }
}
