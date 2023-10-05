import 'package:auto_route/auto_route.dart';
import 'package:demo/product/home_screen/view/home_screen.dart';
import 'package:demo/product/login/view/login_screen.dart';
import 'package:demo/product/setting_screen/setting_screen.dart';
import 'package:demo/product/splash_screen/view/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: RouterItem.splash.str(),
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: RouterItem.home.str(),
          page: HomeRoute.page,
        ),
        AutoRoute(
          path: RouterItem.setting.str(),
          page: SettingRoute.page,
        ),
        AutoRoute(
          path: RouterItem.login.str(),
          page: LoginRoute.page,
        ),
      ];
}

enum RouterItem {
  splash,
  home,
  setting,
  login,
}

extension RouterItems on RouterItem {
  String str() {
    switch (this) {
      case RouterItem.home:
        return "/home";
      case RouterItem.setting:
        return "/setting";
      case RouterItem.splash:
        return "/splash";
      case RouterItem.login:
        return "/login";
    }
  }
}
