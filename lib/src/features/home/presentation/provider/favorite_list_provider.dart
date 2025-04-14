import 'package:flutter/material.dart';
import 'package:mangan/src/features/home/presentation/provider/favorite_list_result_state.dart';
import 'package:mangan/src/shared/data/datasources/localdatasources/sqflite_service.dart';

class FavoriteListProvider extends ChangeNotifier {
  final SqfliteService _service;

  FavoriteListProvider(this._service);

  FavoriteListResultState _resultState = FavoriteListInitialState();
  FavoriteListResultState get resultState => _resultState;

  Future<void> getFavoriteRestaurants() async {
    _resultState = FavoriteListLoadingState();
    notifyListeners();
    try {
      final response = await _service.getAllItems();
      _resultState = FavoriteListLoadedState(data: response);
      notifyListeners();
    } catch (e) {
      const errMsg = "Failed to load Favorite Restaurants";
      _resultState = FavoriteListFailureState(
        error: errMsg,
      );
      notifyListeners();

      debugPrint(errMsg);
    }
  }
}
