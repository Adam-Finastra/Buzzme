import 'package:buzzme/user/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _dateModeEnabled = true;
  bool _autoSpotlightEnabled = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 500;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        //elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: screenWidth * 0.035,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Setting',
          style: GoogleFonts.inter(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.03,
                vertical: isSmallScreen
                    ? screenHeight * 0.01
                    : screenHeight * 0.01,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Type of connection
                  _buildSettingItem(
                    title: 'Type of connection',
                    hasArrow: true,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ConnectionTypeDialog(
                            initialSelection: 'Date',
                            onSelectionChanged: (selectedType) {
                              print('Selected connection type: $selectedType');
                            },
                          );
                        },
                      );
                    },
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    isSmallScreen: isSmallScreen,
                  ),

                  SizedBox(
                    height: isSmallScreen
                        ? screenHeight * 0.006
                        : screenHeight * 0.010,
                  ),

                  // Date mode with toggle
                  _buildSettingItem(
                    title: 'Date mode',
                    hasToggle: true,
                    toggleValue: _dateModeEnabled,
                    onToggleChanged: (value) {
                      setState(() {
                        _dateModeEnabled = value;
                      });
                    },
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    isSmallScreen: isSmallScreen,
                  ),

                  // Description for Date mode
                  _buildDescription(
                    'Hide your profile in Data and just use BFF. If you do this, you\'ll lose your connection and chats in Date.',
                    screenWidth,
                    isSmallScreen,
                  ),

                  SizedBox(
                    height: isSmallScreen
                        ? screenHeight * 0.006
                        : screenHeight * 0.010,
                  ),

                  // Snooze
                  _buildSettingItem(
                    title: 'Snooze',
                    hasArrow: true,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SnoozeDurationDialog(
                            onSelectionChanged: (duration) {
                              print('Snooze duration: $duration');
                            },
                          );
                        },
                      );
                    },
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    isSmallScreen: isSmallScreen,
                  ),

                  // Description for Snooze
                  _buildDescription(
                    'Hide your profile temporarily, in all mode. You won\'t lose any connection or chats',
                    screenWidth,
                    isSmallScreen,
                  ),

                  SizedBox(
                    height: isSmallScreen
                        ? screenHeight * 0.006
                        : screenHeight * 0.010,
                  ),

                  // Auto spotlight with toggle
                  _buildSettingItem(
                    title: 'Auto spotlight',
                    hasToggle: true,
                    toggleValue: _autoSpotlightEnabled,
                    onToggleChanged: (value) {
                      setState(() {
                        _autoSpotlightEnabled = value;
                      });
                    },
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    isSmallScreen: isSmallScreen,
                  ),

                  // Description for Auto spotlight
                  _buildDescription(
                    'We\'ll use spotlight automatically to boost your profile when most people will see you',
                    screenWidth,
                    isSmallScreen,
                  ),

                  SizedBox(
                    height: isSmallScreen
                        ? screenHeight * 0.01
                        : screenHeight * 0.02,
                  ),

                  // Location Section Header
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                    ),
                    child: Text(
                      'Location',
                      style: GoogleFonts.inter(
                        fontSize: isSmallScreen
                            ? screenWidth * 0.03
                            : screenWidth * 0.035,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: isSmallScreen
                        ? screenHeight * 0.01
                        : screenHeight * 0.015,
                  ),

                  // Current location
                  _buildSettingItem(
                    title: 'Current location',
                    hasArrow: true,
                    onTap: () {},
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    isSmallScreen: isSmallScreen,
                  ),

                  SizedBox(
                    height: isSmallScreen
                        ? screenHeight * 0.008
                        : screenHeight * 0.012,
                  ),

                  // Travel
                  _buildSettingItem(
                    title: 'Travel',
                    hasArrow: true,
                    onTap: () {},
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    isSmallScreen: isSmallScreen,
                  ),

                  // Description for Travel
                  _buildDescription(
                    'Change the location to connect with people in other location.',
                    screenWidth,
                    isSmallScreen,
                  ),

                  SizedBox(
                    height: isSmallScreen
                        ? screenHeight * 0.01
                        : screenHeight * 0.02,
                  ),

                  // Notification setting
                  _buildSettingItem(
                    title: 'Notification setting',
                    hasArrow: true,
                    onTap: () {},
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    isSmallScreen: isSmallScreen,
                  ),

                  SizedBox(
                    height: isSmallScreen
                        ? screenHeight * 0.006
                        : screenHeight * 0.010,
                  ),

                  // Security and privacy
                  _buildSettingItem(
                    title: 'Security and privacy',
                    hasArrow: true,
                    onTap: () {},
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    isSmallScreen: isSmallScreen,
                  ),

                  SizedBox(height: screenHeight * 0.008),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryYellow,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            isSmallScreen ? 24 : 28,
                          ),
                        ),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      child: Text(
                        'Switch Another Account',
                        style: GoogleFonts.inter(
                          fontSize: isSmallScreen
                              ? screenWidth * 0.025
                              : screenWidth * 0.03,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.001),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Delete Account',
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: isSmallScreen
                              ? screenWidth * 0.025
                              : screenWidth * 0.03,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Fixed bottom section
        ],
      ),
    );
  }

  Widget _buildDescription(
    String text,
    double screenWidth,
    bool isSmallScreen,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.04,
        right: screenWidth * 0.04,
        top: isSmallScreen ? 4 : 6,
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: isSmallScreen ? screenWidth * 0.028 : screenWidth * 0.03,
          color: Colors.grey[600],
          fontWeight: FontWeight.w400,
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    bool hasArrow = false,
    bool hasToggle = false,
    bool? toggleValue,
    ValueChanged<bool>? onToggleChanged,
    VoidCallback? onTap,
    required double screenWidth,
    required double screenHeight,
    required bool isSmallScreen,
  }) {
    return Container(
      width: double.infinity,
      height: isSmallScreen ? 30 : 42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isSmallScreen ? 26 : 32),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: hasToggle ? null : onTap,
          borderRadius: BorderRadius.circular(isSmallScreen ? 26 : 32),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: isSmallScreen
                          ? screenWidth * 0.025
                          : screenWidth * 0.03,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                if (hasArrow)
                  Icon(
                    Icons.arrow_forward_ios,
                    size: isSmallScreen ? 12 : 14,
                    color: Colors.grey[600],
                  ),
                if (hasToggle)
                  Transform.scale(
                    scale: isSmallScreen ? 0.6 : 0.8,
                    child: Switch(
                      value: toggleValue ?? false,
                      onChanged: onToggleChanged,
                      activeColor: Colors.black,
                      activeTrackColor: Colors.grey[300],
                      inactiveThumbColor: Colors.grey[600],
                      inactiveTrackColor: Colors.grey[300],
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Dialog Classes
class ConnectionTypeDialog extends StatefulWidget {
  final String initialSelection;
  final ValueChanged<String> onSelectionChanged;

  const ConnectionTypeDialog({
    super.key,
    required this.initialSelection,
    required this.onSelectionChanged,
  });

  @override
  State<ConnectionTypeDialog> createState() => _ConnectionTypeDialogState();
}

class _ConnectionTypeDialogState extends State<ConnectionTypeDialog> {
  String? _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialSelection;
  }

  Widget _buildOption({required String type, required String value}) {
    bool isSelected = _selectedType == value;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = value;
        });
        widget.onSelectionChanged(value);
        Navigator.of(context).pop();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryYellow : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(color: AppColors.primaryYellow, width: 2)
              : Border.all(color: Colors.white!, width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                type,
                style: GoogleFonts.inter(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              width: 22,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.black : Colors.grey[400]!,
                  width: 2,
                ),
                color: isSelected ? Colors.black : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(
                      Icons.circle,
                      size: 10,
                      color: AppColors.primaryYellow,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.045),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What Type Of Connection Do You Want',
              style: GoogleFonts.inter(
                fontSize: screenWidth * 0.042,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            _buildOption(type: 'Date', value: 'Date'),
            _buildOption(type: 'BFF', value: 'BFF'),
          ],
        ),
      ),
    );
  }
}

class SnoozeDurationDialog extends StatelessWidget {
  final ValueChanged<String> onSelectionChanged;

  const SnoozeDurationDialog({super.key, required this.onSelectionChanged});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final List<String> durations = [
      '24 hours',
      '72 hours',
      'A week',
      'Until I change it',
    ];

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryYellow,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            padding: EdgeInsets.all(screenWidth * 0.045),
            width: double.infinity,
            child: Text(
              'How long do you want to be invisible for?',
              style: GoogleFonts.inter(
                fontSize: screenWidth * 0.042,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            padding: EdgeInsets.all(screenWidth * 0.045),
            child: Column(
              children: durations.asMap().entries.map((entry) {
                int index = entry.key;
                String duration = entry.value;
                bool isLast = index == durations.length - 1;

                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        onSelectionChanged(duration);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                duration,
                                style: GoogleFonts.inter(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (!isLast)
                      Divider(height: 1, thickness: 1, color: Colors.grey[300]),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
