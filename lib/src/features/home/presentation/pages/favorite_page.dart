import 'package:flutter/material.dart';
import 'package:mangan/src/core/entities/restaurant_entity.dart';
import 'package:mangan/src/features/detail/presentation/pages/detail_page.dart';
import 'package:mangan/src/features/home/presentation/provider/favorite_list_provider.dart';
import 'package:mangan/src/features/home/presentation/provider/favorite_list_result_state.dart';
import 'package:mangan/src/features/home/presentation/widgets/item_restaurant_widget.dart';
import 'package:mangan/src/shared/widgets/empty_widget.dart';
import 'package:mangan/src/shared/widgets/failed_widget.dart';
import 'package:mangan/src/shared/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    final restaurantListProvider = context.read<FavoriteListProvider>();
    Future.microtask(() {
      restaurantListProvider.getFavoriteRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Consumer<FavoriteListProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  FavoriteListLoadingState() => const LoadingWidget(),
                  FavoriteListFailureState(error: var message) => FailedWidget(
                      error: message,
                      onPressed: () {
                        value.getFavoriteRestaurants();
                      },
                    ),
                  FavoriteListLoadedState(
                    data: List<RestaurantEntity> data,
                  ) =>
                    data.isEmpty
                        ? const EmptyWidget(
                            label: "Empty Favorite Restaurants Data",
                          )
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
                                  ).then((_) {
                                    value.getFavoriteRestaurants();
                                  });
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
    );
  }
}
