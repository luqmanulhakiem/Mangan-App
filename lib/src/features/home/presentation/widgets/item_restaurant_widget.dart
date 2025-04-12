import 'package:flutter/material.dart';
import 'package:mangan/src/core/endpoints/app_endpoints.dart';
import 'package:mangan/src/shared/widgets/hero_image_widget.dart';

class ItemRestaurantWidget extends StatelessWidget {
  final String name, location, picture;
  final VoidCallback onPressed;
  final num rating;
  const ItemRestaurantWidget({
    super.key,
    required this.name,
    required this.location,
    required this.picture,
    required this.rating,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 80,
                minHeight: 80,
                maxWidth: 120,
                minWidth: 120,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: HeroImageWidget(
                  url: AppEndpoints.smallPictureRestaurant(idPicture: picture),
                ),
              ),
            ),
            const SizedBox.square(dimension: 8),
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
                      rating.toString(),
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
