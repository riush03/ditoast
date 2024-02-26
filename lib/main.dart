import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ditoast/i18n/strings.g.dart';
import 'package:ditoast/themes/nes_theme.dart';
import 'package:ditoast/scenes/home.dart';
import 'package:ditoast/scenes/play.dart';
import 'package:ditoast/scenes/settings.dart';
import 'package:ditoast/scenes/tutorial.dart';
import 'package:ditoast/utils/prefs.dart';
import 'package:ditoast/utils/ditoast_palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  unawaited(game.preloadSprites);
  Prefs.init();
  _addLicenses();
  GoogleFonts.config.allowRuntimeFetching = false;

  await Future.wait([
    Prefs.highScore.waitUntilLoaded(),
    Prefs.birthYear.waitUntilLoaded(),
  ]);


  runApp(TranslationProvider(child: const MyApp()));
}

void _addLicenses() {
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks(
      ['_gfx'],
      await rootBundle.loadString('assets/images/LICENSE.md'),
    );
    yield LicenseEntryWithLineBreaks(
      ['_ludum_dare_32_track_4'],
      await rootBundle.loadString('assets/audio/bgm/LICENSE.txt'),
    );
    yield LicenseEntryWithLineBreaks(
      ['google_fonts'],
      await rootBundle
          .loadString('assets/google_fonts/Atkinson_Hyperlegible/OFL.txt'),
    );
    yield LicenseEntryWithLineBreaks(
      ['google_fonts'],
      await rootBundle.loadString('assets/google_fonts/Silkscreen/OFL.txt'),
    );
  });
}

Future<void> handleCurrentConsentStage(BuildContext context) async {
  if (kIsWeb) return;
  
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Prefs.hyperlegibleFont.addListener(_prefListener);
  }

  @override
  void dispose() {
    Prefs.hyperlegibleFont.removeListener(_prefListener);
    super.dispose();
  }

  void _prefListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: t.appName,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      debugShowCheckedModeBanner: false,
      theme: nesThemeFrom(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: DitoastPalette.grassColor,
        ),
      ),
      darkTheme: nesThemeFrom(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: DitoastPalette.grassColor,
          brightness: Brightness.dark,
        ),
      ),
      highContrastTheme: nesThemeFrom(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.highContrastLight(),
      ),
      highContrastDarkTheme: nesThemeFrom(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.highContrastDark(),
      ),
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/play',
      builder: (context, state) => const PlayPage(),
    ),
    GoRoute(
      path: '/tutorial',
      builder: (context, state) => const TutorialPage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);

