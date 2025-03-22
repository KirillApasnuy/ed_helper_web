import 'package:ed_helper_web/util/device/localization/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:flutter_web_plugins/flutter_web_plugins.dart";
import 'package:provider/provider.dart';

import 'app.dart';
import 'data/models/user/user_manager.dart';

void main(List<String> arguments) async {
  await dotenv.load();
  setUrlStrategy(PathUrlStrategy());
  runApp(ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp()));
}
