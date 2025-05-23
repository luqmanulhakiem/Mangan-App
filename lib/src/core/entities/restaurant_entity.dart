import 'package:mangan/src/core/entities/drink_entity.dart';
import 'package:mangan/src/core/entities/food_entity.dart';

class RestaurantEntity {
  final String id, name, pictureId, city;
  final num rating;
  final String? address, description;
  final List<FoodEntity>? foods;
  final List<DrinkEntity>? drinks;

  RestaurantEntity({
    required this.id,
    required this.name,
    this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.foods,
    this.drinks,
    this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'pictureId': pictureId,
      'rating': rating,
    };
  }

  factory RestaurantEntity.fromJson(Map<String, dynamic> json) {
    return RestaurantEntity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: json['rating'],
      foods: json['menus'] != null
          ? (json['menus']['foods'] as List)
              .map((json) => FoodEntity.fromJson(json))
              .toList()
          : [],
      drinks: json['menus'] != null
          ? (json['menus']['drinks'] as List)
              .map((json) => DrinkEntity.fromJson(json))
              .toList()
          : [],
      address: json['address'],
    );
  }
}
