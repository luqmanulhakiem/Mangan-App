import 'package:flutter/material.dart';

class StartRatingWidget extends StatelessWidget {
  final num rating;
  const StartRatingWidget({super.key, required this.rating});

  Widget starRating(final BuildContext context, final int index) {
    Icon icon;
    if (index >= rating) {
      icon = const Icon(
        Icons.star_border_outlined,
        color: Colors.orange,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = const Icon(
        Icons.star_half,
        color: Colors.orange,
      );
    } else {
      icon = const Icon(
        Icons.star,
        color: Colors.orange,
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (final index) => starRating(context, index),
      ),
    );
  }
}
