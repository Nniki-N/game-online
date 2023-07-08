import 'package:flutter/foundation.dart';

/// The abstract error for an account exeption.
@immutable
abstract class AccountError {
  final String errorTitle;
  final String errorText;

  const AccountError({
    required this.errorTitle,
    required this.errorText,
  });

  @override
  String toString() {
    return 'ErrorTitle: $errorTitle \nErrorText: $errorText';
  }
}

/// The [AccountError] child for an unknown error.
@immutable
class AccountErrorUnknown extends AccountError {
  const AccountErrorUnknown({
    String? errorTitle,
    String? errorText,
  }) : super(
          errorTitle: errorTitle ?? 'Error',
          errorText: errorText ?? 'Unknown account error happened',
        );
}

/// The [AccountError] child for a creating account error.
@immutable
class AccountErrorCreatingAccount extends AccountError {
  const AccountErrorCreatingAccount()
      : super(
          errorTitle: 'Unable to create an account',
          errorText: 'Some error happened while creating an account',
        );
}

/// The [AccountError] child for an updating account error.
@immutable
class AccountErrorUpdatingAccount extends AccountError {
  const AccountErrorUpdatingAccount()
      : super(
          errorTitle: 'Unable to update the account',
          errorText: 'Some error happened while updating the account',
        );
}

/// The [AccountError] child for a retrieving account error.
@immutable
class AccountErrorRetrievingAccount extends AccountError {
  const AccountErrorRetrievingAccount()
      : super(
          errorTitle: 'Unable to retrieve an account',
          errorText: 'Some error happened while retrieving an account',
        );
}

/// The [AccountError] child for a retrieving account list error.
@immutable
class AccountErrorRetrievingAccountList extends AccountError {
  const AccountErrorRetrievingAccountList()
      : super(
          errorTitle: 'Unable to retrieve an account list',
          errorText: 'Some error happened while retrieving an account list',
        );
}

/// The [AccountError] child for a retrieving account stream error.
@immutable
class AccountErrorRetrievingAccountStream extends AccountError {
  const AccountErrorRetrievingAccountStream()
      : super(
          errorTitle: 'Unable to retrieve an account stream',
          errorText: 'Some error happened while retrieving an account stream',
        );
}

/// The [AccountError] child for a used login error.
@immutable
class AccountErrorLoginIsUsed extends AccountError {
  const AccountErrorLoginIsUsed()
      : super(
          errorTitle: 'Unable to change a login',
          errorText: 'This login is already used',
        );
}
