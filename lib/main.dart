import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/common/di/locator.dart';
import 'package:game/presentation/app/my_app.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/appearance_bloc/appearance_bloc.dart';
import 'package:game/presentation/bloc/appearance_bloc/appearance_event.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:game/presentation/bloc/friends_bloc/friends_bloc.dart';
import 'package:game/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:game/presentation/bloc/language_bloc/language_event.dart';
import 'package:game/presentation/bloc/notification_bloc/notification_bloc.dart';
import 'package:game/presentation/bloc/profile_avatar_bloc/profile_avatar_bloc.dart';
import 'package:game/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:game/presentation/bloc/room_bloc/room_event.dart';
import 'package:game/resources/resources.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Preloads certain svg icons.
  const logoIngameLoader = SvgAssetLoader(Svgs.logoIngame);
  await svg.cache.putIfAbsent(
      logoIngameLoader.cacheKey(null), () => logoIngameLoader.loadBytes(null));
  const informLoader = SvgAssetLoader(Svgs.inform);
  await svg.cache.putIfAbsent(
      informLoader.cacheKey(null), () => informLoader.loadBytes(null));

  // Sets up repositories, services, datasources etc.
  await setUpLocator();

  // Hides status bar.
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await SystemChrome.setSystemUIChangeCallback(
    (bool systemOverlaysAreVisible) async {
      if (!systemOverlaysAreVisible) {
        await SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [],
        );
      }
    },
  );

  // Provides BLoCs and runs app.
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            authRepository: getIt(),
            accountRepository: getIt(),
          )..add(const InitializeAuthEvent()),
        ),
        BlocProvider(
          create: (_) => RoomBloc(
            roomRepository: getIt(),
            accountRepository: getIt(),
          )..add(const InitializeRoomEvent()),
        ),
        BlocProvider(
          create: (_) => AccountBloc(
            accountRepository: getIt(),
          ),
        ),
        BlocProvider(
          create: (_) => LanguageBloc(
            languageRepository: getIt(),
          )..add(const InitializeLanguageEvent()),
        ),
        BlocProvider(
          create: (_) => AppearanceBloc(
            appearanceRepository: getIt(),
          )..add(const InitializeAppearanceEvent()),
        ),
        BlocProvider(
          create: (_) => ProfileAvatarBloc(
            imagesRepository: getIt(),
          ),
        ),
        BlocProvider(
          create: (_) => NotificationBloc(
              notificationRepository: getIt(),
              accountRepository: getIt(),
              roomRepository: getIt()),
        ),
        BlocProvider(
          create: (context) => FriendsBloc(
            friendsRepository: getIt(),
            accountRepository: getIt(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
