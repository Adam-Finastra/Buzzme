import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

class AppColors {
  static const Color darkBackground = Color(0xFF1A1A1A);
  static const Color primaryYellow = Color(0xFFFFD700); // Example yellow
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color lightGray = Color(0xFFE0E0E0);
  static const Color selectedBorder = Colors.blue;

  static const Color lightBackground = Color(
    0xFFF5F5F5,
  ); // Light gray background
  static const Color textGray = Colors.grey;
  static const Color cardBackground = Color(
    0xFFF0F0F0,
  ); // A slightly different light gray
}

// Custom Input Field Widget
class CustomInputField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final double width;
  final double height;
  final TextEditingController? controller;

  const CustomInputField({
    Key? key,
    required this.hintText,
    this.isPassword = false,
    required this.width,
    required this.height,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: AppColors.textGray,
            fontSize: MediaQuery.of(context).size.width * 0.04,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.02,
          ),
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.black, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.black, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }
}

// Custom Button Widget
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double width;
  final double height;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryYellow,
    this.textColor = AppColors.black,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: MediaQuery.of(context).size.width * 0.040,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class HexagonBackground extends StatelessWidget {
  final double size;
  final String assetPath;

  const HexagonBackground({
    Key? key,
    required this.size,
    required this.assetPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(assetPath),
            fit: BoxFit.contain, // Keeps transparent edges visible
          ),
        ),
      ),
    );
  }
}
