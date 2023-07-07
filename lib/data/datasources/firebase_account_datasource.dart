import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:game/common/errors/auth_error.dart';
import 'package:game/data/datasources/helpers/firebase_account_datasource_helper.dart';
import 'package:game/data/models/account_model.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
class FirebaseAccountDatasource {
  final FirebaseAccountDatasourceHelper _firebaseAccountDatasourceHelper;
  final FirebaseAuth _firebaseAuth;
  final Logger _logger;

  FirebaseAccountDatasource({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseAuth firebaseAuth,
    required Logger logger,
  })  : _firebaseAuth = firebaseAuth,
        _logger = logger,
        _firebaseAccountDatasourceHelper =
            FirebaseAccountDatasourceHelper.instance(
          firebaseFirestore: firebaseFirestore,
          logger: logger,
        );

  /// Retrieves an account data of the current user from the Firestore Database and returns
  /// [AccountModel] if the request was successful.
  ///
  /// Throws [AuthErrorLocalCurrentUserNotFound] if a [User] retrieving from local
  /// Firebase Database failed.
  Future<AccountModel> getCurrentAccountModel() async {
    try {
      final User? user = _firebaseAuth.currentUser;

      if (user == null) throw const AuthErrorLocalCurrentUserNotFound();

      final AccountModel accountModel =
          await _firebaseAccountDatasourceHelper.getAccountModel(
        uid: user.uid,
      );

      return accountModel;
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Retrieves a user account data from the Firestore Database and returns
  /// [AccountModel] if the request was successful.
  Future<AccountModel> getAccountModel({required String uid}) async {
    try {
      final AccountModel accountModel =
          await _firebaseAccountDatasourceHelper.getAccountModel(
        uid: uid,
      );

      return accountModel;
    } catch (exception) {
      rethrow;
    }
  }

  /// Retrieves a stream of changes of an account data of a current user from
  /// the Firestore Database and returns a stream of [AccountModel] if the request was successful.
  ///
  /// Throws [AuthErrorLocalCurrentUserNotFound] if a [User] retrieving from local
  /// Firebase Database failed.
  Stream<AccountModel> getCurrentAccountModelStream() {
    try {
      final User? user = _firebaseAuth.currentUser;

      if (user == null) throw const AuthErrorLocalCurrentUserNotFound();

      final Stream<AccountModel> accountModelStream =
          _firebaseAccountDatasourceHelper.getAccountModelStream(uid: user.uid);

      return accountModelStream;
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Updates a user account data in the Firestore Database..
  Future<void> updateAccount({required AccountModel accountModel}) async {
    try {
      await _firebaseAccountDatasourceHelper.updateAccount(
        accountModel: accountModel,
      );
    } catch (exception) {
      rethrow;
    }
  }

  /// Retrieves a list of users where [fieldName] equals [fieldValue] from the 
  /// Firestore Database and returns a list of [AccountModel] if the request was successful.
  Future<List<AccountModel>> getAccountModelsWhere({
    required String fieldName,
    required dynamic fieldValue,
  }) async {
    try {
      final List<AccountModel> accountModelsList =
          await _firebaseAccountDatasourceHelper.getAccountModelsWhere(
        fieldName: fieldName,
        fieldValue: fieldValue,
      );

      return accountModelsList;
    } catch (exception) {
      rethrow;
    }
  }
}
