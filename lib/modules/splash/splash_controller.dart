import 'package:get/get.dart';

import '../../api/api.dart';
import '../../routes/app_pages.dart';
import 'dart:async';

class SplashController extends GetxController {
  SplashController({required this.apiRepository});

  final ApiRepository apiRepository;

  String? _initialHealthStatus;
  String? _initialHealthError;
  Timer? _navigationTimer;

  @override
  void onReady() {
    super.onReady();
    _prepareAndNavigate();
  }

  @override
  void onClose() {
    _navigationTimer?.cancel();
    _navigationTimer = null;
    super.onClose();
  }

  Future<void> _prepareAndNavigate() async {
    final healthFuture = _checkHealth();
    final waitCompleter = Completer<void>();
    _navigationTimer = Timer(const Duration(seconds: 3), () {
      if (!waitCompleter.isCompleted) {
        waitCompleter.complete();
      }
    });

    await Future.wait([healthFuture, waitCompleter.future]);

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
