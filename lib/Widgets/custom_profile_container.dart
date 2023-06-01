import 'package:flutter/material.dart';

class ProfileContainer extends StatelessWidget {
  final String imageAsset;
  final String name;

  const ProfileContainer({super.key, 
    required this.imageAsset,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 50,
          width: 125,
          decoration: BoxDecoration(
            color: const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xff5CAF9F),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(imageAsset),
                ),
                const SizedBox(width: 8),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Transform.translate(
            offset: const Offset(8, -8),
            child: const CircleAvatar(
              radius: 12,
              backgroundColor: Color(0xff5CAF9F),
              child: Image(
                height: 10,
                image: AssetImage('assets/cross.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
