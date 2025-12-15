import 'package:get/get.dart';

import '../modules/modules.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.home;

  static final routes = [
    GetPage(name: Routes.home, page: () => HomeView(), binding: HomeBinding()),
    // GetPage(name: Routes.appSelection, page: () => AppSelectionView()),
  ];
}
