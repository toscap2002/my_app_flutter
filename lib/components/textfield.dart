import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget{

  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Padding build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 5, color: Colors.orange),
            borderRadius: BorderRadius.circular(50.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
          ),
          fillColor: Colors.grey[800],
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}




