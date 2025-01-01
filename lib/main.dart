import 'package:bookstore/controller/themecontroller.dart';
import 'package:bookstore/views/auth/loginscreen.dart';
import 'package:bookstore/views/homescreen.dart';
import 'package:bookstore/views/mainscreen.dart';
import 'package:bookstore/views/profilescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init(); // Ensure GetStorage is initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController =
        Get.put(ThemeController()); // Initialize theme controller

    return Obx(() {
      // Use Obx to listen to theme changes
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BookStore',
        themeMode:
            themeController.currentTheme.value, // Dynamically apply theme
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        initialRoute: '/', // Initial route for the app
        getPages: [
          GetPage(name: '/', page: () => MainScreen()), // Main screen
          GetPage(name: '/home', page: () => HomeScreen()), // Home screen
          GetPage(name: '/login', page: () => LoginScreen()), // Login screen
          GetPage(
              name: '/profile', page: () => ProfileScreen()), // Profile screen
        ],
      );
    });
  }
}
