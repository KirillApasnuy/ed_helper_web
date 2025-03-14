import 'package:auto_route/auto_route.dart';
import 'package:ed_helper_web/util/routes/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeGuard extends AutoRouteGuard {

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    isAuthenticated().then((authenticated) {
      if (authenticated) {
        router.replace(HomeRoute());
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