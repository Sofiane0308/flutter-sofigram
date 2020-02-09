import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _firestore = Firestore.instance;
final storageref = FirebaseStorage.instance.ref();
final usersRef = _firestore.collection('users');