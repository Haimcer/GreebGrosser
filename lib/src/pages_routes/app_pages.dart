import 'package:get/get.dart';
import 'package:greengrosser/src/pages/auth/view/sign_in_screen.dart';
import 'package:greengrosser/src/pages/auth/view/sign_up_screen.dart';
import 'package:greengrosser/src/pages/base/base_screen.dart';
import 'package:greengrosser/src/pages/base/binding/navigation_binding.dart';
import 'package:greengrosser/src/pages/cart/binding/cart_binding.dart';
import 'package:greengrosser/src/pages/home/binding/home_binding.dart';
import 'package:greengrosser/src/pages/orders/binding/orders_binding.dart';
import 'package:greengrosser/src/pages/product/product_screen.dart';
import 'package:greengrosser/src/pages/splash/splash_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.productRoute,
      page: () => ProductScreen(),
    ),
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
      bindings: [
        CartBinding(),
        NavigationBinding(),
        HomeBinding(),
        OrderBinding(),
      ],
    ),
  ];
}

abstract class PagesRoutes {
  static const String productRoute = '/product';
  static const String singInRoute = '/singnin';
  static const String singUpRoute = '/singnup';
  static const String splashRoute = '/splash';
  static const String baseRoute = '/base';
}
