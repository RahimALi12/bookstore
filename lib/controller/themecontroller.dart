import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  var storage = GetStorage();
  var currentTheme = ThemeMode.light.obs; // Rx variable for theme mode

  @override
  void onInit() {
    super.onInit();
    // Fetch the saved theme from GetStorage when the app starts
    var storedTheme = storage.read('themeMode');
    if (storedTheme == 'dark') {
      currentTheme.value = ThemeMode.dark;
    } else if (storedTheme == 'light') {
      currentTheme.value = ThemeMode.light;
    } else {
      // Default to system theme
      currentTheme.value = ThemeMode.system;
    }
  }

  // Method to switch theme and save it to GetStorage
  void switchTheme(ThemeMode theme) {
    currentTheme.value = theme;
    storage.write('themeMode', theme == ThemeMode.dark ? 'dark' : 'light');
  }
}
