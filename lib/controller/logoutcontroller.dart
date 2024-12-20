// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:bookstore/views/auth/loginscreen.dart';

class LogoutContoller extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  void myLogout() {
    try {
      auth.signOut().then((value) {
        Get.snackbar("Logout", "Logout Successfully");
        Get.offAll(() => LoginScreen());
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
