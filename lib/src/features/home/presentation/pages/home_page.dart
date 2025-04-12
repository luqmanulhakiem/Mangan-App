import 'package:flutter/material.dart';
import 'package:mangan/src/core/entities/restaurant_entity.dart';
import 'package:mangan/src/features/detail/presentation/pages/detail_page.dart';
import 'package:mangan/src/features/home/presentation/widgets/item_restaurant_widget.dart';
import 'package:mangan/src/shared/data/repositories/restaurant_repositories_impl.dart';
import 'package:mangan/src/shared/provider/theme_provider.dart';
import 'package:mangan/src/shared/widgets/text_header_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<RestaurantEntity>> _dataResponse;
  @override
  void initState() {
    super.initState();
    _dataResponse = RestaurantRepositoriesImpl().getRestaurants();
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
              FutureBuilder(
                future: _dataResponse,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return ErrorWidget(snapshot.error.toString());
                      }
                      final data = snapshot.data;

                      return ListView.builder(
                        itemCount: data?.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = data![index];
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
                      );
                    default:
                      return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
