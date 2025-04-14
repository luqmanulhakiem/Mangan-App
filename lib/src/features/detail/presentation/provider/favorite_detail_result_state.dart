sealed class FavoriteDetailResultState {}

final class FavoriteDetaiInitialState extends FavoriteDetailResultState {}

final class FavoriteDetailLoadingState extends FavoriteDetailResultState {}

final class FavoriteDetailLoadedState extends FavoriteDetailResultState {
  final bool isFavorite;

  FavoriteDetailLoadedState({required this.isFavorite});
}

final class FavoriteDetailFailureState extends FavoriteDetailResultState {
  final String error;

  FavoriteDetailFailureState({required this.error});
}

final class FavoriteDetailSuccessState extends FavoriteDetailResultState {
  final String message;

  FavoriteDetailSuccessState({required this.message});
}
