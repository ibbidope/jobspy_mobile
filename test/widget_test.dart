import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:jobspy_mobile/api/api_constants.dart';
import 'package:jobspy_mobile/api/api_provider.dart';
import 'package:jobspy_mobile/api/api_repository.dart';
import 'package:jobspy_mobile/models/models.dart';
import 'package:jobspy_mobile/modules/home/home_controller.dart';
import 'package:jobspy_mobile/modules/home/home_view.dart';
import 'package:jobspy_mobile/modules/splash/splash_controller.dart';
import 'package:jobspy_mobile/modules/splash/splash_view.dart';
import 'package:jobspy_mobile/routes/routes.dart';

void main() {
  setUp(() {
    ApiConstants.setBaseUrlForTesting('https://example.com');
  });

  tearDown(() {
    Get.reset();
    ApiConstants.setBaseUrlForTesting(null);
  });

  testWidgets('LinkedIn-only search does not require Indeed country', (
    tester,
  ) async {
    final controller = HomeController(apiRepository: _FakeApiRepository());
    controller.toggleSite('indeed'); // remove Indeed, keep LinkedIn
    controller.setSearchTerm('Designer');
    controller.setLocation('Remote');

    await controller.fetchJobs();

    expect(controller.countryInvalid.value, isFalse);
    expect(controller.jobs, isNotEmpty);
  });

  testWidgets('Indeed search requires country and blocks fetch when missing', (
    tester,
  ) async {
    final controller = HomeController(apiRepository: _FakeApiRepository());
    controller.selectedSites.assignAll(['indeed']);
    controller.setSearchTerm('Developer');
    controller.setLocation('Berlin');
    controller.countryIndeed.value = '';

    await controller.fetchJobs();

    expect(controller.countryInvalid.value, isTrue);
    expect(controller.jobs, isEmpty);
  });

  testWidgets('No results surfaces user-friendly message', (tester) async {
    final controller = HomeController(apiRepository: _EmptyApiRepository());
    controller.selectedSites.assignAll(['linkedin']);
    controller.setSearchTerm('QA');
    controller.setLocation('Remote');

    await controller.fetchJobs();

    expect(
      controller.jobsError.value,
      "No jobs found. Try adjusting your filters and retry.",
    );
  });

  testWidgets('HomeView renders and shows key sections', (tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        builder: (context, _) => GetMaterialApp(
          home: const HomeView(),
          initialBinding: BindingsBuilder(() {
            Get.put<HomeController>(
              HomeController(apiRepository: _FakeApiRepository()),
            );
          }),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('appbar-logo')), findsOneWidget);
    expect(find.text('Job Search'), findsOneWidget);
    expect(find.textContaining('API Health'), findsOneWidget);
  });

  testWidgets('SplashView shows branding and status line', (tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        builder: (context, _) => GetMaterialApp(
          home: const SplashView(),
          getPages: [
            GetPage(
              name: Routes.home,
              page: () =>
                  const Scaffold(body: Center(child: Text('Home placeholder'))),
            ),
            GetPage(name: Routes.splash, page: () => const SplashView()),
          ],
          initialBinding: BindingsBuilder(() {
            Get.put<SplashController>(
              SplashController(apiRepository: _FakeApiRepository()),
            );
          }),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(Image), findsWidgets);
    expect(
      find.text(
        'Bringing LinkedIn & Indeed to your fingertips - no tabs, no chaos.',
      ),
      findsOneWidget,
    );
    expect(find.text('Standby for awesomeness!'), findsOneWidget);

    // Let the splash timer complete to avoid pending timer assertion.
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}

class _FakeApiRepository extends ApiRepository {
  _FakeApiRepository() : super(apiProvider: ApiProvider());

  @override
  Future<HealthModel?> getHealth() async => HealthModel(status: 'ok');

  @override
  Future<List<JobModel>> getJobs(Map<String, dynamic> payload) async => [
    JobModel(
      title: payload['search_term']?.toString() ?? 'Engineer',
      company: 'Acme Inc',
      location: payload['location']?.toString() ?? 'Remote',
      site: (payload['site_name'] as List?)?.first?.toString(),
      jobType: 'Full-time',
      jobUrl: 'https://example.com',
    ),
  ];
}

class _EmptyApiRepository extends ApiRepository {
  _EmptyApiRepository() : super(apiProvider: ApiProvider());

  @override
  Future<HealthModel?> getHealth() async => HealthModel(status: 'ok');

  @override
  Future<List<JobModel>> getJobs(Map<String, dynamic> payload) async => [];
}
