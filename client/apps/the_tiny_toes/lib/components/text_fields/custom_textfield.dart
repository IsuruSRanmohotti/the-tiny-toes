import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hint,
      this.icon,
      this.isPassword = false,
      required this.controller,
      this.isEnabled = true,
      this.iconColor,
      this.onChanged,
      this.fillColor,
      this.inputType,
      this.maxLength});

  final String hint;
  final bool isPassword;
  final IconData? icon;
  final Color? fillColor;
  final TextEditingController? controller;
  final bool isEnabled;
  final Color? iconColor;
  final Function(String)? onChanged;
  final TextInputType? inputType;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        keyboardType: inputType,
        onChanged: onChanged,
        enabled: isEnabled,
        maxLength: maxLength,
        controller: controller,
        cursorColor: Colors.grey.shade500,
        obscureText: isPassword,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15)),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade700, fontSize: 16),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            prefixIcon: Icon(
              hint.toLowerCase().contains('email')
                  ? Icons.email
                  : hint.toLowerCase().contains('password')
                      ? Icons.password
                      : icon,
              color: iconColor,
            ),
            filled: true,
            fillColor: fillColor ?? Colors.grey.shade300),
        style:  TextStyle(color: Colors.grey.shade900, fontSize: 18),
      ),
    );
  }
}
