// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bookstore/controller/homecontroller.dart';
import 'package:bookstore/controller/logoutcontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final con = Get.put(LogoutContoller());
    final homecon = Get.put(HomeController());

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
        title: Text("Home"),
        leading: Container(),
        actions: [
          // Show logout button only if the user is logged in
          if (user != null)
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                con.myLogout(); // Call logout function
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Display user information (name, email, icon) only if user is logged in
            if (user != null)
              Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person, size: 40),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, $username', // Display the username
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          email, // Display the email
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            // Display user data fetched from controller
            Obx(() {
              if (homecon.isLoading.value == true) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (homecon.userData.isEmpty) {
                return const Text("There is no data");
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: homecon.userData.length,
                itemBuilder: (context, index) {
                  var user = homecon.userData[index];
                  return Container(
                    height: 100,
                    child: Card(
                      child: Text(user['username']),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
