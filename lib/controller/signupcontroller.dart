// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

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
        return await create.collection('users').doc(uid).set({
          'email': emailController.text.trim(),
          'username': userController.text.trim(),
          'password': passController.text.trim(),
          'contact': contactController.text.trim(),
          'uid': uid
        });
      }).then((value) {
        Get.snackbar("Success", "Data Stored Successfully");
      }).then((value) {
        Get.to(() => LoginScreen());
      });
    } catch (e) {
      Get.snackbar("Sign up Failed", "Try Again!");
    }
  }
}
