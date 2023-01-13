import 'package:cloud_firestore/cloud_firestore.dart';

class CandidateData {
  CandidateData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.position,
    required this.manifesto,
    required this.dept,
    required this.votes,
  });

  final String id;

  final String firstName;
  final String lastName;
  final String image;
  final String position;
  final String manifesto;
  final String dept;
  int votes;

  String get fullName {
    final _ = '$firstName $lastName'.trim();
    return _.isEmpty ? 'Anonymous' : _;
  }

  String get initial => fullName[0].toUpperCase();

  factory CandidateData.fromDB(DocumentSnapshot doc) {
    return CandidateData(
      id: doc.id,
      firstName: doc['first_name'] as String? ?? '',
      lastName: doc['last_name'] as String? ?? '',
      image: doc['image'] as String? ?? '',
      position: doc['position'] as String? ?? '',
      manifesto: doc['manifesto'] as String? ?? '',
      dept: doc['dept'] as String? ?? '',
      votes: doc['votes'] as int? ?? 0,
    );
  }
}
