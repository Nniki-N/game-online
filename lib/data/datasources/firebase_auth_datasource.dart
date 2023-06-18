import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:game/common/constants/firebase_constants.dart';
import 'package:game/common/errors/auth_error.dart';
import 'package:game/common/utils/random_n_digits_number.dart';
import 'package:game/data/datasources/helpers/firebase_account_datasource_helper.dart';
import 'package:game/data/models/account_model.dart';
import 'package:game/data/models/schemas/account_schema.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
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
  ///
  /// Throws [AuthErrorUserCredentialUserNotFound] if a login process failed.
  Future<AccountModel> logInWithEmailAndPassword({
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

      // Throws an error if a login process in the Firebase failed.
      if (user == null) throw const AuthErrorUserCredentialUserNotFound();

      // returns account data if a login process is successful
      return await _accountDatasourceHelper.getAccountModel(uid: user.uid);
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
  ///
  /// Throws [AuthErrorGoogleSignInWasAborted] if a gogle signin process was aborted.
  /// Throws [AuthErrorUserCredentialUserNotFound] if a login process failed.
  Future<AccountModel> logInWithGoogle() async {
    try {
      // logs in with Google service
      final GoogleSignInAccount? googleAccount = await _googleSingIn.signIn();

      // Throws an error if a google signin process was aborted.
      if (googleAccount == null) throw const AuthErrorGoogleSignInWasAborted();

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

      // Throws an error if a login process in the Firebase failed.
      if (user == null) throw const AuthErrorUserCredentialUserNotFound();

      // if the Firebase login process was successful
      final bool exists =
          await _accountDatasourceHelper.accountExists(uid: user.uid);

      // creates account if it doesn't exist
      if (!exists) {
        final String username = _generateUsername();

        final AccountModel accountModel = AccountModel(
          username: user.displayName ?? username,
          login: user.displayName?.replaceAll(' ', '').toLowerCase() ??
              username.toLowerCase(),
          uid: user.uid,
          avatarLink: null,
          isActiv: true,
          isInGame: false,
          inGameRoomId: '',
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
        return await _accountDatasourceHelper.getAccountModel(uid: user.uid);
      }
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Creates account and logs the user in the app anonymously.
  ///
  /// Returns [AccountModel] if login process is successful and null if not.
  ///
  /// Throws [AuthErrorUserCredentialUserNotFound] if an anonymous login process failed.
  Future<AccountModel> logInAnonymously() async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInAnonymously();
      final User? user = userCredential.user;

      // Throws an error if a anonymous login process in the Firebase failed.
      if (user == null) throw const AuthErrorUserCredentialUserNotFound();

      final String username = _generateUsername();

      final AccountModel accountModel = AccountModel(
        username: username,
        login: username.toLowerCase(),
        uid: user.uid,
        avatarLink: null,
        isActiv: true,
        isInGame: false,
        inGameRoomId: '',
        gamesCount: 0,
        victoriesCount: 0,
        friendsUidList: const [],
        notificationsUidList: const [],
      );

      await _accountDatasourceHelper.createAccount(accountModel: accountModel);

      // return new account data
      return accountModel;
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
  ///
  /// Throws [AuthErrorUserCredentialUserNotFound] if a registration process failed.
  Future<AccountModel> registerWithEmailAndPassword({
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

      // Throws an error if a registration process in the Firebase failed.
      if (user == null) throw const AuthErrorUserCredentialUserNotFound();

      // creates a user account
      final AccountModel accountModel = AccountModel(
        username: username,
        login: login,
        uid: user.uid,
        avatarLink: null,
        isActiv: true,
        isInGame: false,
        inGameRoomId: '',
        gamesCount: 0,
        victoriesCount: 0,
        friendsUidList: const [],
        notificationsUidList: const [],
      );

      await _accountDatasourceHelper.createAccount(accountModel: accountModel);

      // return new account data
      return accountModel;
    } catch (exception) {
      _logger.e(exception);
      rethrow;
    }
  }

  /// Links anonymous user with email and password.
  ///
  /// Returns [AccountModel] if register process is successful and null if not.
  ///
  /// Throws [AuthErrorUserCredentialUserNotFound] if an anonymous registration process failed.
  Future<AccountModel> registerAnonymousUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      User? user = _firebaseAuth.currentUser;

      // Throws an error if an anonymous registration process in the Firebase failed.
      if (user == null) throw const AuthErrorUserCredentialUserNotFound();

      final AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      final UserCredential userCredential =
          await user.linkWithCredential(credential);

      user = userCredential.user;

      // Throws an error if an anonymous registration process in the Firebase failed.
      if (user == null) throw const AuthErrorUserCredentialUserNotFound();

      return await _accountDatasourceHelper.getAccountModel(uid: user.uid);
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
        final AccountModel accountModel =
            await _accountDatasourceHelper.getAccountModel(uid: user.uid);

        final List<String> friendsUidList = accountModel.friendsUidList;

        // removes current user uid from each friend's friends list
        for (String friendUid in friendsUidList) {
          try {
            final AccountModel friendAccountModel =
                await _accountDatasourceHelper.getAccountModel(uid: friendUid);

            final List<String> newFriendsUidList =
                friendAccountModel.friendsUidList.toList();

            // removes current user uid from the list
            newFriendsUidList.removeWhere((e) => e == accountModel.uid);

            final AccountModel newAccountModel =
                friendAccountModel.copyWith(friendsUidList: newFriendsUidList);

            await _accountDatasourceHelper.updateAccount(
                accountModel: newAccountModel);
          } catch (exeption) {
            continue;
          }
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

  /// Checks if user is logged in anonymously.
  bool isAnonymousUser() => _firebaseAuth.currentUser?.isAnonymous ?? false;

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

  String _generateUsername() =>
      'User${randomNDigitNumber(digitsCount: 6)}${randomNDigitNumber(digitsCount: 6)}';
}
