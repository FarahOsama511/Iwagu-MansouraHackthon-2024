import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  String? hint;
  bool obscureText;
  String? obscuringchar;
  Widget? suffix;
  TextEditingController? controller;
  void Function()? onEdit;
  String? Function(String?)? validator;

  Textfield(
      {required this.obscureText,
      this.obscuringchar,
      this.suffix,
      this.controller,
      this.onEdit,
      this.validator,
      this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 60,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.always,
          // validator: validator,
          // onEditingComplete: onEdit,
          controller: controller,
          style: TextStyle(color: Colors.black),
          cursorColor: Colors.black,
          obscureText: obscureText,
          obscuringCharacter: obscuringchar ?? "*",
          decoration: InputDecoration(
            suffix: suffix,
            hintText: hint,
            hintStyle:
                TextStyle(color: const Color.fromARGB(255, 138, 137, 137)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
