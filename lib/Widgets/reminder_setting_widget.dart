import 'package:flutter/material.dart';

class ReminderSettingsSection extends StatelessWidget {
  final String title;
  final Widget child;

  const ReminderSettingsSection({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
          // const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 50),
            child: Column(
              children: [child],
            ),
          ),
        ],
      ),
    );
  }
}
