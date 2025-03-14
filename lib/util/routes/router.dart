import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:ed_helper_web/util/routes/welcome_guard.dart';
import 'package:flutter/material.dart';

import '../../data/models/chat_message/chat_message.dart';
import '../../data/models/chat_message/file_model.dart';
import '../../data/models/user/user_model.dart';
import '../../screens/account_managment/account_managment.dart';
import '../../screens/authorization/authorization_screen.dart';
import '../../screens/done/done_screen.dart';
import '../../screens/error/app_error_screen.dart';
import '../../screens/error/error_screen.dart';
import '../../screens/history/history_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/rates/rates_screen.dart';
import '../../screens/support/support_screen.dart';
import '../../screens/voice_selection/voice_selection.dart';
import '../../screens/welcome/welcome_screen.dart';
import 'auth_guard.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: WelcomeRoute.page, path: "/welcome", initial: true,),
    AutoRoute(page: AuthorizationRoute.page,path: "/auth",),
    AutoRoute(page: RatesRoute.page, path: "/rates",guards: [
      AuthGuard(),
    ]),
    AutoRoute(page: ProfileRoute.page, path: "/profile", guards: [
      AuthGuard(),
    ]),
    AutoRoute(page: HomeRoute.page, path: "/home"),
    AutoRoute(page: HistoryRoute.page, path: "/history", guards: [
      AuthGuard(),
    ]),
    AutoRoute(page: ErrorRoute.page, path: "/error"),
    AutoRoute(page: DoneRoute.page, path: "/done"),
    AutoRoute(page: AppErrorRoute.page, path: "/app_error"),
    AutoRoute(page: AccountManagementRoute.page, path: "/account_management", guards: [
      AuthGuard(),
    ]),
  ];
}