import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AccountEvent {
  const AccountEvent();
}

@immutable
class InitializeAccountEvent extends AccountEvent {
  const InitializeAccountEvent();
}

@immutable
class ChangeUsernameAccountEvent extends AccountEvent {
  final String newUsername;

  const ChangeUsernameAccountEvent({
    required this.newUsername,
  });
}

@immutable
class ChangeLoginAccountEvent extends AccountEvent {
  final String newLogin;

  const ChangeLoginAccountEvent({
    required this.newLogin,
  });
}

@immutable
class LogOutAccountEvent extends AccountEvent {
  const LogOutAccountEvent();
}
