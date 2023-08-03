import 'package:flutter/foundation.dart';

@immutable
abstract class FriendsError {
  final String errorTitle;
  final String errorText;

  const FriendsError({
    required this.errorTitle,
    required this.errorText,
  });

  @override
  String toString() {
    return 'ErrorTitle: $errorTitle \nErrorText: $errorText';
  }
}

/// The [FriendsError] child for an unknown error.
@immutable
class FriendsErrorUnknown extends FriendsError {
  const FriendsErrorUnknown({
    String? errorTitle,
    String? errorText,
  }) : super(
          errorTitle: errorTitle ?? 'Error',
          errorText: errorText ?? 'Unknown friends error happened',
        );
}

/// The [FriendsError] child for an adding friend process error.
@immutable
class FriendsErrorFriendAdding extends FriendsError {
  const FriendsErrorFriendAdding({
    String? errorTitle,
    String? errorText,
  }) : super(
          errorTitle: errorTitle ?? 'Unable to add a friend',
          errorText: errorText ?? 'Some error happened while adding a friend',
        );
}

/// The [FriendsError] child for an deleting friend process error.
@immutable
class FriendsErrorFriendRemoving extends FriendsError {
  const FriendsErrorFriendRemoving({
    String? errorTitle,
    String? errorText,
  }) : super(
          errorTitle: errorTitle ?? 'Unable to remove a friend',
          errorText: errorText ?? 'Some error happened while removing a friend',
        );
}

/// The [FriendsError] child for an error when user is already a friend.
@immutable
class FriendsErrorThisUserIsAlreadyFriend extends FriendsError {
  const FriendsErrorThisUserIsAlreadyFriend({
    String? errorTitle,
    String? errorText,
  }) : super(
          errorTitle: errorTitle ?? 'Unable to add a friend',
          errorText: errorText ?? 'This user is already your fiend',
        );
}

/// The [FriendsError] child for an unknown error.
@immutable
class FriendsErrorRetrievingFriendsList extends FriendsError {
  const FriendsErrorRetrievingFriendsList({
    String? errorTitle,
    String? errorText,
  }) : super(
          errorTitle: errorTitle ?? 'Unable to retrieve a friends list',
          errorText: errorText ??
              'Some error happened while retrieving a friends list',
        );
}

/// The [FriendsError] child for an unknown error.
@immutable
class FriendsErrorNotExistingUserWithLogin extends FriendsError {
  const FriendsErrorNotExistingUserWithLogin({
    String? errorTitle,
    String? errorText,
  }) : super(
          errorTitle: errorTitle ?? 'Can not find user',
          errorText: errorText ??
              'User with such login does not exist',
        );
}

/// The [FriendsError] child for an unknown error.
@immutable
class FriendsErrorCanNotAddYourselfAsFriend extends FriendsError {
  const FriendsErrorCanNotAddYourselfAsFriend({
    String? errorTitle,
    String? errorText,
  }) : super(
          errorTitle: errorTitle ?? 'It is you',
          errorText: errorText ?? 'You can not add yourself to your connections',
        );
}
