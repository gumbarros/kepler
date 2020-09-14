import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/pagesController.dart';

class Views extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PagesController>(
      init: PagesController(Get.arguments),
      builder: (_) => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: _.currentIndex ?? 0,
          selectedItemColor: Color(0xFFF69F0AE),
          selectedLabelStyle: TextStyle(color: Color(0xFFF69F0AE)),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.public), title: Text('Explore')),
            BottomNavigationBarItem(
                icon: Icon(Icons.show_chart), title: Text('Charts')),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), title: Text('Favorites')),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), title: Text('Settings')),
          ],
          onTap: (int index) {
            _.changeIndex(index);
          },
        ),
        body: _.pageView,
      ),
    );
  }
}
