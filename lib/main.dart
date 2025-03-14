import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:flutter_web_plugins/flutter_web_plugins.dart";

import 'app.dart';
import 'data/models/user/user_manager.dart';

void main(List<String> arguments) async {
  await dotenv.load();
  setUrlStrategy(PathUrlStrategy());
  final savedUser = UserManager.loadUser();
  runApp(UserManager(
      user: savedUser,
      onUserChanged: (newUser) {
        UserManager.saveUser(newUser);
      },
      child: const MyApp()));
}
