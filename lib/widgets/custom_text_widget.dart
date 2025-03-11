import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String title;
  final String? subtitle;

  const CustomTextWidget({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 5),
          Text(
            subtitle!,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ]
      ],
    );
  }
}
