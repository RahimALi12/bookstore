// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bookstore/controller/signupcontroller.dart';
import 'package:bookstore/views/auth/loginscreen.dart';
import 'package:bookstore/widgets/customtextfield.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final con = Get.put(SignUpController());
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                "Sign Up",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              // TextField(
              //   decoration: InputDecoration(
              //     suffixIcon: Icon(Icons.email),
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.black),
              //     ),
              //     hintText: "Enter Your Email...",
              //   ),
              // ),

              CustomeTextField(
                controller: con.emailController,
                sufIcon: Icon(Icons.email),
                Hint: "Enter Your Email",
              ),
              SizedBox(
                height: 15,
              ),
              CustomeTextField(
                controller: con.userController,
                sufIcon: Icon(Icons.person),
                Hint: "Enter Your Username",
              ),

              SizedBox(
                height: 15,
              ),
              CustomeTextField(
                  controller: con.contactController,
                  sufIcon: Icon(Icons.phone),
                  Hint: "Enter Your Contact"),
              SizedBox(
                height: 15,
              ),
              Obx(() {
                return TextField(
                  controller: con.passController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          con.isToggle();
                        },
                        icon: Icon(con.isObscure.value
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: "Enter Your Password...",
                  ),
                  obscureText: con.isObscure.value,
                );
              }),
              SizedBox(
                height: 10,
              ),
              Obx(() {
                return TextField(
                  controller: con.confirmPassController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          con.isToggleConfirm();
                        },
                        icon: Icon(con.isObscureConfirm.value
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: "Enter Your Confirm Password...",
                  ),
                  obscureText: con.isObscureConfirm.value,
                );
              }),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  if (con.ConfirmPass()) {
                    // print(con.emailController.text.trim());
                    // print(con.userController.text.trim());
                    // print(con.passController.text.trim());
                    // print(con.confirmPassController.text.trim());
                    // print(con.contactController.text.trim());

                    con.signup();
                  } else {
                    print("Password doesn't match");
                  }
                },
                child: Container(
                  width: Get.width * 0.5,
                  height: Get.height * 0.05,
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Center(
                    child: Text("Sign Up"),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text("Already have an account?"),
              SizedBox(
                height: 15,
              ),

              ElevatedButton(
                onPressed: () {
                  Get.to(LoginScreen());
                },
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
