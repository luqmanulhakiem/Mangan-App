import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mangan/src/features/detail/presentation/provider/restaurant_result_state.dart';
import 'package:mangan/src/shared/data/repositories/restaurant_repositories_impl.dart';

class RestaurantProvider extends ChangeNotifier {
  RestaurantResultState _resultState = RestaurantInitialState();
  RestaurantResultState get resultState => _resultState;

  void getRestaurant({required String id}) async {
    _resultState = RestaurantLoadingState();
    notifyListeners();

    try {
      final response =
          await RestaurantRepositoriesImpl().getSingleRestaurant(id: id);
      _resultState = RestaurantLoadedState(data: response);
    } catch (e) {
      final err = e as ClientException;
      _resultState = RestaurantErrorState(error: err.message);
      debugPrint(err.message);
    }

    notifyListeners();
  }
}
