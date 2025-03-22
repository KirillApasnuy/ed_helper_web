import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = window.locale;

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}