import 'package:flutter/material.dart';

class CustomNoteButton extends StatelessWidget {
  final String buttonText;
  final String buttonIconAsset;

  const CustomNoteButton({super.key, 
    required this.buttonText,
    required this.buttonIconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4, // Adjust the elevation value as needed
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 55,
        width: 342,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xff5CAF9F),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                width: 40,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xff5CAF9F),
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(
                    height: 25,
                    width: 25,
                    image: AssetImage(buttonIconAsset),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 25),
            Text(
              buttonText,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
