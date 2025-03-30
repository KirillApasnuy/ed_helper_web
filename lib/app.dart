import 'dart:ui';

import 'package:ed_helper_web/util/routes/router.dart';
import 'package:ed_helper_web/util/theme/white_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/services/user_service.dart';
import 'generated/l10n.dart';
import 'util/device/localization/locale_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();
  final _userService = UserService();

  Locale _locale = Locale('en');

  void _initialize() async {
    print("Starting verification");
    if (!(await _verifyAuth())) {
      try {
        _userService.newUserWithIp();
      } on Exception catch (e) {
        print(e);
      }
      print("Verified");
    }
  }

  Future<bool> _verifyAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);
    if (token == null || token == "") {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    _changeLanguage(window.locale);
    _initialize();
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
