import 'package:flutter/material.dart';
import 'package:mangan/src/features/home/presentation/pages/favorite_page.dart';
import 'package:mangan/src/features/home/presentation/pages/home_page.dart';
import 'package:mangan/src/features/home/presentation/pages/settings_page.dart';
import 'package:mangan/src/shared/widgets/text_header_widget.dart';

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({
    super.key,
  });

  @override
  State<MainPageWidget> createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final List<String> titles = const ["Mangan", "Favorite", "Settings"];
  final widgets = const [
    HomePage(),
    FavoritePage(),
    SettingsPage(),
  ];

  void onTapped(int index) {
    selectedIndexNotifier.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedIndexNotifier,
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: TextHeaderWidget(title: titles[value]),
          ),
          body: widgets[value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: value,
            onTap: onTapped,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Favorite",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
          ),
        );
      },
    );
  }
}
