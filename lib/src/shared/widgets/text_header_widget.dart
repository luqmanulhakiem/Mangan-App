import 'package:flutter/material.dart';

class TextHeaderWidget extends StatelessWidget {
  final String title;
  const TextHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
