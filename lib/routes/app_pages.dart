import 'package:get/get.dart';

import '../modules/modules.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(name: Routes.home, page: () => HomeView(), binding: HomeBinding()),
  ];
}
