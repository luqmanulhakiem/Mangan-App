import 'package:flutter/material.dart';
import 'package:mangan/src/core/endpoints/app_endpoints.dart';
import 'package:mangan/src/core/entities/restaurant_entity.dart';
import 'package:mangan/src/features/detail/presentation/pages/menu_page.dart';
import 'package:mangan/src/features/detail/presentation/provider/favorite_detail_provider.dart';
import 'package:mangan/src/features/detail/presentation/provider/favorite_detail_result_state.dart';
import 'package:mangan/src/features/detail/presentation/provider/restaurant_provider.dart';
import 'package:mangan/src/features/detail/presentation/provider/restaurant_result_state.dart';
import 'package:mangan/src/features/detail/presentation/widgets/favorite_button_widget.dart';
import 'package:mangan/src/shared/widgets/failed_widget.dart';
import 'package:mangan/src/shared/widgets/hero_image_widget.dart';
import 'package:mangan/src/shared/widgets/loading_widget.dart';
import 'package:mangan/src/shared/widgets/start_rating_widget.dart';
import 'package:mangan/src/shared/widgets/text_header_widget.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String id, label, pictureId;
  const DetailPage({
    super.key,
    required this.id,
    required this.label,
    required this.pictureId,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late RestaurantEntity data;
  @override
  void initState() {
    super.initState();
    final restaurantProvider = context.read<RestaurantProvider>();
    final favoriteProvider = context.read<FavoriteDetailProvider>();

    Future.microtask(() {
      restaurantProvider.getRestaurant(id: widget.id);
      favoriteProvider.loadFavorite(id: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextHeaderWidget(title: widget.label),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.sizeOf(context).width,
                maxWidth: MediaQuery.sizeOf(context).width,
                minHeight: 250,
                maxHeight: 300,
              ),
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: ClipRRect(
                      borderRadius: const BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(15),
                        bottomStart: Radius.circular(15),
                      ),
                      child: HeroImageWidget(
                        url: AppEndpoints.mediumPictureRestaurant(
                          idPicture: widget.pictureId,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 30,
                    child: Consumer<FavoriteDetailProvider>(
                      builder: (context, value, child) {
                        return switch (value.resultState) {
                          FavoriteDetailLoadingState() =>
                            const CircularProgressIndicator.adaptive(),
                          FavoriteDetailLoadedState(
                            isFavorite: var isFavorite
                          ) =>
                            FavoriteButtonWidget(
                              onPressed: () {
                                if (isFavorite) {
                                  value.removeFavorite(widget.id);
                                } else {
                                  value.addFavorite(restaurant: data);
                                }
                              },
                              savedFavorite: isFavorite,
                            ),
                          _ => const SizedBox(),
                        };
                      },
                    ),
                  )
                ],
              ),
            ),
            Consumer<RestaurantProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantLoadingState() => const LoadingWidget(),
                  RestaurantErrorState(error: var error) => FailedWidget(
                      error: error,
                      onPressed: () {
                        value.getRestaurant(id: widget.id);
                      },
                    ),
                  RestaurantLoadedState(data: RestaurantEntity respData) =>
                    _loadedDataWidget(respData),
                  _ => const SizedBox(),
                };
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (
                context,
                animation,
                secondaryAnimation,
              ) {
                return MenuPage(
                  foods: data.foods ?? [],
                  drinks: data.drinks ?? [],
                );
              },
            ),
          );
        },
        tooltip: "Menu",
        child: const Icon(Icons.menu),
      ),
    );
  }

  Widget _loadedDataWidget(RestaurantEntity respData) {
    data = respData;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            respData.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Row(
            children: [
              const Icon(
                Icons.location_pin,
                color: Colors.grey,
              ),
              Text(
                "${respData.address}, ${respData.city}",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox.square(dimension: 10),
          Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rating: ${respData.rating}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      StartRatingWidget(rating: respData.rating),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox.square(dimension: 10),
          Text(
            respData.description ?? "",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox.square(dimension: 100),
        ],
      ),
    );
  }
}
