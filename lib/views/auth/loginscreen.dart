// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bookstore/controller/logincontroller.dart';
import 'package:bookstore/views/auth/signupscreen.dart';
import 'package:bookstore/widgets/customtextfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final con = Get.put(LoginController());
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                "Login",
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
                  Hint: "Enter Your Email"),
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
              InkWell(
                onTap: () {
                  // print(con.emailController.text.trim());
                  // print(con.userController.text.trim());
                  // print(con.passController.text.trim());

                  con.myLogin();
                },
                child: Container(
                  width: Get.width * 0.5,
                  height: Get.height * 0.05,
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Center(
                    child: Text("Login"),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Already have an account?"),
              SizedBox(
                height: 15,
              ),

              ElevatedButton(
                onPressed: () {
                  Get.to(SignUpScreen());
                },
                child: Text("Sin Up"),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
