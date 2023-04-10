import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/errors/auth_error.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/domain/repositories/auth_repository.dart';
import 'package:game/presentation/bloc/auth_bloc.dart/auth_event.dart';
import 'package:game/presentation/bloc/auth_bloc.dart/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoadingAuthState()) {
    on<InitializeAuthEvent>(_init);
    on<LogInAuthEvent>(_logIn);
    on<LogInWithGoogleAuthEvent>(_logInWithGoogle);
    on<LogInAnonymouslyAuthEvent>(_logInAnonymously);
    on<LogOutAuthEvent>(_logOut);
    on<RegisterAuthEvent>(_register);
    on<RegisterAnonymousUserAuthEvent>(_registerAnonymousUser);
    on<DeleteAccountAuthEvent>(_deleteAccount);
  }

  /// Checks if user is logged in and sets first state.
  ///
  /// Sets the error to the state if [AuthError] occurs.
  Future<void> _init(InitializeAuthEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const LoadingAuthState());

      final bool isLoggedIn = await _authRepository.isLoggedIn();

      if (isLoggedIn) {
        emit(const LoggedInAuthState());
      } else {
        emit(const LoggedOutAuthState());
      }
    } on AuthError catch (authError) {
      emit(LoggedOutAuthState(error: authError));
    }
  }

  /// Logs the user in the app.
  ///
  /// Sets the error to the state if [AuthError] occurs.
  Future<void> _logIn(LogInAuthEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const LoadingAuthState());

      final Account? account = await _authRepository.logInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (account != null) {
        emit(const LoggedInAuthState());
      } else {
        emit(const LoggedOutAuthState());
      }
    } on AuthError catch (authError) {
      emit(LoggedOutAuthState(error: authError));
    } catch (e) {
      emit(const LoggedOutAuthState());
    }
  }

  /// Logs the user in the app via Google service.
  ///
  /// Sets the error to the state if [AuthError] occurs.
  Future<void> _logInWithGoogle(
    LogInWithGoogleAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const LoadingAuthState());

      final Account? account = await _authRepository.logInWithGoogle();

      if (account != null) {
        emit(const LoggedInAuthState());
      } else {
        emit(const LoggedOutAuthState());
      }
    } on AuthError catch (authError) {
      emit(LoggedOutAuthState(error: authError));
    }
  }

  /// Logs the user anonymously.
  ///
  /// Sets the error to the state if [AuthError] occurs.
  Future<void> _logInAnonymously(
    LogInAnonymouslyAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const LoadingAuthState());

      final Account? account = await _authRepository.logInAnonymously();

      if (account != null) {
        emit(const LoggedInAuthState(isAnonymousUser: true));
      } else {
        emit(const LoggedOutAuthState());
      }
    } on AuthError catch (authError) {
      emit(LoggedOutAuthState(error: authError));
    }
  }

  /// Logs the user out of the app.
  ///
  /// Sets the error to the state if [AuthError] occurs.
  Future<void> _logOut(LogOutAuthEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const LoadingAuthState());

      await _authRepository.logOut();

      emit(const LoggedOutAuthState());
    } on AuthError catch (authError) {
      emit(LoggedOutAuthState(error: authError));
    }
  }

  /// Registers the user with email, password, username and login.
  ///
  /// Sets the error to the state if [AuthError] occurs.
  Future<void> _register(
    RegisterAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const LoadingAuthState());

      final Account? account =
          await _authRepository.registerWithEmailAndPassword(
        email: event.email,
        password: event.password,
        username: event.username,
        login: event.login,
      );

      if (account != null) {
        emit(const LoggedInAuthState());
      } else {
        emit(const LoggedOutAuthState());
      }
    } on AuthError catch (authError) {
      emit(LoggedOutAuthState(error: authError));
    }
  }

  /// Registers anonymous user account with email and password.
  ///
  /// Sets the error to the state if [AuthError] occurs.
  Future<void> _registerAnonymousUser(
    RegisterAnonymousUserAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const LoadingAuthState());

      await _authRepository.registerAnonymousUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      emit(const LoggedInAuthState());
    } on AuthError catch (authError) {
      emit(LoggedInAuthState(error: authError));
    }
  }

  /// Deletes user account.
  ///
  /// Sets the error to the state if [AuthError] occurs.
  Future<void> _deleteAccount(
    DeleteAccountAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const LoadingAuthState());

      await _authRepository.deleteAccount();

      emit(const LoggedOutAuthState());
    } on AuthError catch (authError) {
      emit(LoggedOutAuthState(error: authError));
    }
  }
}
