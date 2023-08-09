
import 'package:flutter/foundation.dart';

/// The abstract error for a profile avatar exeption.
@immutable
abstract class ProfileAvatarError {
  final String errorTitle;
  final String errorText;

  const ProfileAvatarError({
    required this.errorTitle,
    required this.errorText,
  });

  @override
  String toString() {
    return 'ErrorTitle: $errorTitle \nErrorText: $errorText';
  }
}

/// The [ProfileAvatarError] child for an unknown error.
@immutable
class ProfileAvatarErrorUnknown extends ProfileAvatarError {
  const ProfileAvatarErrorUnknown({
    String? errorTitle,
    String? errorText,
  }) : super(
          errorTitle: errorTitle ?? 'Error',
          errorText: errorText ?? 'Unknown profile avatar error happened',
        );
}

/// The [ProfileAvatarError] child for a creating notification error.
@immutable
class ProfileAvatarErrorSelectingPhoto extends ProfileAvatarError {
  const ProfileAvatarErrorSelectingPhoto()
      : super(
          errorTitle: 'Unable to select a photo',
          errorText: 'Something happened while selecting photo',
        );
}
