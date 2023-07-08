import 'package:flutter/foundation.dart' show immutable;
import 'package:game/common/errors/account_error.dart';
import 'package:game/domain/entities/account.dart';

@immutable
abstract class AccountState {
  const AccountState();
}

@immutable
class InitialAccountState extends AccountState {
  const InitialAccountState();
}

@immutable
class LoadedAccountState extends AccountState {
  final UserAccount userAccount;

  const LoadedAccountState({
    required this.userAccount,
  });
}

@immutable
class EmptyAccountState extends AccountState {
  const EmptyAccountState();
}

@immutable
class ErrorAccountState extends AccountState {
  final UserAccount userAccount;
  final AccountError accountError;

  const ErrorAccountState({
    required this.userAccount,
    required this.accountError,
  });
}

extension GetUserAccount on AccountState {
  UserAccount? getUserAccount() {
    final AccountState accountState = this;

    if (accountState is LoadedAccountState) {
      return accountState.userAccount;
    } else if (accountState is ErrorAccountState) {
      return accountState.userAccount;
    } else {
      return null;
    }
  }
}
