import 'package:get/get.dart';

import '../../api/api.dart';
import '../../models/models.dart';

class HomeController extends GetxController {
  HomeController({required this.apiRepository});

  final ApiRepository apiRepository;

  final RxnString healthStatus = RxnString();
  final RxBool isCheckingHealth = false.obs;
  final RxnString healthError = RxnString();

  final RxList<JobModel> jobs = <JobModel>[].obs;
  final RxBool isFetchingJobs = false.obs;
  final RxnString jobsError = RxnString();

  // Field-level validation state
  final RxBool searchTermInvalid = false.obs;
  final RxBool locationInvalid = false.obs;
  final RxBool countryInvalid = false.obs;
  final RxBool resultsInvalid = false.obs;
  final RxBool hoursInvalid = false.obs;

  // Job search form state
  final RxList<String> selectedSites = <String>['linkedin', 'indeed'].obs;
  final RxString searchTerm = ''.obs;
  final RxString location = ''.obs;
  final RxInt resultsWanted = 10.obs;
  final RxInt hoursOld = 72.obs;
  final RxString countryIndeed = ''.obs;
  // final RxBool linkedinFetchDescription = false.obs;

  @override
  void onInit() {
    super.onInit();
    _applyInitialHealth();
    if (!_hasInitialHealth) {
      fetchHealth();
    }
  }

  Future<void> fetchHealth() async {
    isCheckingHealth.value = true;
    healthError.value = null;
    healthStatus.value = 'checking';
    try {
      final result = await apiRepository.getHealth();
      if (result != null &&
          (result.status.toLowerCase() == 'ok' ||
              result.status.toLowerCase() == 'healthy')) {
        healthStatus.value = 'online';
      } else {
        healthStatus.value = 'offline';
        healthError.value = 'Service reported unhealthy';
      }
    } catch (e) {
      healthError.value = 'Failed to check service health';
      healthStatus.value = 'offline';
    } finally {
      isCheckingHealth.value = false;
    }
  }

  Future<void> fetchJobs() async {
    jobsError.value = null;
    if (!_validateForm()) {
      return;
    }

    final payload = _buildJobPayload();

    isFetchingJobs.value = true;
    try {
      final result = await apiRepository.getJobs(payload);
      jobs.assignAll(result);
      if (result.isEmpty) {
        jobsError.value =
            "No jobs found. Try adjusting your filters and retry.";
      }
    } catch (e) {
      jobsError.value = 'Failed to load jobs. Please try again.';
    } finally {
      isFetchingJobs.value = false;
    }
  }

  Map<String, dynamic> _buildJobPayload() {
    final payload = <String, dynamic>{
      'site_name': selectedSites.toList(),
      'search_term': searchTerm.value.trim(),
      'location': location.value.trim(),
      'results_wanted': resultsWanted.value,
      'hours_old': hoursOld.value,
      // 'linkedin_fetch_description': linkedinFetchDescription.value,
    };

    if (selectedSites.contains('indeed')) {
      payload['country_indeed'] = countryIndeed.value.trim();
    }

    return payload;
  }

  bool _validateForm() {
    bool isValid = true;
    searchTermInvalid.value = false;
    locationInvalid.value = false;
    countryInvalid.value = false;
    resultsInvalid.value = false;
    hoursInvalid.value = false;
    jobsError.value = null;

    if (selectedSites.isEmpty) {
      jobsError.value = 'Select at least one site';
      isValid = false;
    }

    if (searchTerm.value.trim().isEmpty) {
      searchTermInvalid.value = true;
      isValid = false;
    }

    if (location.value.trim().isEmpty) {
      locationInvalid.value = true;
      isValid = false;
    }

    final wantsIndeed = selectedSites.contains('indeed');
    if (wantsIndeed && countryIndeed.value.trim().isEmpty) {
      countryInvalid.value = true;
      isValid = false;
    }

    if (resultsWanted.value <= 0) {
      resultsInvalid.value = true;
      isValid = false;
    }

    if (hoursOld.value <= 0) {
      hoursInvalid.value = true;
      isValid = false;
    }

    return isValid;
  }

  void toggleSite(String site) {
    if (selectedSites.contains(site)) {
      selectedSites.remove(site);
    } else {
      selectedSites.add(site);
    }
  }

  void setSearchTerm(String value) {
    searchTerm.value = value;
    if (value.isNotEmpty) {
      searchTermInvalid.value = false;
    }
  }

  void setLocation(String value) {
    location.value = value;
    if (value.isNotEmpty) {
      locationInvalid.value = false;
    }
  }

  void setResultsWanted(int? value) {
    if (value == null) {
      resultsWanted.value = 0;
      resultsInvalid.value = true;
      return;
    }
    resultsWanted.value = value.clamp(1, 50);
    resultsInvalid.value = false;
  }

  void setHoursOld(int? value) {
    if (value == null) {
      hoursOld.value = 0;
      hoursInvalid.value = true;
      return;
    }
    hoursOld.value = value.clamp(1, 720);
    hoursInvalid.value = false;
  }

  void setCountryIndeed(String value) {
    countryIndeed.value = value;
    if (value.isNotEmpty) {
      countryInvalid.value = false;
    }
  }

  // void setLinkedinFetchDescription(bool value) =>
  //     linkedinFetchDescription.value = value;

  void _applyInitialHealth() {
    final args = Get.arguments;
    if (args is Map) {
      final status = args['healthStatus'] as String?;
      final error = args['healthError'] as String?;
      if (status != null) {
        healthStatus.value = status;
      }
      if (error != null) {
        healthError.value = error;
      }
    }
  }

  bool get _hasInitialHealth =>
      healthStatus.value != null || healthError.value != null;
}
