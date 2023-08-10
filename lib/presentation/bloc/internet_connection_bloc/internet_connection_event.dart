import 'package:flutter/foundation.dart';

@immutable
class InternetConnectionEvent {
  const InternetConnectionEvent();
}

@immutable
class InitializeInternetConnectionEvent extends InternetConnectionEvent {
  const InitializeInternetConnectionEvent();
}
