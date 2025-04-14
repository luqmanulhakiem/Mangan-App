import 'package:mangan/src/core/entities/restaurant_entity.dart';

sealed class FavoriteListResultState {}

final class FavoriteListInitialState extends FavoriteListResultState {}

final class FavoriteListLoadingState extends FavoriteListResultState {}

final class FavoriteListLoadedState extends FavoriteListResultState {
  final List<RestaurantEntity> data;

  FavoriteListLoadedState({required this.data});
}

final class FavoriteListFailureState extends FavoriteListResultState {
  final String error;

  FavoriteListFailureState({required this.error});
}
