// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
// import 'package:bookstore/views/homescreen.dart';
import 'package:bookstore/views/mainscreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bookstore/views/auth/loginscreen.dart';

class SignUpController extends GetxController {
  final emailController = TextEditingController();
  final userController = TextEditingController();
  final contactController = TextEditingController();

  final confirmPassController = TextEditingController();
  final passController = TextEditingController();

  var isObscure = true.obs;
  var isObscureConfirm = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance; // For Authentication

  FirebaseFirestore create = FirebaseFirestore.instance; // For firestore CRUD

// Google Sign-In function
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
            .then((UserCredential userCredential) {
          String uid = userCredential.user!.uid;
          return create.collection('users').doc(uid).set({
            'email': userCredential.user!.email,
            'username': userCredential.user!.displayName ?? '',
            'uid': uid
          });
        }).then((value) {
          Get.snackbar(
              "Google Connection", "Successfully Connected with Google");
          Get.to(() => MainScreen());
        });
      }
    } catch (e) {
      // Get.snackbar("Google Error", e.toString());
    }
  }

  void isToggle() {
    isObscure.value = !isObscure.value;
  }

  void isToggleConfirm() {
    isObscureConfirm.value = !isObscureConfirm.value;
  }

  bool ConfirmPass() {
    return confirmPassController.text.trim() == passController.text.trim();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    userController.dispose();
    contactController.dispose();
    passController.dispose();
    confirmPassController.dispose();
  }

  // Sign Up Function
  void signup() async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passController.text.trim())
          .then((credential) async {
        String uid = credential.user!.uid;

// Update the user's displayName in FirebaseAuth
        await credential.user?.updateDisplayName(userController.text.trim());
        await credential.user?.reload(); // Reload the user to reflect changes

        return await create.collection('users').doc(uid).set({
          'email': emailController.text.trim(),
          'username': userController.text.trim(),
          'password': passController.text.trim(),
          'contact': contactController.text.trim(),
          'uid': uid
        });
      }).then((value) {
        Get.snackbar("Congratulations", "Your Account Created Successfully!");
      }).then((value) {
        Get.to(() => LoginScreen());
      });
    } catch (e) {
      Get.snackbar("Sign up Failed", "Try Again!");
    }
  }
}
