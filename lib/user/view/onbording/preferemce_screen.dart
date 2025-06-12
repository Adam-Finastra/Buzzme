import 'package:buzzme/user/view/screens/bottombar.dart';
import 'package:buzzme/user/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  bool isBasicSelected = true;
  double ageRangeStart = 18;
  double ageRangeEnd = 35;
  double distanceRange = 100;
  bool expandAge = true;
  bool expandDistance = true;
  bool verifiedOnly = true;
  List<String> selectedRelationshipGoals = [];

  // Helper to get a scaling factor for text and icons
  double _getTextAndIconScaleFactor(double screenWidth) {
    if (screenWidth < 360) {
      // Very small phones
      return 0.85;
    } else if (screenWidth < 400) {
      // Smaller phones
      return 0.9;
    }
    return 1.0; // Default for larger phones/tablets
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final scaleFactor = _getTextAndIconScaleFactor(screenWidth);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        // Keep for safety, but aim to remove scroll if possible
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Row(
                  children: [
                    ToggleButton(
                      text: 'Basic',
                      isSelected: isBasicSelected,
                      onTap: () => setState(() => isBasicSelected = true),
                      width:
                          screenWidth *
                          0.22 *
                          scaleFactor, // Scale button width
                      height:
                          screenHeight *
                          0.04 *
                          scaleFactor, // Scale button height
                      textScaleFactor:
                          scaleFactor, // Pass scale factor to ToggleButton
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    ToggleButton(
                      text: 'Advanced',
                      isSelected: !isBasicSelected,
                      onTap: () => setState(() => isBasicSelected = false),
                      width:
                          screenWidth *
                          0.27 *
                          scaleFactor, // Scale button width
                      height:
                          screenHeight *
                          0.04 *
                          scaleFactor, // Scale button height
                      textScaleFactor:
                          scaleFactor, // Pass scale factor to ToggleButton
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              if (isBasicSelected) ...[
                PreferenceSection(
                  title: 'Who you want to date',
                  textScaleFactor: scaleFactor,
                  child: PreferenceItem(
                    text: 'Women',
                    hasArrow: true,
                    screenWidth: screenWidth,
                    textScaleFactor: scaleFactor, // Pass scale factor
                  ),
                ),

                PreferenceSection(
                  title: 'How old are they?',
                  textScaleFactor: scaleFactor,
                  child: AgeRangeWidget(
                    start: ageRangeStart,
                    end: ageRangeEnd,
                    expandAge: expandAge,
                    onStartChanged: (value) =>
                        setState(() => ageRangeStart = value),
                    onEndChanged: (value) =>
                        setState(() => ageRangeEnd = value),
                    onExpandChanged: (value) =>
                        setState(() => expandAge = value),
                    screenWidth: screenWidth,
                    textScaleFactor: scaleFactor, // Pass scale factor
                  ),
                ),

                PreferenceSection(
                  title: 'How far away are they?',
                  textScaleFactor: scaleFactor,
                  child: DistanceRangeWidget(
                    distance: distanceRange,
                    expandDistance: expandDistance,
                    onDistanceChanged: (value) =>
                        setState(() => distanceRange = value),
                    onExpandChanged: (value) =>
                        setState(() => expandDistance = value),
                    screenWidth: screenWidth,
                    textScaleFactor: scaleFactor, // Pass scale factor
                  ),
                ),

                PreferenceSection(
                  title: 'Have they verified themselves?',
                  textScaleFactor: scaleFactor,
                  child: VerifiedOnlyWidget(
                    isEnabled: verifiedOnly,
                    onChanged: (value) => setState(() => verifiedOnly = value),
                    screenWidth: screenWidth,
                    textScaleFactor: scaleFactor, // Pass scale factor
                  ),
                ),
              ] else ...[
                // Advanced preferences - compact layout
                FilterOptionWidget(
                  title: 'What\'s your family plan?',
                  icon: Icons.family_restroom,
                  screenWidth: screenWidth,
                  textScaleFactor: scaleFactor, // Pass scale factor
                ),

                FilterOptionWidget(
                  title: 'Do they have kids?',
                  icon: Icons.child_care,
                  screenWidth: screenWidth,
                  textScaleFactor: scaleFactor, // Pass scale factor
                ),

                FilterOptionWidget(
                  title: 'What\'s their education level?',
                  icon: Icons.school,
                  screenWidth: screenWidth,
                  textScaleFactor: scaleFactor, // Pass scale factor
                ),

                FilterOptionWidget(
                  title: 'Do they exercise?',
                  icon: Icons.fitness_center,
                  screenWidth: screenWidth,
                  textScaleFactor: scaleFactor, // Pass scale factor
                ),

                FilterOptionWidget(
                  title: 'What\'s their religion?',
                  icon: Icons.church,
                  screenWidth: screenWidth,
                  textScaleFactor: scaleFactor, // Pass scale factor
                ),

                SizedBox(
                  height: screenHeight * 0.015 * scaleFactor,
                ), // Scale vertical spacing
                // Relationship goals section with compact layout
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What are you looking for?',
                      style: GoogleFonts.poppins(
                        fontSize:
                            screenWidth *
                            0.035 *
                            scaleFactor, // Scale font size
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01 * scaleFactor,
                    ), // Scale vertical spacing

                    Container(
                      width: screenWidth * 0.88,
                      padding: EdgeInsets.all(
                        screenWidth * 0.03 * scaleFactor,
                      ), // Scale padding
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.black),
                      ),
                      child: Column(
                        children: [
                          RelationshipGoalItem(
                            text: 'A long term relationship',
                            isSelected: selectedRelationshipGoals.contains(
                              'long_term',
                            ),
                            onChanged: (selected) {
                              setState(() {
                                if (selected) {
                                  selectedRelationshipGoals.add('long_term');
                                } else {
                                  selectedRelationshipGoals.remove('long_term');
                                }
                              });
                            },
                            screenWidth: screenWidth,
                            textScaleFactor: scaleFactor, // Pass scale factor
                          ),

                          Divider(
                            color: AppColors.black.withOpacity(0.3),
                            height:
                                screenHeight *
                                0.02 *
                                scaleFactor, // Scale divider height
                          ),

                          RelationshipGoalItem(
                            text: 'Marriage',
                            isSelected: selectedRelationshipGoals.contains(
                              'marriage',
                            ),
                            onChanged: (selected) {
                              setState(() {
                                if (selected) {
                                  selectedRelationshipGoals.add('marriage');
                                } else {
                                  selectedRelationshipGoals.remove('marriage');
                                }
                              });
                            },
                            screenWidth: screenWidth,
                            textScaleFactor: scaleFactor, // Pass scale factor
                          ),

                          Divider(
                            color: AppColors.black.withOpacity(0.3),
                            height:
                                screenHeight *
                                0.02 *
                                scaleFactor, // Scale divider height
                          ),

                          RelationshipGoalItem(
                            text: 'Fun, casual dating',
                            isSelected: selectedRelationshipGoals.contains(
                              'casual',
                            ),
                            onChanged: (selected) {
                              setState(() {
                                if (selected) {
                                  selectedRelationshipGoals.add('casual');
                                } else {
                                  selectedRelationshipGoals.remove('casual');
                                }
                              });
                            },
                            screenWidth: screenWidth,
                            textScaleFactor: scaleFactor, // Pass scale factor
                          ),

                          Divider(
                            color: AppColors.black.withOpacity(0.3),
                            height:
                                screenHeight *
                                0.02 *
                                scaleFactor, // Scale divider height
                          ),

                          RelationshipGoalItem(
                            text: 'A life partner',
                            isSelected: selectedRelationshipGoals.contains(
                              'life_partner',
                            ),
                            onChanged: (selected) {
                              setState(() {
                                if (selected) {
                                  selectedRelationshipGoals.add('life_partner');
                                } else {
                                  selectedRelationshipGoals.remove(
                                    'life_partner',
                                  );
                                }
                              });
                            },
                            screenWidth: screenWidth,
                            textScaleFactor: scaleFactor, // Pass scale factor
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: screenHeight * 0.03 * scaleFactor,
                ), // Scale vertical spacing
                // Next button
                CustomButton(
                  text: 'Next',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomBarScreen(),
                      ),
                    );
                  },
                  width: screenWidth * 0.58,
                  height:
                      screenHeight * 0.055 * scaleFactor, // Scale button height
                  textScaleFactor: scaleFactor, // Pass scale factor
                ),
              ],

              SizedBox(
                height: screenHeight * 0.05 * scaleFactor,
              ), // Scale bottom padding
            ],
          ),
        ),
      ),
    );
  }
}

