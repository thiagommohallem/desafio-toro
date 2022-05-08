import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:toro_app/colors.dart';

class ToroTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const ToroTextFormField({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: toroPrimaryColor,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
        floatingLabelStyle: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
        errorStyle: const TextStyle(
          fontSize: 15,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(26),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(26)),
      ),
    );
  }
}
