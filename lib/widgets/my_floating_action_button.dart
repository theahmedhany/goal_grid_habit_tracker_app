import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({
    super.key,
    required this.onPressed,
  });

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xff013A63),
      onPressed: onPressed,
      child: const Icon(
        Icons.add,
        size: 28,
        color: Colors.white,
      ),
    );
  }
}
