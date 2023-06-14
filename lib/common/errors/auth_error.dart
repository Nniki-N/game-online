import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;

/// Map of all child errors of type [AuthError].
const Map<String, AuthError> firebaseAuthErrorsMapping = {
  'user-not-found': AuthErrorUserNotFound(),
  'no-current-user': AuthErrorNoCurrentUser(),
  'requires-recent-login': AuthErrorRequiresRecentLogin(),
  'operation-not-allowed': AuthErrorOperationNotAllowed(),
  'weak-password': AuthErrorWeakPassword(),
  'invalid-email': AuthErrorInvalidEmail(),
  'invalid-password': AuthErrorInvalidPassword(),
  'email-already-in-use': AuthErrorEmailAlreadyInUse(),
  'wrong-password': AuthErrorWrongPassword(),
  'account-exists-with-different-credential':
      AuthErrorAccountExistsWithDifferentCredential(),
  'invalid-credential': AuthErrorInvalidCredential(),
  'credential-already-in-use': AuthErrorCredentialAlreadyInUse(),
};

/// The abstract error for the firebase auth exeption.
/// Factory constructor implements conversion of [FirebaseAuthException]
/// in [AuthError]
@immutable
abstract class AuthError {
  final String errorTitle;
  final String errorText;

  const AuthError({
    required this.errorTitle,
    required this.errorText,
  });

  factory AuthError.fromFirebaseAuthExeption({
    required FirebaseAuthException exception,
  }) =>
      firebaseAuthErrorsMapping[exception.code.toLowerCase().trim()] ??
      const AuthErrorUnknown();
}

/// The [AuthError] child for unknown error
@immutable
class AuthErrorUnknown extends AuthError {
  const AuthErrorUnknown()
      : super(
          errorTitle: 'Error',
          errorText: 'Unknown error happend',
        );
}

/// The [AuthError] child for firebase error "auth/user-not-found"
@immutable
class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound()
      : super(
          errorTitle: 'User not found',
          errorText: 'The given user was not found on the server!',
        );
}

/// The [AuthError] child error due to absence of a user in received credentials
@immutable
class AuthErrorUserCredentialUserNotFound extends AuthError {
  const AuthErrorUserCredentialUserNotFound()
      : super(
          errorTitle: 'User not found',
          errorText: 'The user was not found in credentials',
        );
}

/// The [AuthError] child error due to googl sign in aborting
@immutable
class AuthErrorGoogleSignInWasAborted extends AuthError {
  const AuthErrorGoogleSignInWasAborted()
      : super(
          errorTitle: 'Google sign in was aborted',
          errorText: 'Google sign in was aborted',
        );
}

/// The [AuthError] child for local firebase database
@immutable
class AuthErrorLocalCurrentUserNotFound extends AuthError {
  const AuthErrorLocalCurrentUserNotFound()
      : super(
          errorTitle: 'User not found',
          errorText: 'The given user was not found in the local database!',
        );
}

/// The [AuthError] child for firebase error "auth/no-current-user"
@immutable
class AuthErrorNoCurrentUser extends AuthError {
  const AuthErrorNoCurrentUser()
      : super(
          errorTitle: 'No current user!',
          errorText: 'No current user with this information was found!',
        );
}

/// The [AuthError] child for firebase error "auth/requires-recent-login"
@immutable
class AuthErrorRequiresRecentLogin extends AuthError {
  const AuthErrorRequiresRecentLogin()
      : super(
          errorTitle: 'Requires recent login',
          errorText:
              'You need to log out and log back in again in order to perform this operation',
        );
}

/// The [AuthError] child for firebase error "auth/operation-not-allowed"
@immutable
class AuthErrorOperationNotAllowed extends AuthError {
  const AuthErrorOperationNotAllowed()
      : super(
          errorTitle: 'Operation not allowed',
          errorText: 'You cannot register using this method at this moment!',
        );
}

/// The [AuthError] child for firebase error "auth/invalid-email"
@immutable
class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail()
      : super(
          errorTitle: 'Invalid email',
          errorText: 'Please double check your email and try again!',
        );
}

/// The [AuthError] child for firebase error "auth/invalid-password"
@immutable
class AuthErrorInvalidPassword extends AuthError {
  const AuthErrorInvalidPassword()
      : super(
          errorTitle: 'Invalid password',
          errorText: 'Please try again!',
        );
}

/// The [AuthError] child for firebase error "auth/weak-password"
@immutable
class AuthErrorWeakPassword extends AuthError {
  const AuthErrorWeakPassword()
      : super(
          errorTitle: 'Weak password',
          errorText:
              'Please choose a stronger password consisting of more characters!',
        );
}

/// The [AuthError] child for firebase error "auth/wrong-password"
@immutable
class AuthErrorWrongPassword extends AuthError {
  const AuthErrorWrongPassword()
      : super(
          errorTitle: 'Wrong password',
          errorText: 'The password is invalid for the given email!',
        );
}

/// The [AuthError] child for firebase error "auth/email-already-in-use"
@immutable
class AuthErrorEmailAlreadyInUse extends AuthError {
  const AuthErrorEmailAlreadyInUse()
      : super(
          errorTitle: 'Email already in use',
          errorText: 'Please choose another email to register with!',
        );
}

/// The [AuthError] child for firebase error "auth/account-exists-with-different-credential"
@immutable
class AuthErrorAccountExistsWithDifferentCredential extends AuthError {
  const AuthErrorAccountExistsWithDifferentCredential()
      : super(
          errorTitle: 'Invalid email',
          errorText: 'An account with this email address already exists!',
        );
}

/// The [AuthError] child for firebase error "auth/invalid-credential"
@immutable
class AuthErrorInvalidCredential extends AuthError {
  const AuthErrorInvalidCredential()
      : super(
          errorTitle: 'Invalid credential',
          errorText: 'The credential is malformed or has expired!',
        );
}

/// The [AuthError] child for firebase error "auth/credential-already-in-use"
@immutable
class AuthErrorCredentialAlreadyInUse extends AuthError {
  const AuthErrorCredentialAlreadyInUse()
      : super(
          errorTitle: 'Invalid credential',
          errorText: 'The credential is already in use!',
        );
}

/// The [AuthError] child for error "specific login is already used"
@immutable
class AuthErrorLoginIsAlreadyUsed extends AuthError {
  const AuthErrorLoginIsAlreadyUsed()
      : super(
          errorTitle: 'Login is already used',
          errorText: 'This login is already used, try another one!',
        );
}
