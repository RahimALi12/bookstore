// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomeTextField extends StatelessWidget {
  final TextEditingController controller;
  final Icon sufIcon;
  final isObs = false;
  final String Hint;

  const CustomeTextField(
      {super.key,
      required this.controller,
      required this.sufIcon,
      required this.Hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObs,
      controller: controller,
      decoration: InputDecoration(
          suffixIcon: sufIcon,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: Hint),
    );
  }
}
