import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String proflieImageUrl;
  final String email;
  final String bio;

  User({this.id, this.name, this.proflieImageUrl, this.email, this.bio});

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
        id: doc.documentID,
        name: doc['name'],
        proflieImageUrl: doc['profileImageUrl'],
        email: doc['email'],
        bio: doc['bio'] ?? '');
  }
}
