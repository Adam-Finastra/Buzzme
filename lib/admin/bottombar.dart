import 'package:buzzme/user/view/auth/login_screen.dart';
import 'package:buzzme/user/view/onbording/preferemce_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String status; // e.g., 'Active', 'Inactive', 'Blocked'
  final String imageUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.imageUrl,
  });
}

// --- NEW: Admin Home Page (User List) ---
class AdminHomePage extends StatelessWidget {
  AdminHomePage({Key? key}) : super(key: key);

  final List<User> _users = [
    User(
      id: '1',
      name: 'Alice Smith',
      email: 'alice@example.com',
      status: 'Active',
      imageUrl: 'https://via.placeholder.com/150/FFC107/FFFFFF?text=A', // Example image
    ),
    User(
      id: '2',
      name: 'Bob Johnson',
      email: 'bob@example.com',
      status: 'Inactive',
      imageUrl: 'https://via.placeholder.com/150/FFC107/FFFFFF?text=B',
    ),
    User(
      id: '3',
      name: 'Charlie Brown',
      email: 'charlie@example.com',
      status: 'Blocked',
      imageUrl: 'https://via.placeholder.com/150/FFC107/FFFFFF?text=C',
    ),
    User(
      id: '4',
      name: 'Diana Prince',
      email: 'diana@example.com',
      status: 'Active',
      imageUrl: 'https://via.placeholder.com/150/FFC107/FFFFFF?text=D',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'User Management',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(context).primaryColor,
                          backgroundImage: NetworkImage(user.imageUrl),
                          child: user.imageUrl.isEmpty
                              ? Text(user.name[0],
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.email,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Status: ${user.status}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: user.status == 'Active'
                                      ? Colors.green[700]
                                      : user.status == 'Blocked'
                                          ? Colors.red[700]
                                          : Colors.orange[700],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Example actions (buttons)
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                // Implement edit user logic
                                print('Edit ${user.name}');
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Implement delete user logic
                                print('Delete ${user.name}');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- NEW: Admin Settings Page ---
class AdminSettingsPage extends StatelessWidget {
  const AdminSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Admin Settings',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: 'Logout',
                onPressed: () {
                  // Navigate to LoginScreen and clear navigation stack
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false, // Remove all previous routes
                  );
                },
                width: 200, // Fixed width for logout button
                height: 50,
                // color: Colors.redAccent,
                // textColor: Colors.white,
                // fontSize: 16,
              ),
              const SizedBox(height: 20),
              Text(
                'Version 1.0.0',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- AdminBottomBar (Modified to StatefulWidget with BottomNavBar) ---
class AdminBottomBar extends StatefulWidget {
  const AdminBottomBar({Key? key}) : super(key: key);

  @override
  State<AdminBottomBar> createState() => _AdminBottomBarState();
}

class _AdminBottomBarState extends State<AdminBottomBar> {
  int _selectedIndex = 0; // Current selected tab index

  // List of widgets to display for each tab
  static final List<Widget> _pages = <Widget>[
    AdminHomePage(), // First tab: Home/User List
    const AdminSettingsPage(), // Second tab: Settings
    // Add more pages here as needed
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? 'Admin Dashboard' : 'Settings', // Dynamic title
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFFC107), // App bar color
      ),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF2C2C2C), // Dark background for nav bar
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          // Add more BottomNavigationBarItems here as needed
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFFFC107), // Yellow for selected item
        unselectedItemColor: Colors.grey, // Grey for unselected items
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensures labels are always visible
        selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        unselectedLabelStyle: GoogleFonts.poppins(),
      ),
    );
  }
}