import 'package:flutter/foundation.dart';

@immutable
abstract class ProfileAvatarEvent {
  const ProfileAvatarEvent();
}

@immutable
class SetNewPhotoProfileAvatarEvent extends ProfileAvatarEvent {
  const SetNewPhotoProfileAvatarEvent();
}