import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mangan/src/core/entities/restaurant_entity.dart';
import 'package:mangan/src/shared/data/repositories/restaurant_repositories_impl.dart';

class RestaurantListProvider extends ChangeNotifier {
  final List<RestaurantEntity> _restaurantList = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isError = false;
  bool get isError => _isError;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  List<RestaurantEntity> get restaurantList => _restaurantList;

  void getRestaurantList() async {
    _isLoading = true;
    _isError = false;
    _errorMessage = "";
    notifyListeners();

    try {
      final response = await RestaurantRepositoriesImpl().getRestaurants();
      _restaurantList
        ..clear()
        ..addAll(response);
    } catch (e) {
      _isError = true;
      final err = e as ClientException;
      _errorMessage = "Error fetching restaurants: ${err.message}";
      debugPrint(_errorMessage);
    }
    _isLoading = false;

    notifyListeners();
  }
}
