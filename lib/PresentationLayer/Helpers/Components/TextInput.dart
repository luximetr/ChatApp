
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {

  final TextEditingController controller;
  final bool obscureText;
  final bool autocorrect;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final TextInputType keyboardType;
  final String placeholder;
  final Widget suffixIcon;
  final String errorText;

  TextInput({
    this.controller,
    this.obscureText = false,
    this.autocorrect = false,
    this.focusNode,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
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
        focusNode: focusNode,
        textInputAction: textInputAction,
        onChanged: onChanged,
        keyboardType: keyboardType,
        style: TextStyle(color: appearance.text.primary),
        onSubmitted: onSubmitted,
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