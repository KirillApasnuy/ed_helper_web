// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AccountManagementRoute.name: (routeData) {
      final args = routeData.argsAs<AccountManagementRouteArgs>(
          orElse: () => const AccountManagementRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AccountManagementScreen(
          key: args.key,
          authUser: args.authUser,
        ),
      );
    },
    AuthorizationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthorizationScreen(),
      );
    },
    DoneRoute.name: (routeData) {
      final args = routeData.argsAs<DoneRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DoneScreen(
          key: args.key,
          title: args.title,
        ),
      );
    },
    AppErrorRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AppErrorScreen(),
      );
    },
    ErrorRoute.name: (routeData) {
      final args = routeData.argsAs<ErrorRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ErrorScreen(
          key: args.key,
          title: args.title,
        ),
      );
    },
    HistoryRoute.name: (routeData) {
      final args = routeData.argsAs<HistoryRouteArgs>(
          orElse: () => const HistoryRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HistoryScreen(
          key: args.key,
          authUser: args.authUser,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomeScreen(
          key: args.key,
          message: args.message,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    RatesRoute.name: (routeData) {
      final args = routeData.argsAs<RatesRouteArgs>(
          orElse: () => const RatesRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RatesScreen(
          key: args.key,
          authUser: args.authUser,
          onUserChanged: args.onUserChanged,
        ),
      );
    },
    SupportRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SupportScreen(),
      );
    },
    VoiceSelectionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const VoiceSelectionScreen(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WelcomeScreen(),
      );
    },
  };
}

/// generated route for
/// [AccountManagementScreen]
class AccountManagementRoute extends PageRouteInfo<AccountManagementRouteArgs> {
  AccountManagementRoute({
    Key? key,
    UserModel? authUser,
    List<PageRouteInfo>? children,
  }) : super(
          AccountManagementRoute.name,
          args: AccountManagementRouteArgs(
            key: key,
            authUser: authUser,
          ),
          initialChildren: children,
        );

  static const String name = 'AccountManagementRoute';

  static const PageInfo<AccountManagementRouteArgs> page =
      PageInfo<AccountManagementRouteArgs>(name);
}

class AccountManagementRouteArgs {
  const AccountManagementRouteArgs({
    this.key,
    this.authUser,
  });

  final Key? key;

  final UserModel? authUser;

  @override
  String toString() {
    return 'AccountManagementRouteArgs{key: $key, authUser: $authUser}';
  }
}

/// generated route for
/// [AuthorizationScreen]
class AuthorizationRoute extends PageRouteInfo<void> {
  const AuthorizationRoute({List<PageRouteInfo>? children})
      : super(
          AuthorizationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthorizationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DoneScreen]
class DoneRoute extends PageRouteInfo<DoneRouteArgs> {
  DoneRoute({
    Key? key,
    required String title,
    List<PageRouteInfo>? children,
  }) : super(
          DoneRoute.name,
          args: DoneRouteArgs(
            key: key,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'DoneRoute';

  static const PageInfo<DoneRouteArgs> page = PageInfo<DoneRouteArgs>(name);
}

class DoneRouteArgs {
  const DoneRouteArgs({
    this.key,
    required this.title,
  });

  final Key? key;

  final String title;

  @override
  String toString() {
    return 'DoneRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for
/// [AppErrorScreen]
class AppErrorRoute extends PageRouteInfo<void> {
  const AppErrorRoute({List<PageRouteInfo>? children})
      : super(
          AppErrorRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppErrorRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ErrorScreen]
class ErrorRoute extends PageRouteInfo<ErrorRouteArgs> {
  ErrorRoute({
    Key? key,
    required String title,
    List<PageRouteInfo>? children,
  }) : super(
          ErrorRoute.name,
          args: ErrorRouteArgs(
            key: key,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'ErrorRoute';

  static const PageInfo<ErrorRouteArgs> page = PageInfo<ErrorRouteArgs>(name);
}

class ErrorRouteArgs {
  const ErrorRouteArgs({
    this.key,
    required this.title,
  });

  final Key? key;

  final String title;

  @override
  String toString() {
    return 'ErrorRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for
/// [HistoryScreen]
class HistoryRoute extends PageRouteInfo<HistoryRouteArgs> {
  HistoryRoute({
    Key? key,
    UserModel? authUser,
    List<PageRouteInfo>? children,
  }) : super(
          HistoryRoute.name,
          args: HistoryRouteArgs(
            key: key,
            authUser: authUser,
          ),
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static const PageInfo<HistoryRouteArgs> page =
      PageInfo<HistoryRouteArgs>(name);
}

class HistoryRouteArgs {
  const HistoryRouteArgs({
    this.key,
    this.authUser,
  });

  final Key? key;

  final UserModel? authUser;

  @override
  String toString() {
    return 'HistoryRouteArgs{key: $key, authUser: $authUser}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    Key? key,
    ChatMessage? message,
    List<PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(
            key: key,
            message: message,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<HomeRouteArgs> page = PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    this.message,
  });

  final Key? key;

  final ChatMessage? message;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, message: $message}';
  }
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RatesScreen]
class RatesRoute extends PageRouteInfo<RatesRouteArgs> {
  RatesRoute({
    Key? key,
    UserModel? authUser,
    dynamic Function(UserModel)? onUserChanged,
    List<PageRouteInfo>? children,
  }) : super(
          RatesRoute.name,
          args: RatesRouteArgs(
            key: key,
            authUser: authUser,
            onUserChanged: onUserChanged,
          ),
          initialChildren: children,
        );

  static const String name = 'RatesRoute';

  static const PageInfo<RatesRouteArgs> page = PageInfo<RatesRouteArgs>(name);
}

class RatesRouteArgs {
  const RatesRouteArgs({
    this.key,
    this.authUser,
    this.onUserChanged,
  });

  final Key? key;

  final UserModel? authUser;

  final dynamic Function(UserModel)? onUserChanged;

  @override
  String toString() {
    return 'RatesRouteArgs{key: $key, authUser: $authUser, onUserChanged: $onUserChanged}';
  }
}

/// generated route for
/// [SupportScreen]
class SupportRoute extends PageRouteInfo<void> {
  const SupportRoute({List<PageRouteInfo>? children})
      : super(
          SupportRoute.name,
          initialChildren: children,
        );

  static const String name = 'SupportRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [VoiceSelectionScreen]
class VoiceSelectionRoute extends PageRouteInfo<void> {
  const VoiceSelectionRoute({List<PageRouteInfo>? children})
      : super(
          VoiceSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'VoiceSelectionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WelcomeScreen]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
