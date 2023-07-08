import 'package:flutter/foundation.dart' show immutable;

/// The abstract error for a game room exeption.
@immutable
abstract class GameRoomError {
  final String errorTitle;
  final String errorText;

  const GameRoomError({
    required this.errorTitle,
    required this.errorText,
  });

  @override
  String toString() {
    return 'ErrorTitle: $errorTitle \nErrorText: $errorText';
  }
}

/// The [GameRoomError] child for an unknown error.
@immutable
class GameRoomErrorUnknown extends GameRoomError {
  const GameRoomErrorUnknown({
    String? errorTitle,
    String? errorText,
  }) : super(
          errorTitle: errorTitle ?? 'Error',
          errorText: errorText ?? 'Unknown game room error happened',
        );
}

/// The [GameRoomError] child for an empty room error.
@immutable
class GameRoomErrorEmptyRoom extends GameRoomError {
  const GameRoomErrorEmptyRoom()
      : super(
          errorTitle: 'Game room is empty',
          errorText: 'There are no players in the room',
        );
}

/// The [GameRoomError] child for a creating room error.
@immutable
class GameRoomErrorCreatingRoom extends GameRoomError {
  const GameRoomErrorCreatingRoom()
      : super(
          errorTitle: 'Unable to create a room',
          errorText: 'Some error happened while creating a room',
        );
}

/// The [GameRoomError] child for an updating room error.
@immutable
class GameRoomErrorUpdatingRoom extends GameRoomError {
  const GameRoomErrorUpdatingRoom()
      : super(
          errorTitle: 'Unable to update the room',
          errorText: 'Some error happened while updating the room',
        );
}

/// The [GameRoomError] child for a deleting room error.
@immutable
class GameRoomErrorDeletingRoom extends GameRoomError {
  const GameRoomErrorDeletingRoom()
      : super(
          errorTitle: 'Unable to delete the room',
          errorText: 'Some error happened while deleting the room',
        );
}

/// The [GameRoomError] child for a not allowed number of players error.
@immutable
class GameRoomErrorNotAllowedNumberOfPlayers extends GameRoomError {
  const GameRoomErrorNotAllowedNumberOfPlayers()
      : super(
          errorTitle: 'Unable to join the room',
          errorText: 'The room is full, so you can not join it',
        );
}

/// The [GameRoomError] child for a not two players in the room error.
@immutable
class GameRoomErrorNotTwoPlayers extends GameRoomError {
  const GameRoomErrorNotTwoPlayers()
      : super(
          errorTitle: 'Not full room',
          errorText: 'This room is not full',
        );
}

/// The [GameRoomError] child for a player's move error.
@immutable
class GameRoomErrorInvalidPlayerMove extends GameRoomError {
  const GameRoomErrorInvalidPlayerMove()
      : super(
          errorTitle: 'Wrong move',
          errorText: 'This move can not be made',
        );
}

/// The [GameRoomError] child for a not found player error.
@immutable
class GameRoomErrorNotFoundPlayer extends GameRoomError {
  const GameRoomErrorNotFoundPlayer()
      : super(
          errorTitle: 'Not found player',
          errorText: 'Player is not found in the room',
        );
}

/// The [GameRoomError] child for a joining room error.
@immutable
class GameRoomErrorJoiningRoom extends GameRoomError {
  const GameRoomErrorJoiningRoom()
      : super(
          errorTitle: 'Unable to join the room',
          errorText: 'Something happened while joining the room',
        );
}

/// The [GameRoomError] child for a retrieving room list error.
@immutable
class GameRoomErrorRetrieveingRoomList extends GameRoomError {
  const GameRoomErrorRetrieveingRoomList()
      : super(
          errorTitle: 'Unable to get a list of room',
          errorText: 'Something happened while retrieving a list of rooms',
        );
}

/// The [GameRoomError] child for a retrieving room stream error.
@immutable
class GameRoomErrorRetrievingRoomStream extends GameRoomError {
  const GameRoomErrorRetrievingRoomStream()
      : super(
          errorTitle: 'Stream was not retrieved',
          errorText: 'Something happened while retrieving a room stream',
        );
}

/// The [GameRoomError] child for a retrieving room error.
@immutable
class GameRoomErrorRetrievingRoom extends GameRoomError {
  const GameRoomErrorRetrievingRoom()
      : super(
          errorTitle: 'Room was not retrieved',
          errorText: 'Something happened while retrieving a room',
        );
}
