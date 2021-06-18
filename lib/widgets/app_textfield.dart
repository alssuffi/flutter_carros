import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final InputBorder border;
  final FocusNode focusNode;
  final FocusNode nextFocus; // eu quem criei esse parametro novo
  final TextStyle hintStyle;

  AppTextField({
    @required this.label,
    @required this.hint,
    this.obscureText = false,
    @required this.controller,
    @required this.validator,
    @required this.keyboardType,
    this.textInputAction,
    this.border,
    this.focusNode,
    this.nextFocus,
    this.hintStyle,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      decoration: InputDecoration(
        border: border,
        labelText: label,
        hintText: hint,
        hintStyle: hintStyle,
      ),
    );
  }
}
