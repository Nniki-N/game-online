import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/common/services/firebase_service.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @preResolve
  Future<FirebaseService> get firebaseService => FirebaseService.init();

  @singleton
  AppRouter get appRouter => AppRouter();
}
