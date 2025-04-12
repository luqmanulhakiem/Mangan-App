import 'package:flutter/material.dart';

class FailedWidget extends StatelessWidget {
  final String error;
  final VoidCallback onPressed;
  const FailedWidget({super.key, required this.error, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(error),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
