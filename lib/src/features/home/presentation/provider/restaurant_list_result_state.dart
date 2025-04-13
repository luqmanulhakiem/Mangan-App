import 'package:mangan/src/core/entities/restaurant_entity.dart';

sealed class RestaurantListResultState {}

class RestaurantListInitialState extends RestaurantListResultState {}

class RestaurantListLoadingState extends RestaurantListResultState {}

class RestaurantListErrorState extends RestaurantListResultState {
  final String error;

  RestaurantListErrorState({required this.error});
}

class RestaurantListLoadedState extends RestaurantListResultState {
  final List<RestaurantEntity> data;

  RestaurantListLoadedState({required this.data});
}
