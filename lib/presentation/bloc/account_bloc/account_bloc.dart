import 'dart:async';
import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/errors/account_error.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/domain/repositories/account_repository.dart';
import 'package:game/presentation/bloc/account_bloc/account_event.dart';
import 'package:game/presentation/bloc/account_bloc/account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository _accountRepository;

  AccountBloc({
    required AccountRepository accountRepository,
  })  : _accountRepository = accountRepository,
        super(const InitialAccountState()) {
    on<InitializeAccountEvent>(_init, transformer: droppable());
    on<ChangeUsernameAccountEvent>(_changeUsername, transformer: sequential());
    on<ChangeLoginAccountEvent>(_changeLogin, transformer: sequential());
    on<ChangeOnlineStateAccountEvent>(_changeOnlineState,
        transformer: sequential());
    on<LogOutAccountEvent>(_logOut, transformer: droppable());
  }

  /// Initializes the first state.
  ///
  /// Changes the state base on the current user data changes.
  Future<void> _init(
    InitializeAccountEvent event,
    Emitter<AccountState> emit,
  ) async {
    try {
      // Retrieve the current user account data.
      final UserAccount currentUserAccount =
          await _accountRepository.getCurrentUserAccount();

      // Indicates that the current user account data was loaded.
      emit(LoadedAccountState(userAccount: currentUserAccount));

      // Retrieves a stream of the current user account data changes.
      final Stream<UserAccount> currentUserAccountStream =
          _accountRepository.getCurrentUserAccountStream();

      // Responds to the current user account data changes.
      await emit.onEach(
        currentUserAccountStream,
        onData: (userAccount) {
          // Updates the current user account.
          emit(LoadedAccountState(userAccount: userAccount));
        },
        onError: (error, stackTrace) {
          // emit(const EmptyAccountState());
          log('AccountBloc: account stream error');
        },
      );
    } catch (exception) {
      emit(const EmptyAccountState());
    }
  }

  /// Changes the username of the current user.
  Future<void> _changeUsername(
    ChangeUsernameAccountEvent event,
    Emitter<AccountState> emit,
  ) async {
    try {
      UserAccount userAccount = state.getUserAccount()!;

      // Changes the username to a new one.
      userAccount = userAccount.copyWith(
        username: event.newUsername,
      );

      // Updates the username.
      _accountRepository.updateUserAccount(userAccount: userAccount);

      emit(LoadedAccountState(userAccount: userAccount));
    } on AccountError catch (accountError) {
      emit(ErrorAccountState(
        accountError: accountError,
        userAccount: state.getUserAccount()!,
      ));
    }
  }

  /// Changes the login of the current user.
  ///
  /// If specified login is already used, indicates this.
  Future<void> _changeLogin(
    ChangeLoginAccountEvent event,
    Emitter<AccountState> emit,
  ) async {
    try {
      UserAccount userAccount = state.getUserAccount()!;

      // Retrieves a list of all users with specified login.
      final List<UserAccount> userAccountsList =
          await _accountRepository.getAccountModelListWhere(
        fieldName: 'login',
        fieldValue: event.newLogin,
      );

      if (userAccountsList.isNotEmpty) {
        // Indicates that this login is already used.
        throw const AccountErrorLoginIsUsed();
      } else {
        // Changes the login to a new one.
        userAccount = userAccount.copyWith(
          login: event.newLogin,
        );

        // Updates the login.
        _accountRepository.updateUserAccount(userAccount: userAccount);

        emit(LoadedAccountState(userAccount: userAccount));
      }
    } on AccountError catch (accountError) {
      emit(ErrorAccountState(
        accountError: accountError,
        userAccount: state.getUserAccount()!,
      ));
    }
  }

  /// Changes the online stateus of the current user.
  Future<void> _changeOnlineState(
    ChangeOnlineStateAccountEvent event,
    Emitter<AccountState> emit,
  ) async {
    try {
      UserAccount userAccount = state.getUserAccount()!;

      // Changes the username to a new one.
      userAccount = userAccount.copyWith(
        isOnline: event.isOnline,
      );

      // Updates the username.
      _accountRepository.updateUserAccount(userAccount: userAccount);

      emit(LoadedAccountState(userAccount: userAccount));
    } on AccountError catch (accountError) {
      emit(ErrorAccountState(
        accountError: accountError,
        userAccount: state.getUserAccount()!,
      ));
    }
  }

  /// Notifies that the current user logged out.
  Future<void> _logOut(
    LogOutAccountEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(const EmptyAccountState());
  }
}
