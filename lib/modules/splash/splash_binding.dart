import 'package:get/get.dart';

import '../../api/api.dart';
import 'splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(
      SplashController(apiRepository: Get.find<ApiRepository>()),
    );
  }
}
