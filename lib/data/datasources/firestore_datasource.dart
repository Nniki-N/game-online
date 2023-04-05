import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirestoreDatasource {
  final FirebaseFirestore firebaseFirestore;

  const FirestoreDatasource({
    required this.firebaseFirestore,
  });

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    
  }
}
