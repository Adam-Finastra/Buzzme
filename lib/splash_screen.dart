// lib/view/screens/splash_screen.dart
import 'dart:async';
import 'package:buzzme/user/view/auth/login_screen.dart';
import 'package:buzzme/user/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
// Import your AppColors

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start a timer for 4 seconds
    Timer(const Duration(seconds: 5), () {
      // Navigate to the LoginScreen after the duration
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ), // Replace with your actual LoginScreen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the background color to a dark color from your theme
      backgroundColor:
          AppColors.white, // Using a dark background from AppColors
      body: Center(
        child: Image.asset(
          'assets/splash_buzzme-removebg-preview (1).png', // Your asset image path

          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.3,
        ),
      ),
    );
  }
}
