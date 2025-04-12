import 'dart:convert';

import 'package:mangan/src/core/endpoints/app_endpoints.dart';
import 'package:mangan/src/core/entities/restaurant_entity.dart';
import 'package:mangan/src/shared/domain/repositories/restaurant_repositories.dart';
import 'package:http/http.dart' as http;

class RestaurantRepositoriesImpl implements RestaurantRepositories {
  @override
  Future<List<RestaurantEntity>> getRestaurants() async {
    final url = Uri.https(AppEndpoints.baseUrl, AppEndpoints.listRestaurant);
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final jsonResponse = jsonDecode(resp.body);
      final entityResponse = (jsonResponse['restaurants'] as List)
          .map((json) => RestaurantEntity.fromJson(json))
          .toList();
      return entityResponse;
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  @override
  Future<RestaurantEntity> getSingleRestaurant({required String id}) async {
    final url =
        Uri.https(AppEndpoints.baseUrl, AppEndpoints.detailRestaurant(id: id));
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final jsonResponse = jsonDecode(resp.body);
      final entityResponse =
          RestaurantEntity.fromJson(jsonResponse['restaurant']);
      return entityResponse;
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }
}
