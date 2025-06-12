// lib/view/screens/rejected_screen.dart
import 'package:buzzme/user/controller/provider.dart';
import 'package:buzzme/user/view/screens/home/homescreen.dart';
import 'package:buzzme/user/view/screens/like/liked_screen.dart';
import 'package:buzzme/user/view/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:buzzme/user/widgets/custom_widgets.dart';

class RejectedScreen extends StatelessWidget {
  const RejectedScreen({Key? key}) : super(key: key);

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
              // Hexagon background
              Positioned(
                left: -screenWidth * 0.1,
                child: HexagonBackground(
                  size: screenWidth * 1,
                  assetPath: 'assets/light__login-.png',
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
                            onPressed: () => Navigator.pop(context),
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
                          'Rejected',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          'Check out people who you rejected',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.04,
                            color: AppColors.textGray,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Rejected profiles grid
                  Expanded(
                    child: Consumer<AppProvider>(
                      builder: (context, provider, child) {
                        if (provider.rejectedProfiles.isEmpty) {
                          provider.initializeDemoData();
                          if (provider.rejectedProfiles.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.05),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'No rejected profiles yet',
                                      style: GoogleFonts.poppins(
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Text(
                                      'Try rejecting some profiles on the home screen!',
                                      style: GoogleFonts.poppins(
                                        fontSize: screenWidth * 0.04,
                                        color: AppColors.textGray,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: screenHeight * 0.03),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
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
                              itemCount: provider.rejectedProfiles.length,
                              itemBuilder: (context, index) {
                                final profile =
                                    provider.rejectedProfiles[index];
                                return RejectedProfileCard(profile: profile);
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

class RejectedProfileCard extends StatelessWidget {
  final Profile profile;

  const RejectedProfileCard({Key? key, required this.profile})
    : super(key: key);

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
              Image.network(
                profile.imageUrl,
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
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[300],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                            : null,
                        color: AppColors.primaryYellow,
                      ),
                    ),
                  );
                },
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

              // Cross icon indicator
            ],
          ),
        ),
      ),
    );
  }
}
