import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemRestaurantWidget extends StatelessWidget {
  final String name, location, rating;
  const ItemRestaurantWidget(
      {super.key,
      required this.name,
      required this.location,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          if (kDebugMode) print("Tapped");
        },
        child: Row(
          children: [
            Container(
              height: 70,
              width: 100,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_pin),
                    const SizedBox(width: 2),
                    Text(
                      location,
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.star),
                    const SizedBox(width: 2),
                    Text(
                      rating,
                      style: textTheme.bodyMedium,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
