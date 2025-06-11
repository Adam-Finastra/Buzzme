import 'package:buzzme/widgets/custom_widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // Toggle buttons
              Row(
                children: [
                  ToggleButton(
                    text: 'Basic',
                    isSelected: isBasicSelected,
                    onTap: () => setState(() => isBasicSelected = true),
                    width: screenWidth * 0.25,
                    height: screenHeight * 0.05,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  ToggleButton(
                    text: 'Advanced',
                    isSelected: !isBasicSelected,
                    onTap: () => setState(() => isBasicSelected = false),
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.05,
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.03),

              if (isBasicSelected) ...[
                // Basic preferences
                PreferenceSection(
                  title: 'Who you want to date',
                  child: PreferenceItem(
                    text: 'Women',
                    hasArrow: true,
                    screenWidth: screenWidth,
                  ),
                ),

                PreferenceSection(
                  title: 'How old are they?',
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
                  ),
                ),

                PreferenceSection(
                  title: 'How far away are they?',
                  child: DistanceRangeWidget(
                    distance: distanceRange,
                    expandDistance: expandDistance,
                    onDistanceChanged: (value) =>
                        setState(() => distanceRange = value),
                    onExpandChanged: (value) =>
                        setState(() => expandDistance = value),
                    screenWidth: screenWidth,
                  ),
                ),

                PreferenceSection(
                  title: 'Have they verified themselves?',
                  child: VerifiedOnlyWidget(
                    isEnabled: verifiedOnly,
                    onChanged: (value) => setState(() => verifiedOnly = value),
                    screenWidth: screenWidth,
                  ),
                ),
              ] else ...[
                // Advanced preferences
                AdvancedPreferencesWidget(screenWidth: screenWidth),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Widgets for Preferences
class ToggleButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final double width;
  final double height;

  const ToggleButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.width,
    required this.height,
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
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? AppColors.primaryYellow : AppColors.textGray,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: isSelected ? AppColors.black : AppColors.textGray,
              fontSize: MediaQuery.of(context).size.width * 0.035,
              fontWeight: FontWeight.w500,
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

  const PreferenceSection({Key? key, required this.title, required this.child})
    : super(key: key);

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
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w500,
            color: AppColors.textGray,
          ),
        ),
        SizedBox(height: screenHeight * 0.015),
        child,
        SizedBox(height: screenHeight * 0.03),
      ],
    );
  }
}

class PreferenceItem extends StatelessWidget {
  final String text;
  final bool hasArrow;
  final double screenWidth;