// --- Optimized Custom Widgets ---

class ToggleButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final double width;
  final double height;
  final double textScaleFactor; // New property

  const ToggleButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.width,
    required this.height,
    this.textScaleFactor = 1.0, // Default to 1.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryYellow : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryYellow : AppColors.black,
          ),
        ),
        child: Center(
          child: FittedBox(
            // Use FittedBox for text
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: isSelected ? AppColors.black : AppColors.black,
                fontSize:
                    MediaQuery.of(context).size.width *
                    0.03 *
                    textScaleFactor, // Apply scale factor
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PreferenceSection extends StatelessWidget {
  final String title;
  final Widget child;
  final double textScaleFactor; // New property

  const PreferenceSection({
    Key? key,
    required this.title,
    required this.child,
    this.textScaleFactor = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize:
                screenWidth * 0.035 * textScaleFactor, // Apply scale factor
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.01 * textScaleFactor,
        ), // Scale vertical spacing
        child,
        SizedBox(
          height: screenHeight * 0.02 * textScaleFactor,
        ), // Scale vertical spacing
      ],
    );
  }
}

class PreferenceItem extends StatelessWidget {
  final String text;
  final bool hasArrow;
  final double screenWidth;
  final double textScaleFactor; // New property

  const PreferenceItem({
    Key? key,
    required this.text,
    this.hasArrow = false,
    required this.screenWidth,
    this.textScaleFactor = 1.0, // Default to 1.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.88,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03 * textScaleFactor, // Scale padding
        vertical: screenWidth * 0.03 * textScaleFactor, // Scale padding
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            // Use Expanded to prevent text overflow
            child: FittedBox(
              // Use FittedBox for text
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize:
                      screenWidth *
                      0.035 *
                      textScaleFactor, // Apply scale factor
                  color: AppColors.black,
                ),
              ),
            ),
          ),
          if (hasArrow)
            Icon(
              Icons.arrow_forward_ios,
              size: screenWidth * 0.035 * textScaleFactor, // Scale icon size
              color: AppColors.black,
            ),
        ],
      ),
    );
  }
}

