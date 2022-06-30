import 'package:flutter/material.dart';

class CardinFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool? obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final String hintText;
  final bool isPassword;
  final void Function()? iconTap;
  final bool? tap;

  const CardinFormField({
    Key? key,
    required this.controller,
    this.obscureText,
    required this.keyboardType,
    required this.hintText,
    required this.isPassword,
    required this.validator,
    this.iconTap,
    this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 240, 240, 240),
        isDense: true,
        suffixIcon: isPassword
            ? InkWell(
                onTap: iconTap,
                child: Icon(
                  tap! ? Icons.visibility : Icons.visibility_off,
                  color: const Color.fromRGBO(119, 0, 187, 1),
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        contentPadding: const EdgeInsets.all(15),
      ),
    );
  }
}
