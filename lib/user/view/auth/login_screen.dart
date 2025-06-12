import 'package:buzzme/admin/bottombar.dart';
import 'package:buzzme/user/view/screens/bottombar.dart';
import 'package:buzzme/user/widgets/button.dart';
import 'package:buzzme/user/widgets/custom_widgets.dart'; // Assuming CustomInputField and SocialButton are defined here
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback? onPressed; // Add this

  const SocialButton({
    Key? key,
    required this.icon,
    required this.size,
    this.onPressed, // Initialize it
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Use InkWell or GestureDetector for tap
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.black, size: size * 0.6),
      ),
    );
  }
}

// --- Placeholder for your AdminBottomBar (replace with your actual code) ---

// --- Your modified LoginScreen ---
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

    return Scaffold(
      // Set background color for Scaffold to match the overall dark theme
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SizedBox(
          width: screenWidth,
          // Set height to screenHeight to ensure the background covers the whole screen
          // even if content is less than screen height, allowing scroll if content overflows.
          height: screenHeight,
          child: Stack(
            children: [
              // --- Background Image ---
              Positioned(
                left: -screenWidth * 0.25,
                bottom: screenHeight * 0.08,
                child: SizedBox(
                  width: screenWidth * 1.5,
                  height: screenHeight * 1,
                  child: Image.network(
                    'assets/buzzme_login-.png',
                    width: screenWidth * 0.9,
                  ),
                ),
              ),

              // --- Black Transparent Overlay ---
              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.6)),
              ),

              // --- Main Content ---
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Use min to wrap content
                    children: [
                      SizedBox(height: screenHeight * 0.06),

                      // --- Logo and Title ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth * 0.12,
                            height: screenWidth * 0.12,
                            decoration: const BoxDecoration(
                              color: Color(
                                0xFFFFC107,
                              ), // AppColors.primaryYellow
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/splash_buzzme-removebg-preview (1).png', // Ensure this asset path is correct
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          // Use Flexible to allow text to shrink if necessary
                          Flexible(
                            child: Text(
                              'Buzz Me....',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFFFC107),
                                fontSize:
                                    screenWidth *
                                    0.08, // Font size scales with screen width
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow
                                  .ellipsis, // Prevents overflow with "..."
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.08),

                      // --- Main Heading ---
                      Text(
                        'MAKE THE\nFIRST MOVE',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFFC107),
                          fontSize:
                              screenWidth *
                              0.09, // Font size scales with screen width
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.06),

                      // --- Input Fields ---
                      CustomInputField(
                        controller: _emailController, // Assign controller
                        hintText: 'Email',
                        width:
                            screenWidth *
                            0.84, // Width scales with screen width
                        height:
                            screenHeight *
                            0.065, // Height scales with screen height
                      ),

                      SizedBox(height: screenHeight * 0.025),

                      CustomInputField(
                        controller: _passwordController, // Assign controller
                        hintText: 'Password',
                        isPassword: true,
                        width:
                            screenWidth *
                            0.84, // Width scales with screen width
                        height:
                            screenHeight *
                            0.065, // Height scales with screen height
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      // --- Sign In Button ---
                      CustomButton(
                        text: 'Sign in',
                        onPressed: () {
                          // Authentication Logic
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();

                          if (email == 'admin' && password == 'admin123') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AdminBottomBar(),
                              ),
                            );
                          } else {
                            // Optionally, show a SnackBar for incorrect credentials
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //     content: Text('Invalid email or password.'),
                            //     backgroundColor: Colors.red,
                            //   ),
                            // );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BottomBarScreen(),
                              ),
                            );
                          }
                        },
                        width:
                            screenWidth *
                            0.84, // Width scales with screen width
                        height:
                            screenHeight *
                            0.065, // Height scales with screen height
                      ),

                      SizedBox(height: screenHeight * 0.06),

                      // --- Social Login Buttons ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SocialButton(
                            icon: Icons.apple,
                            size:
                                screenWidth *
                                0.12, // Size scales with screen width
                          ),
                          SocialButton(
                            icon: Icons.facebook,
                            size:
                                screenWidth *
                                0.12, // Size scales with screen width
                          ),
                          SocialButton(
                            icon: Icons
                                .g_mobiledata, // Using g_mobiledata as requested, or Icons.google
                            size:
                                screenWidth *
                                0.12, // Size scales with screen width
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BottomBarScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // --- Terms and Privacy Policy ---
                      Text(
                        'By signing up, you agree to our terms.\nSee how we use your data in our privacy policy.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade400,
                          fontSize:
                              screenWidth *
                              0.03, // Font size scales with screen width
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03), // Final spacing
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
