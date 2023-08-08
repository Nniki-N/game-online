import 'package:flutter/foundation.dart';
import 'package:game/data/datasources/firebase_account_datasource.dart';
import 'package:game/data/datasources/firebase_notification_datasource.dart';
import 'package:game/data/models/account_model.dart';
import 'package:game/data/models/game_room_model.dart';
import 'package:game/data/models/notification_model.dart';
import 'package:game/domain/entities/game_room.dart';
import 'package:game/domain/entities/notification.dart';
import 'package:game/common/errors/notification_error.dart';
import 'package:game/domain/repositories/notification_repository.dart';
import 'package:logger/logger.dart';

@immutable
class FirestoreNotificationRepository implements NotificationRepository {
  final FirebaseNotificationDatasource _firebaseNotificationDatasource;
  final FirebaseAccountDatasource _firebaseAccountDatasource;
  final Logger _logger;

  const FirestoreNotificationRepository({
    required FirebaseNotificationDatasource firebaseNotificationDatasource,
    required FirebaseAccountDatasource firebaseAccountDatasource,
    required Logger logger,
  })  : _firebaseNotificationDatasource = firebaseNotificationDatasource,
        _firebaseAccountDatasource = firebaseAccountDatasource,
        _logger = logger;

  /// Retrieves all notifications of a current user from the Firebase Firestore.
  ///
  /// Returns list of [Notification] if the request was successful.
  ///
  /// Rethrows [NotificationError] when the error occurs.
  /// Throws [NotificationErrorRetrievingNotificationsList] when any other error occurs.
  @override
  Future<List<Notification>> getNotificationsList() async {
    try {
      // Retrieves current user account model.
      final AccountModel currentAccountModel =
          await _firebaseAccountDatasource.getCurrentAccountModel();

      // A notifications list of a current user.
      final List<String> notificationsUidList =
          currentAccountModel.notificationsUidList;

      List<Notification> notificationsList = [];

      // Converts notification models to notifications.
      await Future.forEach(
        notificationsUidList,
        (uid) async {
          final bool notificationExists = await _notificationExists(uid: uid);

          // Adds a notification to the list only if it exists.
          if (notificationExists) {
            final NotificationModel notificationModel =
                await _firebaseNotificationDatasource.getNotification(uid: uid);

            final Notification notification =
                Notification.fromNotificationModel(
              notificationModel: notificationModel,
            );

            notificationsList.add(notification);
          }
        },
      );

      return notificationsList;
    } on NotificationError {
      rethrow;
    } catch (exception) {
      _logger.e(exception);
      throw const NotificationErrorRetrievingNotificationsList();
    }
  }

  /// Sends a game offer notification. Saves the notification in the Firebase Firestore
  /// and adds notification to the recepient notifications list.
  ///
  /// Rethrows [NotificationError] when the error occurs.
  /// Throws [NotificationErrorSendingGameOffer] when any other error occurs.
  @override
  Future<Notification> sendGameOfferNotification({
    required String recipientUid,
    required GameRoom gameRoom,
  }) async {
    try {
      // Retrieves current user account model and recipient user account model.
      final AccountModel currentAccountModel =
          await _firebaseAccountDatasource.getCurrentAccountModel();
      AccountModel recipientAccountModel =
          await _firebaseAccountDatasource.getAccountModel(uid: recipientUid);

      // Creates a new notification.
      final NotificationModel notificationModel =
          await _firebaseNotificationDatasource.createNotification(
        sender: currentAccountModel,
        notificationType: NotificationTypes.gameOffer,
        gameRoomModel: GameRoomModel.fromGameRoomEntity(gameRoom: gameRoom),
      );

      // Adds a notification uid to the notifications list.
      final List<String> notificationsUiList =
          recipientAccountModel.notificationsUidList;
      notificationsUiList.add(notificationModel.uid);

      recipientAccountModel = recipientAccountModel.copyWith(
        notificationsUidList: notificationsUiList,
      );

      // Updates a recipient user's notification list.
      await _firebaseAccountDatasource.updateAccount(
        accountModel: recipientAccountModel,
      );

      return Notification.fromNotificationModel(
        notificationModel: notificationModel,
      );
    } on NotificationError {
      rethrow;
    } catch (exception) {
      _logger.e(exception);
      throw const NotificationErrorSendingGameOffer();
    }
  }

  /// Sends a game offer denial notification. Saves the notification in the Firebase Firestore
  /// and adds notification to the recepient notifications list.
  ///
  /// Rethrows [NotificationError] when the error occurs.
  /// Throws [NotificationErrorSendingGameOfferDenial] when any other error occurs.
  @override
  Future<Notification> sendGameOfferDenialNotification({
    required String recipientUid,
    required GameRoom gameRoom,
  }) async {
    try {
      // Retrieves current user account model and recipient user account model.
      final AccountModel currentAccountModel =
          await _firebaseAccountDatasource.getCurrentAccountModel();
      AccountModel recipientAccountModel =
          await _firebaseAccountDatasource.getAccountModel(uid: recipientUid);

      // Creates a new notification.
      final NotificationModel notificationModel =
          await _firebaseNotificationDatasource.createNotification(
        sender: currentAccountModel,
        notificationType: NotificationTypes.gameOfferDenian,
        gameRoomModel: GameRoomModel.fromGameRoomEntity(gameRoom: gameRoom),
      );

      // Adds a notification uid to the notifications list.
      final List<String> notificationsUiList =
          recipientAccountModel.notificationsUidList;
      notificationsUiList.add(notificationModel.uid);

      recipientAccountModel = recipientAccountModel.copyWith(
        notificationsUidList: notificationsUiList,
      );

      // Updates a recipient user's notification list.
      await _firebaseAccountDatasource.updateAccount(
        accountModel: recipientAccountModel,
      );

      return Notification.fromNotificationModel(
        notificationModel: notificationModel,
      );
    } on NotificationError {
      rethrow;
    } catch (exception) {
      _logger.e(exception);
      throw const NotificationErrorSendingGameOfferDenial();
    }
  }

  /// Deletes a notification from the Firebase Firestore.
  ///
  /// Rethrows [NotificationError] when the error occurs.
  /// Throws [NotificationErrorDeletingNotification] when any other error occurs.
  @override
  Future<void> deleteNotification({
    required String uid,
  }) async {
    try {
      await _firebaseNotificationDatasource.deleteNotification(uid: uid);
    } on NotificationError {
      rethrow;
    } catch (exception) {
      _logger.e(exception);
      throw const NotificationErrorDeletingNotification();
    }
  }

  /// Checks if a notification with specified id exists in the Firestore Database.
  ///
  /// Returns true if the notification exists.
  ///
  /// Returns false if any error occurs.
  Future<bool> _notificationExists({required String uid}) async {
    try {
      // Retrieves a notification model.
      await _firebaseNotificationDatasource.getNotification(
        uid: uid,
      );

      return true;
    } catch (notificationError) {
      return false;
    }
  }
}
