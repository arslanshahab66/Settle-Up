import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget {
  final String text;
  final String iconAsset;

  const CustomBadge({super.key, 
    required this.text,
    required this.iconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      width: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xff5CAF9F), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Image(
            height: 10,
            image: AssetImage(iconAsset),
          ),
        ],
      ),
    );
  }
}
