import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../models/job_model.dart';
import '../../shared/utils/platform_loading_indicator.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('JobSpy Mobile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.wait([
              controller.fetchHealth(),
              controller.fetchJobs(),
            ]);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHealthCard(),
                SizedBox(height: 16.h),
                _buildSearchForm(),
                SizedBox(height: 16.h),
                _buildJobsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchForm() {
    return Obx(() {
      return Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Job Search',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 6.h,
                children: ['linkedin', 'indeed'].map((site) {
                  final isSelected = controller.selectedSites.contains(site);
                  return FilterChip(
                    label: Text(site),
                    selected: isSelected,
                    onSelected: (_) => controller.toggleSite(site),
                    selectedColor: const Color(
                      0xFF2E8BFD,
                    ).withValues(alpha: 0.15),
                    checkmarkColor: const Color(0xFF2E8BFD),
                  );
                }).toList(),
              ),
              SizedBox(height: 12.h),
              TextFormField(
                initialValue: controller.searchTerm.value,
                decoration: const InputDecoration(
                  labelText: 'Search term',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: controller.setSearchTerm,
              ),
              SizedBox(height: 12.h),
              TextFormField(
                initialValue: controller.location.value,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
                onChanged: controller.setLocation,
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: _NumberField(
                      label: 'Results wanted',
                      value: controller.resultsWanted.value,
                      onChanged: (v) => controller.setResultsWanted(v ?? 10),
                      min: 1,
                      max: 50,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _NumberField(
                      label: 'Hours old',
                      value: controller.hoursOld.value,
                      onChanged: (v) => controller.setHoursOld(v ?? 72),
                      min: 1,
                      max: 720,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              TextFormField(
                initialValue: controller.countryIndeed.value,
                decoration: const InputDecoration(
                  labelText: 'Indeed country',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.flag_outlined),
                ),
                onChanged: controller.setCountryIndeed,
              ),
              SizedBox(height: 8.h),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('LinkedIn fetch description'),
                value: controller.linkedinFetchDescription.value,
                onChanged: controller.setLinkedinFetchDescription,
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: controller.isFetchingJobs.value
                      ? null
                      : controller.fetchJobs,
                  icon: const Icon(Icons.search),
                  label: const Text('Fetch Jobs'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildHealthCard() {
    return Obx(() {
      final isLoading = controller.isCheckingHealth.value;
      final status = controller.healthStatus.value;
      final error = controller.healthError.value;

      Color statusColor;
      String label;
      if (status != null &&
          (status.toLowerCase() == 'ok' || status.toLowerCase() == 'healthy')) {
        statusColor = Colors.green;
        label = 'Online';
      } else if (status == null) {
        statusColor = Colors.grey;
        label = 'Unknown';
      } else {
        statusColor = Colors.red;
        label = status;
      }

      return Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              if (isLoading)
                const PlatformLoadingIndicator()
              else
                Icon(Icons.circle, color: statusColor, size: 18.w),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'API Health',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      error ?? label,
                      style: TextStyle(
                        color: error != null ? Colors.red : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: isLoading ? null : () => controller.fetchHealth(),
                icon: const Icon(Icons.refresh),
                tooltip: 'Refresh health',
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildJobsSection() {
    return Obx(() {
      if (controller.isFetchingJobs.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: PlatformLoadingIndicator(),
          ),
        );
      }

      if (controller.jobsError.value != null) {
        return _MessageCard(
          title: 'Jobs',
          message: controller.jobsError.value!,
          icon: Icons.error_outline,
          color: Colors.red,
          onRetry: controller.fetchJobs,
        );
      }

      if (controller.jobs.isEmpty) {
        return _MessageCard(
          title: 'Jobs',
          message: 'No jobs found for the current filters.',
          icon: Icons.work_outline,
          color: Colors.grey,
          onRetry: controller.fetchJobs,
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Latest Jobs',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 8.h),
          ListView.separated(
            itemCount: controller.jobs.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (_, index) {
              final job = controller.jobs[index];
              return _JobTile(job: job);
            },
          ),
        ],
      );
    });
  }
}

class _JobTile extends StatelessWidget {
  const _JobTile({required this.job});

  final JobModel job;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.title ?? 'Untitled role',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(
              job.company ?? 'Unknown company',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 16),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    job.location ?? 'Location not provided',
                    style: const TextStyle(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (job.jobType != null)
                  _Tag(label: job.jobType!, color: const Color(0xFF2E8BFD)),
                _Tag(
                  label: job.site != null ? job.site!.toUpperCase() : 'UNKNOWN',
                  color: Colors.grey.shade400,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                if (job.jobUrl != null || job.jobUrlDirect != null)
                  TextButton(
                    onPressed: () {
                      final url = job.jobUrlDirect ?? job.jobUrl;
                      if (url != null) {
                        Get.snackbar(
                          'Job Link',
                          url,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 3),
                        );
                      }
                    },
                    child: const Text('Copy Link'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({
    required this.title,
    required this.message,
    required this.icon,
    required this.color,
    this.onRetry,
  });

  final String title;
  final String message;
  final IconData icon;
  final Color color;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(color: color.withValues(alpha: 0.9)),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color.withValues(alpha: 0.9),
        ),
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
  });

  final String label;
  final int value;
  final void Function(int?) onChanged;
  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value.toString(),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      onChanged: (val) {
        final parsed = int.tryParse(val);
        if (parsed != null) {
          onChanged(parsed.clamp(min, max));
        }
      },
    );
  }
}
