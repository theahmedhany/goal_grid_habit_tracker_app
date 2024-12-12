import 'package:flutter/material.dart';

class CustomAlertBox extends StatelessWidget {
  const CustomAlertBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.hintText,
    required this.buttonText,
  });

  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String hintText;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xff014F86).withOpacity(0.9),
      content: SizedBox(
        height: 250,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                '$buttonText Habit',
                style: const TextStyle(
                  fontSize: 28,
                  color: Color(0xffA9D6E5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextField(
              controller: controller,
              style: const TextStyle(
                color: Color(0xffA9D6E5),
                fontSize: 18,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                  left: 24,
                  top: 16,
                  bottom: 16,
                ),
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color(0xffA9D6E5),
                  fontSize: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Color(0xffA9D6E5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Color(0xffA9D6E5),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 130,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffC62E2E),
                    ),
                    onPressed: onCancel,
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 130,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff012A4A),
                    ),
                    onPressed: onSave,
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
