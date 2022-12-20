import 'package:get/get.dart';
import 'package:greengrosser/src/pages/auth/sign_in_screen.dart';
import 'package:greengrosser/src/pages/auth/sign_up_screen.dart';
import 'package:greengrosser/src/pages/base/base_screen.dart';
import 'package:greengrosser/src/pages/splash/splash_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      page: () => const SplashScreen(),
      name: PagesRoutes.splashRoute,
    ),
    GetPage(
      page: () => SignInScreen(),
      name: PagesRoutes.singInRoute,
    ),
    GetPage(
      page: () => SignUpScreen(),
      name: PagesRoutes.singUpRoute,
    ),
    GetPage(
      page: () => const BaseScreen(),
      name: PagesRoutes.baseRoute,
    ),
  ];
}

abstract class PagesRoutes {
  static const String singInRoute = '/singnin';
  static const String singUpRoute = '/singnup';
  static const String splashRoute = '/splash';
  static const String baseRoute = '/base';
}
