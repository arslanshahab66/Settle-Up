import 'package:flutter/material.dart';

class CustomCircleIcon extends StatelessWidget {
  final Color color;
  final String image;
  final String text;

  const CustomCircleIcon({
    Key? key,
    required this.color,
    required this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              height: 25,
              image: AssetImage(image),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
