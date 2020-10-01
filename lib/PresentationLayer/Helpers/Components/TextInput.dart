
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {

  final TextEditingController controller;
  final bool obscureText;
  final bool autocorrect;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final String placeholder;
  final Widget suffixIcon;
  final String errorText;

  TextInput({
    this.controller,
    this.obscureText = false,
    this.autocorrect = false,
    this.onChanged,
    this.keyboardType,
    this.placeholder,
    this.suffixIcon,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        autocorrect: autocorrect,
        onChanged: onChanged,
        keyboardType: keyboardType,
        style: TextStyle(color: appearance.text.primary),
        decoration: InputDecoration(
          labelText: placeholder,
          filled: true,
          fillColor: appearance.background.secondary,
          labelStyle: TextStyle(color: appearance.text.secondary),
          suffixIcon: suffixIcon,
          errorText: errorText,
        ),
      ),
    );
  }
}