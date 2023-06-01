import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String hintText;
  final Function(String) onAdd;
  final Function(String) onEdit;

  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.hintText,
    required this.onAdd,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 17),
      ),
      content: Card(
        elevation: 4.0,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xffD9D9D9),
            width: 1.0,
          ),
        ),
        child: TextFormField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(
                  color: Color(0xffC1C5C8), fontWeight: FontWeight.bold),
              contentPadding: const EdgeInsets.only(left: 20)),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  onEdit('');
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Edit',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff5CAF9F),
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  onAdd('');
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Add',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff5CAF9F),
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
