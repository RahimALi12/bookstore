import 'package:bookstore/views/auth/emailverification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailLoginController extends GetxController {
  final emailController = TextEditingController();
  final userController = TextEditingController();
  final confirmPassController = TextEditingController();
  final passController = TextEditingController();

  var isObscure = true.obs;
  var isObscureConfirm = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance; // For Authentication
  FirebaseFirestore firestore =
      FirebaseFirestore.instance; // For Firestore CRUD

  // Email validation
  bool isValidEmail(String email) {
    RegExp emailRegExp =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegExp.hasMatch(email);
  }

  // Save user data to Firestore
  Future<void> saveUserData(User user) async {
    try {
      String uid = user.uid;
      await firestore.collection('users').doc(uid).set({
        'email': user.email,
        'username': userController.text.trim(),
        'uid': uid,
        'isEmailVerified': false, // To track email verification status
      });
    } catch (e) {
      Get.snackbar("Error", "Failed to save user data: ${e.toString()}");
    }
  }

  // Toggle password visibility
  void isToggle() {
    isObscure.value = !isObscure.value;
  }

  void isToggleConfirm() {
    isObscureConfirm.value = !isObscureConfirm.value;
  }

  // Check if passwords match
  bool ConfirmPass() {
    return confirmPassController.text.trim() == passController.text.trim();
  }

  // Dispose controllers
  @override
  void dispose() {
    emailController.dispose();
    userController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  // Signup logic
  void signUpWithEmail() async {
    if (!isValidEmail(emailController.text.trim())) {
      Get.snackbar("Invalid Email", "Please enter a valid email address.");
      return;
    }

    if (!ConfirmPass()) {
      Get.snackbar("Password Mismatch", "Passwords do not match.");
      return;
    }

    try {
      // Create user with email and password
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );

      // Send verification email
      User? user = userCredential.user;
      await user?.sendEmailVerification();

      // Save user data to Firestore
      if (user != null) {
        await saveUserData(user);
      }

      // Navigate to VerificationPage
      Get.to(() => const VerificationPage());

      Get.snackbar(
        "Signup Successful",
        "A verification email has been sent. Please verify your email to continue.",
      );
    } catch (e) {
      Get.snackbar("Signup Error", "Error: ${e.toString()}");
    }
  }
}
