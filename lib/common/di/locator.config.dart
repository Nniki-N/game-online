// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i7;

import '../../data/datasources/firebase_account_datasource.dart' as _i4;
import '../../data/datasources/firebase_auth_datasource.dart' as _i8;
import '../../data/datasources/firebase_notification_datasource.dart' as _i10;
import '../../data/datasources/firestore_game_room_datasource.dart' as _i12;
import '../navigation/app_router.gr.dart' as _i3;
import '../services/firebase_service.dart' as _i11;
import 'app_module.dart' as _i13; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.singleton<_i3.AppRouter>(appModule.appRouter);
  gh.lazySingleton<_i4.FirebaseAccountDatasource>(
      () => _i4.FirebaseAccountDatasource(
            firebaseFirestore: get<_i5.FirebaseFirestore>(),
            firebaseAuth: get<_i6.FirebaseAuth>(),
            logger: get<_i7.Logger>(),
          ));
  gh.lazySingleton<_i8.FirebaseAuthDataSource>(() => _i8.FirebaseAuthDataSource(
        firebaseFirestore: get<_i5.FirebaseFirestore>(),
        firebaseAuth: get<_i6.FirebaseAuth>(),
        googleSignIn: get<_i9.GoogleSignIn>(),
        logger: get<_i7.Logger>(),
      ));
  gh.lazySingleton<_i10.FirebaseNotificationDatasource>(
      () => _i10.FirebaseNotificationDatasource(
            firebaseFirestore: get<_i5.FirebaseFirestore>(),
            logger: get<_i7.Logger>(),
          ));
  await gh.factoryAsync<_i11.FirebaseService>(
    () => appModule.firebaseService,
    preResolve: true,
  );
  gh.lazySingleton<_i12.FirestoreGameRoomDatasource>(
      () => _i12.FirestoreGameRoomDatasource(
            firebaseFirestore: get<_i5.FirebaseFirestore>(),
            logger: get<_i7.Logger>(),
          ));
  return get;
}

class _$AppModule extends _i13.AppModule {}
