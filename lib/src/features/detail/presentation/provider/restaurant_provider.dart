import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mangan/src/core/entities/restaurant_entity.dart';
import 'package:mangan/src/shared/data/repositories/restaurant_repositories_impl.dart';

class RestaurantProvider extends ChangeNotifier {
  RestaurantEntity _restaurant = RestaurantEntity(
    id: 'id',
    name: 'name',
    description: 'description',
    pictureId: 'pictureId',
    city: 'city',
    rating: 0,
  );

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isError = false;
  bool get isError => _isError;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  RestaurantEntity get restaurant => _restaurant;

  void getRestaurant({required String id}) async {
    _isLoading = true;
    _isError = false;
    _errorMessage = "";
    notifyListeners();

    try {
      final response =
          await RestaurantRepositoriesImpl().getSingleRestaurant(id: id);
      _restaurant = response;
    } catch (e) {
      _isError = true;
      final err = e as ClientException;
      _errorMessage = "Error fetching restaurant: ${err.message}";
      debugPrint(_errorMessage);
    }
    _isLoading = false;

    notifyListeners();
  }
}
