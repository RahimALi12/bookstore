// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var userData = <Map<String, dynamic>>[].obs;
  final FirebaseFirestore fetch = FirebaseFirestore.instance;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchdata();
  }

  Future<void> fetchdata() async {
    try {
      final QuerySnapshot data = await fetch.collection("users").get();

      if (data.docs.isNotEmpty) {
        List<Map<String, dynamic>> userlist = [];

        for (var doc in data.docs) {
          userlist.add(doc.data() as Map<String, dynamic>);
        }

        userData.value = userlist;
        isLoading.value = false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