class AgeRangeWidget extends StatelessWidget {
  final double start;
  final double end;
  final bool expandAge;
  final Function(double) onStartChanged;
  final Function(double) onEndChanged;
  final Function(bool) onExpandChanged;
  final double screenWidth;
  final double textScaleFactor; // New property

  const AgeRangeWidget({
    Key? key,
    required this.start,
    required this.end,
    required this.expandAge,
    required this.onStartChanged,
    required this.onEndChanged,
    required this.onExpandChanged,
    required this.screenWidth,
    this.textScaleFactor = 1.0, // Default to 1.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.88,
      padding: EdgeInsets.all(
        screenWidth * 0.03 * textScaleFactor,
      ), // Scale padding
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Between ${start.round()} and ${end.round()}',
            style: GoogleFonts.poppins(
              fontSize:
                  screenWidth * 0.035 * textScaleFactor, // Apply scale factor
              color: AppColors.black,
            ),
          ),
          SizedBox(
            height: screenWidth * 0.02 * textScaleFactor,
          ), // Scale vertical spacing
          SliderTheme(
            // Reduced all slider component sizes
            data: SliderTheme.of(context).copyWith(
              trackHeight: 1.5 * textScaleFactor, // Reduced from 2.0 to 1.5
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius:
                    6.0 *
                    textScaleFactor, // Reduced from 3.0 to 6.0 (this is actually the diameter, so it's smaller)
              ),
              overlayShape: RoundSliderOverlayShape(
                overlayRadius:
                    8.0 * textScaleFactor, // Reduced from 10.0 to 8.0
              ),
              // Additional properties to make slider more compact
              rangeThumbShape: RoundRangeSliderThumbShape(
                enabledThumbRadius:
                    6.0 *
                    textScaleFactor, // Reduced thumb size for range slider
              ),
              valueIndicatorShape:
                  PaddleSliderValueIndicatorShape(), // Smaller value indicator
              valueIndicatorTextStyle: TextStyle(
                fontSize:
                    10.0 * textScaleFactor, // Smaller text in value indicator
              ),
            ),
            child: Transform.scale(
              scale: 0.8, // Overall scale reduction of the entire slider
              child: RangeSlider(
                values: RangeValues(start, end),
                min: 18,
                max: 60,
                activeColor: AppColors.black,
                inactiveColor: AppColors.lightGray,
                onChanged: (values) {
                  onStartChanged(values.start);
                  onEndChanged(values.end);
                },
              ),
            ),
          ),
          SwitchListTile(
            title: Text(
              'See people 2 years either side if I run out',
              style: GoogleFonts.poppins(
                fontSize:
                    screenWidth * 0.03 * textScaleFactor, // Apply scale factor
                color: AppColors.black,
              ),
            ),
            value: expandAge,
            onChanged: onExpandChanged,
            activeColor: AppColors.textGray,
            contentPadding: EdgeInsets.zero,
            dense: true, // Makes the tile more compact
          ),
        ],
      ),
    );
  }
}

