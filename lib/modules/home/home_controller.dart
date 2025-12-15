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

  // Job search form state
  final RxList<String> selectedSites = <String>['linkedin', 'indeed'].obs;
  final RxString searchTerm = 'Graphic Designer'.obs;
  final RxString location = 'Islamabad, Pakistan'.obs;
  final RxInt resultsWanted = 10.obs;
  final RxInt hoursOld = 72.obs;
  final RxString countryIndeed = 'Pakistan'.obs;
  final RxBool linkedinFetchDescription = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHealth();
  }

  Future<void> fetchHealth() async {
    isCheckingHealth.value = true;
    healthError.value = null;
    try {
      final result = await apiRepository.getHealth();
      if (result != null) {
        healthStatus.value = result.status;
      } else {
        healthStatus.value = 'unknown';
      }
    } catch (e) {
      healthError.value = 'Failed to check service health';
    } finally {
      isCheckingHealth.value = false;
    }
  }

  Future<void> fetchJobs() async {
    isFetchingJobs.value = true;
    jobsError.value = null;
    try {
      final payload = _buildJobPayload();
      final result = await apiRepository.getJobs(payload);
      jobs.assignAll(result);
    } catch (e) {
      jobsError.value = 'Failed to load jobs';
    } finally {
      isFetchingJobs.value = false;
    }
  }

  Map<String, dynamic> _buildJobPayload() {
    return {
      'site_name': selectedSites.toList(),
      'search_term': searchTerm.value.trim(),
      'location': location.value.trim(),
      'results_wanted': resultsWanted.value,
      'hours_old': hoursOld.value,
      'country_indeed': countryIndeed.value.trim(),
      'linkedin_fetch_description': linkedinFetchDescription.value,
    };
  }

  void toggleSite(String site) {
    if (selectedSites.contains(site)) {
      selectedSites.remove(site);
    } else {
      selectedSites.add(site);
    }
  }

  void setSearchTerm(String value) => searchTerm.value = value;
  void setLocation(String value) => location.value = value;
  void setResultsWanted(int value) => resultsWanted.value = value.clamp(1, 50);
  void setHoursOld(int value) => hoursOld.value = value.clamp(1, 720);
  void setCountryIndeed(String value) => countryIndeed.value = value;
  void setLinkedinFetchDescription(bool value) =>
      linkedinFetchDescription.value = value;
}
