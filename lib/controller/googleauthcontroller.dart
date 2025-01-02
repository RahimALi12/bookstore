// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:bookstore/views/mainscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthcontroller extends GetxController {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance; // For Authentication
  FirebaseFirestore create = FirebaseFirestore.instance; // Firestore instance

  // Save user data to Firestore
  Future<void> saveUserData(User user) async {
    String uid = user.uid;

    // Check if data already exists
    DocumentSnapshot userDoc = await create.collection('users').doc(uid).get();

    if (!userDoc.exists) {
      await create.collection('users').doc(uid).set({
        'email': user.email,
        'username': user.displayName ?? '',
        'uid': uid,
      });
    }
  }

  // Google Sign-In
  Future<void> googleSignUp() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId:
            "240145924114-4vr72o56kko3o8s0nkkjdk4ulpoudlkj.apps.googleusercontent.com",
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await auth
            .signInWithCredential(credential)
            .then((userCredential) async {
          // String uid = userCredential.user!.uid;
          await saveUserData(userCredential.user!);
          // Get.snackbar(
          //     "Google Connection", "Successfully Connected with Google");
          Get.to(() => MainScreen());
        });
      }
    } catch (e) {
      // Get.snackbar("Google Sign-In Error", e.toString());
    }
  }
}
