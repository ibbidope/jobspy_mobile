import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home View',
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/app_controller.dart';
// import '../../controllers/focus_controller.dart';
// import '../../routes/app_pages.dart';
// import '../../services/permission_service.dart';

// class HomeView extends StatelessWidget {
//   final AppController appController = Get.find<AppController>();
//   final FocusController focusController = Get.find<FocusController>();
//   final PermissionService permissionService = Get.find<PermissionService>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: SafeArea(
//         child: Obx(() {
//           if (focusController.isSessionActive.value) {
//             return _buildActiveSessionView();
//           }

//           if (!permissionService.allPermissionsGranted.value) {
//             return _buildPermissionsView();
//           }

//           return _buildHomeView();
//         }),
//       ),
//     );
//   }

//   Widget _buildPermissionsView() {
//     return Padding(
//       padding: EdgeInsets.all(24),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.security, size: 80, color: Colors.blue),
//           SizedBox(height: 32),
//           Text(
//             'Permissions Required',
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[800],
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 16),
//           Text(
//             'To block apps and help you focus, we need the following permissions:',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey[600],
//               height: 1.5,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 24),
//           _buildPermissionItem(
//             'Display over other apps',
//             'Shows blocking overlay when you open blocked apps',
//             permissionService.hasOverlayPermission.value,
//             permissionService.requestOverlayPermission,
//           ),
//           SizedBox(height: 12),
//           _buildPermissionItem(
//             'Usage access',
//             'Monitors which apps you\'re using',
//             permissionService.hasUsageStatsPermission.value,
//             permissionService.requestUsageStatsPermission,
//           ),
//           SizedBox(height: 32),
//           ElevatedButton(
//             onPressed: () async {
//               await permissionService.checkAllPermissions();
//               if (!permissionService.allPermissionsGranted.value) {
//                 Get.snackbar(
//                   'Permissions Still Required',
//                   'Please grant all permissions for the app to work properly',
//                   snackPosition: SnackPosition.BOTTOM,
//                 );
//               }
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               foregroundColor: Colors.white,
//               padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: Text(
//               'Check Permissions Again',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//             ),
//           ),
//           SizedBox(height: 16),
//           TextButton(
//             onPressed: permissionService.openAppSettings,
//             child: Text(
//               'Open App Settings',
//               style: TextStyle(color: Colors.blue),
//             ),
//           ),
//           SizedBox(height: 16),
//           Obx(
//             () => Text(
//               permissionService.getPermissionStatusText(),
//               style: TextStyle(
//                 color: permissionService.allPermissionsGranted.value
//                     ? Colors.green
//                     : Colors.orange,
//                 fontWeight: FontWeight.w500,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPermissionItem(
//     String title,
//     String description,
//     bool isGranted,
//     VoidCallback onRequest,
//   ) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: isGranted ? Colors.green : Colors.grey[300]!,
//           width: 2,
//         ),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             isGranted ? Icons.check_circle : Icons.error,
//             color: isGranted ? Colors.green : Colors.orange,
//             size: 24,
//           ),
//           SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   description,
//                   style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                 ),
//               ],
//             ),
//           ),
//           if (!isGranted)
//             TextButton(
//               onPressed: onRequest,
//               child: Text('Grant', style: TextStyle(color: Colors.blue)),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActiveSessionView() {
//     return Column(
//       children: [
//         _buildAppBar(),
//         Expanded(
//           child: Center(
//             child: Padding(
//               padding: EdgeInsets.all(24),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       SizedBox(
//                         width: 220,
//                         height: 220,
//                         child: CircularProgressIndicator(
//                           value: focusController.progress.clamp(0.0, 1.0),
//                           strokeWidth: 8,
//                           backgroundColor: Colors.blue[100],
//                           valueColor: AlwaysStoppedAnimation<Color>(
//                             Colors.blue,
//                           ),
//                         ),
//                       ),
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             'Remaining',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey[600],
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Obx(
//                             () => Text(
//                               focusController.formatDuration(
//                                 focusController.remainingTime.value,
//                               ),
//                               style: TextStyle(
//                                 fontSize: 36,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 40),
//                   Text(
//                     'Stay Focused! 💪',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Obx(() {
//                     final session = focusController.currentSession.value;
//                     return Text(
//                       'Blocking ${session?.blockedApps.length ?? 0} apps',
//                       style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                     );
//                   }),
//                   SizedBox(height: 32),
//                   ElevatedButton(
//                     onPressed: focusController.stopFocusSession,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       foregroundColor: Colors.white,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 32,
//                         vertical: 16,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: Text(
//                       'End Session',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildHomeView() {
//     return Column(
//       children: [
//         _buildAppBar(),
//         Expanded(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.all(24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildWelcomeSection(),
//                 SizedBox(height: 32),
//                 _buildQuickStartSection(),
//                 SizedBox(height: 32),
//                 _buildStatsSection(),
//                 SizedBox(height: 32),
//                 _buildActionsSection(),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildAppBar() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
//         ],
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.timer, color: Colors.blue, size: 28),
//           SizedBox(width: 12),
//           Text(
//             'Focus Time',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[800],
//             ),
//           ),
//           Spacer(),
//           IconButton(
//             icon: Icon(Icons.settings, color: Colors.grey[600]),
//             onPressed: () {
//               Get.toNamed(Routes.appSelection);
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.security, color: Colors.grey[600]),
//             onPressed: () {
//               permissionService.checkAllPermissions();
//               Get.snackbar(
//                 'Permission Status',
//                 permissionService.getPermissionStatusText(),
//                 snackPosition: SnackPosition.BOTTOM,
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildWelcomeSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Hello! 👋',
//           style: TextStyle(
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//             color: Colors.grey[800],
//           ),
//         ),
//         SizedBox(height: 8),
//         Text(
//           'Ready to boost your productivity? Start a focus session to block distracting apps.',
//           style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.5),
//         ),
//       ],
//     );
//   }

