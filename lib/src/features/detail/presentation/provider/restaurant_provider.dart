import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mangan/src/features/detail/presentation/provider/restaurant_result_state.dart';
import 'package:mangan/src/shared/data/repositories/restaurant_repositories_impl.dart';

class RestaurantProvider extends ChangeNotifier {
  RestaurantResultState _resultState = RestaurantInitialState();
  RestaurantResultState get resultState => _resultState;

  Future<void> getRestaurant({required String id}) async {
    _resultState = RestaurantLoadingState();
    notifyListeners();

    try {
      final response =
          await RestaurantRepositoriesImpl().getSingleRestaurant(id: id);
      _resultState = RestaurantLoadedState(data: response);
    } catch (e) {
      if (e is ClientException) {
        _resultState = RestaurantErrorState(error: e.message);
        debugPrint('ClientException: ${e.message}');
      } else if (e is HttpException) {
        _resultState = RestaurantErrorState(error: e.message);
        debugPrint('HttpException: ${e.message}');
      } else {
        _resultState = RestaurantErrorState(error: 'Unknown error: $e');
        debugPrint('Unknown error: $e');
      }
    }

    notifyListeners();
  }
}
