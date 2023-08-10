import 'package:flutter/foundation.dart';

@immutable
abstract class InternetConnectionState {
  const InternetConnectionState();
}

@immutable
class InitialInternetConnectionState extends InternetConnectionState {
  const InitialInternetConnectionState();
}

@immutable
class ConnectedInternetConnectionState extends InternetConnectionState {
  const ConnectedInternetConnectionState();
}

@immutable
class DisconnectedInternetConnectionState extends InternetConnectionState {
  const DisconnectedInternetConnectionState();
}
