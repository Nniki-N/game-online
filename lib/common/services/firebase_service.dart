import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:game/common/di/locator.dart';
import 'package:game/firebase_options.dart';

class FirebaseService {
    static Future<FirebaseService> init() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
    getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
    getIt.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);
    
    return FirebaseService();
  }
}