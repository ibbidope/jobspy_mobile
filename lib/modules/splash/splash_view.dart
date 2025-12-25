import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../shared/constants/colors.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  static const String _tagline =
      'Bringing LinkedIn & Indeed to your fingertips - no tabs, no chaos.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorConstants.primary.withValues(alpha: 0.98),
              ColorConstants.accent.withValues(alpha: 0.95),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/jobspy_banner.png',
                  width: Get.width * 0.6,
                ),
                SizedBox(height: 16.h),
                Text(
                  _tagline,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13.5.sp,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 26.h),
                _buildProgress(),
                SizedBox(height: 10.h),
                Text(
                  'Standby for awesomeness!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgress() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: LinearProgressIndicator(
        minHeight: 8.h,
        backgroundColor: Colors.white.withValues(alpha: 0.25),
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}
