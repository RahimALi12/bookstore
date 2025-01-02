import 'package:bookstore/views/mainscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance; // For Authentication
  FirebaseFirestore create = FirebaseFirestore.instance; // Firestore instance

  var isObscure = true.obs;

  void isToggle() {
    isObscure.value = !isObscure.value;
  }

  // Email Verification Check Before Login
  Future<bool> isEmailVerified() async {
    User? user = auth.currentUser;
    if (user != null && user.emailVerified) {
      return true; // Email is verified
    }
    return false; // Email is not verified
  }

  void myLogin() async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );

      User? user = auth.currentUser;

      // Reload the user state
      await user?.reload();

      if (user != null && user.emailVerified) {
        // Email is verified, proceed to the main screen
        Get.snackbar("Login Successful", "Welcome back!");
        Get.off(() => const MainScreen());
      } else {
        // Email is not verified
        Get.snackbar("Email Not Verified", "Please verify your email first.");
        await auth.signOut(); // Sign out the user
      }
    } catch (e) {
      Get.snackbar("Error", "Login failed. Error: ${e.toString()}");
    }
  }
}
