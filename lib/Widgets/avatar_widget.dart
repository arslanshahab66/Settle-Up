import 'package:flutter/material.dart';

class CircleAvatarWithInitial extends StatelessWidget {
  final String displayName;

  const CircleAvatarWithInitial({
    required this.displayName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xff5CAF9F),
      child: Text(
        displayName.isNotEmpty ? displayName[0].toUpperCase() : '',
        style: const TextStyle(
          color: Colors.white,
        ),
        
      ),
    );
  }
}
