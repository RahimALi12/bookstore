import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var categoryData =
      <Map<String, dynamic>>[].obs; // To store fetched categories
  var productsByCategory =
      <String, List<Map<String, dynamic>>>{}.obs; // Store products by category
  final FirebaseFirestore firebase = FirebaseFirestore.instance;
  var isLoading = false.obs; // To track loading state
  var allBooks = <Map<String, dynamic>>[].obs; // All books
  var filteredBooks =
      <Map<String, dynamic>>[].obs; // Filtered books for display

  @override
  void onInit() {
    super.onInit();
    fetchCategories();

    fetchBooks(); // Load books initially
  }

  void fetchBooks() {
    // Simulate fetching books
    allBooks.value = [
      {"title": "Book One", "author": "Author A", "genre": "Fiction"},
      {"title": "Book Two", "author": "Author B", "genre": "Non-Fiction"},
      {"title": "Book Three", "author": "Author C", "genre": "Fiction"},
    ];

    filteredBooks.value = allBooks; // Initially show all books
  }

  void searchBooks(String query) {
    if (query.isEmpty) {
      filteredBooks.value = allBooks; // Show all books when query is empty
    } else {
      filteredBooks.value = allBooks.where((book) {
        return book['title'].toLowerCase().contains(query.toLowerCase()) ||
            book['author'].toLowerCase().contains(query.toLowerCase()) ||
            book['genre'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true; // Start loading
      final QuerySnapshot categorySnapshot =
          await firebase.collection("categories").get();

      if (categorySnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> categoryList = [];
        for (var categoryDoc in categorySnapshot.docs) {
          var categoryData = categoryDoc.data() as Map<String, dynamic>;
          categoryData['id'] =
              categoryDoc.id; // Add the category ID to the data
          categoryList.add(categoryData);

          // Fetch products for this category
          await fetchProductsForCategory(categoryDoc.id);
        }
        categoryData.value = categoryList; // Assign fetched categories
      }
      isLoading.value = false; // Stop loading
    } catch (e) {
      isLoading.value = false; // Stop loading in case of error
      print("Error fetching categories: ${e.toString()}");
    }
  }

  Future<void> fetchProductsForCategory(String categoryId) async {
    try {
      // Fetch products from the 'products' sub-collection of the current category
      final QuerySnapshot productSnapshot =
          await firebase.collection("products").get();

      if (productSnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> productList = [];
        for (var productDoc in productSnapshot.docs) {
          var productData = productDoc.data() as Map<String, dynamic>;
          productData['id'] = productDoc.id; // Add the product ID
          productList.add(productData);
        }
        productsByCategory[categoryId] =
            productList; // Store products for this category
      }
    } catch (e) {
      print("Error fetching products: ${e.toString()}");
    }
  }

  void searchProducts(String query) {}
}
