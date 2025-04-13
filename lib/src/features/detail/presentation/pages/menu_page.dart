import 'package:flutter/material.dart';
import 'package:mangan/src/core/entities/drink_entity.dart';
import 'package:mangan/src/core/entities/food_entity.dart';
import 'package:mangan/src/shared/widgets/text_header_widget.dart';

class MenuPage extends StatelessWidget {
  final List<FoodEntity> foods;
  final List<DrinkEntity> drinks;

  const MenuPage({super.key, required this.foods, required this.drinks});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const TextHeaderWidget(title: "Menu"),
          bottom: const TabBar(tabs: [
            Tab(
              child: Text("Foods"),
            ),
            Tab(
              child: Text("Drinks"),
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: foods.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(foods[index].name),
                );
              },
            ),
            ListView.builder(
              itemCount: drinks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(drinks[index].name),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
