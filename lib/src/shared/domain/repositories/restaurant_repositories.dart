import 'package:mangan/src/core/entities/restaurant_entity.dart';

abstract class RestaurantRepositories {
  Future<List<RestaurantEntity>> getRestaurants();
  Future<RestaurantEntity> getSingleRestaurant({required String id});
}
