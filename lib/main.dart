import '/custom_code/actions/index.dart' as actions;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'auth/supabase_auth/supabase_user_provider.dart';
import 'auth/supabase_auth/auth_util.dart';

import '/backend/supabase/supabase.dart';
import 'backend/firebase/firebase_config.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await initFirebase();

  // Start initial custom actions code
  await actions.changeBarColors();
  await actions.appLinksUsage();
  // End initial custom actions code

  await SupaFlow.initialize();

  await FlutterFlowTheme.initialize();

  await FFLocalizations.initialize();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }
  await initializeFirebaseRemoteConfig();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale = FFLocalizations.getStoredLocale();

  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  late Stream<BaseAuthUser> userStream;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = iEvangelizeSupabaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      const Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  void setLocale(String language) {
    safeSetState(() => _locale = createLocale(language));
    FFLocalizations.storeLocale(language);
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'iEvangelize',
      localizationsDelegates: const [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackMaterialLocalizationDelegate(),
        FallbackCupertinoLocalizationDelegate(),
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ja'),
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
        Locale('hi'),
        Locale('ml'),
        Locale('ru'),
        Locale('ko'),
        Locale('de'),
        Locale('es'),
        Locale('pt'),
        Locale('id'),
        Locale('fr'),
        Locale('it'),
        Locale('ar'),
        Locale('uk'),
        Locale('nl'),
        Locale('pl'),
        Locale('bg'),
        Locale('tr'),
        Locale('sv'),
        Locale('ms'),
        Locale('ro'),
        Locale('el'),
        Locale('cs'),
        Locale('da'),
        Locale('fi'),
        Locale('hr'),
        Locale('sk'),
        Locale('ta'),
        Locale('be'),
        Locale('et'),
        Locale('ka'),
        Locale('hu'),
        Locale('mn'),
        Locale('my'),
        Locale('no'),
        Locale('fa'),
        Locale('sr'),
        Locale('sd'),
        Locale('sl'),
        Locale('ur'),
        Locale('uz'),
        Locale('vi'),
        Locale('bn'),
        Locale('sq'),
        Locale('hy'),
        Locale('am'),
        Locale('eu'),
        Locale('bs'),
        Locale('ca'),
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
        Locale('gl'),
        Locale('gu'),
        Locale('kn'),
        Locale('lv'),
        Locale('lt'),
        Locale('mk'),
        Locale('mr'),
        Locale('ne'),
        Locale('or'),
        Locale('pa'),
        Locale('si'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(
          interactive: false,
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.dragged)) {
              return const Color(0x00ffffff);
            }
            if (states.contains(WidgetState.hovered)) {
              return const Color(0x00ffffff);
            }
            return const Color(0x00ffffff);
          }),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scrollbarTheme: ScrollbarThemeData(
          interactive: false,
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.dragged)) {
              return const Color(0x00ffffff);
            }
            if (states.contains(WidgetState.hovered)) {
              return const Color(0x00ffffff);
            }
            return const Color(0x00ffffff);
          }),
        ),
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}
