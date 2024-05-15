import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String content;
  final String date;
  const MessageWidget({super.key, required this.content, required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xFF007CE1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          child: Text(content),
        ),
        Text(date)
      ],
    );
  }
}
