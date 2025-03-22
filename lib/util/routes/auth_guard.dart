import 'package:auto_route/auto_route.dart';
import 'package:ed_helper_web/util/routes/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // TODO: implement onNavigation

    isAuthenticated().then((authenticated) {
      if (!authenticated) {
        print('guard');
        router.replace(AuthorizationRoute());
        // router.replace(const AppErrorRoute());
      } else {
        resolver.next();
      }
    });
  }

  Future<bool> isAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null;
  }
}
