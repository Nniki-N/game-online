import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:game/common/constants/firebase_constants.dart';
import 'package:game/common/typedefs.dart';
import 'package:game/data/models/account_model.dart';
import 'package:logger/logger.dart';

@immutable
class FirebaseAccountDatasourceHelper {
  final FirebaseFirestore _firebaseFirestore;
  final Logger _logger;

  const FirebaseAccountDatasourceHelper._sharedInstance({
    required FirebaseFirestore firebaseFirestore,
    required Logger logger,
  })  : _firebaseFirestore = firebaseFirestore,
        _logger = logger;

  static const _shared = FirebaseAccountDatasourceHelper._sharedInstance;

  factory FirebaseAccountDatasourceHelper.instance({
    required FirebaseFirestore firebaseFirestore,
    required Logger logger,
  }) =>
      _shared(
        firebaseFirestore: firebaseFirestore,
        logger: logger,
      );

  /// Creates a new account document in the Firestore Database.
  Future<void> createAccount({required AccountModel accountModel}) async {
    try {
      await _firebaseFirestore
          .collection(FirebaseConstants.accounts)
          .doc(accountModel.uid)
          .set(accountModel.toJson());
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Retrieves account data from the Firestore Database and returns
  /// [AccountModel] if the request was successful or null if not.
  Future<AccountModel?> getAccountModel({required String uid}) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firebaseFirestore
              .collection(FirebaseConstants.accounts)
              .doc(uid)
              .get();

      final Json? json = snapshot.data();

      if (json != null) return AccountModel.fromJson(json);

      return null;
    } catch (exception) {
      _logger.e(exception);
      return null;
    }
  }

  /// Updates account data in the Firestore Database.
  Future<void> updateAccount({required AccountModel accountModel}) async {
    try {
      await _firebaseFirestore
          .collection(FirebaseConstants.accounts)
          .doc(accountModel.uid)
          .update(accountModel.toJson());
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Checks if account already exists in the Firestore Database.
  Future<bool> accountExists({required String uid}) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firebaseFirestore
              .collection(FirebaseConstants.accounts)
              .doc(uid)
              .get();

      return snapshot.exists;
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }
}
