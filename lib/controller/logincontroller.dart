// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:bookstore/views/mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:bookstore/views/homescreen.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final userController = TextEditingController();
  final passController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance; // For Authentication

  var isObscure = true.obs;

  void isToggle() {
    isObscure.value = !isObscure.value;
  }

  void myLogin() {
    try {
      auth
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passController.text.trim())
          .then((value) {
        // Get.snackbar("Success", "Login Successfully");
        Get.to(MainScreen());
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
