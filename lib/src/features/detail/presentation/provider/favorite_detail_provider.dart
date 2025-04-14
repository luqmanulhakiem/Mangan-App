import 'package:flutter/material.dart';
import 'package:mangan/src/core/entities/restaurant_entity.dart';
import 'package:mangan/src/features/detail/presentation/provider/favorite_detail_result_state.dart';
import 'package:mangan/src/shared/data/datasources/localdatasources/sqflite_service.dart';

class FavoriteDetailProvider extends ChangeNotifier {
  final SqfliteService _service;

  FavoriteDetailProvider(this._service);

  FavoriteDetailResultState _resultState = FavoriteDetaiInitialState();
  FavoriteDetailResultState get resultState => _resultState;

  Future<void> addFavorite({required RestaurantEntity restaurant}) async {
    try {
      final response = await _service.insertItem(restaurant);
      final isError = response == 0;
      if (isError) {
        _resultState =
            FavoriteDetailFailureState(error: "Failed to save restaurant");
      } else {
        _resultState =
            FavoriteDetailSuccessState(message: "Restaurant is saved");
        loadFavorite(id: restaurant.id);
      }

      notifyListeners();
    } catch (e) {
      _resultState =
          FavoriteDetailFailureState(error: "Failed to save restaurant");
      debugPrint(e.toString());
      notifyListeners();
    }
  }

  Future<void> loadFavorite({required String id}) async {
    _resultState = FavoriteDetailLoadingState();
    notifyListeners();

    try {
      final response = await _service.getItemById(id);
      if (response != null) {
        _resultState = FavoriteDetailLoadedState(isFavorite: true);
      } else {
        _resultState = FavoriteDetailLoadedState(isFavorite: false);
      }
      notifyListeners();
    } catch (e) {
      _resultState = FavoriteDetailFailureState(
          error: "Failed load to favorite restaurant");
      debugPrint("$e");
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String id) async {
    try {
      await _service.removeItem(id);
      _resultState =
          FavoriteDetailSuccessState(message: "Restaurant is removed");
      loadFavorite(id: id);
      notifyListeners();
    } catch (e) {
      _resultState = FavoriteDetailFailureState(
        error: "Failed to remove favorite restaurant",
      );
      debugPrint(e.toString());
      notifyListeners();
    }
  }
}
