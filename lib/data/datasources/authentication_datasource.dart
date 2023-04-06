import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/services.dart';
import 'package:game/common/constants/firebase_constants.dart';
import 'package:game/common/errors/auth_error.dart';
import 'package:game/common/typedefs.dart';
import 'package:game/common/utils/random_n_digits_number.dart';
import 'package:game/data/models/account_model.dart';
import 'package:game/data/models/schemas/account_schema.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

@immutable
class AuthenticationDataSource {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSingIn;
  final Logger _logger;

  const AuthenticationDataSource({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required Logger logger,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore,
        _googleSingIn = googleSignIn,
        _logger = logger;

  /// Logs the user in the app via Firebase Authentication with email and password.
  ///
  /// Rethrows [AuthError] when the error of type [FirebaseAuthException] occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (firebaseAuthException) {
      _logger.w(firebaseAuthException);

      throw AuthError.fromFirebaseAuthExeption(
        exception: firebaseAuthException,
      );
    }
  }

  /// Logs user in the app via Google Authentication and Firebase Authentication
  /// with credentials.
  ///
  /// Creates and account the first time  user signs in with Google.
  ///
  /// Rethrows [AuthError] when the error of type [FirebaseAuthException] occurs.
  /// Throws [AuthError] when the error of type [PlatformException] occurs.
  Future<void> logInWithGoogle() async {
    try {
      // signs in with Google service
      final GoogleSignInAccount? googleAccount = await _googleSingIn.signIn();

      // if sign in process was not aborted
      if (googleAccount != null) {
        // gets authentication tokens after sign in
        final GoogleSignInAuthentication gogleAuth =
            await googleAccount.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: gogleAuth.accessToken,
          idToken: gogleAuth.idToken,
        );

        // signs in to Firebase with credentials
        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        final User? user = userCredential.user;

        // if the Firebase signin process was successful
        if (user != null) {
          final bool exists = await accountExists(uid: user.uid);

          // creates account if it doesn't exist
          if (!exists) {
            final AccountModel accountModel = AccountModel(
              username: user.displayName ?? _createGeneralUsername(),
              login: _createGeneralLogin(),
              uid: user.uid,
              avatarLink: null,
              isActiv: true,
              isInGame: false,
              gamesCount: 0,
              victoriesCount: 0,
              friendsUidList: const [],
              notificationsUidList: const [],
            );

            await _createAccount(accountModel: accountModel);
          }
        } else {
          throw const AuthErrorUserNotFound();
        }
      }
    } on FirebaseAuthException catch (firebaseAuthException) {
      _logger.w(firebaseAuthException);

      throw AuthError.fromFirebaseAuthExeption(
        exception: firebaseAuthException,
      );
    } on PlatformException catch (platformExcaption) {
      _logger.e(platformExcaption);

      throw const AuthErrorUnknown();
    } on AuthError catch (authError) {
      _logger.e(authError);
      rethrow;
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Creates account and logs user in the app anonymously.
  ///
  /// Rethrows [AuthError] when the error of type [FirebaseAuthException] occurs.
  Future<void> logInAnonymously() async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInAnonymously();
      final User? user = userCredential.user;

      // if the Firebase anonymous signin process was successful
      if (user != null) {
        final AccountModel accountModel = AccountModel(
          username: user.displayName ?? _createGeneralUsername(),
          login: _createGeneralLogin(),
          uid: user.uid,
          avatarLink: null,
          isActiv: true,
          isInGame: false,
          gamesCount: 0,
          victoriesCount: 0,
          friendsUidList: const [],
          notificationsUidList: const [],
        );

        await _createAccount(accountModel: accountModel);
      }
    } on FirebaseAuthException catch (firebaseAuthException) {
      _logger.w(firebaseAuthException);

      throw AuthError.fromFirebaseAuthExeption(
        exception: firebaseAuthException,
      );
    }
  }

  /// Logs the user out from the app.
  ///
  /// Rethrows [AuthError] when the error of type [FirebaseAuthException] occurs.
  /// Throws [AuthError] when the error of type [PlatformException] occurs.
  Future<void> logOut() async {
    try {
      if (await _googleSingIn.isSignedIn()) await _googleSingIn.signOut();
      if (isLoggedIn()) await _firebaseAuth.signOut();
    } on PlatformException catch (platformExcaption) {
      _logger.e(platformExcaption);

      throw const AuthErrorUnknown();
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Registers userr with email and password and creates account.
  ///
  /// Throws [AuthError] if specific login is already used by someone.
  /// Rethrows [AuthError] when the error of type [FirebaseAuthException] occurs.
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String login,
  }) async {
    try {
      // checks if specific login is already used by someone.
      final bool isLoginAlreasyUsed =
          await checkIfDocumentWithSpecificValueExists(
        collectionReference:
            _firebaseFirestore.collection(FirebaseConstants.accounts),
        field: AccountSchema.login,
        value: login,
      );
      if (isLoginAlreasyUsed) {
        throw const AuthErrorUnknown();
      }

      // registers user
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      // creates user account
      if (user != null) {
        final AccountModel accountModel = AccountModel(
          username: username,
          login: login,
          uid: user.uid,
          avatarLink: null,
          isActiv: true,
          isInGame: false,
          gamesCount: 0,
          victoriesCount: 0,
          friendsUidList: const [],
          notificationsUidList: const [],
        );

        await _createAccount(accountModel: accountModel);
      } else {
        throw const AuthErrorUnknown();
      }
    } on FirebaseAuthException catch (firebaseAuthException) {
      throw AuthError.fromFirebaseAuthExeption(
        exception: firebaseAuthException,
      );
    } on AuthError catch (authError) {
      _logger.w(authError);
      rethrow;
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Links anonymous user with email and password.
  ///
  /// Rethrows [AuthError] when the error of type [FirebaseAuthException] occurs.
  Future<void> registerAnonymousUserWithEmailAndPassword({
    required AccountModel accountModel,
    required String email,
    required String password,
  }) async {
    try {
      final User? user = _firebaseAuth.currentUser;

      if (user != null && user.isAnonymous) {
        final AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );

        await user.linkWithCredential(credential);
      }
    } on FirebaseAuthException catch (firebaseAuthException) {
      _logger.w(firebaseAuthException);

      throw AuthError.fromFirebaseAuthExeption(
        exception: firebaseAuthException,
      );
    } on AuthError catch (authError) {
      _logger.w(authError);
      rethrow;
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Delete account from Firebase Authentication and Firestore Database.
  ///
  /// Rethrows [AuthError] when the error of type [FirebaseAuthException] occurs.
  Future<void> deleteAccount() async {
    try {
      final User? user = _firebaseAuth.currentUser;

      if (user != null) {
        final AccountModel? accountModel = await getAccountModel(uid: user.uid);

        if (accountModel == null) throw const AuthErrorUnknown();

        final Iterable<String> friendsUidList = accountModel.friendsUidList;

        // removes current user uid from friend list of every friend
        for (String accountUid in friendsUidList) {
          final AccountModel? friendAccountModel =
              await getAccountModel(uid: accountUid);

          if (friendAccountModel == null) continue;

          final Iterable<String> newFriendsUidList =
              friendAccountModel.friendsUidList;

          newFriendsUidList
              .toList()
              .removeWhere((friendUid) => friendUid == accountModel.uid);

          final AccountModel newAccountModel =
              friendAccountModel.copyWith(friendsUidList: newFriendsUidList);

          await updateAccount(accountModel: newAccountModel);
        }

        // deletes account data
        await _firebaseFirestore
            .collection(FirebaseConstants.accounts)
            .doc(user.uid)
            .delete();

        // deletes account and signs out
        if (await _googleSingIn.isSignedIn()) await _googleSingIn.signOut();
        await user.delete();
      }
    } on FirebaseAuthException catch (firebaseAuthException) {
      _logger.w(firebaseAuthException);

      throw AuthError.fromFirebaseAuthExeption(
        exception: firebaseAuthException,
      );
    } on AuthError catch (authError) {
      _logger.w(authError);
      rethrow;
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Checks if user is logged in.
  bool isLoggedIn() => _firebaseAuth.currentUser == null ? false : true;

  /// Retrieves account data from the Firestore Database and returns
  /// [AccountModel] if the request was successful or null if the request is failed.
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

  /// Checks if a document with a specific value exists in a specific collection
  Future<bool> checkIfDocumentWithSpecificValueExists({
    required CollectionReference<Map<String, dynamic>> collectionReference,
    required String field,
    required dynamic value,
  }) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> query =
          await collectionReference.where(field, isEqualTo: value).get();

      return query.docs.isNotEmpty;
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Checks if account already exists in Firestore Database
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

  /// Creates a new account document
  Future<void> _createAccount({required AccountModel accountModel}) async {
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

  String _createGeneralLogin() => 'user${randomNDigitNumber(digitsCount: 10)}';
  String _createGeneralUsername() =>
      'User${randomNDigitNumber(digitsCount: 10)}';
}
