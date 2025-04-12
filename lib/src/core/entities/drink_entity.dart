class DrinkEntity {
  final String name;

  DrinkEntity({required this.name});

  factory DrinkEntity.fromJson(Map<String, dynamic> json) {
    return DrinkEntity(name: json['name']);
  }
}
