import 'package:flutter/material.dart';
import 'package:mangan/src/core/entities/restaurant_entity.dart';
import 'package:mangan/src/features/detail/presentation/pages/detail_page.dart';
import 'package:mangan/src/features/home/presentation/provider/restaurant_list_provider.dart';
import 'package:mangan/src/features/home/presentation/provider/restaurant_list_result_state.dart';
import 'package:mangan/src/features/home/presentation/widgets/item_restaurant_widget.dart';
import 'package:mangan/src/shared/provider/theme_provider.dart';
import 'package:mangan/src/shared/widgets/empty_widget.dart';
import 'package:mangan/src/shared/widgets/loading_widget.dart';
import 'package:mangan/src/shared/widgets/text_header_widget.dart';
import 'package:mangan/src/shared/widgets/failed_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final restaurantListProvider = context.read<RestaurantListProvider>();
    Future.microtask(() {
      restaurantListProvider.getRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const TextHeaderWidget(title: "Mangan"),
        actions: [
          IconButton(
            onPressed: () async {
              final savedTheme = await themeProvider.getThemePreferences();
              themeProvider.toggleTheme(!savedTheme);
            },
            icon: Icon(
              isDarkMode ? Icons.nightlight_round : Icons.sunny,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
              Consumer<RestaurantListProvider>(
                builder: (context, value, child) {
                  return switch (value.resultState) {
                    RestaurantListLoadingState() => const LoadingWidget(),
                    RestaurantListErrorState(error: var message) =>
                      FailedWidget(
                        error: message,
                        onPressed: () {
                          value.getRestaurantList();
                        },
                      ),
                    RestaurantListLoadedState(
                      data: List<RestaurantEntity> data,
                    ) =>
                      data.isEmpty
                          ? const EmptyWidget(label: "Empty Restaurants Data")
                          : ListView.builder(
                              itemCount: data.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return ItemRestaurantWidget(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      PageRouteBuilder(
                                        pageBuilder: (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) {
                                          return DetailPage(
                                            id: item.id,
                                            label: item.name,
                                            pictureId: item.pictureId,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  picture: item.pictureId,
                                  name: item.name,
                                  location: item.city,
                                  rating: item.rating,
                                );
                              },
                            ),
                    _ => const SizedBox(),
                  };
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
