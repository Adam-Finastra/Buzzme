// lib/view/screens/bottom_screen.dart
import 'package:buzzme/user/controller/provider.dart';
import 'package:buzzme/user/view/screens/chat/chat_screen.dart';
import 'package:buzzme/user/view/screens/home/homescreen.dart';
import 'package:buzzme/user/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// // Import your screens
import 'package:buzzme/user/view/screens/like/liked_screen.dart';
import 'package:buzzme/user/view/screens/premium/premium_screen.dart';
import 'package:buzzme/user/view/screens/profile/profile_screen.dart';

// class BottomBarScreen extends StatefulWidget {
//   final int? selectedIndex;

//   const BottomBarScreen({Key? key, this.selectedIndex = 0}) : super(key: key);

//   @override
//   State<BottomBarScreen> createState() => _BottomBarScreenState();
// }

// class _BottomBarScreenState extends State<BottomBarScreen> {
//   int _currentIndex = 0;

//   // List of screens to display
//   final List<Widget> screens = [
//     BuzzMeScreen(),
//     const LikedScreen(),
//     const PremiumScreen(),
//     const ChatsScreen(),
//     const ProfileScreen(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.selectedIndex ?? 0;
//   }

//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: _currentIndex == 0,
//       onPopInvokedWithResult: (didPop, result) {
//         if (!didPop && _currentIndex != 0) {
//           setState(() {
//             _currentIndex = 0;
//           });
//         }
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: screens[_currentIndex],
//         bottomNavigationBar: _buildCustomBottomBar(),
//       ),
//     );
//   }

//   Widget _buildCustomBottomBar() {
//     return Container(
//       height: 60,
//       margin: const EdgeInsets.only(left: 20, right: 20, bottom: 18),
//       decoration: BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.circular(30),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.white.withOpacity(0.1),
//             blurRadius: 15,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildNavItem(0, Icons.menu),
//           _buildNavItem(1, Icons.favorite),
//           _buildNavItem(2, Icons.diamond),
//           _buildNavItem(3, Icons.chat),
//           _buildNavItem(4, Icons.person),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(int index, IconData icon) {
//     final bool isSelected = _currentIndex == index;

//     return GestureDetector(
//       onTap: () => _onTabTapped(index),
//       child: Container(
//         width: 50,
//         height: 50,
//         decoration: BoxDecoration(
//           color: isSelected ? AppColors.primaryYellow : Colors.transparent,
//           shape: BoxShape.circle,
//           boxShadow: isSelected
//               ? [
//                   BoxShadow(
//                     color: AppColors.primaryYellow.withOpacity(0.3),
//                     blurRadius: 8,
//                     offset: const Offset(0, 2),
//                   ),
//                 ]
//               : null,
//         ),
//         child: Center(
//           child: Icon(
//             icon,
//             size: 24,
//             color: isSelected ? AppColors.black : AppColors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }

class BottomBarScreen extends StatefulWidget {
  final int? selectedIndex;

  const BottomBarScreen({Key? key, this.selectedIndex = 0}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _currentIndex = 0;

  // List of screens to display
  final List<Widget> screens = [
    BuzzMeScreen(),
    const LikedScreen(),
    const PremiumScreen(),
    const ChatsScreen(),
    const ProfileScreen(),
  ];

  // Define your image paths for selected and unselected states
  // Make sure these paths match your actual asset structure
  final List<String> _selectedIconPaths = [
    'assets/buzz logo.png', // Assuming you have a menu icon
    'assets/love-removebg-preview.png',
    'assets/premium-removebg-preview.png',
    'assets/chat-removebg-preview.png',
    'assets/Frame_217-removebg-preview.png',
  ];

  final List<String> _unselectedIconPaths = [
    'assets/buzz logo.png',
    'assets/love-removebg-preview.png',
    'assets/premium-removebg-preview.png',
    'assets/chat-removebg-preview.png',
    'assets/Frame_217-removebg-preview.png',
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex ?? 0;
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // --- Responsive Scaling Factor Calculation ---
    // Using screenHeight for scale factor as bottom bar is vertically constrained
    final screenHeight = MediaQuery.of(context).size.height;
    const double baseScreenHeight = 812.0; // iPhone 11 height, good baseline
    double scaleFactor = screenHeight / baseScreenHeight;
    const double minScaleFactor =
        0.85; // Prevent bottom bar from becoming too small
    if (scaleFactor < minScaleFactor) {
      scaleFactor = minScaleFactor;
    }
    // --- End Responsive Scaling Factor Calculation ---

    return PopScope(
      canPop: _currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: screens[_currentIndex],
        bottomNavigationBar: _buildCustomBottomBar(
          scaleFactor,
        ), // Pass scaleFactor
      ),
    );
  }

  Widget _buildCustomBottomBar(double scaleFactor) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 60 * scaleFactor, // Scale height
      margin: EdgeInsets.only(
        left: 20 * scaleFactor, // Scale margin
        right: 20 * scaleFactor, // Scale margin
        bottom: 18 * scaleFactor, // Scale margin
      ),
      decoration: BoxDecoration(
        color: AppColors.black, // Changed to AppColors.black for consistency
        borderRadius: BorderRadius.circular(
          30 * scaleFactor,
        ), // Scale border radius
        boxShadow: [
          BoxShadow(
            color: AppColors.white.withOpacity(0.1), // Using AppColors.white
            blurRadius: 15 * scaleFactor, // Scale blur radius
            offset: Offset(0, 4 * scaleFactor), // Scale offset
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          _selectedIconPaths.length,
          (index) => _buildNavItem(
            index,
            _selectedIconPaths[index],
            _unselectedIconPaths[index],
            scaleFactor,
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    String selectedImagePath,
    String unselectedImagePath,
    double scaleFactor,
  ) {
    final bool isSelected = _currentIndex == index;
    final double itemSize = 50 * scaleFactor; // Scale item size
    final double iconSize = 24 * scaleFactor; // Scale icon size

    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Container(
        width: itemSize,
        height: itemSize,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryYellow : Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryYellow.withOpacity(0.3),
                    blurRadius: 8 * scaleFactor, // Scale blur radius
                    offset: Offset(0, 2 * scaleFactor), // Scale offset
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Image.network(
            isSelected ? selectedImagePath : unselectedImagePath,
            width: iconSize, // Set scaled width for the image
            height: iconSize, // Set scaled height for the image
            color: isSelected
                ? AppColors.black
                : AppColors
                      .white, // Apply color if needed, or remove if images are already colored
          ),
        ),
      ),
    );
  }
}
