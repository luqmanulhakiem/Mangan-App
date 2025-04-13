import 'package:mangan/src/core/entities/restaurant_entity.dart';

sealed class RestaurantResultState {}

class RestaurantInitialState extends RestaurantResultState {}

class RestaurantLoadingState extends RestaurantResultState {}

class RestaurantErrorState extends RestaurantResultState {
  final String error;

  RestaurantErrorState({required this.error});
}

class RestaurantLoadedState extends RestaurantResultState {
  final RestaurantEntity data;

  RestaurantLoadedState({required this.data});
}
