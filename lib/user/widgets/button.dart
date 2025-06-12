import 'package:buzzme/user/view/onbording/preferemce_screen.dart';
import 'package:buzzme/user/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final double size;

  const SocialButton({Key? key, required this.icon, required this.size})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColors.primaryYellow,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppColors.black, size: size * 0.6),
    );
  }
}

// Hexagon Pattern Widget
class HexagonPattern extends StatelessWidget {
  final double size;

  const HexagonPattern({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: HexagonPainter()),
    );
  }
}

class HexagonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.black
      ..style = PaintingStyle.fill;

    final hexSize = size.width * 0.15;

    for (int row = 0; row < 6; row++) {
      for (int col = 0; col < 5; col++) {
        final x = col * hexSize * 1.5 + (row % 2) * hexSize * 0.75;
        final y = row * hexSize * 0.87;

        if (x < size.width && y < size.height) {
          drawHexagon(canvas, paint, Offset(x, y), hexSize * 0.5);
        }
      }
    }
  }

  void drawHexagon(Canvas canvas, Paint paint, Offset center, double radius) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60) * (3.14159 / 180);
      final x =
          center.dx +
          radius *
              0.8 *
              (i == 0
                  ? 1
                  : (i == 1 || i == 5)
                  ? 0.5
                  : (i == 2 || i == 4)
                  ? -0.5
                  : -1);
      final y =
          center.dy +
          radius *
              0.8 *
              (i < 2 || i > 4
                  ? 0
                  : i == 2 || i == 3
                  ? 0.87
                  : -0.87);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Intro Screen
class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.01),

            Text(
              'Oh Hey! Let\'s start with an intro.',
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.050,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            // First name field
            Text(
              'Your first name',
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            CustomInputField(
              hintText: '',
              width: screenWidth * 0.88,
              height: screenHeight * 0.045,
            ),

            SizedBox(height: screenHeight * 0.02),

            // Birthday section
            Text(
              'Your birthday',
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Month',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.030,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    CustomInputField(
                      hintText: '',
                      width: screenWidth * 0.25,
                      height: screenHeight * 0.040,
                    ),
                  ],
                ),
                SizedBox(width: screenWidth * 0.03),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'day',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.030,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    CustomInputField(
                      hintText: '',
                      width: screenWidth * 0.25,
                      height: screenHeight * 0.040,
                    ),
                  ],
                ),
                SizedBox(width: screenWidth * 0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'year',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.035,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    CustomInputField(
                      hintText: '',
                      width: screenWidth * 0.25,
                      height: screenHeight * 0.040,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.03),

            // Description section
            Text(
              'Description',
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.010),
            Container(
              width: screenWidth * 0.88,
              height: screenHeight * 0.20,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.black),
              ),
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(screenWidth * 0.04),
                ),
              ),
            ),

            const Spacer(),

            // Next button
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: screenWidth * 0.10,
                height: screenWidth * 0.10,
                decoration: const BoxDecoration(
                  color: AppColors.primaryYellow,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.black,
                    size: screenWidth * 0.04,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PreferencesScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.04),
          ],
        ),
      ),
    );
  }
}
