import 'package:buzzme/user/controller/provider.dart';
import 'package:buzzme/user/view/screens/profile/you_liked_screen.dart';
import 'package:buzzme/user/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BuzzMeScreen extends StatefulWidget {
  const BuzzMeScreen({Key? key}) : super(key: key);

  @override
  State<BuzzMeScreen> createState() => _BuzzMeScreenState();
}

class _BuzzMeScreenState extends State<BuzzMeScreen> {
  int _currentProfileIndex = 0;

  // Updated demo profiles list with working URLs
  final List<Profile> _profiles = [
    Profile(
      id: '1',
      name: 'Emma',
      age: 26,
      location: 'Melbourne, Australia',
      imageUrl: 'assets/img1.jpg',
      interests: ['Photography', 'Coffee', 'Travel'],
    ),
    Profile(
      id: '2',
      name: 'Sarah',
      age: 28,
      location: 'New York, USA',
      imageUrl: 'assets/img2.jpg',
      interests: ['Reading', 'Hiking', 'Yoga'],
    ),
    Profile(
      id: '3',
      name: 'Devika',
      age: 30,
      location: 'Los Angeles, USA',
      imageUrl: 'assets/img3.jpg',
      interests: ['Gaming', 'Coding', 'Music'],
    ),
    Profile(
      id: '4',
      name: 'Jessica',
      age: 25,
      location: 'London, UK',
      imageUrl: 'assets/img4.png',
      interests: ['Art', 'Dancing', 'Cooking'],
    ),
    Profile(
      id: '5',
      name: 'Miya',
      age: 29,
      location: 'Toronto, Canada',
      imageUrl: 'assets/img17.png',
      interests: ['Sports', 'Travel', 'Music'],
    ),
    Profile(
      id: '6',
      name: 'Alexa',
      age: 26,
      location: 'Berlin, Germany',
      imageUrl: 'assets/img6.png',
      interests: ['Tech', 'Cycling', 'Beer'],
    ),
  ];

  // Responsive helper function
  double getResponsiveSize(BuildContext context, double size) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final isLargeScreen = screenWidth > 900;

