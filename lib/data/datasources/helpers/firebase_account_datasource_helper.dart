import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:game/common/constants/firebase_constants.dart';
import 'package:game/common/errors/auth_error.dart';
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

  /// Retrieves a user account data from the Firestore Database and returns
  /// [AccountModel] if the request was successful.
  ///
  /// Throws [AuthErrorLocalCurrentUserNotFound] if an account data was not retrieved.
  Future<AccountModel> getAccountModel({required String uid}) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firebaseFirestore
              .collection(FirebaseConstants.accounts)
              .doc(uid)
              .get();

      final Json? json = snapshot.data();

      if (json == null) throw const AuthErrorUserNotFound();

      return AccountModel.fromJson(json);
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Retrieves a stream of changes of an account data from the Firestore Database
  /// and returns a stream of[AccountModel] if the request was successful.
  Stream<AccountModel> getAccountModelStream({required String uid}) {
    try {
      final Stream<AccountModel> accountModelStream = _firebaseFirestore
          .collection(FirebaseConstants.accounts)
          .doc(uid)
          .snapshots()
          .map((snapshot) => AccountModel.fromJson(snapshot.data() as Json));

      return accountModelStream;
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Updates a user account data in the Firestore Database.
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

  /// Checks if a user account already exists in the Firestore Database.
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
