import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String label;
  const EmptyWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(label),
    );
  }
}
