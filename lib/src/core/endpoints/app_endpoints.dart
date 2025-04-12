class AppEndpoints {
  static get baseUrl => "restaurant-api.dicoding.dev";
  static get listRestaurant => "/list";
  static detailRestaurant({required String id}) => "/detail/$id";
  static smallPictureRestaurant({required String idPicture}) =>
      "https://$baseUrl/images/small/$idPicture";
  static mediumPictureRestaurant({required String idPicture}) =>
      "https://$baseUrl/images/small/$idPicture";
}
