import 'package:bookstore/controller/signupcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bookstore/controller/logincontroller.dart'; // Assuming you have a LoginController
import 'package:bookstore/views/auth/signupscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final con = Get.put(LoginController());
    final conn = Get.put(SignUpController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // Header with Animation (Can re-use same as Signup)
                Stack(
                  children: [
                    ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 26, 118, 193),
                              Color.fromARGB(255, 0, 167, 189),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(
                              context); // Go back to the previous page
                        },
                        child: const Icon(
                          Icons.close,
                          size: 28,
                          color: Color.fromARGB(255, 244, 244, 244),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 20,
                      right: 20,
                      child: SizedBox(
                        height: 150,
                        child: Lottie.asset('assets/animations/book.json'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 0),

                // Login Form Section
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Column(
                    children: [
                      // Email TextField
                      buildTextField(con.emailController, 'Email', Icons.email),
                      const SizedBox(height: 20),

                      // Password TextField
                      buildPasswordField(con),
                      const SizedBox(height: 30),

                      // Login Button
                      buildLoginButton(con, context),

                      const SizedBox(height: 20),

                      // "Connect with Us" Text and Google Button
                      buildGoogleSignUp(conn),

                      const SizedBox(height: 20),

                      // Sign Up Button
                      buildSignUpButton(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable TextField Builder for Email and other fields
  Widget buildTextField(
      TextEditingController controller, String hint, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: Icon(icon, color: const Color.fromARGB(193, 0, 0, 0)),
        hintText: hint,
        hintStyle:
            GoogleFonts.roboto(color: const Color.fromARGB(255, 53, 53, 53)),
        filled: true,
        fillColor: const Color.fromARGB(255, 210, 241, 255),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Password Field with Toggle
  Widget buildPasswordField(LoginController con) {
    return Obx(() {
      return TextField(
        controller: con.passController,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: con.isToggle,
            icon: Icon(
              con.isObscure.value ? Icons.visibility : Icons.visibility_off,
              color: const Color.fromARGB(194, 0, 0, 0),
            ),
          ),
          hintText: "Password",
          hintStyle:
              GoogleFonts.roboto(color: const Color.fromARGB(203, 3, 3, 3)),
          filled: true,
          fillColor: const Color.fromARGB(255, 214, 239, 255),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        obscureText: con.isObscure.value,
      );
    });
  }

  // Login Button
  Widget buildLoginButton(LoginController con, BuildContext context) {
    return InkWell(
      onTap: () {
        con.myLogin();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 167, 189),
              Color.fromARGB(255, 26, 118, 193)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 5,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Center(
          child: Text(
            "Login",
            style: GoogleFonts.openSans(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

// Google Sign Up Button
  Widget buildGoogleSignUp(SignUpController conn) {
    return Column(
      children: [
        // "Connect with Us" Text
        Text(
          "Or connect with Us",
          style: GoogleFonts.roboto(
            color: const Color.fromARGB(255, 84, 83, 83),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10), // Add some space between text and button

        // Google Sign Up Button
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey[400], thickness: 1.5)),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: () {
                  conn.googleSignUp();
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                        color: const Color.fromARGB(255, 175, 175, 175),
                        width: 1.5),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Image.asset('assets/icons/google-icon.png',
                        height: 24, width: 24),
                  ),
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey[400], thickness: 1.5)),
          ],
        ),
      ],
    );
  }
}

// Sign Up Button
Widget buildSignUpButton(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          Get.to(() => const SignUpScreen(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 900));
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeInCubic,
          width: 150,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 5,
                  offset: Offset(0, 0)),
            ],
          ),
          child: Center(
            child: Text(
              "Go to Sign Up",
              style: GoogleFonts.openSans(
                  color: const Color.fromARGB(255, 107, 107, 107),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ],
  );
}

// Custom ClipPath for Unique Header Shape
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 220);
    path.quadraticBezierTo(size.width / 4, 160, size.width / 2, 175);
    path.quadraticBezierTo(3 / 4 * size.width, 190, size.width, 130);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
