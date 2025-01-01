// ignore_for_file: prefer_const_constructors, avoid_print

// import 'package:bookstore/views/homescreen.dart';
import 'package:bookstore/views/mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// import 'package:bookstore/views/auth/loginscreen.dart';

class LogoutContoller extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  void myLogout() {
    try {
      auth.signOut().then((value) {
        Get.snackbar("Logout", "You Logged Out");
        Get.offAll(() => MainScreen());
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
