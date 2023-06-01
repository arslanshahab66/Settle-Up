import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String leadingImagePath;
  final String title;
  final String subtitle1;
  final String trailingIconPath;
  final String trailingText;
  final String trailingSubtext;
  final Color color;

  const CustomListTile({
    Key? key,
    required this.leadingImagePath,
    required this.title,
    required this.subtitle1,
    required this.trailingIconPath,
    required this.trailingText,
    required this.trailingSubtext,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              height: 30,
              image: AssetImage(leadingImagePath),
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    subtitle1,
                    style: const TextStyle(
                      color: Color(0xffC1C5C8),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                '2 Days ago',
                style: TextStyle(
                  color: Color(0xffC1C5C8),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      height: 15,
                      image: AssetImage(trailingIconPath),
                    ),
                    Text(
                      trailingText,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1C9611),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  trailingSubtext,
                  style: const TextStyle(
                    color: Color(0xffC1C5C8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
