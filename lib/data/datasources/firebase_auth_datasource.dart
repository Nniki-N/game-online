import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:game/common/constants/firebase_constants.dart';
import 'package:game/common/errors/auth_error.dart';
import 'package:game/common/utils/random_n_digits_number.dart';
import 'package:game/data/datasources/helpers/firebase_account_datasource_helper.dart';
import 'package:game/data/models/account_model.dart';
import 'package:game/data/models/schemas/account_schema.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class FirebaseAuthDataSource {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSingIn;
  final Logger _logger;
  late final FirebaseAccountDatasourceHelper _accountDatasourceHelper;

  FirebaseAuthDataSource({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required Logger logger,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore,
        _googleSingIn = googleSignIn,
        _logger = logger,
        _accountDatasourceHelper = FirebaseAccountDatasourceHelper.instance(
          firebaseFirestore: firebaseFirestore,
          logger: logger,
        );

  /// Logs the user in the app via Firebase Authentication with email and password.
  ///
  /// Returns [AccountModel] if login process is successful and null if not.
  Future<AccountModel?> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      // returns account data if login process is successful
      if (user != null) {
        return await _accountDatasourceHelper.getAccountModel(uid: user.uid);
      } else {
        return null;
      }
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Logs user in the app via Google Authentication and Firebase Authentication
  /// with credentials.
  ///
  /// Creates an account the first time user logs in with Google.
  ///
  /// Returns [AccountModel] if login process is successful and null if not.
  Future<AccountModel?> logInWithGoogle() async {
    try {
      // s in with Google service
      final GoogleSignInAccount? googleAccount = await _googleSingIn.signIn();

      // if login process was not aborted
      if (googleAccount != null) {
        // gets authentication tokens after sign in
        final GoogleSignInAuthentication gogleAuth =
            await googleAccount.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: gogleAuth.accessToken,
          idToken: gogleAuth.idToken,
        );

        // logs in to Firebase with credentials
        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        final User? user = userCredential.user;

        // if the Firebase login process was successful
        if (user != null) {
          final bool exists =
              await _accountDatasourceHelper.accountExists(uid: user.uid);

          // creates account if it doesn't exist
          if (!exists) {
            final AccountModel accountModel = AccountModel(
              username: user.displayName ?? _generateUsername(),
              login: _generateLogin(),
              uid: user.uid,
              avatarLink: null,
              isActiv: true,
              isInGame: false,
              gamesCount: 0,
              victoriesCount: 0,
              friendsUidList: const [],
              notificationsUidList: const [],
            );

            await _accountDatasourceHelper.createAccount(
                accountModel: accountModel);

            // return new account data
            return accountModel;
          } else {
            // returns existing account data
            return await _accountDatasourceHelper.getAccountModel(
                uid: user.uid);
          }
        } else {
          // login process was not successful
          return null;
        }
      } else {
        // login process was aborted
        return null;
      }
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Creates account and logs the user in the app anonymously.
  ///
  /// Returns [AccountModel] if login process is successful and null if not.
  Future<AccountModel?> logInAnonymously() async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInAnonymously();
      final User? user = userCredential.user;

      // if the Firebase anonymous login process was successful
      if (user != null) {
        final AccountModel accountModel = AccountModel(
          username: user.displayName ?? _generateUsername(),
          login: _generateLogin(),
          uid: user.uid,
          avatarLink: null,
          isActiv: true,
          isInGame: false,
          gamesCount: 0,
          victoriesCount: 0,
          friendsUidList: const [],
          notificationsUidList: const [],
        );

        await _accountDatasourceHelper.createAccount(
            accountModel: accountModel);

        // return new account data
        return accountModel;
      } else {
        return null;
      }
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Logs the user out from the app.
  Future<void> logOut() async {
    try {
      if (await _googleSingIn.isSignedIn()) await _googleSingIn.signOut();
      if (isLoggedIn()) await _firebaseAuth.signOut();
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Registers a user with email, password, username and login
  /// and creates account.
  ///
  /// Returns [AccountModel] if register process is successful and null if not.
  Future<AccountModel?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String login,
  }) async {
    try {
      // registers a user
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      // creates a user account
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

        await _accountDatasourceHelper.createAccount(
            accountModel: accountModel);

        // return new account data
        return accountModel;
      } else {
        // register process was not successful
        return null;
      }
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Links anonymous user with email and password.
  ///
  /// Returns [AccountModel] if register process is successful and null if not.
  Future<AccountModel?> registerAnonymousUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null && user.isAnonymous) {
        final AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );

        final UserCredential userCredential =
            await user.linkWithCredential(credential);

        user = userCredential.user;

        if (user != null) {
          return await _accountDatasourceHelper.getAccountModel(uid: user.uid);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Delete account from Firebase Authentication and Firestore Database.
  Future<void> deleteAccount() async {
    try {
      final User? user = _firebaseAuth.currentUser;

      if (user != null) {
        final AccountModel? accountModel =
            await _accountDatasourceHelper.getAccountModel(uid: user.uid);

        if (accountModel == null) throw const AuthErrorUnknown();

        final Iterable<String> friendsUidList = accountModel.friendsUidList;

        // removes current user uid from each friend's friends list
        for (String friendUid in friendsUidList) {
          final AccountModel? friendAccountModel =
              await _accountDatasourceHelper.getAccountModel(uid: friendUid);

          if (friendAccountModel == null) continue;

          final List<String> newFriendsUidList =
              friendAccountModel.friendsUidList.toList();

          // removes current user uid from the list
          newFriendsUidList.removeWhere((e) => e == accountModel.uid);

          final AccountModel newAccountModel =
              friendAccountModel.copyWith(friendsUidList: newFriendsUidList);

          await _accountDatasourceHelper.updateAccount(
              accountModel: newAccountModel);
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
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Checks if user is logged in.
  bool isLoggedIn() => _firebaseAuth.currentUser == null ? false : true;

  /// Returns true if an account with a specific login exists
  Future<bool> loginIsAlreadyUsed({required String login}) async {
    try {
      final QuerySnapshot query = await _firebaseFirestore
          .collection(FirebaseConstants.accounts)
          .where(AccountSchema.login, isEqualTo: login)
          .get();

      return query.docs.isNotEmpty;
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  String _generateLogin() => 'user${randomNDigitNumber(digitsCount: 10)}';
  String _generateUsername() => 'User${randomNDigitNumber(digitsCount: 10)}';
}
