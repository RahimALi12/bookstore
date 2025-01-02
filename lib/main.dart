import 'package:bookstore/controller/themecontroller.dart';
import 'package:bookstore/views/auth/loginscreen.dart';
import 'package:bookstore/views/homescreen.dart';
import 'package:bookstore/views/mainscreen.dart';
import 'package:bookstore/views/profilescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  await GetStorage.init(); // Initialize GetStorage
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Check email verification and logout if not verified
  Future<void> checkUserVerification() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      // Reload user state to fetch updated verification status
      await user.reload();

      if (!user.emailVerified) {
        // If email is not verified, sign out and redirect to login
        await auth.signOut();
        Get.offAll(() => const LoginScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    checkUserVerification(); // Check email verification on app launch
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
          GetPage(name: '/', page: () => const MainScreen()), // Main screen
          GetPage(name: '/home', page: () => const HomeScreen()), // Home screen
          GetPage(
              name: '/login', page: () => const LoginScreen()), // Login screen
          GetPage(
              name: '/profile',
              page: () => const ProfileScreen()), // Profile screen
        ],
      );
    });
  }
}

// Handles user authentication state
class AuthenticationHandler extends StatelessWidget {
  const AuthenticationHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading screen while waiting for connection
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          // User is logged in
          return const MainScreen();
        } else {
          // User is not logged in
          return const LoginScreen();
        }
      },
    );
  }
}
