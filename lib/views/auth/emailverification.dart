import 'package:bookstore/views/mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    // Start periodic verification check
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      checkVerification();
    });

    // Send verification email if not already sent
    if (!auth.currentUser!.emailVerified) {
      sendVerificationEmail();
    }
  }

  Future<void> sendVerificationEmail() async {
    try {
      final user = auth.currentUser!;
      await user.sendEmailVerification();
      Get.snackbar("Verification Email Sent", "Please check your inbox.");
    } catch (e) {
      Get.snackbar("Error", "Failed to send verification email: $e");
    }
  }

  Future<void> checkVerification() async {
    User? user = auth.currentUser;

    // Reload user state
    await user?.reload();
    user = auth.currentUser;

    if (user != null && user.emailVerified) {
      timer?.cancel(); // Stop the timer
      Get.snackbar("Success", "Email verified successfully!");
      Get.off(() => const MainScreen()); // Navigate to MainScreen
    }
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Your Email"),
        automaticallyImplyLeading: false, // Disable back button
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "A verification email has been sent to your email address.\nPlease verify your email to proceed.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendVerificationEmail,
              child: const Text("Resend Verification Email"),
            ),
            const SizedBox(height: 20),
            const Text(
              "You cannot access any other page until your email is verified.",
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
