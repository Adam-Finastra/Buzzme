import 'package:buzzme/widgets/button.dart';
import 'package:buzzme/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: AppColors.darkBackground,
//       body: SingleChildScrollView(
//         child: Container(
//           width: screenWidth,
//           height: screenHeight,
//           child: Stack(
//             children: [
//               // Hexagon pattern background
//               Positioned(
//                 right: -screenWidth * 0.1,
//                 bottom: screenHeight * 0.45,
//                 child: SizedBox(
//                   width: screenWidth * 1.2,
//                   child: Image.network(
//                     'assets/buzzme_login-.png',
//                     width: screenWidth * 0.9,
//                   ),
//                 ),
//               ),

//               // Main content
//               SafeArea(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(height: screenHeight * 0.08),

//                       // Logo and title
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: screenWidth * 0.12,
//                             height: screenWidth * 0.12,
//                             decoration: const BoxDecoration(
//                               color: AppColors.primaryYellow,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.hexagon,
//                               size: screenWidth * 0.08,
//                               color: AppColors.black,
//                             ),
//                           ),
//                           SizedBox(width: screenWidth * 0.03),
//                           Text(
//                             'Buzz Me....',
//                             style: GoogleFonts.poppins(
//                               color: AppColors.primaryYellow,
//                               fontSize: screenWidth * 0.08,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: screenHeight * 0.15),

//                       // Main heading
//                       Text(
//                         'MAKE THE\nFIRST MOVE',
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.poppins(
//                           color: AppColors.primaryYellow,
//                           fontSize: screenWidth * 0.09,
//                           fontWeight: FontWeight.bold,
//                           height: 1.2,
//                         ),
//                       ),

//                       SizedBox(height: screenHeight * 0.08),

//                       // Input fields
//                       CustomInputField(
//                         hintText: 'Email',
//                         width: screenWidth * 0.84,
//                         height: screenHeight * 0.065,
//                       ),

//                       SizedBox(height: screenHeight * 0.025),

//                       CustomInputField(
//                         hintText: 'Password',
//                         isPassword: true,
//                         width: screenWidth * 0.84,
//                         height: screenHeight * 0.065,
//                       ),

//                       SizedBox(height: screenHeight * 0.04),

//                       // Sign in button
//                       CustomButton(
//                         text: 'Sign in',
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const IntroScreen(),
//                             ),
//                           );
//                         },
//                         width: screenWidth * 0.84,
//                         height: screenHeight * 0.065,
//                       ),

//                       const Spacer(),

//                       // Social login buttons
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           SocialButton(
//                             icon: Icons.apple,
//                             size: screenWidth * 0.12,
//                           ),
//                           SocialButton(
//                             icon: Icons.facebook,
//                             size: screenWidth * 0.12,
//                           ),
//                           SocialButton(
//                             icon: Icons.g_mobiledata,
//                             size: screenWidth * 0.12,
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: screenHeight * 0.03),

//                       // Terms text
//                       Text(
//                         'By signing up, you agree to our teams.\nsee how we use your data in our privacy policy.',
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.poppins(
//                           color: AppColors.textGray,
//                           fontSize: screenWidth * 0.03,
//                         ),
//                       ),

//                       SizedBox(height: screenHeight * 0.03),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.network(
                  'assets/buzzme_login-.png',
                  fit: BoxFit.cover,
                ),
              ),

              // Black transparent overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),

              // Main content
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.08),

                      // Logo and title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth * 0.12,
                            height: screenWidth * 0.12,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryYellow,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.hexagon,
                              size: screenWidth * 0.08,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          Text(
                            'Buzz Me....',
                            style: GoogleFonts.poppins(
                              color: AppColors.primaryYellow,
                              fontSize: screenWidth * 0.08,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.15),

                      // Main heading
                      Text(
                        'MAKE THE\nFIRST MOVE',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: AppColors.primaryYellow,
                          fontSize: screenWidth * 0.09,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.08),

                      // Input fields
                      CustomInputField(
                        hintText: 'Email',
                        width: screenWidth * 0.84,
                        height: screenHeight * 0.065,
                      ),

                      SizedBox(height: screenHeight * 0.025),

                      CustomInputField(
                        hintText: 'Password',
                        isPassword: true,
                        width: screenWidth * 0.84,
                        height: screenHeight * 0.065,
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      // Sign in button
                      CustomButton(
                        text: 'Sign in',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const IntroScreen(),
                            ),
                          );
                        },
                        width: screenWidth * 0.84,
                        height: screenHeight * 0.065,
                      ),

                      const Spacer(),

                      // Social login buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SocialButton(
                            icon: Icons.apple,
                            size: screenWidth * 0.12,
                          ),
                          SocialButton(
                            icon: Icons.facebook,
                            size: screenWidth * 0.12,
                          ),
                          SocialButton(
                            icon: Icons.g_mobiledata,
                            size: screenWidth * 0.12,
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // Terms text
                      Text(
                        'By signing up, you agree to our teams.\nsee how we use your data in our privacy policy.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: AppColors.textGray,
                          fontSize: screenWidth * 0.03,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),
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
