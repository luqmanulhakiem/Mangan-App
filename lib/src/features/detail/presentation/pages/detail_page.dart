import 'package:flutter/material.dart';
import 'package:mangan/src/core/endpoints/app_endpoints.dart';
import 'package:mangan/src/core/entities/restaurant_entity.dart';
import 'package:mangan/src/features/detail/presentation/pages/menu_page.dart';
import 'package:mangan/src/shared/data/repositories/restaurant_repositories_impl.dart';
import 'package:mangan/src/shared/widgets/hero_image_widget.dart';
import 'package:mangan/src/shared/widgets/start_rating_widget.dart';
import 'package:mangan/src/shared/widgets/text_header_widget.dart';

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
  late Future<RestaurantEntity> _dataResponse;
  late RestaurantEntity data;
  @override
  void initState() {
    super.initState();
    _dataResponse = RestaurantRepositoriesImpl().getSingleRestaurant(
      id: widget.id,
    );
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
                    data = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.name,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: Colors.grey,
                              ),
                              Text(
                                data.city,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Rating: ${data.rating}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      StartRatingWidget(rating: data.rating),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox.square(dimension: 10),
                          Text(
                            data.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox.square(dimension: 100),
                        ],
                      ),
                    );
                  default:
                    return const SizedBox();
                }
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
}
