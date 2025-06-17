import 'dart:math';

import 'package:buzzme/user/controller/provider.dart';
import 'package:buzzme/user/view/screens/home/homescreen.dart';
import 'package:buzzme/user/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class YouLikedScreen extends StatelessWidget {
  YouLikedScreen({super.key});

  double getResponsiveSize(BuildContext context, double size) {
    final screenWidth = MediaQuery.of(context).size.width;
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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    // final isTablet = screenWidth > 600; // Moved this inside the builder where it's used

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Consumer<AppProvider>(
          builder: (context, provider, child) {
            final likedProfiles = provider.likedProfiles;
            final bool isTablet = screenWidth > 600; // Redefine here

            return Stack(
              children: [
                // Hexagon background
                Positioned(
                  left: -screenWidth * 0.1, // Adjust position as needed
                  top: -screenHeight * 0.2, // Adjust position as needed
                  child: HexagonBackground(
                    size: screenWidth * 1.5, // Adjust size as needed
                    assetPath:
                        'assets/light__login-.png', // Your background image asset
                  ),
                ),
                Column(
                  children: [
                    // Header section
                    Container(
                      padding: EdgeInsets.all(
                        getResponsiveSize(context, screenWidth * 0.05),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: getResponsiveSize(
                              context,
                              screenWidth * 0.12,
                            ),
                            height: getResponsiveSize(
                              context,
                              screenWidth * 0.12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryYellow,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: getResponsiveSize(
                                  context,
                                  screenWidth * 0.06,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: Colors.black,
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Title and subtitle section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: getResponsiveSize(
                          context,
                          screenWidth * 0.05,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You liked',
                            style: GoogleFonts.poppins(
                              fontSize: getResponsiveSize(
                                context,
                                screenWidth * 0.04,
                              ),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: getResponsiveSize(
                              context,
                              screenHeight * 0.01,
                            ),
                          ),
                          Text(
                            'Check out people who you liked (${likedProfiles.length})',
                            style: GoogleFonts.poppins(
                              fontSize: getResponsiveSize(
                                context,
                                screenWidth * 0.04,
                              ),
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: getResponsiveSize(context, screenHeight * 0.03),
                    ),

                    // Grid of liked profiles
                    Expanded(
                      child: likedProfiles.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'No liked profiles yet',
                                    style: GoogleFonts.poppins(
                                      fontSize: getResponsiveSize(context, 10),
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(
                                    height: getResponsiveSize(context, 4),
                                  ),
                                  Text(
                                    'Start swiping to see your matches here!',
                                    style: GoogleFonts.poppins(
                                      fontSize: getResponsiveSize(context, 8),
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getResponsiveSize(
                                  context,
                                  screenWidth * 0.05,
                                ),
                                vertical: getResponsiveSize(
                                  context,
                                  screenHeight * 0.01,
                                ),
                              ),
                              child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: isTablet
                                          ? 3
                                          : 2, // 'isTablet' is now accessible here
                                      crossAxisSpacing: getResponsiveSize(
                                        context,
                                        screenWidth * 0.03,
                                      ),
                                      mainAxisSpacing: getResponsiveSize(
                                        context,
                                        screenWidth * 0.03,
                                      ),
                                      childAspectRatio: 0.75,
                                    ),
                                itemCount: likedProfiles.length,
                                itemBuilder: (context, index) {
                                  final profile = likedProfiles[index];
                                  return LikedProfileCard(
                                    profile: profile,
                                    screenWidth: screenWidth,
                                    onRemove: () {
                                      provider.removeLikedProfile(profile.id);
                                    },
                                  );
                                },
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class LikedProfileCard extends StatefulWidget {
  final Profile profile;
  final double screenWidth;
  final VoidCallback? onRemove;

  const LikedProfileCard({
    super.key,
    required this.profile,
    required this.screenWidth,
    this.onRemove,
  });

  @override
  State<LikedProfileCard> createState() => _LikedProfileCardState();
}

class _LikedProfileCardState extends State<LikedProfileCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onLongPress: () {
        // Show remove option on long press
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Remove ${widget.profile.name}?'),
            content: Text(
              'Are you sure you want to remove this profile from your liked list?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  widget.onRemove?.call();
                },
                child: const Text(
                  'Remove',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.screenWidth * 0.05),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.screenWidth * 0.05),
                child: Stack(
                  children: [
                    // Profile image
                    Image.asset(
                      widget.profile.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(
                              widget.screenWidth * 0.05,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.broken_image_outlined,
                                size: widget.screenWidth * 0.08,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Image unavailable',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: widget.screenWidth * 0.03,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
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
                      bottom: 8,
                      left: 8,
                      right: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${widget.profile.name}, ${widget.profile.age}',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: widget.screenWidth * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.profile.location,
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: widget.screenWidth * 0.025,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
