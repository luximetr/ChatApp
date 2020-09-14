
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {

  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String placeholder;

  TextInput({
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.placeholder
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(color: appearance.text.primary),
      decoration: InputDecoration(
        labelText: placeholder,
        filled: true,
        fillColor: appearance.background.secondary,
        labelStyle: TextStyle(color: appearance.text.secondary),
      ),
    );
  }
}