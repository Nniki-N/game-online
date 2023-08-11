import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/presentation/bloc/internet_connection_bloc/internet_connection_event.dart';
import 'package:game/presentation/bloc/internet_connection_bloc/internet_connection_state.dart';

class InternetConnectionBloc
    extends Bloc<InternetConnectionEvent, InternetConnectionState> {
  late StreamSubscription _connectivityStreamSubscription;

  InternetConnectionBloc() : super(const InitialInternetConnectionState()) {
    on<InitializeInternetConnectionEvent>(_init);
  }

  /// Initializes connectivity stream and stream subscription, which changes state
  /// based on the connection status.
  Future<void> _init(
    InitializeInternetConnectionEvent event,
    Emitter<InternetConnectionState> emit,
  ) async {
    try {
      final Connectivity connectivity = Connectivity();
      log('initialize internet connection state');

      final ConnectivityResult initialConnectivityResult = await connectivity.checkConnectivity();

      if (initialConnectivityResult == ConnectivityResult.wifi) {
        emit(const ConnectedInternetConnectionState());
      } else if (initialConnectivityResult == ConnectivityResult.mobile) {
        emit(const ConnectedInternetConnectionState());
      } else if (initialConnectivityResult == ConnectivityResult.vpn) {
        emit(const ConnectedInternetConnectionState());
      } else if (initialConnectivityResult == ConnectivityResult.none) {
        emit(const DisconnectedInternetConnectionState());
      } else {
        emit(const DisconnectedInternetConnectionState());
      }

      await _listenConnectivityStream(
        connectivity.onConnectivityChanged,
        onData: (connectivityResult) {
          log(connectivityResult.toString());

          if (connectivityResult == ConnectivityResult.wifi) {
            emit(const ConnectedInternetConnectionState());
          } else if (connectivityResult == ConnectivityResult.mobile) {
            emit(const ConnectedInternetConnectionState());
          } else if (connectivityResult == ConnectivityResult.vpn) {
            emit(const ConnectedInternetConnectionState());
          } else if (connectivityResult == ConnectivityResult.none) {
            emit(const DisconnectedInternetConnectionState());
          } else {
            emit(const DisconnectedInternetConnectionState());
          }
        },
        onError: (exception, stackTrace) {
          emit(const DisconnectedInternetConnectionState());
        },
      );
    } catch (exception) {
      emit(const DisconnectedInternetConnectionState());
    }
  }

  Future<void> _listenConnectivityStream<ConnectivityResult>(
    Stream<ConnectivityResult> stream, {
    required void Function(ConnectivityResult data) onData,
    required void Function(Object error, StackTrace stackTrace) onError,
  }) {
    final completer = Completer<void>();

    _connectivityStreamSubscription = stream.listen(
      onData,
      onDone: completer.complete,
      onError: onError,
      cancelOnError: false,
    );

    return completer.future.whenComplete(() {
      _connectivityStreamSubscription.cancel();
    });
  }

  /// Closes the stream subscription.
  @override
  Future<void> close() async {
    await _connectivityStreamSubscription.cancel();
    super.close();
  }
}
