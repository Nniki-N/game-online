import 'package:flutter/foundation.dart';

/// The abstract error for a notification exeption.
@immutable
abstract class NotificationError {
  final String errorTitle;
  final String errorText;

  const NotificationError({
    required this.errorTitle,
    required this.errorText,
  });

  @override
  String toString() {
    return 'ErrorTitle: $errorTitle \nErrorText: $errorText';
  }
}

/// The [NotificationError] child for an unknown error.
@immutable
class NotificationErrorUnknown extends NotificationError {
  const NotificationErrorUnknown({
    String? errorTitle,
    String? errorText,
  }) : super(
          errorTitle: errorTitle ?? 'Error',
          errorText: errorText ?? 'Unknown notification error happened',
        );
}

/// The [NotificationError] child for a creating notification error.
@immutable
class NotificationErrorCreatingNotification extends NotificationError {
  const NotificationErrorCreatingNotification()
      : super(
          errorTitle: 'Unable to create a notification',
          errorText: 'Some error happened while creating a notification',
        );
}

/// The [NotificationError] child for a updating notification error.
@immutable
class NotificationErrorUpdatingNotification extends NotificationError {
  const NotificationErrorUpdatingNotification()
      : super(
          errorTitle: 'Unable to update a notification',
          errorText: 'Some error happened while updating a notification',
        );
}

/// The [NotificationError] child for a deleting notification error.
@immutable
class NotificationErrorDeletingNotification extends NotificationError {
  const NotificationErrorDeletingNotification()
      : super(
          errorTitle: 'Unable to delete a notification',
          errorText: 'Some error happened while deleting a notification',
        );
}

/// The [NotificationError] child for a retrieving notification error.
@immutable
class NotificationErrorRetrievingNotification extends NotificationError {
  const NotificationErrorRetrievingNotification()
      : super(
          errorTitle: 'Unable to retrieve a notification',
          errorText: 'Some error happened while retrieving a notification',
        );
}

/// The [NotificationError] child for a retrieving notifications list error.
@immutable
class NotificationErrorRetrievingNotificationsList extends NotificationError {
  const NotificationErrorRetrievingNotificationsList()
      : super(
          errorTitle: 'Unable to retrieve a notifications list',
          errorText:
              'Some error happened while retrieving a notifications list',
        );
}

/// The [NotificationError] child for a sending game offer error.
@immutable
class NotificationErrorSendingGameOffer extends NotificationError {
  const NotificationErrorSendingGameOffer()
      : super(
          errorTitle: 'Unable to send a game offer',
          errorText: 'Some error happened while sending a game offer',
        );
}

/// The [NotificationError] child for a sending game offer acceptance error.
@immutable
class NotificationErrorSendingGameOfferAcceptance extends NotificationError {
  const NotificationErrorSendingGameOfferAcceptance()
      : super(
          errorTitle: 'Unable to send a game offer acceptance',
          errorText:
              'Some error happened while sending a game offer acceptance',
        );
}

/// The [NotificationError] child for a sending game offer denial error.
@immutable
class NotificationErrorSendingGameOfferDenial extends NotificationError {
  const NotificationErrorSendingGameOfferDenial()
      : super(
          errorTitle: 'Unable to send a game offer denian',
          errorText: 'Some error happened while sending a game offer denian',
        );
}
