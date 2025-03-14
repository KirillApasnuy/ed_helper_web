import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'dart:html' as html;

import 'user_model.dart';

class UserManager extends InheritedWidget {
  UserModel? user;
  final Function(UserModel) onUserChanged;

  UserManager({
    super.key,
    required Widget child,
    required this.user,
    required this.onUserChanged,
  }) : super(child: child);

  static UserManager? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserManager>();
  }

  @override
  bool updateShouldNotify(UserManager oldWidget) => user != oldWidget.user;

  static void saveUser(UserModel user) {
    final jsonString = jsonEncode(user.toJson());
    html.window.localStorage['authUser'] = jsonString;
  }

  static UserModel? loadUser() {
    final jsonString = html.window.localStorage['authUser'];
    if (jsonString != null) {
      return UserModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }
}