//   Widget _buildQuickStartSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Quick Start',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: Colors.grey[800],
//           ),
//         ),
//         SizedBox(height: 16),
//         Wrap(
//           spacing: 12,
//           runSpacing: 12,
//           children: [
//             _SessionDurationButton(
//               duration: Duration(minutes: 25),
//               label: '25 min',
//               emoji: '⚡',
//             ),
//             _SessionDurationButton(
//               duration: Duration(minutes: 50),
//               label: '50 min',
//               emoji: '🚀',
//             ),
//             _SessionDurationButton(
//               duration: Duration(hours: 1, minutes: 30),
//               label: '90 min',
//               emoji: '🔥',
//             ),
//             _SessionDurationButton(
//               duration: Duration(hours: 2),
//               label: '2 hours',
//               emoji: '🎯',
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildStatsSection() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.blue[50],
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildStatItem(
//             'Selected',
//             '${appController.selectedCount}',
//             Icons.apps,
//           ),
//           _buildStatItem(
//             'Available',
//             '${appController.totalCount}',
//             Icons.phone_android,
//           ),
//           _buildStatItem('Blocked', '0', Icons.block),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatItem(String label, String value, IconData icon) {
//     return Column(
//       children: [
//         Icon(icon, color: Colors.blue, size: 24),
//         SizedBox(height: 8),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.blue,
//           ),
//         ),
//         SizedBox(height: 4),
//         Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
//       ],
//     );
//   }

//   Widget _buildActionsSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Actions',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: Colors.grey[800],
//           ),
//         ),
//         SizedBox(height: 16),
//         _buildActionCard(
//           icon: Icons.apps,
//           title: 'Select Apps to Block',
//           subtitle: 'Choose which apps to block during focus sessions',
//           onTap: () => Get.toNamed(Routes.appSelection),
//           color: Colors.blue,
//         ),
//         SizedBox(height: 12),
//         _buildActionCard(
//           icon: Icons.timer,
//           title: 'Custom Session',
//           subtitle: 'Set custom duration and specific apps',
//           onTap: _showCustomSessionDialog,
//           color: Colors.green,
//         ),
//         SizedBox(height: 12),
//         _buildActionCard(
//           icon: Icons.security,
//           title: 'Permission Status',
//           subtitle: 'Check and manage app permissions',
//           onTap: () {
//             permissionService.checkAllPermissions();
//             Get.snackbar(
//               'Permissions',
//               permissionService.getPermissionStatusText(),
//               snackPosition: SnackPosition.BOTTOM,
//             );
//           },
//           color: Colors.orange,
//         ),
//       ],
//     );
//   }

//   Widget _buildActionCard({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required VoidCallback onTap,
//     required Color color,
//   }) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         leading: Container(
//           width: 50,
//           height: 50,
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Icon(icon, color: color),
//         ),
//         title: Text(
//           title,
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             color: Colors.grey[800],
//           ),
//         ),
//         subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
//         trailing: Icon(
//           Icons.arrow_forward_ios,
//           size: 16,
//           color: Colors.grey[400],
//         ),
//         onTap: onTap,
//       ),
//     );
//   }

//   void _showCustomSessionDialog() {
//     Duration selectedDuration = Duration(minutes: 25);

//     showDialog(
//       context: Get.context!,
//       builder: (context) => AlertDialog(
//         title: Text('Custom Focus Session'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Select duration for your focus session:',
//               style: TextStyle(color: Colors.grey[600]),
//             ),
//             SizedBox(height: 20),
//             DropdownButtonFormField<Duration>(
//               value: selectedDuration,
//               decoration: InputDecoration(
//                 labelText: 'Session Duration',
//                 border: OutlineInputBorder(),
//                 contentPadding: EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 8,
//                 ),
//               ),
//               onChanged: (Duration? newValue) {
//                 if (newValue != null) {
//                   selectedDuration = newValue;
//                 }
//               },
//               items: [
//                 DropdownMenuItem(
//                   value: Duration(minutes: 15),
//                   child: Text('15 minutes'),
//                 ),
//                 DropdownMenuItem(
//                   value: Duration(minutes: 25),
//                   child: Text('25 minutes'),
//                 ),
//                 DropdownMenuItem(
//                   value: Duration(minutes: 45),
//                   child: Text('45 minutes'),
//                 ),
//                 DropdownMenuItem(
//                   value: Duration(minutes: 50),
//                   child: Text('50 minutes'),
//                 ),
//                 DropdownMenuItem(
//                   value: Duration(hours: 1),
//                   child: Text('1 hour'),
//                 ),
//                 DropdownMenuItem(
//                   value: Duration(hours: 1, minutes: 30),
//                   child: Text('1 hour 30 minutes'),
//                 ),
//                 DropdownMenuItem(
//                   value: Duration(hours: 2),
//                   child: Text('2 hours'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Get.back();
//               Get.toNamed(Routes.appSelection, arguments: selectedDuration);
//             },
//             child: Text('Select Apps'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               foregroundColor: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _SessionDurationButton extends StatelessWidget {
//   final Duration duration;
//   final String label;
//   final String emoji;

//   const _SessionDurationButton({
//     required this.duration,
//     required this.label,
//     required this.emoji,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final focusController = Get.find<FocusController>();
//     final appController = Get.find<AppController>();
//     final permissionService = Get.find<PermissionService>();

//     return OutlinedButton(
//       onPressed: () {
//         if (!permissionService.allPermissionsGranted.value) {
//           Get.snackbar(
//             'Permissions Required',
//             'Please grant all permissions first',
//             snackPosition: SnackPosition.BOTTOM,
//           );
//           return;
//         }

//         if (appController.selectedApps.isEmpty) {
//           Get.toNamed(Routes.appSelection, arguments: duration);
//         } else {
//           focusController.startFocusSession(
//             duration: duration,
//             blockedApps: appController.selectedApps.toList(),
//           );
//         }
//       },
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(emoji, style: TextStyle(fontSize: 16)),
//           SizedBox(width: 6),
//           Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
//         ],
//       ),
//       style: OutlinedButton.styleFrom(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         side: BorderSide(color: Colors.blue),
//       ),
//     );
//   }
// }
