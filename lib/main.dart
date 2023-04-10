import 'package:flutter/material.dart';
import 'package:game/common/di/locator.dart';
import 'package:game/presentation/app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setUpLocator();
  
  runApp(const MyApp());
}
