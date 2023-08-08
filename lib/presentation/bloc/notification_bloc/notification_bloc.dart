import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/errors/notification_error.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/domain/entities/notification.dart';
import 'package:game/domain/repositories/account_repository.dart';
import 'package:game/domain/repositories/notification_repository.dart';
import 'package:game/domain/repositories/room_repository.dart';
import 'package:game/presentation/bloc/notification_bloc/notification_event.dart';
import 'package:game/presentation/bloc/notification_bloc/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _notificationRepository;
  final AccountRepository _accountRepository;
  final RoomRepository _roomRepository;
  late StreamSubscription streamSubscription;

  NotificationBloc({
    required NotificationRepository notificationRepository,
    required AccountRepository accountRepository,
    required RoomRepository roomRepository,
  })  : _notificationRepository = notificationRepository,
        _accountRepository = accountRepository,
        _roomRepository = roomRepository,
        super(const InitialNotificationState()) {
    on<InitializeNotificationEvent>(_init);
    on<SendGameOfferNotificationEvent>(_sendGameOffer);
    // on<SendAcceptanceOfGameOfferNotificationEvent>(_sendAcceptanceOfGameOffer);
    on<SendDenianOfGameOfferNotificationEvent>(_sendDenialOfGameOffer);
    on<DeleteForCurrentUserNotificationEvent>(
        _deleteNotificationForCurrentUser);
    on<DeleteLastSentNotification>(_deleteLastSentNotification);
    on<StopListenUpdatesNotificationEvent>(_stopListenStream);
  }

  /// Initializes the first state.
  ///
  /// Changes the state base on the current user data changes.
  Future<void> _init(
    InitializeNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      log('start notification initializing');

      // Retrieve the current user account data.
      final UserAccount currentUserAccount =
          await _accountRepository.getCurrentUserAccount();

      // Initial notifications uid list of a current user.
      final List<String> notificationsUidList =
          currentUserAccount.notificationsUidList;

      // Retrieve the current user's notifications list.
      List<Notification> notificationsList =
          await _notificationRepository.getNotificationsList();
      
      // Removes all unnecessary notifications.
      notificationsList = await _filterNotifications(
        notificationsList: notificationsList,
      );

      // Indicates that the current user's notifications list was loaded.
      emit(LoadedNotificationState(notificationsList: notificationsList));

      // Retrieves a stream of the current user account data changes.
      final Stream<UserAccount> currentUserAccountStream =
          _accountRepository.getCurrentUserAccountStream().asBroadcastStream();

      // Responds to the current user account data changes.
      await _listenStream(
        currentUserAccountStream,
        onData: (userAccount) async {
          if (notificationsUidList != userAccount.friendsUidList) {
            // Retrieve the current user's notifications list.
            List<Notification> notificationsList =
                await _notificationRepository.getNotificationsList();

            // Indicates that the current user's notifications list was loaded.
            emit(LoadedNotificationState(
              lastSentNotification: state.lastSentNotification,
              recipientOfLastNotificationUid: state.recipientOfLastNotificationUid,
              notificationsList: notificationsList,
            ));
          }
        },
        onError: (error, stackTrace) async {
          await streamSubscription.cancel();

          emit(ErrorNotificationState(
            lastSentNotification: state.lastSentNotification,
            recipientOfLastNotificationUid: state.recipientOfLastNotificationUid,
            notificationError: const NotificationErrorUnknown(),
            notificationsList: state.notificationsList,
          ));
        },
      );
    } on NotificationError catch (notificationError) {
      emit(ErrorNotificationState(
        lastSentNotification: state.lastSentNotification,
        recipientOfLastNotificationUid: state.recipientOfLastNotificationUid,
        notificationError: notificationError,
        notificationsList: state.notificationsList,
      ));
    }
  }

  Future<void> _listenStream<T>(
    Stream<T> stream, {
    required void Function(T data) onData,
    required void Function(Object error, StackTrace stackTrace) onError,
  }) {
    final completer = Completer<void>();

    streamSubscription = stream.listen(
      onData,
      onDone: completer.complete,
      onError: onError,
      cancelOnError: false,
    );

    return completer.future.whenComplete(() {
      streamSubscription.cancel();
    });
  }

  /// Returns a new filtered list of notifications.
  ///
  /// Deletes all game offer denial notifications.
  ///
  /// Deletes a game offer notification if a game room does not exist anymore.
  Future<List<Notification>> _filterNotifications({
    required List<Notification> notificationsList,
  }) async {
    List<Notification> filteredNotificationList = [];

    for (Notification notification in notificationsList) {
      // Clears all game offer denial notifications.
      if (notification.notificationType == NotificationTypes.gameOfferDenian) {
        // Deletes notification.
        await _notificationRepository.deleteNotification(
          uid: notification.uid,
        );

        continue;
      }

      // Deletes a game offer notification if a game room does not exist anymore.
      else {
        final bool gameRoomExists = await _roomRepository.gameRoomExists(
          gameRoomId: notification.gameRoom.uid,
        );

        if (!gameRoomExists) {
          // Deletes notification.
          await _notificationRepository.deleteNotification(
            uid: notification.uid,
          );

          continue;
        }

        // Adds a notification to the filtered list.
        filteredNotificationList.add(notification);
      }
    }

    return filteredNotificationList;
  }

  /// Sends a game offer to the specified user.
  Future<void> _sendGameOffer(
    SendGameOfferNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      // Sends a game offer notification to another user.
      final Notification notification =
          await _notificationRepository.sendGameOfferNotification(
        recipientUid: event.recipientUid,
        gameRoom: event.gameRoom,
      );

      // Indicates that the game offer notification was sent.
      emit(LoadedNotificationState(
        lastSentNotification: notification,
        recipientOfLastNotificationUid: event.recipientUid,
        notificationsList: state.notificationsList,
      ));
    } on NotificationError catch (notificationError) {
      emit(ErrorNotificationState(
        lastSentNotification: state.lastSentNotification,
        recipientOfLastNotificationUid: state.recipientOfLastNotificationUid,
        notificationError: notificationError,
        notificationsList: state.notificationsList,
      ));
    }
  }

  /// Sends a game offer denial to the specified user.
  Future<void> _sendDenialOfGameOffer(
    SendDenianOfGameOfferNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      // Sends a game offer denian notification to another user.
      final Notification notification =
          await _notificationRepository.sendGameOfferDenialNotification(
        recipientUid: event.recipientUid,
        gameRoom: event.gameRoom,
      );

      // Indicates that the game offer notification was sent.
      emit(LoadedNotificationState(
        lastSentNotification: notification,
        recipientOfLastNotificationUid: event.recipientUid,
        notificationsList: state.notificationsList,
      ));
    } on NotificationError catch (notificationError) {
      emit(ErrorNotificationState(
        lastSentNotification: state.lastSentNotification,
        recipientOfLastNotificationUid: state.recipientOfLastNotificationUid,
        notificationError: notificationError,
        notificationsList: state.notificationsList,
      ));
    }
  }

  /// Deletes a notification for a current user.
  Future<void> _deleteNotificationForCurrentUser(
    DeleteForCurrentUserNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      // Retrieve the current user account data.
      UserAccount currentUserAccount =
          await _accountRepository.getCurrentUserAccount();

      // Removes notification uid from the list.
      final List<String> notificationsUidList =
          currentUserAccount.notificationsUidList;
      notificationsUidList.remove(event.notificationUid);

      currentUserAccount.copyWith(notificationsUidList: notificationsUidList);

      log(currentUserAccount.uid.toString());
      log(currentUserAccount.notificationsUidList.toString());

      // Saves updated notification list.
      await _accountRepository.updateUserAccount(
        userAccount: currentUserAccount,
      );

      log('${event.notificationUid} to delete');

      // Deletes notification
      await _notificationRepository.deleteNotification(
        uid: event.notificationUid,
      );
    } on NotificationError catch (notificationError) {
      emit(ErrorNotificationState(
        lastSentNotification: state.lastSentNotification,
        recipientOfLastNotificationUid: state.recipientOfLastNotificationUid,
        notificationError: notificationError,
        notificationsList: state.notificationsList,
      ));
    }
  }

  /// Deletes a last sent notification.
  Future<void> _deleteLastSentNotification(
    DeleteLastSentNotification event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      // Retrieves the reciever account data.
      UserAccount userAccount =
          await _accountRepository.getUserAccount(uid: event.recipientUid);

      // Removes notification uid from the list.
      final List<String> notificationsUidList =
          userAccount.notificationsUidList;
      notificationsUidList.remove(event.notificationUid);

      userAccount.copyWith(notificationsUidList: notificationsUidList);

      // Saves updated notification list.
      await _accountRepository.updateUserAccount(
        userAccount: userAccount,
      );

      log('${event.notificationUid} to delete');

      // Deletes notification
      await _notificationRepository.deleteNotification(
        uid: event.notificationUid,
      );
    } on NotificationError catch (notificationError) {
      emit(ErrorNotificationState(
        lastSentNotification: state.lastSentNotification,
        recipientOfLastNotificationUid: state.recipientOfLastNotificationUid,
        notificationError: notificationError,
        notificationsList: state.notificationsList,
      ));
    }
  }

  /// Closes the stream subscription.
  Future<void> _stopListenStream(
    StopListenUpdatesNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await streamSubscription.cancel();
    emit(const UnlistenedNotificationState());
  }

  /// Closes the stream subscription.
  @override
  Future<void> close() async {
    await streamSubscription.cancel();
    super.close();
  }
}
