import 'package:get/get.dart';

import 'api/api.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiProvider(), permanent: true);
    Get.put(ApiRepository(apiProvider: Get.find()), permanent: true);
  }
}
