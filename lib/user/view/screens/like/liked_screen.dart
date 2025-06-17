import 'package:buzzme/user/controller/provider.dart';
import 'package:buzzme/user/view/screens/home/homescreen.dart';
import 'package:buzzme/user/view/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:buzzme/user/widgets/custom_widgets.dart';

class LikedScreen extends StatelessWidget {
  const LikedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final safePadding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: SizedBox(
          height: screenHeight - safePadding.top - safePadding.bottom,
          child: Stack(
            children: [
              // Hexagon background (existing)
              // Positioned(
              //   top: -screenHeight * 0.05,
              //   left: -screenWidth * 0.1,
              //   child:   HexagonBackground(
              //     size: 150,
              //     assetPath: 'assets/buzzme_login-.png',
              //   ),
              // ),

              // NEW: Background image for LikedScreen
              Positioned(
                left: -screenWidth * 0.25,
                bottom: screenHeight * 0.08,
                child: SizedBox(
                  width: screenWidth * 1.5,
                  height: screenHeight * 1,
                  child: Image.asset(
                    // Use Image.asset for local assets
                    'assets/light__login-.png',
                    fit: BoxFit.contain, // Adjust fit as needed
                    alignment:
                        Alignment.centerLeft, // Adjust alignment as needed
                  ),
                ),
              ),
              Column(
                children: [
                  // Header
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth * 0.12,
                          height: screenWidth * 0.12,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryYellow,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.black,
                              size: screenWidth * 0.06,
                            ),
                            onPressed: () =>
                                context.read<AppProvider>().setCurrentIndex(0),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Title and subtitle
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Liked you',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          'Check out people who you like',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.03,
                            color: AppColors.textGray,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Liked profiles grid
                  Expanded(
                    child: Consumer<AppProvider>(
                      builder: (context, provider, child) {
                        if (provider.likedProfiles.isEmpty) {
                          provider.initializeDemoData();
                          if (provider.likedProfiles.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.05),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite_border,
                                      size: screenWidth * 0.15,
                                      color: AppColors.textGray,
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    Text(
                                      'No liked profiles yet',
                                      style: GoogleFonts.poppins(
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Text(
                                      'Try liking some profiles on the home screen!',
                                      style: GoogleFonts.poppins(
                                        fontSize: screenWidth * 0.04,
                                        color: AppColors.textGray,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: screenHeight * 0.03),
                                    ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<AppProvider>()
                                            .setCurrentIndex(0);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.primaryYellow,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.08,
                                          vertical: screenHeight * 0.015,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Go to Home',
                                        style: GoogleFonts.poppins(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        }

                        return LayoutBuilder(
                          builder: (context, constraints) {
                            // Calculate cross axis count based on screen width
                            int crossAxisCount = screenWidth > 600 ? 3 : 2;
                            double childAspectRatio = screenWidth > 600
                                ? 0.7
                                : 0.75;

                            return GridView.builder(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05,
                                vertical: screenHeight * 0.01,
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    childAspectRatio: childAspectRatio,
                                    crossAxisSpacing: screenWidth * 0.03,
                                    mainAxisSpacing: screenWidth * 0.03,
                                  ),
                              itemCount: provider.likedProfiles.length,
                              itemBuilder: (context, index) {
                                final profile = provider.likedProfiles[index];
                                return LikedProfileCard(profile: profile);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LikedProfileCard extends StatelessWidget {
  final Profile profile;

  const LikedProfileCard({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileDetailScreen(profile: profile),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Profile image
              Image.asset(
                profile
                    .imageUrl, // Use the actual profile image URL instead of random
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.textGray.withOpacity(0.2),
                    child: Center(
                      child: Icon(
                        Icons.broken_image,
                        color: AppColors.textGray,
                        size: screenWidth * 0.08,
                      ),
                    ),
                  );
                },
                // loadingBuilder: (context, child, loadingProgress) {
                //   if (loadingProgress == null) return child;
                //   return Container(
                //     color: Colors.grey[300],
                //     child: Center(
                //       child: CircularProgressIndicator(
                //         value: loadingProgress.expectedTotalBytes != null
                //             ? loadingProgress.cumulativeBytesLoaded /
                //                   loadingProgress.expectedTotalBytes!
                //             : null,
                //         color: AppColors.primaryYellow,
                //       ),
                //     ),
                //   );
                // },
              ),

              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),

              // Profile info
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${profile.name}, ${profile.age}',
                        style: GoogleFonts.poppins(
                          color: AppColors.white,
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: screenHeight * 0.002),
                      Text(
                        profile.location,
                        style: GoogleFonts.poppins(
                          color: AppColors.white,
                          fontSize: screenWidth * 0.03,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),

              // Heart icon indicator
              Positioned(
                top: screenWidth * 0.02,
                right: screenWidth * 0.02,
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.015),
                  // Assuming there was a heart icon here previously,
                  // it's commented out in your provided code
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Interest Chip Widget (No changes needed here)
class InterestChip extends StatelessWidget {
  final String text;
  final double screenWidth;

  const InterestChip({Key? key, required this.text, required this.screenWidth})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenWidth * 0.02,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.textGray.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: screenWidth * 0.035,
          color: AppColors.black,
        ),
      ),
    );
  }
}

// Profile Detail Screen
class ProfileDetailScreen extends StatelessWidget {
  final Profile profile;

  const ProfileDetailScreen({Key? key, required this.profile})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final safePadding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: SizedBox(
          height: screenHeight - safePadding.top - safePadding.bottom,
          child: Stack(
            children: [
              // Hexagon background (existing)
              Positioned(
                left: -screenWidth * 0.25,
                bottom: screenHeight * 0.08,
                child: SizedBox(
                  width: screenWidth * 1.5,
                  height: screenHeight * 1,
                  child: Image.asset(
                    // Use Image.asset for local assets
                    'assets/light__login-.png',
                    fit: BoxFit.contain, // Adjust fit as needed
                    alignment:
                        Alignment.centerLeft, // Adjust alignment as needed
                  ),
                ),
              ),

              // NEW: Background image for ProfileDetailScreen
              SingleChildScrollView(
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      child: Row(
                        children: [
                          Container(
                            width: screenWidth * 0.12,
                            height: screenWidth * 0.12,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryYellow,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.black,
                                size: screenWidth * 0.06,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Profile image
                    Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.55,
                      margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            // Background image
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Image.asset(
                                profile
                                    .imageUrl, // Use the actual profile image URL
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.textGray.withOpacity(0.2),
                                    child: Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        color: AppColors.textGray,
                                        size: screenWidth * 0.15,
                                      ),
                                    ),
                                  );
                                },
                                // loadingBuilder:
                                //     (context, child, loadingProgress) {
                                //       if (loadingProgress == null) return child;
                                //       return Container(
                                //         color: Colors.grey[300],
                                //         child: Center(
                                //           child: CircularProgressIndicator(
                                //             value:
                                //                 loadingProgress
                                //                         .expectedTotalBytes !=
                                //                     null
                                //                 ? loadingProgress
                                //                           .cumulativeBytesLoaded /
                                //                       loadingProgress
                                //                           .expectedTotalBytes!
                                //                 : null,
                                //             color: AppColors.primaryYellow,
                                //           ),
                                //         ),
                                //       );
                                //   },
                              ),
                            ),

                            // Gradient overlay
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.8),
                                  ],
                                  stops: const [0.6, 1.0],
                                ),
                              ),
                            ),

                            // Profile info (name, age, location)
                            Positioned(
                              bottom: screenHeight * 0.05,
                              left: screenWidth * 0.05,
                              right: screenWidth * 0.05,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${profile.name}, ${profile.age}',
                                    style: GoogleFonts.poppins(
                                      color: AppColors.white,
                                      fontSize: screenWidth * 0.07,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    profile.location,
                                    style: GoogleFonts.poppins(
                                      color: AppColors.white,
                                      fontSize: screenWidth * 0.04,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // Interests section
                    Container(
                      width: screenWidth * 0.9,
                      margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                      ),
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Interests',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          profile.interests.isNotEmpty
                              ? Wrap(
                                  spacing: screenWidth * 0.02,
                                  runSpacing: screenHeight * 0.01,
                                  children: profile.interests
                                      .map(
                                        (interest) => InterestChip(
                                          text: interest,
                                          screenWidth: screenWidth,
                                        ),
                                      )
                                      .toList(),
                                )
                              : Wrap(
                                  spacing: screenWidth * 0.02,
                                  runSpacing: screenHeight * 0.01,
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
                                  ],
                                ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // Bio section
                    Container(
                      width: screenWidth * 0.9,
                      margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                      ),
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About Me',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Text(
                            'Loves spontaneous adventures and lazy Sundays. Fluent in sarcasm and kindness. Always up for trying new coffee shops and exploring hidden gems in the city.',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.035,
                              color: AppColors.textGray,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