class DistanceRangeWidget extends StatelessWidget {
  final double distance;
  final bool expandDistance;
  final Function(double) onDistanceChanged;
  final Function(bool) onExpandChanged;
  final double screenWidth;
  final double textScaleFactor; // New property

  const DistanceRangeWidget({
    Key? key,
    required this.distance,
    required this.expandDistance,
    required this.onDistanceChanged,
    required this.onExpandChanged,
    required this.screenWidth,
    this.textScaleFactor = 1.0, // Default to 1.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.88,
      padding: EdgeInsets.all(
        screenWidth * 0.025 * textScaleFactor,
      ), // Scale padding
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Up to ${distance.round()} kilometer away',
            style: GoogleFonts.poppins(
              fontSize:
                  screenWidth * 0.035 * textScaleFactor, // Apply scale factor
              color: AppColors.black,
            ),
          ),
          SizedBox(
            height: screenWidth * 0.015 * textScaleFactor,
          ), // Scale vertical spacing
          SliderTheme(
            // Apply a custom slider theme if needed for thumb/track size
            data: SliderTheme.of(context).copyWith(
              trackHeight: 2.0 * textScaleFactor, // Scale track height
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: 6.0 * textScaleFactor,
              ), // Scale thumb size
              overlayShape: RoundSliderOverlayShape(
                overlayRadius: 12.0 * textScaleFactor,
              ), // Scale overlay size
            ),
            child: Slider(
              value: distance,
              min: 1,
              max: 200,
              activeColor: AppColors.black,
              inactiveColor: AppColors.lightGray,
              onChanged: onDistanceChanged,
            ),
          ),
          SwitchListTile(
            title: Text(
              'See people slightly further away if I run out',
              style: GoogleFonts.poppins(
                fontSize:
                    screenWidth * 0.03 * textScaleFactor, // Apply scale factor
                color: AppColors.black,
              ),
            ),
            value: expandDistance,
            onChanged: onExpandChanged,
            activeColor: AppColors.textGray,
            contentPadding: EdgeInsets.zero,
            dense: true, // Makes the tile more compact
          ),
        ],
      ),
    );
  }
}

class VerifiedOnlyWidget extends StatelessWidget {
  final bool isEnabled;
  final Function(bool) onChanged;
  final double screenWidth;
  final double textScaleFactor; // New property

