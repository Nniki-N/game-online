import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/common/constants/firebase_constants.dart';
import 'package:game/common/errors/notification_error.dart';
import 'package:game/common/typedefs.dart';
import 'package:game/data/models/account_model.dart';
import 'package:game/data/models/game_room_model.dart';
import 'package:game/data/models/notification_model.dart';
import 'package:game/domain/entities/notification.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class FirebaseNotificationDatasource {
  final FirebaseFirestore _firebaseFirestore;
  final Logger _logger;

  const FirebaseNotificationDatasource({
    required FirebaseFirestore firebaseFirestore,
    required Logger logger,
  })  : _firebaseFirestore = firebaseFirestore,
        _logger = logger;

  /// Creates a new notification document in the Firestore Database.
  ///
  /// Returns created [NotificationModel].
  ///
  /// Throws [NotificationErrorCreatingNotification] when the error occurs.
  Future<NotificationModel> createNotification({
    required AccountModel sender,
    required NotificationTypes notificationType,
    required GameRoomModel gameRoomModel,
  }) async {
    try {
      // Creates a notification model with data of the sender and notification type.
      final NotificationModel notificationModel = NotificationModel(
        uid: const Uuid().v4(),
        sender: sender,
        notificationType: notificationType,
        gameRoomModel: gameRoomModel,
      );

      // Creates a notification document in the Firebase Firestore.
      await _firebaseFirestore
          .collection(FirebaseConstants.notifications)
          .doc(notificationModel.uid)
          .set(notificationModel.toJson());

      return notificationModel;
    } catch (exception) {
      _logger.e(exception);

      const NotificationError error = NotificationErrorCreatingNotification();
      _logger.e('$error: ${error.errorText}');
      throw error;
    }
  }

  /// Updates a notification data in the Firestore Database.
  ///
  /// Throws [NotificationErrorUpdatingNotification] when the error occurs.
  Future<void> updateNotification({
    required NotificationModel notificationModel,
  }) async {
    try {
      //
      await _firebaseFirestore
          .collection(FirebaseConstants.notifications)
          .doc(notificationModel.uid)
          .update(notificationModel.toJson());
    } catch (exception) {
      _logger.e(exception);

      const NotificationError error = NotificationErrorUpdatingNotification();
      _logger.e('$error: ${error.errorText}');
      throw error;
    }
  }

  /// Deletes a notification document from the Firestore Database.
  ///
  /// Throws [NotificationErrorUpdatingNotification] when the error occurs.
  Future<void> deleteNotification({
    required String uid,
  }) async {
    try {
      //
      await _firebaseFirestore
          .collection(FirebaseConstants.notifications)
          .doc(uid)
          .delete();
    } catch (exception) {
      _logger.e(exception);

      const NotificationError error = NotificationErrorDeletingNotification();
      _logger.e('$error: ${error.errorText}');
      throw error;
    }
  }

  /// Retrieves a [NotificationModel] from the Firestore Database.
  ///
  /// Throws [NotificationErrorRetrievingNotification] if the request failed or the error occurs.
  Future<NotificationModel> getNotification({required String uid}) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firebaseFirestore
              .collection(FirebaseConstants.notifications)
              .doc(uid)
              .get();

      final Json? json = snapshot.data();

      if (json == null) throw Error();

      return NotificationModel.fromJson(json);
    } catch (exception) {
      _logger.e(exception);

      const NotificationError error = NotificationErrorRetrievingNotification();
      _logger.e('$error: ${error.errorText}');
      
      // deleteNotification(uid: uid);
      throw error;
    }
  }
}
