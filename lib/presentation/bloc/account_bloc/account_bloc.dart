import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/errors/account_error.dart';
import 'package:game/data/models/schemas/account_schema.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/domain/repositories/account_repository.dart';
import 'package:game/presentation/bloc/account_bloc/account_event.dart';
import 'package:game/presentation/bloc/account_bloc/account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository _accountRepository;
  late StreamSubscription _streamSubscription;

  AccountBloc({
    required AccountRepository accountRepository,
  })  : _accountRepository = accountRepository,
        super(const InitialAccountState()) {
    on<InitializeAccountEvent>(_init);
    on<ChangeUsernameAccountEvent>(_changeUsername);
    on<ChangeLoginAccountEvent>(_changeLogin);
    on<ChangeOnlineStateAccountEvent>(_changeOnlineState);
    on<LogOutAccountEvent>(_logOut, transformer: restartable());
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
          _accountRepository.getCurrentUserAccountStream().asBroadcastStream();

      // Responds to the current user account data changes.
      await _listenStream(
        currentUserAccountStream,
        onData: (userAccount) {
          // Updates the current user account.
          emit(LoadedAccountState(userAccount: userAccount));
        },
        onError: (error, stackTrace) {
          emit(const EmptyAccountState());
        },
      );
    } catch (exception) {
      emit(const EmptyAccountState());
    }
  }

  Future<void> _listenStream<T>(
    Stream<T> stream, {
    required void Function(T data) onData,
    required void Function(Object error, StackTrace stackTrace) onError,
  }) {
    final completer = Completer<void>();

    _streamSubscription = stream.listen(
      onData,
      onDone: completer.complete,
      onError: onError,
      cancelOnError: false,
    );

    return completer.future.whenComplete(() {
      _streamSubscription.cancel();
    });
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
          await _accountRepository.getUserAccountListWhere(
        fieldName: AccountSchema.login,
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
    await _streamSubscription.cancel();
    emit(const EmptyAccountState());
  }

  /// Closes the stream subscription.
  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    super.close();
  }
}
