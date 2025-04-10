import 'package:flutter/material.dart';
import 'package:mangan/src/features/home/presentation/widgets/item_restaurant_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mangan",
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              //
            },
            icon: const Icon(
              Icons.light_mode,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Restaurant",
              style: textTheme.headlineMedium,
            ),
            Text(
              "Recommendation restaurant for you",
              style: textTheme.labelMedium,
            ),
            const SizedBox(
              height: 40,
            ),
            ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ItemRestaurantWidget(
                  name: "Restaurant $index",
                  location: "Permai",
                  rating: "2.8",
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
