import 'package:flutter/material.dart';

class GlobalButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  const GlobalButton({required this.icon, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: CircleAvatar(radius: 70, child: Icon(icon, size: 70)));
  }
}
