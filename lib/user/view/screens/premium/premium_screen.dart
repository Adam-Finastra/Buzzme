import 'package:buzzme/user/controller/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:buzzme/user/widgets/custom_widgets.dart'; // Assuming AppColors, HexagonBackground, CustomButton are here
import 'package:provider/provider.dart'; // Required for context.read<AppProvider>()

//Premium Screen - Converted to StatefulWidget
class PremiumScreen extends StatefulWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  int _selectedCardIndex =
      1; // Default to the "MOST POPULAR" card (index 1 for 6 months)

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Base font size for better responsiveness
    final double baseFontSize = screenWidth * 0.04;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Stack(
          children: [
            // New: Your background image
            Positioned(
              left: -screenWidth * 0.25,
              bottom: screenHeight * 0.08,
              child: SizedBox(
                width: screenWidth * 1.5,
                height: screenHeight * 1,
                child: Image.asset(
                  // Use Image.asset for local assets
                  'assets/light__login-.png',
                  // You can add fit, alignment if needed
                  // fit: BoxFit.cover,
                  // alignment: Alignment.centerLeft,
                ),
              ),
            ),

            // The main content of the screen (your SingleChildScrollView with Column)
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.05),

                  // Title
                  Text(
                    'Get buzz diamond',
                    style: GoogleFonts.poppins(
                      fontSize: baseFontSize * 2, // Adjusted font size
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.05),

                  // Star icon
                  Container(
                    width: screenWidth * 0.2,
                    height: screenWidth * 0.2,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryYellow,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.star,
                      color: AppColors.white,
                      size: screenWidth * 0.1,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  Text(
                    'Unlimited stars',
                    style: GoogleFonts.poppins(
                      fontSize: baseFontSize * 1.5, // Adjusted font size
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.01),

                  Text(
                    'Send as many stars as you want.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: baseFontSize, // Adjusted font size
                      color: AppColors.textGray,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.05),

                  // Pricing options - horizontally scrollable
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                    ),
                    child: Row(
                      children: [
                        PricingCard(
                          months: '12',
                          price: '\$12.50/MO',
                          savings: 'SAVE 50%',
                          finalPrice: '\$6.25',
                          isPopular: false,
                          screenWidth: screenWidth,
                          isSelected: _selectedCardIndex == 0,
                          onTap: () {
                            setState(() {
                              _selectedCardIndex = 0;
                            });
                          },
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        PricingCard(
                          months: '6',
                          price: '\$12.50/MO',
                          savings: 'SAVE 50%',
                          finalPrice: '\$6.25',
                          isPopular: true,
                          screenWidth: screenWidth,
                          isSelected: _selectedCardIndex == 1,
                          onTap: () {
                            setState(() {
                              _selectedCardIndex = 1;
                            });
                          },
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        PricingCard(
                          months: '1',
                          price: '\$12.50/MO',
                          savings: 'SAVE 50%',
                          finalPrice: '\$6.25',
                          isPopular: false,
                          screenWidth: screenWidth,
                          isSelected: _selectedCardIndex == 2,
                          onTap: () {
                            setState(() {
                              _selectedCardIndex = 2;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.05),

                  // Continue button
                  CustomButton(
                    text: 'CONTINUE',
                    onPressed: () {
                      print(
                        'Continue button pressed with selected card index: $_selectedCardIndex',
                      );
                      // Implement your payment logic here based on _selectedCardIndex
                    },
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.07,
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // No thanks button
                  TextButton(
                    onPressed: () =>
                        context.read<AppProvider>().setCurrentIndex(0),
                    child: Text(
                      'NO THANKS',
                      style: GoogleFonts.poppins(
                        fontSize: baseFontSize, // Adjusted font size
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Pricing Card Widget (Modified for selection)
class PricingCard extends StatelessWidget {
  final String months;
  final String price;
  final String savings;
  final String finalPrice;
  final bool isPopular;
  final double screenWidth;
  final bool isSelected; // New property
  final VoidCallback onTap; // New property

  const PricingCard({
    Key? key,
    required this.months,
    required this.price,
    required this.savings,
    required this.finalPrice,
    required this.isPopular,
    required this.screenWidth,
    required this.isSelected, // Initialize new property
    required this.onTap, // Initialize new property
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Base font size for pricing card
    final double baseCardFontSize = screenWidth * 0.035;

    return GestureDetector(
      onTap: onTap, // Add GestureDetector for tap detection
      child: Container(
        width: screenWidth * 0.28,
        padding: EdgeInsets.all(screenWidth * 0.03),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color:
                isSelected // Use isSelected for border color
                ? AppColors
                      .selectedBorder // Example selected color
                : (isPopular
                      ? AppColors.primaryYellow
                      : AppColors.textGray.withOpacity(0.3)),
            width: isSelected
                ? 3
                : (isPopular ? 2 : 1), // Thicker border when selected
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isPopular) ...[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenWidth * 0.01,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryYellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'MOST POPULAR',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.025,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ),
              SizedBox(height: screenWidth * 0.02),
            ],
            Text(
              months,
              style: GoogleFonts.poppins(
                fontSize: baseCardFontSize * 2, // Adjusted font size
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            Text(
              'MONTHS',
              style: GoogleFonts.poppins(
                fontSize: baseCardFontSize * 0.8, // Adjusted font size
                color: AppColors.black,
              ),
            ),
            SizedBox(height: screenWidth * 0.02),
            Text(
              price,
              style: GoogleFonts.poppins(
                fontSize: baseCardFontSize * 0.8, // Adjusted font size
                color: AppColors.textGray,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            Text(
              savings,
              style: GoogleFonts.poppins(
                fontSize: baseCardFontSize * 0.8, // Adjusted font size
                fontWeight: FontWeight.bold,
                color: AppColors.primaryYellow,
              ),
            ),
            Text(
              finalPrice,
              style: GoogleFonts.poppins(
                fontSize: baseCardFontSize * 1.2, // Adjusted font size
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            if (isSelected) // Show a checkmark when selected
              Padding(
                padding: EdgeInsets.only(top: screenWidth * 0.01),
                child: const Icon(
                  Icons.check_circle,
                  color: AppColors.selectedBorder,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Interest Chip Widget (No changes needed here as it's not directly part of the PremiumScreen interaction)
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
