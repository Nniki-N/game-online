import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/errors/account_error.dart';
import 'package:game/common/errors/friends_error.dart';
import 'package:game/data/models/schemas/account_schema.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/domain/repositories/account_repository.dart';
import 'package:game/domain/repositories/friends_repository.dart';
import 'package:game/presentation/bloc/friends_bloc/friends_event.dart';
import 'package:game/presentation/bloc/friends_bloc/friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final FriendsRepository _friendsRepository;
  final AccountRepository _accountRepository;
  late StreamSubscription _streamSubscription;

  FriendsBloc({
    required FriendsRepository friendsRepository,
    required AccountRepository accountRepository,
  })  : _friendsRepository = friendsRepository,
        _accountRepository = accountRepository,
        super(const InitialFriendsState()) {
    on<InitializeFriendsEvent>(_init);
    on<AddFriendsEvent>(_addFriend);
    on<RemoveFriendsEvent>(_removeFriend);
    on<StopListenUpdatesFriendsEvent>(_stopListenStream);
  }

  /// Initializes a friends list.
  ///
  /// Emits [ErrorFriendsState] when the error occurs.
  Future<void> _init(
    InitializeFriendsEvent event,
    Emitter<FriendsState> emit,
  ) async {
    try {
      log('start friends initializing');
      // Loads a friends list and indicates that this list was retrieved.
      await _loadFriendsList(emit: emit);

      // Retrieves a stream of the current user account data changes.
      final Stream<UserAccount> currentUserAccountStream =
          _accountRepository.getCurrentUserAccountStream().asBroadcastStream();

      // Retrieves a list of friends uid of a current user.
      final UserAccount currentUserAccount =
          await _accountRepository.getCurrentUserAccount();
      final List<String> initialFriendsUidList =
          currentUserAccount.friendsUidList;

      // Listens to changes of the account steam and emits if a friends list was changed.
      await _listenStream(
        currentUserAccountStream,
        onData: (userAccount) async {
          // Checks if the list was changed.
          if (initialFriendsUidList != userAccount.friendsUidList) {
            // Loads a friends list and indicates that this list was retrieved.
            await _loadFriendsList(emit: emit);
          }
        },
        onError: (error, stackTrace) async {
          await _streamSubscription.cancel();
        },
      );
    } on FriendsError catch (exeption) {
      emit(ErrorFriendsState(
        friendsError: exeption,
        friendsList: state.friendsList,
      ));
    }
  }

  Future<void> _listenStream<T>(
    Stream<T> stream, {
    required void Function(T data) onData,
    required void Function(Object error, StackTrace stackTrace) onError,
  }) {
    final completer = Completer<void>();

    _streamSubscription = stream.listen(
      onData,
      onDone: completer.complete,
      onError: onError,
      cancelOnError: false,
    );

    return completer.future.whenComplete(() {
      _streamSubscription.cancel();
    });
  }

  /// Adds a friend to both users' friends lists.
  ///
  /// Emits [ErrorFriendsState] when the error occurs.
  Future<void> _addFriend(
    AddFriendsEvent event,
    Emitter<FriendsState> emit,
  ) async {
    try {
      // Retrieves a current user account.
      final UserAccount currentUserAccount =
          await _accountRepository.getCurrentUserAccount();

      // Checks if specified login does not equal to the current user's login.
      if (event.friendLogin == currentUserAccount.login) {
        throw const FriendsErrorCanNotAddYourselfAsFriend();
      }

      // Retrieves a friend's user account list.
      final List<UserAccount> friendUserAccountList =
          await _accountRepository.getUserAccountListWhere(
        fieldName: AccountSchema.login,
        fieldValue: event.friendLogin,
      );

      // Checks if the user with specified login exists.
      if (friendUserAccountList.isEmpty) {
        throw const FriendsErrorNotExistingUserWithLogin();
      }

      final UserAccount friendUserAccount = friendUserAccountList.first;

      // Adds a friend uid to the current user account friends list.
      await _friendsRepository.addFriend(
        uid: currentUserAccount.uid,
        friendUid: friendUserAccount.uid,
      );

      // Adds a uid to the friend's user account friends list.
      await _friendsRepository.addFriend(
        uid: friendUserAccount.uid,
        friendUid: currentUserAccount.uid,
      );

      // Loads a friends list and indicates that this list was retrieved.
      await _loadFriendsList(emit: emit);
    } on FriendsError catch (exeption) {
      emit(ErrorFriendsState(
        friendsError: exeption,
        friendsList: state.friendsList,
      ));
    } on AccountError {
      emit(ErrorFriendsState(
        friendsError: const FriendsErrorFriendAdding(),
        friendsList: state.friendsList,
      ));
    }
  }

  /// Removes a friend from both users' friends lists.
  ///
  /// Emits [ErrorFriendsState] when the error occurs.
  Future<void> _removeFriend(
    RemoveFriendsEvent event,
    Emitter<FriendsState> emit,
  ) async {
    try {
      // Retrieves a current user account.
      final UserAccount currentUserAccount =
          await _accountRepository.getCurrentUserAccount();

      // Removes a friend uid from the current user account friends list.
      await _friendsRepository.removeFriend(
        uid: currentUserAccount.uid,
        friendUid: event.friendUid,
      );

      // Removes a uid from the friend user account friends list.
      await _friendsRepository.removeFriend(
        uid: event.friendUid,
        friendUid: currentUserAccount.uid,
      );

      // Loads a friends list and indicates that this list was retrieved.
      await _loadFriendsList(emit: emit);
    } on FriendsError catch (exeption) {
      emit(ErrorFriendsState(
        friendsError: exeption,
        friendsList: state.friendsList,
      ));
    } on AccountError {
      emit(ErrorFriendsState(
        friendsError: const FriendsErrorFriendAdding(),
        friendsList: state.friendsList,
      ));
    }
  }

  /// Retrieves a friends list of a current user and indicates that friends list was retrieved
  Future<void> _loadFriendsList({required Emitter<FriendsState> emit}) async {
    // Retrieves a friends list of a current user.
    final List<Account> friendsList = await _friendsRepository.getFriendsList();

    // Indicates that friends list was retrieved.
    emit(LoadedFriendsState(friendsList: friendsList));
  }

  /// Closes the stream subscription.
  Future<void> _stopListenStream(
    StopListenUpdatesFriendsEvent event,
    Emitter<FriendsState> emit,
  ) async {
    await _streamSubscription.cancel();
    emit(const UnlistenedFriendsState());
  }


  /// Closes the stream subscription.
  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    super.close();
  }
}
