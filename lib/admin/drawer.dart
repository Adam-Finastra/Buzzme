//  import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// Widget buildBeautifulDrawer() {
//     return Drawer(
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       backgroundColor: const Color(0xFF1E293B),
//       child: Column(
//         children: [
//           // Admin Header
//           Container(
//             padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Color(0xFFFACC15), // Bright yellow
//                   Color(0xFFFDE047), // Soft lemon
//                   Color(0xFFFCD34D), // Golden yellow
//                 ],
//               ),
//               borderRadius: BorderRadius.only(topRight: Radius.circular(30)),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.15),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.white24),
//                   ),
//                   child: const Icon(
//                     Icons.admin_panel_settings,
//                     color: Colors.white,
//                     size: 26,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Admin Panel',
//                         style: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 22,
//                           fontWeight: FontWeight.w700,
//                           shadows: [
//                             Shadow(
//                               blurRadius: 6,
//                               color: Colors.black.withOpacity(0.2),
//                               offset: const Offset(1, 2),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Text(
//                         'Super Administrator',
//                         style: GoogleFonts.poppins(
//                           color: Colors.white.withOpacity(0.85),
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Stats Section
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF334155),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 8,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   buildStatItem(
//                     'Total Users',
//                     '${_users.length}',
//                     Icons.people,
//                     const Color(0xFF06B6D4),
//                   ),
//                   const SizedBox(height: 12),
//                   buildStatItem(
//                     'Active Users',
//                     '${_users.where((u) => u.status == 'Active').length}',
//                     Icons.check_circle,
//                     const Color(0xFF10B981),
//                   ),
//                   const SizedBox(height: 12),
//                   buildStatItem(
//                     'Blocked Users',
//                     '${_users.where((u) => u.status == 'Blocked').length}',
//                     Icons.block,
//                     const Color(0xFFEF4444),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Drawer Navigation Items
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               children: [
//                 buildDrawerItem(Icons.dashboard, 'Dashboard', 0),
//                 buildDrawerItem(Icons.people, 'Users Management', 1),
//                 buildDrawerItem(Icons.settings, 'Settings', 2),
//                 const Divider(
//                   color: Color(0xFF334155),
//                   thickness: 1,
//                   height: 30,
//                 ),
//                 buildDrawerItem(Icons.logout, 'Logout', -1, isLogout: true),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }


//   Widget buildStatItem(String title, String value, IconData icon, Color color) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.2),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(icon, color: color, size: 16),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 value,
//                 style: GoogleFonts.poppins(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 title,
//                 style: GoogleFonts.poppins(
//                   color: const Color(0xFF94A3B8),
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildDrawerItem(
//     IconData icon,
//     String title,
//     int index, {
//     bool isLogout = false,
//   }) {
//     final isSelected = _selectedIndex == index && !isLogout;

//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 4),
//       child: ListTile(
//         leading: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: isSelected
//                 ? Colors.white.withOpacity(0.1)
//                 : isLogout
//                 ? const Color(0xFFEF4444).withOpacity(0.2)
//                 : Colors.transparent,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(
//             icon,
//             color: isSelected
//                 ? Colors
//                       .white // White icon for selected
//                 : isLogout
//                 ? const Color(0xFFEF4444)
//                 : const Color(0xFF94A3B8),
//             size: 20,
//           ),
//         ),
//         title: Text(
//           title,
//           style: GoogleFonts.poppins(
//             color: isSelected
//                 ? Colors
//                       .white // White text for selected
//                 : isLogout
//                 ? const Color(0xFFEF4444)
//                 : const Color(0xFF94A3B8),
//             fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//             fontSize: 14,
//           ),
//         ),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         tileColor: isSelected ? const Color(0xFF334155) : null,
//         onTap: () {
//           if (isLogout) {
//             showLogoutDialog();
//           } else {
//             setState(() {
//               _selectedIndex = index;
//             });
//             Navigator.pop(context);
//           }
//         },
//       ),
//     );
//   }