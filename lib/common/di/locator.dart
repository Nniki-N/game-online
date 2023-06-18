import 'package:game/common/di/locator.config.dart';
import 'package:game/data/repositories/firestore_account_repository.dart';
import 'package:game/data/repositories/firebase_auth_repository.dart';
import 'package:game/data/repositories/firestore_game_repository.dart';
import 'package:game/data/repositories/firestore_room_repository.dart';
import 'package:game/domain/repositories/account_repository.dart';
import 'package:game/domain/repositories/auth_repository.dart';
import 'package:game/domain/repositories/game_repository.dart';
import 'package:game/domain/repositories/room_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> setUpLocator() async {
  await $initGetIt(getIt);
  getIt.registerFactory<GoogleSignIn>(() => GoogleSignIn());

  getIt.registerLazySingleton<Logger>(
    () => Logger(printer: PrettyPrinter(methodCount: 10)),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => FirebaseAuthRepository(authDatasource: getIt()),
  );

  getIt.registerLazySingleton<AccountRepository>(
    () => FirestoreAccountRepository(firebaseAccountDatasource: getIt()),
  );

  getIt.registerLazySingleton<RoomRepository>(
    () => FirestoreRoomRepository(firestoreGameRoomDatasource: getIt()),
  );

  getIt.registerLazySingleton<GameRepository>(
    () => const FirestoreGameRepository(),
  );
}
