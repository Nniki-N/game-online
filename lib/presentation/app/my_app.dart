import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/common/di/locator.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/appearance_bloc/appearance_bloc.dart';
import 'package:game/presentation/bloc/appearance_bloc/appearance_state.dart';
import 'package:game/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:game/presentation/bloc/language_bloc/language_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:game/presentation/screens/loading_screen.dart/loading_screen.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';
import 'package:game/presentation/theme/theme_extensions.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 667),
        minTextAdapt: true,
        splitScreenMode: true,
        // scaleByHeight: true,
        builder: (context, child) {
          return BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, languageState) {
              return BlocBuilder<AppearanceBloc, AppearanceState>(
                builder: (context, appearanceState) {

                  // Displays splash loading screen while an appearance is not initialized.
                  if (appearanceState is InitialAppearanceState) {
                    return MaterialApp(
                      title: 'Tic Tac Toe',
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                        extensions: lightThemeExtension,
                      ),
                      home: Builder(builder: (context) {
                        final BackgroundTheme backgroundTheme = Theme.of(context).extension<BackgroundTheme>()!;

                        return LoadingScreen(
                          backgroundColor: backgroundTheme.color2,
                          animationWidgetColor: Colors.white,
                        );
                      }),
                    );
                  }

                  // Displays main screen after an appearance is initialized.
                  else {
                    final ThemeMode themeMode;

                    if ((appearanceState as LoadedAppearanceState)
                        .isAutomatic) {
                      themeMode = ThemeMode.system;
                    } else {
                      themeMode = appearanceState.isDark
                          ? ThemeMode.dark
                          : ThemeMode.light;
                    }

                    return MaterialApp.router(
                      title: 'Tic Tac Toe',
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                        brightness: Brightness.light,
                        extensions: lightThemeExtension,
                      ),
                      darkTheme: ThemeData(
                        brightness: Brightness.dark,
                        extensions: darkThemeExtension,
                      ),
                      themeMode: themeMode,
                      localizationsDelegates: AppLocalizations.localizationsDelegates,
                      supportedLocales: AppLocalizations.supportedLocales,
                      locale: languageState.language.locale,
                      routerDelegate: getIt<AppRouter>().delegate(),
                      routeInformationParser: getIt<AppRouter>().defaultRouteParser(),
                      builder: (context, router) => router!,
                    );
                  }
                },
              );
            },
          );
        });
  }
}