  const VerifiedOnlyWidget({
    Key? key,
    required this.isEnabled,
    required this.onChanged,
    required this.screenWidth,
    this.textScaleFactor = 1.0, // Default to 1.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.88,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03 * textScaleFactor, // Scale padding
        vertical: screenWidth * 0.015 * textScaleFactor, // Scale padding
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.black),
      ),
      child: SwitchListTile(
        title: Row(
          children: [
            Icon(
              Icons.verified,
              color: Colors.blue,
              size: screenWidth * 0.04 * textScaleFactor,
            ), // Scale icon size
            SizedBox(
              width: screenWidth * 0.015 * textScaleFactor,
            ), // Scale horizontal spacing
            FittedBox(
              // Use FittedBox for text
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                'Verified only',
                style: GoogleFonts.poppins(
                  fontSize:
                      screenWidth *
                      0.035 *
                      textScaleFactor, // Apply scale factor
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
        value: isEnabled,
        onChanged: onChanged,
        activeColor: AppColors.textGray,
        contentPadding: EdgeInsets.zero,
        dense: true, // Makes the tile more compact
      ),
    );
  }
}

class FilterOptionWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final double screenWidth;
  final double textScaleFactor; // New property

  const FilterOptionWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.screenWidth,
    this.textScaleFactor = 1.0, // Default to 1.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize:
                screenWidth * 0.030 * textScaleFactor, // Apply scale factor
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.008 * textScaleFactor,
        ), // Scale vertical spacing

        Container(
          width: screenWidth * 0.88,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03 * textScaleFactor, // Scale padding
            vertical: screenWidth * 0.025 * textScaleFactor, // Scale padding
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.black),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: screenWidth * 0.04 * textScaleFactor,
                color: AppColors.black,
              ), // Scale icon size
              SizedBox(
                width: screenWidth * 0.025 * textScaleFactor,
              ), // Scale horizontal spacing
              Expanded(
                // Use Expanded to prevent text overflow
                child: FittedBox(
                  // Use FittedBox for text
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Add to filter',
                    style: GoogleFonts.poppins(
                      fontSize:
                          screenWidth *
                          0.035 *
                          textScaleFactor, // Apply scale factor
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
              Icon(
                Icons.add,
                size: screenWidth * 0.04 * textScaleFactor,
                color: AppColors.black,
              ), // Scale icon size
            ],
          ),
        ),

        SizedBox(
          height: screenHeight * 0.018 * textScaleFactor,
        ), // Scale vertical spacing
      ],
    );
  }
}

class RelationshipGoalItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function(bool) onChanged;
  final double screenWidth;
  final double textScaleFactor; // New property

  const RelationshipGoalItem({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onChanged,
    required this.screenWidth,
    this.textScaleFactor = 1.0, // Default to 1.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isSelected),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.015 * textScaleFactor,
        ), // Scale vertical padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              // Use Expanded to prevent text overflow
              child: FittedBox(
                // Use FittedBox for text
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontSize:
                        screenWidth *
                        0.035 *
                        textScaleFactor, // Apply scale factor
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
            Container(
              width:
                  screenWidth * 0.04 * textScaleFactor, // Scale checkbox width
              height:
                  screenWidth * 0.04 * textScaleFactor, // Scale checkbox height
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryYellow
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppColors.primaryYellow : AppColors.black,
                  width: 1.5 * textScaleFactor, // Scale border width
                ),
                borderRadius: BorderRadius.circular(3),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size:
                          screenWidth *
                          0.025 *
                          textScaleFactor, // Scale check icon size
                      color: AppColors.black,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// Assuming CustomButton is defined elsewhere and handles its own scaling internally or accepts a scale factor.
// If not, you might need to add textScaleFactor and apply it similar to ToggleButton.
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double textScaleFactor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.width,
    required this.height,
    this.textScaleFactor = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryYellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            //side: BorderSide(color: AppColors.black), // Add border to button
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: AppColors.black,
              fontSize: 16 * textScaleFactor, // Base font size, scaled
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