  const PreferenceItem({
    Key? key,
    required this.text,
    this.hasArrow = false,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.88,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenWidth * 0.04,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.textGray.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.04,
              color: AppColors.black,
            ),
          ),
          if (hasArrow)
            Icon(
              Icons.arrow_forward_ios,
              size: screenWidth * 0.04,
              color: AppColors.textGray,
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

  const AgeRangeWidget({
    Key? key,
    required this.start,
    required this.end,
    required this.expandAge,
    required this.onStartChanged,
    required this.onEndChanged,
    required this.onExpandChanged,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.88,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.textGray.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Between ${start.round()} and ${end.round()}',
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.04,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: screenWidth * 0.03),
          RangeSlider(
            values: RangeValues(start, end),
            min: 18,
            max: 60,
            activeColor: AppColors.primaryYellow,
            inactiveColor: AppColors.textGray.withOpacity(0.3),
            onChanged: (values) {
              onStartChanged(values.start);
              onEndChanged(values.end);
            },
          ),
          SwitchListTile(
            title: Text(
              'See people 2 years either side if i run out',
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.035,
                color: AppColors.black,
              ),
            ),
            value: expandAge,
            onChanged: onExpandChanged,
            activeColor: AppColors.primaryYellow,
            contentPadding: EdgeInsets.zero,
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

  const DistanceRangeWidget({
    Key? key,
    required this.distance,
    required this.expandDistance,
    required this.onDistanceChanged,
    required this.onExpandChanged,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.88,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.textGray.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Up to ${distance.round()} kilometer away',
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.04,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: screenWidth * 0.03),
          Slider(
            value: distance,
            min: 1,
            max: 200,
            activeColor: AppColors.primaryYellow,
            inactiveColor: AppColors.textGray.withOpacity(0.3),
            onChanged: onDistanceChanged,
          ),
          SwitchListTile(
            title: Text(
              'See people slightly further away if i run out',
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.035,
                color: AppColors.black,
              ),
            ),
            value: expandDistance,
            onChanged: onExpandChanged,
            activeColor: AppColors.primaryYellow,
            contentPadding: EdgeInsets.zero,
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

  const VerifiedOnlyWidget({
    Key? key,
    required this.isEnabled,
    required this.onChanged,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.88,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenWidth * 0.02,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.textGray.withOpacity(0.3)),
      ),
      child: SwitchListTile(
        title: Row(
          children: [
            Icon(Icons.verified, color: Colors.blue, size: screenWidth * 0.05),
            SizedBox(width: screenWidth * 0.02),
            Text(
              'Verified only',
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.04,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        value: isEnabled,
        onChanged: onChanged,
        activeColor: AppColors.primaryYellow,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

class AdvancedPreferencesWidget extends StatefulWidget {
  final double screenWidth;

  const AdvancedPreferencesWidget({Key? key, required this.screenWidth})
    : super(key: key);

  @override
  State<AdvancedPreferencesWidget> createState() =>
      _AdvancedPreferencesWidgetState();
}

class _AdvancedPreferencesWidgetState extends State<AdvancedPreferencesWidget> {
  List<String> selectedRelationshipGoals = [];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Expanded(
      child: Column(
        children: [
          // Filter options
          FilterOptionWidget(
            title: 'What\'s your family plan?',
            icon: Icons.family_restroom,
            screenWidth: widget.screenWidth,
          ),

          FilterOptionWidget(
            title: 'Do they have kids?',
            icon: Icons.child_care,
            screenWidth: widget.screenWidth,
          ),

          FilterOptionWidget(
            title: 'What\'s their education level?',
            icon: Icons.school,
            screenWidth: widget.screenWidth,
          ),

          FilterOptionWidget(
            title: 'Do thet exercise?',
            icon: Icons.fitness_center,
            screenWidth: widget.screenWidth,
          ),

          FilterOptionWidget(
            title: 'What\'s their religion?',
            icon: Icons.church,
            screenWidth: widget.screenWidth,
          ),

          SizedBox(height: screenHeight * 0.02),

          // Relationship goals section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What are you looking for?',
                style: GoogleFonts.poppins(
                  fontSize: widget.screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textGray,
                ),
              ),
              SizedBox(height: screenHeight * 0.015),

              Container(
                width: widget.screenWidth * 0.88,
                padding: EdgeInsets.all(widget.screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: AppColors.textGray.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    RelationshipGoalItem(
                      text: 'A long team relationship',
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
                      screenWidth: widget.screenWidth,
                    ),

                    const Divider(color: AppColors.textGray),

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
                      screenWidth: widget.screenWidth,
                    ),

                    const Divider(color: AppColors.textGray),

                    RelationshipGoalItem(
                      text: 'Fun, casual data',
                      isSelected: selectedRelationshipGoals.contains('casual'),
                      onChanged: (selected) {
                        setState(() {
                          if (selected) {
                            selectedRelationshipGoals.add('casual');
                          } else {
                            selectedRelationshipGoals.remove('casual');
                          }
                        });
                      },
                      screenWidth: widget.screenWidth,
                    ),

                    const Divider(color: AppColors.textGray),

                    RelationshipGoalItem(
                      text: 'A life parnter',
                      isSelected: selectedRelationshipGoals.contains(
                        'life_partner',
                      ),
                      onChanged: (selected) {
                        setState(() {
                          if (selected) {
                            selectedRelationshipGoals.add('life_partner');
                          } else {
                            selectedRelationshipGoals.remove('life_partner');
                          }
                        });
                      },
                      screenWidth: widget.screenWidth,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Spacer(),

          // Next button
          CustomButton(
            text: 'Next',
            onPressed: () {
              // Navigate to next screen or handle completion
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Preferences saved!')),
              );
            },
            width: widget.screenWidth * 0.88,
            height: screenHeight * 0.065,
          ),

          SizedBox(height: screenHeight * 0.03),
        ],
      ),
    );
  }
}

class FilterOptionWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final double screenWidth;

  const FilterOptionWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.screenWidth,
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
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w500,
            color: AppColors.textGray,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),

        Container(
          width: screenWidth * 0.88,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenWidth * 0.035,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.textGray.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(icon, size: screenWidth * 0.05, color: AppColors.textGray),
              SizedBox(width: screenWidth * 0.03),
              Text(
                'Add to filter',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.04,
                  color: AppColors.textGray,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.add,
                size: screenWidth * 0.05,
                color: AppColors.textGray,
              ),
            ],
          ),
        ),

        SizedBox(height: screenHeight * 0.025),
      ],
    );
  }
}

class RelationshipGoalItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function(bool) onChanged;
  final double screenWidth;

  const RelationshipGoalItem({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onChanged,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isSelected),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.04,
                color: AppColors.black,
              ),
            ),
            Container(
              width: screenWidth * 0.05,
              height: screenWidth * 0.05,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryYellow
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryYellow
                      : AppColors.textGray,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: screenWidth * 0.03,
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
