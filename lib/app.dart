import 'dart:ui';

import 'package:ed_helper_web/util/routes/router.dart';
import 'package:ed_helper_web/util/theme/white_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';
import 'util/device/localization/locale_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  Locale _locale = Locale('en');

  @override
  void initState() {
    print(window.locale.languageCode);
    _changeLanguage(window.locale);
    super.initState();
  }

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {

    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp.router(
      title: 'Ed Helper',
      debugShowCheckedModeBanner: false,
      theme: WhiteTheme.theme,
      locale: localeProvider.locale,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      routerConfig: _appRouter.config(),
    );
  }
}
