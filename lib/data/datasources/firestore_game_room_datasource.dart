
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/common/constants/firebase_constants.dart';
import 'package:game/common/errors/game_room_error.dart';
import 'package:game/common/typedefs.dart';
import 'package:game/data/models/game_room_model.dart';
import 'package:game/domain/entities/game_room.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class FirestoreGameRoomDatasource {
  final FirebaseFirestore _firebaseFirestore;
  final Logger _logger;

  FirestoreGameRoomDatasource({
    required FirebaseFirestore firebaseFirestore,
    required Logger logger,
    // required FirebaseAccountDatasourceHelper accountDatasourceHelper,
  })  : _firebaseFirestore = firebaseFirestore,
        _logger = logger;

  /// Creates a new game room document in the Firestore Database.
  ///
  /// Returns the created [GameRoomModel].
  Future<GameRoomModel> createGameRoom() async {
    try {
      // Creates a new game room with data of the first player.
      final GameRoomModel gameRoomModel = GameRoomModel(
        uid: const Uuid().v4(),
        players: const [],
        gameRoomState: GameRoomState.init,
        winnerUid: '',
        turnOfPlayerUid: '',
        fieldWithChips: const [
          [null, null, null],
          [null, null, null],
          [null, null, null],
        ],
      );

      // Creates a new game room document in the Firestore Database.
      await _firebaseFirestore
          .collection(FirebaseConstants.gameRooms)
          .doc(gameRoomModel.uid)
          .set(gameRoomModel.toJson());

      return gameRoomModel;
    } catch (exception) {
      _logger.e(exception);

      const GameRoomError error = GameRoomErrorCreatingRoom();
      _logger.e(error.errorText);
      throw error;
    }
  }

  /// Updates a game room data in the Firestore Database.
  Future<void> updateGameRoom({required GameRoomModel gameRoomModel}) async {
    try {
      await _firebaseFirestore
          .collection(FirebaseConstants.gameRooms)
          .doc(gameRoomModel.uid)
          .update(gameRoomModel.toJson());
    } catch (exception) {
      _logger.e(exception);

      const GameRoomError error = GameRoomErrorUpdatingRoom();
      _logger.e(error.errorText);
      throw error;
    }
  }

  /// Deletes a game room document from the Firestore Database.
  Future<void> deleteGameRoom({required String gameRoomId}) async {
    try {
      await _firebaseFirestore
          .collection(FirebaseConstants.gameRooms)
          .doc(gameRoomId)
          .delete();
    } catch (exception) {
      _logger.e(exception);

      const GameRoomError error = GameRoomErrorDeletingRoom();
      _logger.e(error.errorText);
      throw error;
    }
  }

  /// Retrieves a [GameRoomModel] from the Firestore Database.
  ///
  /// Throws [GameRoomErrorNotExistingRoom] if the request failed.
  Future<GameRoomModel> getGameRoom({required String gameRoomId}) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firebaseFirestore
              .collection(FirebaseConstants.gameRooms)
              .doc(gameRoomId)
              .get();

      Json? json = snapshot.data();

      if (json == null) throw const GameRoomErrorNotExistingRoom();

      return GameRoomModel.fromJson(json);
    } catch (exception) {
      _logger.e(exception);

      const GameRoomError error = GameRoomErrorNotExistingRoom();
      _logger.e(error.errorText);
      throw error;
    }
  }

  /// Retrieves a list of [GameRoomModel] from the Firestore Database.
  Future<List<GameRoomModel>> getGameRoomModelList() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firebaseFirestore
              .collection(FirebaseConstants.gameRooms)
              .get();

      final List<GameRoomModel> gameRoomModelList = snapshot.docs.map((doc) {
        final Json json = doc.data();
        final GameRoomModel gameRoomModel = GameRoomModel.fromJson(json);

        return gameRoomModel;
      }).toList();

      return gameRoomModelList;
    } catch (exception) {
      _logger.e(exception);

      const GameRoomError error = GameRoomErrorUnknown();
      _logger.e(error.errorText);
      throw error;
    }
  }

  /// Retrieves a stream of game room document changes from the Firestore Dtabase.
  Stream<GameRoomModel> getGameRoomStream({required String gameRoomId}) {
    try {
      final Stream<GameRoomModel> gameRoomStream = _firebaseFirestore
          .collection(FirebaseConstants.gameRooms)
          .doc(gameRoomId)
          .snapshots()
          .map((snapshot) => GameRoomModel.fromJson(snapshot.data() as Json));

      return gameRoomStream;
    } catch (exception) {
      _logger.e(exception);

      const GameRoomError error = GameRoomErrorNotExistingRoom();
      _logger.e(error.errorText);
      throw error;
    }
  }
}
