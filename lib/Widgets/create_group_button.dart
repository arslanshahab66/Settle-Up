import 'package:flutter/material.dart';

Widget reusebaleCreateGroupButton(
  String text,
  BuildContext context,
) {
  return Container(
    height: MediaQuery.of(context).size.height * .05,
    width: MediaQuery.of(context).size.width * .9,
    decoration: BoxDecoration(
      color: const Color(0xff5CAF9F),
      borderRadius: BorderRadius.circular(40),
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xffF5F5F5),
        ),
      ),
    ),
  );
}
