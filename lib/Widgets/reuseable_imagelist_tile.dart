import 'package:flutter/material.dart';

class ImageListTile extends StatelessWidget {
  final String imageUrl;
  final String title;

  const ImageListTile({
    Key? key,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(imageUrl),
            ),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Divider(
          thickness: 1,
          color: Color(0xffD9D9D9),
        )
      ],
    );
  }
}
