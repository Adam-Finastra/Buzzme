import 'package:buzzme/user/controller/provider.dart';
import 'package:buzzme/user/view/screens/like/liked_screen.dart';
import 'package:buzzme/user/view/screens/profile/rejeted_screen.dart';
import 'package:buzzme/user/view/screens/profile/settings_screen.dart';
import 'package:buzzme/user/view/auth/login_screen.dart';
import 'package:buzzme/user/view/screens/profile/you_liked_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:buzzme/user/widgets/custom_widgets.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  // Optimized responsive size calculator - reduced scaling
  double getResponsiveSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 375; // Base width (iPhone X)
    return baseSize *
        scaleFactor.clamp(0.7, 1.0); // Reduced scaling for smaller sizes
  }

  // Show profile image popup with edit option
  void _showProfileImagePopup(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: isTablet ? screenWidth * 0.6 : screenWidth * 0.85,
            constraints: BoxConstraints(
              maxWidth: 400,
              maxHeight: screenHeight * 0.65, // Reduced height
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14), // Reduced border radius
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Profile image
                Container(
                  width: double.infinity,
                  height:
                      screenHeight * (isTablet ? 0.25 : 0.3), // Reduced height
                  constraints: const BoxConstraints(
                    maxHeight: 250,
                  ), // Reduced max height
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/profile.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.6),
                            ],
                            stops: const [0.6, 1.0],
                          ),
                        ),
                      ),
                      // Profile info
                      Positioned(
                        bottom: 10, // Reduced padding
                        left: 12,
                        right: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Albert Flores, 26',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: getResponsiveSize(
                                  context,
                                  15,
                                ), // Reduced
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Melbourne, Australia',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: getResponsiveSize(
                                  context,
                                  12,
                                ), // Reduced
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Edit profile button
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12), // Reduced padding
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ), // Reduced
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16), // Reduced
                      ),
                      child: Center(
                        child: Text(
                          'Edit profile',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: getResponsiveSize(context, 13), // Reduced
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final horizontalPadding = isTablet ? 24.0 : 12.0; // Reduced padding

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  children: [
                    SizedBox(height: isTablet ? 12 : 10), // Reduced spacing
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Profile',
                          style: GoogleFonts.poppins(
                            fontSize: getResponsiveSize(
                              context,
                              20,
                            ), // Reduced from 24
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        Container(
                          width: getResponsiveSize(
                            context,
                            32,
                          ), // Reduced from 40
                          height: getResponsiveSize(context, 32),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.settings,
                              size: getResponsiveSize(
                                context,
                                16,
                              ), // Reduced from 20
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SettingsScreen(),
                                ),
                              );
                            },
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: isTablet ? 20 : 16), // Reduced spacing
                    // Profile image and info - Made clickable
                    GestureDetector(
                      onTap: () => _showProfileImagePopup(context),
                      child: Row(
                        children: [
                          Hero(
                            tag: 'profile_image',
                            child: Container(
                              width: getResponsiveSize(
                                context,
                                65,
                              ), // Reduced from 80
                              height: getResponsiveSize(context, 65),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2, // Reduced border width
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 6, // Reduced shadow
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: getResponsiveSize(
                                  context,
                                  50,
                                ), // Reduced
                                backgroundImage: const AssetImage(
                                  'assets/profile.png',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: isTablet ? 12 : 10,
                          ), // Reduced spacing
                          Text(
                            'Albert Flores, 26',
                            style: GoogleFonts.poppins(
                              fontSize: getResponsiveSize(
                                context,
                                16,
                              ), // Reduced from 22
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: isTablet ? 16 : 12), // Reduced spacing
                    // Premium section
                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 320),
                      padding: EdgeInsets.all(
                        getResponsiveSize(context, 14),
                      ), // Reduced from 20
                      decoration: BoxDecoration(
                        color: AppColors.primaryYellow,
                        borderRadius: BorderRadius.circular(
                          20,
                        ), // Reduced from 25
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryYellow.withOpacity(0.3),
                            blurRadius: 6, // Reduced shadow
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Premium',
                            style: GoogleFonts.poppins(
                              fontSize: getResponsiveSize(
                                context,
                                13,
                              ), // Reduced from 17
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(
                            height: getResponsiveSize(context, 5),
                          ), // Reduced
                          Text(
                            'Get the treatment, and enjoy better ways to connect \n with incredible people.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: getResponsiveSize(
                                context,
                                11,
                              ), // Reduced from 13
                              color: AppColors.black,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(
                            height: getResponsiveSize(context, 10),
                          ), // Reduced
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: getResponsiveSize(
                                context,
                                18,
                              ), // Reduced
                              vertical: getResponsiveSize(
                                context,
                                10,
                              ), // Reduced
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(
                                16,
                              ), // Reduced
                            ),
                            child: Text(
                              'Explore Premium',
                              style: GoogleFonts.poppins(
                                color: AppColors.white,
                                fontSize: getResponsiveSize(
                                  context,
                                  10,
                                ), // Reduced from 12
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: isTablet ? 20 : 16), // Reduced spacing
                    // Menu items with navigation
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: Column(
                        children: [
                          ProfileMenuItem(
                            title: 'Liked',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => YouLikedScreen(),
                                ),
                              );
                            },
                            screenWidth: screenWidth,
                          ),
                          ProfileMenuItem(
                            title: 'Rejected',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RejectedScreen(),
                                ),
                              );
                            },
                            screenWidth: screenWidth,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: isTablet ? 20 : 16), // Reduced spacing
                    // Interests section - FIXED WIDTH TO MATCH BIO
                    Container(
                      width: screenWidth * 1,
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              'Interests',
                              style: GoogleFonts.poppins(
                                fontSize: getResponsiveSize(
                                  context,
                                  13,
                                ), // Reduced from 16
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getResponsiveSize(context, 6),
                          ), // Reduced
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              'Get Specific About The Things You Love.',
                              style: GoogleFonts.poppins(
                                fontSize: getResponsiveSize(
                                  context,
                                  10,
                                ), // Reduced from 12
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getResponsiveSize(context, 12),
                          ), // Reduced
                          Container(
                            width: screenWidth * 0.90,
                            padding: EdgeInsets.all(
                              getResponsiveSize(context, 12), // Reduced from 16
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(
                                10,
                              ), // Reduced from 12
                              border: Border.all(
                                color: AppColors.textGray.withOpacity(0.3),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4, // Reduced shadow
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Wrap(
                              spacing: getResponsiveSize(
                                context,
                                4,
                              ), // Reduced spacing
                              runSpacing: getResponsiveSize(context, 4),
                              children: [
                                InterestChip(
                                  text: '🏋️ Gym',
                                  screenWidth: screenWidth,
                                ),
                                InterestChip(
                                  text: '🎵 Music',
                                  screenWidth: screenWidth,
                                ),
                                InterestChip(
                                  text: '🐶 Dog',
                                  screenWidth: screenWidth,
                                ),
                                InterestChip(
                                  text: '🐱 Cat',
                                  screenWidth: screenWidth,
                                ),
                                InterestChip(
                                  text: '🎬 movies',
                                  screenWidth: screenWidth,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: isTablet ? 20 : 16), // Reduced spacing
                    // Bio section - SAME WIDTH AS INTERESTS
                    Container(
                      width: screenWidth * 0.90,
                      constraints: const BoxConstraints(maxWidth: 3200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              'Bio',
                              style: GoogleFonts.poppins(
                                fontSize: getResponsiveSize(
                                  context,
                                  13, // SAME AS INTERESTS TITLE
                                ),
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getResponsiveSize(
                              context,
                              6,
                            ), // SAME AS INTERESTS
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(
                              getResponsiveSize(
                                context,
                                12,
                              ), // SAME AS INTERESTS
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(
                                10, // SAME AS INTERESTS
                              ),
                              border: Border.all(
                                color: AppColors.textGray.withOpacity(0.3),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4, // SAME AS INTERESTS
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Text(
                              'Loves Spontaneous Adventures And Lazy Sundays ✨\n'
                              'Fluent In Sarcasm And Kindness 😊\n'
                              'Passionate About Food, Music, And Good Conversations 🎵🍕\n'
                              'Dog Lover, Sunset Chaser, And Book Hoarder 🐕📚\n'
                              'Career-Driven But Always Makes Time For Fun 💼\n'
                              'Looking To Vibe With Someone Real And Open-Hearted ❤️',
                              style: GoogleFonts.poppins(
                                fontSize: getResponsiveSize(
                                  context,
                                  9,
                                ), // Reduced from 10
                                color: AppColors.black,
                                height: 1.4, // Reduced line height
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: isTablet ? 20 : 18), // Reduced spacing
                    // Logout button
                    // Container(
                    //   constraints: const BoxConstraints(maxWidth: 300),
                    //   child: CustomButton(
                    //     text: 'Logout',
                    //     onPressed: () {
                    //       Navigator.pushAndRemoveUntil(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => const LoginScreen(),
                    //         ),
                    //         (route) => false,
                    //       );
                    //     },
                    //     width: screenWidth * 5,
                    //     height: getResponsiveSize(
                    //       context,
                    //       32,
                    //     ), // Reduced from 38
                    //   ),
                    // ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 300),
                      width: screenWidth * 0.40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryYellow,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shadowColor: Colors.black.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: getResponsiveSize(context, 12),
                            horizontal: getResponsiveSize(context, 20),
                          ),
                          minimumSize: Size(
                            double.infinity,
                            getResponsiveSize(context, 44),
                          ),
                        ),
                        child: Text(
                          'Logout',
                          style: GoogleFonts.poppins(
                            fontSize: getResponsiveSize(context, 14),
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: isTablet ? 40 : 30,
                    ), // Reduced bottom spacing
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Edit Profile Screen - Optimized
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  // Optimized responsive size calculator
  double getResponsiveSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 375;
    return baseSize * scaleFactor.clamp(0.7, 1.0); // Reduced scaling
  }

  void _showAddPhotoOptions(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    final safeAreaTop = MediaQuery.of(context).padding.top;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    final availableHeight =
        screenHeight - safeAreaTop - safeAreaBottom - keyboardHeight;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: 240, // Reduced
              maxHeight: isTablet
                  ? math.min(280, availableHeight * 0.35) // Reduced
                  : math.min(300, availableHeight * 0.4),
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), // Reduced
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle indicator
                Container(
                  margin: EdgeInsets.only(
                    top: getResponsiveSize(context, 10),
                  ), // Reduced
                  width: getResponsiveSize(context, 32), // Reduced
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                SizedBox(height: getResponsiveSize(context, 12)), // Reduced
                // Title
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getResponsiveSize(context, 16), // Reduced
                  ),
                  child: Text(
                    'Add More Photos Or Videos',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: getResponsiveSize(
                        context,
                        13,
                      ), // Reduced from 16
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: getResponsiveSize(context, 16)), // Reduced
                // Options
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: getResponsiveSize(
                        context,
                        isTablet ? 24 : 16, // Reduced
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildOptionItem(
                          context,
                          icon: Icons.image_outlined,
                          title: 'Upload Image',
                          onTap: () {
                            Navigator.pop(context);
                            print('Upload Image selected');
                          },
                        ),

                        SizedBox(
                          height: getResponsiveSize(context, 6),
                        ), // Reduced

                        _buildOptionItem(
                          context,
                          icon: Icons.videocam_outlined,
                          title: 'Upload Video',
                          onTap: () {
                            Navigator.pop(context);
                            print('Upload Video selected');
                          },
                        ),

                        SizedBox(
                          height: getResponsiveSize(context, 6),
                        ), // Reduced

                        _buildOptionItem(
                          context,
                          icon: Icons.camera_alt_outlined,
                          title: 'Take Photo',
                          onTap: () {
                            Navigator.pop(context);
                            print('Take Photo selected');
                          },
                        ),

                        SizedBox(
                          height: getResponsiveSize(context, 12),
                        ), // Reduced
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: getResponsiveSize(context, 10), // Reduced
          vertical: getResponsiveSize(context, 10), // Reduced
        ),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8), // Reduced
          border: Border.all(color: Colors.grey[200]!, width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(getResponsiveSize(context, 5)), // Reduced
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2, // Reduced
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: getResponsiveSize(context, 14), // Reduced from 18
                color: Colors.black87,
              ),
            ),
            SizedBox(width: getResponsiveSize(context, 10)), // Reduced
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: getResponsiveSize(context, 11), // Reduced from 13
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: getResponsiveSize(context, 12), // Reduced from 14
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final horizontalPadding = isTablet ? 24.0 : 12.0; // Reduced

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getResponsiveSize(context, 12)), // Reduced
                // Header with back button
                Row(
                  children: [
                    Container(
                      width: getResponsiveSize(context, 32), // Reduced from 40
                      height: getResponsiveSize(context, 32),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFD700),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: getResponsiveSize(
                            context,
                            16,
                          ), // Reduced from 20
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: getResponsiveSize(context, 18)), // Reduced
                // Photos and Videos section
                Text(
                  'Photos And Videos',
                  style: GoogleFonts.poppins(
                    fontSize: getResponsiveSize(context, 18), // Reduced from 22
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: getResponsiveSize(context, 16)), // Reduced
                // Photo grid
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: getResponsiveSize(
                        context,
                        8,
                      ), // Reduced
                      mainAxisSpacing: getResponsiveSize(context, 8),
                      childAspectRatio: 1.0,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // Main photo
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10), // Reduced
                            image: const DecorationImage(
                              image: AssetImage('assets/profile.png'),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4, // Reduced
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 4, // Reduced
                                left: 4,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getResponsiveSize(
                                      context,
                                      6,
                                    ), // Reduced
                                    vertical: getResponsiveSize(context, 3),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(
                                      6,
                                    ), // Reduced
                                  ),
                                  child: Text(
                                    'Main',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: getResponsiveSize(
                                        context,
                                        8,
                                      ), // Reduced
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // Add photo placeholder
                        return GestureDetector(
                          onTap: () => _showAddPhotoOptions(context),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(
                                10,
                              ), // Reduced
                              border: Border.all(
                                color: Colors.grey[300]!,
                                style: BorderStyle.solid,
                                strokeAlign: BorderSide.strokeAlignInside,
                              ),
                            ),
                            child: Icon(
                              Icons.add,
                              size: getResponsiveSize(context, 20), // Reduced
                              color: Colors.grey[600],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),

                SizedBox(height: getResponsiveSize(context, 24)), // Reduced
                // Interests section
                Text(
                  'Interests',
                  style: GoogleFonts.poppins(
                    fontSize: getResponsiveSize(context, 15), // Reduced from 18
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: getResponsiveSize(context, 6)), // Reduced
                Text(
                  'Get Specific About The Things You Love.',
                  style: GoogleFonts.poppins(
                    fontSize: getResponsiveSize(context, 10), // Reduced from 12
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: getResponsiveSize(context, 12)), // Reduced

                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 500),
                  padding: EdgeInsets.all(
                    getResponsiveSize(context, 12),
                  ), // Reduced
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(10), // Reduced
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Add interest field
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: getResponsiveSize(context, 14), // Reduced
                          vertical: getResponsiveSize(context, 12), // Reduced
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6), // Reduced
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add your favorite interest',
                              style: GoogleFonts.poppins(
                                fontSize: getResponsiveSize(
                                  context,
                                  11,
                                ), // Reduced from 14
                                color: Colors.grey[600],
                              ),
                            ),
                            Icon(
                              Icons.add,
                              color: Colors.black,
                              size: getResponsiveSize(
                                context,
                                14,
                              ), // Reduced from 18
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: getResponsiveSize(context, 12),
                      ), // Reduced
                      // Interest chips
                      Wrap(
                        spacing: getResponsiveSize(context, 8), // Reduced
                        runSpacing: getResponsiveSize(context, 8),
                        children: [
                          _buildInterestChip('🏋️ Gym', context),
                          _buildInterestChip('🎵 Music', context),
                          _buildInterestChip('🐶 Dog', context),
                          _buildInterestChip('🐱 Cat', context),
                          _buildInterestChip('🎬 movies', context),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: getResponsiveSize(context, 24)), // Reduced
                // Bio section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bio',
                      style: GoogleFonts.poppins(
                        fontSize: getResponsiveSize(
                          context,
                          15,
                        ), // Reduced from 18
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Icon(
                      Icons.edit,
                      size: getResponsiveSize(context, 14), // Reduced from 18
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(height: getResponsiveSize(context, 12)), // Reduced

                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 500),
                  padding: EdgeInsets.all(
                    getResponsiveSize(context, 12),
                  ), // Reduced
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(10), // Reduced
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    'Loves Spontaneous Adventures And Lazy Sundays ⭐\nFluent In Sarcasm And Kindness 😊\nPassionate About Food, Music, And Good Conversations 🎵🍕\nDog Lover, Sunset Chaser, And Book Hoarder 🐕📚\nCareer-Driven But Always Makes Time For Fun 💼\nLooking To Vibe With Someone Real And Open-Hearted ❤️',
                    style: GoogleFonts.poppins(
                      fontSize: getResponsiveSize(
                        context,
                        10,
                      ), // Reduced from 12
                      color: Colors.black,
                      height: 1.4, // Reduced line height
                    ),
                  ),
                ),

                SizedBox(height: getResponsiveSize(context, 30)), // Reduced
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInterestChip(String text, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getResponsiveSize(context, 10), // Reduced from 12
        vertical: getResponsiveSize(context, 6), // Reduced from 8
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12), // Reduced from 16
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: getResponsiveSize(context, 10), // Reduced from 12
          color: Colors.black,
        ),
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double screenWidth;

  const ProfileMenuItem({
    Key? key,
    required this.title,
    required this.onTap,
    required this.screenWidth,
  }) : super(key: key);

  // Optimized responsive size calculator
  double getResponsiveSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 365;
    return baseSize * scaleFactor.clamp(0.7, 1.0); // Reduced scaling
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = screenWidth > 600;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(
          getResponsiveSize(context, 10),
        ), // Reduced from 12
        margin: EdgeInsets.only(
          bottom: getResponsiveSize(context, 8),
        ), // Reduced
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24), // Reduced from 30
          border: Border.all(color: AppColors.textGray.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4, // Reduced shadow
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(
                    getResponsiveSize(context, 6),
                  ), // Reduced
                ),
                // SizedBox(width: getResponsiveSize(context, 10)), // Reduced
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: getResponsiveSize(context, 10), // Reduced from 16
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: getResponsiveSize(context, 11), // Reduced from 14
              color: AppColors.textGray,
            ),
          ],
        ),
      ),
    );
  }
}

// Interest Chip Widget - Optimized
class InterestChip extends StatelessWidget {
  final String text;
  final double screenWidth;

  const InterestChip({Key? key, required this.text, required this.screenWidth})
    : super(key: key);

  // Optimized responsive size calculator
  double getResponsiveSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 400;
    return baseSize * scaleFactor.clamp(0.7, 1.0); // Reduced scaling
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getResponsiveSize(context, 15), // Reduced from 12
        vertical: getResponsiveSize(context, 8), // Reduced from 10
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12), // Reduced from 16
        border: Border.all(color: AppColors.textGray.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: getResponsiveSize(context, 10), // Reduced from 12
          color: AppColors.black,
        ),
      ),
    );
  }
}
