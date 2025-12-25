import 'package:get/get.dart';

import '../../api/api.dart';
import '../../routes/app_pages.dart';

class SplashController extends GetxController {
  SplashController({required this.apiRepository});

  final ApiRepository apiRepository;

  String? _initialHealthStatus;
  String? _initialHealthError;

  @override
  void onReady() {
    super.onReady();
    _prepareAndNavigate();
  }

  Future<void> _prepareAndNavigate() async {
    final healthFuture = _checkHealth();
    final waitFuture = Future.delayed(const Duration(seconds: 3));

    await Future.wait([healthFuture, waitFuture]);

    if (isClosed) return;
    Get.offAllNamed(
      Routes.home,
      arguments: {
        'healthStatus': _initialHealthStatus,
        'healthError': _initialHealthError,
      },
    );
  }

  Future<void> _checkHealth() async {
    try {
      final result = await apiRepository.getHealth();
      if (result != null &&
          (result.status.toLowerCase() == 'ok' ||
              result.status.toLowerCase() == 'healthy')) {
        _initialHealthStatus = 'online';
      } else {
        _initialHealthStatus = 'offline';
        _initialHealthError = 'Service reported unhealthy';
      }
    } catch (_) {
      _initialHealthError = 'Failed to check service health';
      _initialHealthStatus = 'offline';
    }
  }
}
