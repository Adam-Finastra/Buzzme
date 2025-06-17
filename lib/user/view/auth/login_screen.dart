import 'package:buzzme/admin/bottombar.dart';
import 'package:buzzme/user/view/screens/bottombar.dart';
import 'package:buzzme/user/widgets/button.dart';
import 'package:buzzme/user/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback? onPressed;

  const SocialButton({
    Key? key,
    required this.icon,
    required this.size,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.primaryYellow,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black, size: size * 0.6),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;
    final isLargeScreen = screenWidth > 400;

    // Responsive padding and sizing
    final horizontalPadding = screenWidth * 0.08;
    final logoSize = isSmallScreen ? screenWidth * 0.10 : screenWidth * 0.12;
    final titleFontSize = isSmallScreen
        ? screenWidth * 0.07
        : screenWidth * 0.08;
    final headingFontSize = isSmallScreen
        ? screenWidth * 0.08
        : screenWidth * 0.09;
    final inputWidth = screenWidth * 0.84;
    final inputHeight = isSmallScreen
        ? screenHeight * 0.055
        : screenHeight * 0.065;
    final socialButtonSize = isSmallScreen
        ? screenWidth * 0.11
        : screenWidth * 0.12;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  screenHeight -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Stack(
              children: [
                // Background Image
                Positioned(
                  left: -screenWidth * 0.20,
                  bottom: isSmallScreen
                      ? screenHeight * 0.02
                      : screenHeight * 0.25,
                  child: SizedBox(
                    width: screenWidth * 1.5,
                    height: screenHeight * 0.8,
                    child: Image.asset(
                      'assets/buzzme_login-.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // Black Transparent Overlay
                Positioned.fill(
                  child: Container(color: Colors.black.withOpacity(0.6)),
                ),

                // Main Content
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Top spacing
                      SizedBox(
                        height: isSmallScreen
                            ? screenHeight * 0.02
                            : screenHeight * 0.06,
                      ),

                      // Logo and Title Section
                      _buildLogoSection(
                        screenWidth: screenWidth,
                        logoSize: logoSize,
                        titleFontSize: titleFontSize,
                      ),

                      SizedBox(
                        height: isSmallScreen
                            ? screenHeight * 0.1
                            : screenHeight * 0.1,
                      ),

                      // Main Heading
                      _buildMainHeading(
                        screenWidth: screenWidth,
                        headingFontSize: headingFontSize,
                      ),

                      SizedBox(
                        height: isSmallScreen
                            ? screenHeight * 0.08
                            : screenHeight * 0.06,
                      ),

                      // Input Fields Section
                      _buildInputFields(
                        screenHeight: screenHeight,
                        inputWidth: inputWidth,
                        inputHeight: inputHeight,
                        isSmallScreen: isSmallScreen,
                      ),

                      SizedBox(
                        height: isSmallScreen
                            ? screenHeight * 0.01
                            : screenHeight * 0.01,
                      ),

                      // Sign In Button
                      _buildSignInButton(
                        inputWidth: inputWidth,
                        inputHeight: inputHeight * 0.8,
                      ),

                      SizedBox(
                        height: isSmallScreen
                            ? screenHeight * 0.15
                            : screenHeight * 0.15,
                      ),

                      // Social Login Buttons
                      _buildSocialButtons(socialButtonSize: socialButtonSize),

                      SizedBox(
                        height: isSmallScreen
                            ? screenHeight * 0.02
                            : screenHeight * 0.03,
                      ),

                      // Terms and Privacy Policy
                      _buildTermsText(
                        screenWidth: screenWidth,
                        isSmallScreen: isSmallScreen,
                      ),

                      // Bottom spacing
                      SizedBox(
                        height: isSmallScreen
                            ? screenHeight * 0.02
                            : screenHeight * 0.03,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection({
    required double screenWidth,
    required double logoSize,
    required double titleFontSize,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: logoSize,
          height: logoSize,
          decoration: const BoxDecoration(
            color: Color(0xFFFFC107),
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/splash_buzzme-removebg-preview (1).png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(width: screenWidth * 0.03),
        Flexible(
          child: Text(
            'Buzz Me....',
            style: GoogleFonts.poppins(
              color: const Color(0xFFFFC107),
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildMainHeading({
    required double screenWidth,
    required double headingFontSize,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        'MAKE THE\nFIRST MOVE',
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          color: const Color(0xFFFFC107),
          fontSize: headingFontSize,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildInputFields({
    required double screenHeight,
    required double inputWidth,
    required double inputHeight,
    required bool isSmallScreen,
  }) {
    final spacing = isSmallScreen ? screenHeight * 0.01 : screenHeight * 0.01;

    return Column(
      children: [
        CustomInputField(
          controller: _emailController,
          hintText: 'Email',
          width: inputWidth,
          height: inputHeight,
        ),
        SizedBox(height: spacing),
        CustomInputField(
          controller: _passwordController,
          hintText: 'Password',
          isPassword: true,
          width: inputWidth,
          height: inputHeight,
        ),
      ],
    );
  }

  Widget _buildSignInButton({
    required double inputWidth,
    required double inputHeight,
  }) {
    return CustomButton(
      text: 'Sign in',
      onPressed: () {
        final email = _emailController.text.trim();
        final password = _passwordController.text.trim();

        if (email == 'admin' && password == 'admin123') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdminDashboard()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const IntroScreen()),
          );
        }
      },
      width: inputWidth,
      height: inputHeight,
    );
  }

  Widget _buildSocialButtons({required double socialButtonSize}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SocialButton(
          icon: Icons.apple,
          size: socialButtonSize,
          onPressed: () {
            // Handle Apple login
          },
        ),
        SocialButton(
          icon: Icons.facebook,
          size: socialButtonSize,
          onPressed: () {
            // Handle Facebook login
          },
        ),
        SocialButton(
          icon: Icons.g_mobiledata,
          size: socialButtonSize,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BottomBarScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTermsText({
    required double screenWidth,
    required bool isSmallScreen,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Text(
        'By signing up, you agree to our terms.\nSee how we use your data in our privacy policy.',
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          color: Colors.grey.shade400,
          fontSize: isSmallScreen ? screenWidth * 0.028 : screenWidth * 0.03,
          height: 1.3,
        ),
      ),
    );
  }
}
