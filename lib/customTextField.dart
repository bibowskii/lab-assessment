import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {
  final IconData? icon;
  final String? htext;
  final String? ltext;
  final TextEditingController controller;
  final String? Function(String?) validator;  // Specify the correct function type here
  final bool obsecureText;

  const Customtextfield({
    super.key,
    this.icon,
    this.htext,
    required this.controller,
    required this.ltext,
    required this.obsecureText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,  // Pass the function itself, not a call to it
        obscureText: obsecureText,
        decoration: InputDecoration(
          hintText: htext,
          labelText: ltext,
          icon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Icon(icon),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
