import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mangan/src/features/home/presentation/provider/restaurant_list_result_state.dart';
import 'package:mangan/src/shared/data/repositories/restaurant_repositories_impl.dart';

class RestaurantListProvider extends ChangeNotifier {
  RestaurantListResultState _resultState = RestaurantListInitialState();
  RestaurantListResultState get resultState => _resultState;

  Future<void> getRestaurantList() async {
    _resultState = RestaurantListLoadingState();
    notifyListeners();

    try {
      final response = await RestaurantRepositoriesImpl().getRestaurants();
      _resultState = RestaurantListLoadedState(data: response);
    } catch (e) {
      final err = e as ClientException;
      _resultState = RestaurantListErrorState(error: err.message);
      debugPrint(err.message);
    }

    notifyListeners();
  }
}
