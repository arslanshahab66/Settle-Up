import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double height;
  final Color borderColor;
  final String prefixIconPath;
  final String hintText;
  final TextStyle hintStyle;
  final EdgeInsetsGeometry contentPadding;

  const CustomTextField({
    Key? key,
    this.height = 40,
    this.borderColor = const Color(0xff5CAF9F),
    required this.prefixIconPath,
    this.hintText = '',
    required this.hintStyle,
    required this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 1.0,
        ),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: prefixIconPath != null ? Image.asset(prefixIconPath) : null,
          ),
          hintText: hintText,
          hintStyle: hintStyle,
          border: InputBorder.none,
          contentPadding: contentPadding,
        ),
      ),
    );
  }
}
