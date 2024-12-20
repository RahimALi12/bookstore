// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bookstore/controller/homecontroller.dart';
import 'package:bookstore/controller/logoutcontroller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final con = Get.put(LogoutContoller());
    final homecon = Get.put(HomeController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                      child: Text(user['email']),
                    ),
                  );
                },
              );
            }),
            Container(
              child: ElevatedButton(
                  onPressed: () {
                    con.myLogout();
                  },
                  child: Text("Logout")),
            ),
          ],
        ),
      ),
    );
  }
}
