// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:bookstore/controller/logoutcontroller.dart';
import 'package:bookstore/controller/themecontroller.dart';
import 'package:bookstore/views/auth/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final con = Get.put(LogoutContoller());
    final themeController = Get.find<ThemeController>();
    // Fetch current user's data
    User? user = FirebaseAuth.instance.currentUser;

    String username = '';
    String email = '';

    if (user != null) {
      username = user.displayName ?? 'Unknown User';
      email = user.email ?? 'No email provided';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BookStore',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: user != null
          ? SingleChildScrollView(
              child: Column(
                children: [
                  // User Info Section
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          child: Icon(Icons.person, size: 50),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome, $username',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              email,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Theme Options Section
                  ListTile(
                    leading: Icon(Icons.brightness_6, color: Colors.blue),
                    title: Text(
                      'Theme',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      _showThemeOptions(context,
                          themeController); // Show theme options on tap
                    },
                  ),
                  // Options Section
                  ListTile(
                    leading: Icon(Icons.shopping_cart, color: Colors.blue),
                    title: Text(
                      'My Orders',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      // Navigate to My Orders
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite, color: Colors.blue),
                    title: Text(
                      'Wishlist',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      // Navigate to Wishlist
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.edit, color: Colors.blue),
                    title: Text(
                      'Edit Profile',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      // Navigate to Edit Profile
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.blue),
                    title: Text(
                      'Settings',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      // Navigate to Settings
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.blue),
                    title: Text(
                      'Logout',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      // Implement Logout
                      con.myLogout();
                      Get.offAllNamed('/login'); // Navigate to login page
                    },
                  ),
                ],
              ),
            )
          : Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const LoginScreen(),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 900));
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
    );
  }

  // Function to show theme options
  void _showThemeOptions(
      BuildContext context, ThemeController themeController) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.light_mode),
                title: Text('Light Mode'),
                onTap: () {
                  themeController.switchTheme(ThemeMode.light);
                  // Get.back(); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: Icon(Icons.dark_mode),
                title: Text('Dark Mode'),
                onTap: () {
                  themeController.switchTheme(ThemeMode.dark);
                  // Get.back(); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('System Default'),
                onTap: () {
                  themeController.switchTheme(ThemeMode.system);
                  // Get.back(); // Close the bottom sheet
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
