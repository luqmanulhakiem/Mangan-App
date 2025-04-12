class FoodEntity {
  final String name;

  FoodEntity({required this.name});

  factory FoodEntity.fromJson(Map<String, dynamic> json) {
    return FoodEntity(name: json['name']);
  }
}
