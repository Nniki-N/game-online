import 'package:flutter/foundation.dart' show immutable;

/// The abstract error for the firebase auth exeption.
@immutable
abstract class GameRoomError {
  final String errorTitle;
  final String errorText;

  const GameRoomError({
    required this.errorTitle,
    required this.errorText,
  });
}

/// The [GameRoomError] child for unknown error
@immutable
class GameRoomErrorUnknown extends GameRoomError {
  const GameRoomErrorUnknown()
      : super(
          errorTitle: 'Error',
          errorText: 'Unknown room error happend',
        );
}

/// The [GameRoomError] child for not existing room error
@immutable
class GameRoomErrorNotExistingRoom extends GameRoomError {
  const GameRoomErrorNotExistingRoom()
      : super(
          errorTitle: 'Not existing room',
          errorText: 'This room does not exist',
        );
}

/// The [GameRoomError] child for empty room
@immutable
class GameRoomErrorEmptyRoom extends GameRoomError {
  const GameRoomErrorEmptyRoom()
      : super(
          errorTitle: 'Game room is empty',
          errorText: 'Game room is empty',
        );
}

/// The [GameRoomError] child for creating room error
@immutable
class GameRoomErrorCreatingRoom extends GameRoomError {
  const GameRoomErrorCreatingRoom()
      : super(
          errorTitle: 'Creating room error',
          errorText: 'Some error happened while creating the room',
        );
}

/// The [GameRoomError] child for updating room error
@immutable
class GameRoomErrorUpdatingRoom extends GameRoomError {
  const GameRoomErrorUpdatingRoom()
      : super(
          errorTitle: 'Updating room error',
          errorText: 'Some error happened while updating the room',
        );
}

/// The [GameRoomError] child for deleting room error
@immutable
class GameRoomErrorDeletingRoom extends GameRoomError {
  const GameRoomErrorDeletingRoom()
      : super(
          errorTitle: 'Deleting room error',
          errorText: 'Some error happened while deleting the room',
        );
}

/// The [GameRoomError] child for deleting room error
@immutable
class GameRoomErrorNotAllowedNumberOfPlayers extends GameRoomError {
  const GameRoomErrorNotAllowedNumberOfPlayers()
      : super(
          errorTitle: 'You can not join the room',
          errorText: 'The room is full, so you can not join it',
        );
}

/// The [GameRoomError] child for deleting room error
@immutable
class GameRoomErrorNotTwoPlayers extends GameRoomError {
  const GameRoomErrorNotTwoPlayers()
      : super(
          errorTitle: 'Not two players in the room',
          errorText: 'Not two players in the room',
        );
}

/// The [GameRoomError] child for player's move
@immutable
class GameRoomErrorInvalidPlayerMove extends GameRoomError {
  const GameRoomErrorInvalidPlayerMove()
      : super(
          errorTitle: 'Player`s wrong move',
          errorText: 'Player`s wrong move',
        );
}

/// The [GameRoomError] child 
@immutable
class GameRoomErrorNotFoundPlayer extends GameRoomError {
  const GameRoomErrorNotFoundPlayer()
      : super(
          errorTitle: 'Player is not found in the room',
          errorText: 'Player is not found in the room',
        );
}

/// The [GameRoomError] child for not existing room error
@immutable
class GameRoomErrorNotExistingPlayer extends GameRoomError {
  const GameRoomErrorNotExistingPlayer()
      : super(
          errorTitle: 'Not existing player',
          errorText: 'This player does not exist',
        );
}

/// The [GameRoomError] child for joining room
@immutable
class GameRoomErrorJoiningRoom extends GameRoomError {
  const GameRoomErrorJoiningRoom()
      : super(
          errorTitle: 'Joining room error',
          errorText: 'Something happened while joining room',
        );
}
