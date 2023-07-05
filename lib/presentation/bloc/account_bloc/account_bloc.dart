import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    on<LogOutAccountEvent>(_logOut, transformer: droppable());
  }

  ///
  ///
  ///
  Future<void> _init(
    InitializeAccountEvent event,
    Emitter<AccountState> emit,
  ) async {
    try {
      //
      final UserAccount userAccount =
          await _accountRepository.getCurrentUserAccount();

      emit(LoadedAccountState(userAccount: userAccount));
    } catch (exception) {
      // emit(ErrorAccountState(
      //   errorText: exception.toString(),
      //   userAccount: state.getUserAccount(),
      // ));

      emit(const EmptyAccountState());
    }
  }

  ///
  ///
  ///
  Future<void> _changeUsername(
    ChangeUsernameAccountEvent event,
    Emitter<AccountState> emit,
  ) async {
    try {
      //
      emit(LoadingAccountState(userAccount: state.getUserAccount()!));

      UserAccount userAccount = state.getUserAccount()!;

      userAccount = userAccount.copyWith(
        username: event.newUsername,
      );

      _accountRepository.updateUserAccount(userAccount: userAccount);

      emit(LoadedAccountState(userAccount: userAccount));
    } catch (exception) {
      emit(ErrorAccountState(
        errorText: exception.toString(),
        userAccount: state.getUserAccount()!,
      ));
    }
  }

  ///
  ///
  ///
  Future<void> _changeLogin(
    ChangeLoginAccountEvent event,
    Emitter<AccountState> emit,
  ) async {
    try {
      //
      emit(LoadingAccountState(userAccount: state.getUserAccount()!));

      UserAccount userAccount = state.getUserAccount()!;

      userAccount = userAccount.copyWith(
        username: event.newLogin,
      );

      _accountRepository.updateUserAccount(userAccount: userAccount);

      emit(LoadedAccountState(userAccount: userAccount));
    } catch (exception) {
      emit(ErrorAccountState(
        errorText: exception.toString(),
        userAccount: state.getUserAccount()!,
      ));
    }
  }

  ///
  ///
  ///
  Future<void> _logOut(
    LogOutAccountEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(const EmptyAccountState());
  }
}
