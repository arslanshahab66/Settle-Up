import 'package:flutter/material.dart';

class DecisionDialog extends StatelessWidget {
  final String title;
  final void Function() onSettleUp;
  final void Function() onPayBack;

  const DecisionDialog({
    Key? key,
    required this.title,
    required this.onSettleUp,
    required this.onPayBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: onSettleUp,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff5CAF9F),
            ),
            child: const Text(
              'Settle up',
              style: TextStyle(fontSize: 15),
            ),
          ),
          const Text('Or'),
          ElevatedButton(
            onPressed: onPayBack,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff5CAF9F),
            ),
            child: const Text(
              'I owe to',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

void showDecisionDialog(BuildContext context, String title,
    void Function() onSettleUp, void Function() onPayBack) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DecisionDialog(
        title: title,
        onSettleUp: onSettleUp,
        onPayBack: onPayBack,
      );
    },
  );
}
