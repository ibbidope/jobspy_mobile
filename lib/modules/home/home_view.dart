import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/job_model.dart';
import '../../shared/constants/colors.dart';
import '../../shared/utils/platform_loading_indicator.dart';
import '../../shared/widgets/widgets.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const String _searchPlaceholder = 'e.g. Product Designer';
  static const String _locationPlaceholder = 'e.g. Islamabad, Pakistan';
  static const String _indeedCountryPlaceholder = 'e.g. Pakistan';
  static const String _repoUrl = 'https://github.com/ibbidope/jobspy_mobile';
  static const String _linkedInUrl =
      'https://www.linkedin.com/in/ibrahimhassan99/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.surface,
      appBar: AppBar(
        backgroundColor: ColorConstants.surface,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/app_icon_transparent.png',
              width: 180.w,
              key: const Key('appbar-logo'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHero(),
              SizedBox(height: 14.h),
              _buildRepoCard(),
              SizedBox(height: 14.h),
              _buildHealthCard(),
              SizedBox(height: 14.h),
              _buildSearchCard(),
              SizedBox(height: 14.h),
              _buildJobsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorConstants.primary, ColorConstants.accent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find your next role',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6.h),
          const Text(
            'Search LinkedIn and Indeed with one tap.',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Pill(text: 'Realtime scrape', icon: Icons.bolt),
              SizedBox(width: 8.w),
              Obx(
                () => Pill(
                  text: '${controller.selectedSites.length} sites',
                  icon: Icons.public,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRepoCard() {
    final githubColor = const Color(0xFF24292E);
    final linkedinColor = const Color(0xFF0A66C2);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorConstants.surface,
            ColorConstants.primary.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: ColorConstants.primary.withValues(alpha: 0.15),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [ColorConstants.primary, ColorConstants.accent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.primary.withValues(alpha: 0.18),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(Icons.public, color: Colors.white),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Built with love for the community',
                  style: TextStyle(
                    fontSize: 15.5.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: ColorConstants.primary.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.code, size: 18.w, color: githubColor),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          'Open-source & hiring friendly',
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.5.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    _buildLinkButton(
                      label: 'GitHub',
                      icon: Icons.code,
                      color: githubColor,
                      onTap: () => _openJobLink(_repoUrl),
                    ),
                    _buildLinkButton(
                      label: 'LinkedIn',
                      icon: Icons.work_outline,
                      color: linkedinColor,
                      onTap: () => _openJobLink(_linkedInUrl),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 2,
      ),
    );
  }

  Widget _buildHealthCard() {
    return Obx(() {
      final isLoading = controller.isCheckingHealth.value;
      final status = controller.healthStatus.value;
      final error = controller.healthError.value;

      Color statusColor;
      String label;
      if (isLoading || status?.toLowerCase() == 'checking') {
        statusColor = Colors.orange;
        label = 'Checking...';
      } else if (status != null && status.toLowerCase() == 'online') {
        statusColor = Colors.green;
        label = 'Online';
      } else if (status != null && status.toLowerCase() == 'offline') {
        statusColor = Colors.red;
        label = 'Offline';
      } else {
        statusColor = Colors.grey;
        label = 'Unknown';
      }

      return AppCard(
        child: Row(
          children: [
            Icon(Icons.circle, color: statusColor, size: 18.w),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'API Health',
                    style: TextStyle(
                      fontSize: 16.sp,
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
            _SpinningRefresh(
              spinning: isLoading,
              onTap: isLoading ? null : controller.fetchHealth,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSearchCard() {
    return Obx(() {
      return AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Job Search',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 10.w,
              runSpacing: 6.h,
              children: ['linkedin', 'indeed'].map((site) {
                final isSelected = controller.selectedSites.contains(site);
                return FilterChip(
                  label: Text(site),
                  selected: isSelected,
                  onSelected: (_) => controller.toggleSite(site),
                  selectedColor: ColorConstants.primary.withValues(alpha: 0.12),
                  checkmarkColor: ColorConstants.primary,
                );
              }).toList(),
            ),
            SizedBox(height: 12.h),
            TextInput(
              placeholder: _searchPlaceholder,
              label: 'Search term',
              icon: Icons.search,
              onChanged: controller.setSearchTerm,
              hasError: controller.searchTermInvalid.value,
            ),
            SizedBox(height: 10.h),
            TextInput(
              placeholder: _locationPlaceholder,
              label: 'Location',
              icon: Icons.location_on_outlined,
              onChanged: controller.setLocation,
              hasError: controller.locationInvalid.value,
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: NumberInput(
                    label: 'Results wanted',
                    value: controller.resultsWanted.value,
                    onChanged: controller.setResultsWanted,
                    min: 1,
                    max: 50,
                    hasError: controller.resultsInvalid.value,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: NumberInput(
                    label: 'Hours old',
                    value: controller.hoursOld.value,
                    onChanged: controller.setHoursOld,
                    min: 1,
                    max: 720,
                    hasError: controller.hoursInvalid.value,
                  ),
                ),
              ],
            ),
            if (controller.selectedSites.contains('indeed')) ...[
              SizedBox(height: 10.h),
              TextInput(
                placeholder: _indeedCountryPlaceholder,
                label: 'Indeed country',
                icon: Icons.flag_outlined,
                onChanged: controller.setCountryIndeed,
                hasError: controller.countryInvalid.value,
              ),
              SizedBox(height: 6.h),
            ],
            // SwitchListTile(
            //   contentPadding: EdgeInsets.zero,
            //   title: const Text('LinkedIn fetch description'),
            //   value: controller.linkedinFetchDescription.value,
            //   onChanged: controller.setLinkedinFetchDescription,
            // ),
            // SizedBox(height: 6.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: controller.isFetchingJobs.value
                    ? null
                    : controller.fetchJobs,
                icon: const Icon(Icons.search, color: Colors.white),
                label: const Text(
                  'Fetch Jobs',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primary,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ],
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
        final message = controller.jobsError.value!;
        final isNoResults =
            message == "No jobs found. Try adjusting your filters and retry.";
        return _MessageCard(
          title: 'Jobs',
          message: message,
          icon: isNoResults ? Icons.search_off : Icons.error_outline,
          color: isNoResults ? Colors.grey : Colors.red,
          onRetry: controller.fetchJobs,
        );
      }

      if (controller.jobs.isEmpty) {
        return SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Latest Jobs',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstants.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Obx(
                      () => Text(
                        '${controller.jobs.length} results',
                        style: TextStyle(
                          color: ColorConstants.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: controller.fetchJobs,
                icon: const Icon(Icons.filter_alt_outlined, color: Colors.grey),
                tooltip: 'Refetch with current filters',
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ListView.separated(
            itemCount: controller.jobs.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, _) => SizedBox(height: 12.h),
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
    final accent = ColorConstants.primary;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            job.title ?? 'Untitled role',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(Icons.business_center_outlined, size: 16, color: accent),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  job.company ?? 'Unknown company',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 16),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  job.location ?? 'Location not provided',
                  style: TextStyle(fontSize: 13.sp),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              if (job.jobType != null)
                TagChip(label: job.jobType!, color: accent),
              const Spacer(),
              TagChip(
                label: job.site != null ? job.site!.toUpperCase() : 'UNKNOWN',
                color: Colors.grey.shade500,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              if (job.jobUrl != null)
                TextButton.icon(
                  onPressed: () => _openJobLink(job.jobUrl),
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Open job page'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<void> _openJobLink(String? jobUrl) async {
  if (jobUrl == null) {
    Get.snackbar(
      'Link unavailable',
      'No URL provided for this job',
      duration: const Duration(seconds: 3),
    );
    return;
  }

  final Uri uri = Uri.parse(jobUrl);

  if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
    Get.snackbar(
      'Could not open link',
      uri.toString(),
      duration: const Duration(seconds: 3),
    );
  }
}

class _SpinningRefresh extends StatefulWidget {
  const _SpinningRefresh({required this.spinning, this.onTap});

  final bool spinning;
  final VoidCallback? onTap;

  @override
  State<_SpinningRefresh> createState() => _SpinningRefreshState();
}

class _SpinningRefreshState extends State<_SpinningRefresh>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    if (widget.spinning) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant _SpinningRefresh oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.spinning && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.spinning && _controller.isAnimating) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: IconButton(
        onPressed: widget.spinning ? null : widget.onTap,
        icon: const Icon(Icons.refresh),
        tooltip: 'Refresh health',
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
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              SizedBox(width: 8.w),
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(message, style: TextStyle(color: color.withValues(alpha: 0.9))),
          if (onRetry != null) ...[
            SizedBox(height: 8.h),
            TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}