    if (isLargeScreen) {
      return size * 1.2;
    } else if (isTablet) {
      return size * 1.1;
    } else {
      return size;
    }
  }

  void _handleSwipe(bool isLike) {
    if (_profiles.isEmpty) return;

    final currentProfile = _profiles[_currentProfileIndex % _profiles.length];
    final provider = Provider.of<AppProvider>(context, listen: false);

    if (isLike) {
      provider.addLikedProfile(currentProfile);
      print('Liked: ${currentProfile.name}');
    } else {
      provider.addRejectedProfile(currentProfile);
      print('Rejected: ${currentProfile.name}');
    }

    setState(() {
      _currentProfileIndex++;
    });
  }

  void _navigateToLikedProfiles() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => YouLikedScreen()),
    );
  }

  Widget _buildInterestChip(String text, double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenWidth * 0.015,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.textGray.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: screenWidth * 0.03,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isTablet = screenWidth > 600;
    final isLargeScreen = screenWidth > 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            // Top header with logo and liked profiles button
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: getResponsiveSize(context, screenWidth * 0.05),
                vertical: getResponsiveSize(context, screenHeight * 0.035),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Buzz Me....',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFFD700),
                      fontSize: getResponsiveSize(context, screenWidth * 0.08),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Main content - Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Profile card with reduced height
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: getResponsiveSize(
                          context,
                          screenWidth * 0.05,
                        ),
                      ),
                      height: screenHeight * 0.64, // Reduced height
                      child: ProfileCard(
                        profile:
                            _profiles[_currentProfileIndex % _profiles.length],
                        onLike: () => _handleSwipe(true),
                        onReject: () => _handleSwipe(false),
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                    ),

                    SizedBox(
                      height: getResponsiveSize(context, screenHeight * 0.02),
                    ),

                    // Action buttons
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getResponsiveSize(
                          context,
                          screenWidth * 0.05,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Reject button
                          SizedBox(
                            width: getResponsiveSize(
                              context,
                              screenWidth * 0.22,
                            ),
                            child: GestureDetector(
                              onTap: () => _handleSwipe(false),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: getResponsiveSize(
                                    context,
                                    screenHeight * 0.004,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 1.2,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_back,
                                      color: Colors.red,
                                      size: getResponsiveSize(
                                        context,
                                        screenWidth * 0.055,
                                      ),
                                    ),
                                    SizedBox(
                                      width: getResponsiveSize(
                                        context,
                                        screenWidth * 0.01,
                                      ),
                                    ),
                                    Text(
                                      'Reject',
                                      style: GoogleFonts.poppins(
                                        color: Colors.red,
                                        fontSize: getResponsiveSize(
                                          context,
                                          screenWidth * 0.035,
                                        ),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: getResponsiveSize(
                              context,
                              screenWidth * 0.4,
                            ),
                          ),

                          // Like button
                          SizedBox(
                            width: getResponsiveSize(
                              context,
                              screenWidth * 0.25,
                            ),
                            child: GestureDetector(
                              onTap: () => _handleSwipe(true),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: getResponsiveSize(
                                    context,
                                    screenHeight * 0.004,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: Colors.amber,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Like',
                                      style: GoogleFonts.poppins(
                                        color: Colors.amber,
                                        fontSize: getResponsiveSize(
                                          context,
                                          screenWidth * 0.035,
                                        ),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      width: getResponsiveSize(
                                        context,
                                        screenWidth * 0.02,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.amber,
                                      size: getResponsiveSize(
                                        context,
                                        screenWidth * 0.055,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: getResponsiveSize(context, screenHeight * 0.02),
                    ),

                    // Enhanced About me section
                    Container(
                      width: isLargeScreen
                          ? screenWidth * 0.7
                          : screenWidth * 0.9,
                      margin: EdgeInsets.symmetric(
                        horizontal: getResponsiveSize(
                          context,
                          screenWidth * 0.05,
                        ),
                      ),
                      padding: EdgeInsets.all(
                        getResponsiveSize(context, screenWidth * 0.04),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                              fontSize: getResponsiveSize(
                                context,
                                screenWidth * 0.04,
                              ),
                              fontWeight: FontWeight.normal,
                              color: const Color.fromARGB(255, 99, 96, 96),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),

                          // Interests Section
                          Text(
                            'Interests',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.03,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            'Get Specific About The Things You Love.',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.03,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),

                          // Interest chips
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _buildInterestChip('🏋️ Gym', screenWidth),
                              _buildInterestChip('🎵 Music', screenWidth),
                              _buildInterestChip('🐶 Dog', screenWidth),
                              _buildInterestChip('🐱 Cat', screenWidth),
                              _buildInterestChip('🎬 Movies', screenWidth),
                            ],
                          ),

                          SizedBox(height: screenHeight * 0.02),

                          // Bio Section
                          Text(
                            'Bio',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(screenWidth * 0.04),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              'Loves Spontaneous Adventures And Lazy Sundays ✨\n'
                              'Fluent In Sarcasm And Kindness 😊\n'
                              'Passionate About Food, Music, And Good Conversations 🎵🍕\n'
                              'Dog Lover, Sunset Chaser, And Book Hoarder 🐕📚\n'
                              'Career-Driven But Always Makes Time For Fun 💼\n'
                              'Looking To Vibe With Someone Real And Open-Hearted ❤️',
                              style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.032,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getResponsiveSize(context, screenHeight * 0.02),
                    ),
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

class ProfileCard extends StatefulWidget {
  final Profile profile;
  final VoidCallback? onLike;
  final VoidCallback? onReject;
  final double screenWidth;
  final double screenHeight;

  const ProfileCard({
    Key? key,
    required this.profile,
    this.onLike,
    this.onReject,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double getResponsiveSize(double size) {
    final isTablet = widget.screenWidth > 600;
    final isLargeScreen = widget.screenWidth > 900;

    if (isLargeScreen) {
      return size * 1.2;
    } else if (isTablet) {
      return size * 1.1;
    } else {
      return size;
    }
  }

  void _handlePanEnd(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond.dx;

    if (velocity > 500) {
      // Swipe right - Like
      widget.onLike?.call();
    } else if (velocity < -500) {
      // Swipe left - Reject
      widget.onReject?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: _handlePanEnd,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
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
                  widget.profile.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print('Image error: $error');
                    return Container(
                      color: Colors.grey[300],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.grey[600],
                            size: getResponsiveSize(80),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Image not available',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: getResponsiveSize(16),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  // loadingBuilder: (context, child, loadingProgress) {
                  //   if (loadingProgress == null) return child;
                  //   return Container(
                  //     color: Colors.grey[200],
                  //     child: Center(
                  //       child: CircularProgressIndicator(
                  //         value: loadingProgress.expectedTotalBytes != null
                  //             ? loadingProgress.cumulativeBytesLoaded /
                  //                   loadingProgress.expectedTotalBytes!
                  //             : null,
                  //         color: const Color(0xFFFFD700),
                  //       ),
                  //     ),
                  //   );
                  // },
                ),
              ),

              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                    stops: const [0.5, 1.0],
                  ),
                ),
              ),

              // Profile info
              Positioned(
                bottom: getResponsiveSize(widget.screenHeight * 0.0),
                left: getResponsiveSize(widget.screenWidth * 0.05),
                right: getResponsiveSize(widget.screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${widget.profile.name}, ${widget.profile.age}',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: getResponsiveSize(widget.screenWidth * 0.06),
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: getResponsiveSize(widget.screenHeight * 0.005),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.profile.location,
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: getResponsiveSize(
                                widget.screenWidth * 0.035,
                              ),
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    if (widget.profile.interests.isNotEmpty) ...[
                      SizedBox(
                        height: getResponsiveSize(widget.screenHeight * 0.01),
                      ),
                      Wrap(
                        spacing: 8,
                        children: widget.profile.interests.take(3).map((
                          interest,
                        ) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: getResponsiveSize(12),
                              vertical: getResponsiveSize(4),
                            ),
                            // decoration: BoxDecoration(
                            //   color: Colors.black.withOpacity(0.3),
                            //   borderRadius: BorderRadius.circular(15),
                            // ),
                            // child: Text(
                            //   interest,
                            //   style: GoogleFonts.poppins(
                            //     color: Colors.white,
                            //     fontSize: getResponsiveSize(
                            //       widget.screenWidth * 0.03,
                            //     ),
                            //     fontWeight: FontWeight.w400,
                            //   ),
                            // ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),

              // Star icon
              Positioned(
                top: getResponsiveSize(widget.screenHeight * 0.54),
                right: getResponsiveSize(widget.screenWidth * 0.05),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/shape-removebg-preview.png',
                      width: getResponsiveSize(widget.screenWidth * 0.13),
                    ),
                    Icon(
                      Icons.star,
                      size: getResponsiveSize(widget.screenWidth * 0.1),
                      color: Colors.white,
                    ),
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

class Profile {
  final String id;
  final String name;
  final int age;
  final String location;
  final String imageUrl;
  final List<String> interests;
  final String? bio;

  Profile({
    required this.id,
    required this.name,
    required this.age,
    required this.location,
    required this.imageUrl,
    this.interests = const [],
    this.bio,
  });
}
