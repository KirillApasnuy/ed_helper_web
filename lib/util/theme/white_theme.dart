import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class WhiteTheme {
  static ThemeData get theme => ThemeData(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: AppColors.secondary,
    ),
    useMaterial3: true,
  );
}
