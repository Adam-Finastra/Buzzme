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
    // Using iPhone 12 Pro height as baseline for smaller bottom bar
    final screenHeight = MediaQuery.of(context).size.height;
    const double baseScreenHeight = 844.0; // iPhone 12 Pro height
    double scaleFactor = screenHeight / baseScreenHeight;
    const double minScaleFactor =
        0.75; // Reduced from 0.85 to make bottom bar smaller
    const double maxScaleFactor = 0.95; // Added max scale to prevent oversizing

    if (scaleFactor < minScaleFactor) {
      scaleFactor = minScaleFactor;
    } else if (scaleFactor > maxScaleFactor) {
      scaleFactor = maxScaleFactor;
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
      height: 50 * scaleFactor, // Reduced from 60 to 50
      margin: EdgeInsets.only(
        left: 16 * scaleFactor, // Reduced from 20 to 16
        right: 16 * scaleFactor, // Reduced from 20 to 16
        bottom: 12 * scaleFactor, // Reduced from 18 to 12
      ),
      decoration: BoxDecoration(
        color: AppColors.black, // Changed to AppColors.black for consistency
        borderRadius: BorderRadius.circular(
          25 * scaleFactor, // Reduced from 30 to 25
        ), // Scale border radius
        boxShadow: [
          BoxShadow(
            color: AppColors.white.withOpacity(0.1), // Using AppColors.white
            blurRadius: 12 * scaleFactor, // Reduced from 15 to 12
            offset: Offset(0, 3 * scaleFactor), // Reduced from 4 to 3
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
    final double itemSize = 40 * scaleFactor; // Reduced from 50 to 40
    final double iconSize = 20 * scaleFactor; // Reduced from 24 to 20

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
                    blurRadius: 6 * scaleFactor, // Reduced from 8 to 6
                    offset: Offset(
                      0,
                      1.5 * scaleFactor,
                    ), // Reduced from 2 to 1.5
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Image.asset(
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
