import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String content;
  const Message({required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(fontSize: 18),
    );
  }
}
