import 'package:flutter_test/flutter_test.dart';
import 'package:mangan/src/features/detail/presentation/provider/restaurant_provider.dart';
import 'package:mangan/src/features/detail/presentation/provider/restaurant_result_state.dart';
import 'package:mangan/src/features/home/presentation/provider/restaurant_list_provider.dart';
import 'package:mangan/src/features/home/presentation/provider/restaurant_list_result_state.dart';

void main() {
  group('RestaurantProvider', () {
    late RestaurantListProvider restaurantListProvider;
    late RestaurantProvider restaurantProvider;

    setUp(() {
      restaurantListProvider = RestaurantListProvider();
      restaurantProvider = RestaurantProvider();
    });

    test('Memastikan state awal provider harus didefinisikan', () {
      expect(restaurantListProvider.resultState,
          isA<RestaurantListInitialState>());
      expect(restaurantProvider.resultState, isA<RestaurantInitialState>());
    });

    test(
        'Memastikan harus mengembalikan daftar restoran ketika pengambilan data API berhasil.',
        () async {
      await restaurantListProvider.getRestaurantList();
      expect(
          restaurantListProvider.resultState, isA<RestaurantListLoadedState>());

      final loadedState =
          restaurantListProvider.resultState as RestaurantListLoadedState;
      expect(loadedState.data.length, 20);
      expect(loadedState.data.first.name, 'Melting Pot');
    });

    test(
        'Memastikan harus mengembalikan kesalahan ketika pengambilan data API gagal (Kondisi Restaurant Tidak ditemukan)',
        () async {
      await restaurantProvider.getRestaurant(id: 'null');
      final loadedState =
          restaurantProvider.resultState as RestaurantErrorState;
      expect(loadedState.error, "Restaurant not found");
    });
  });
}
