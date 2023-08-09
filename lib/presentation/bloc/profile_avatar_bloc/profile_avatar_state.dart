import 'package:flutter/foundation.dart';
import 'package:game/common/errors/profile_avatar_error.dart';

@immutable
abstract class ProfileAvatarState {
  const ProfileAvatarState();
}

@immutable
class InitialProfileAvatarState extends ProfileAvatarState {
  const InitialProfileAvatarState();
}

@immutable
class SelectingPictureProfileAvatarState extends ProfileAvatarState {
  const SelectingPictureProfileAvatarState();
}

@immutable
class ErrorProfileAvatarState extends ProfileAvatarState {
  final ProfileAvatarError profileAvatarError;
  const ErrorProfileAvatarState({
    required this.profileAvatarError,
  });
}
