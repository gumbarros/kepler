import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/views/chartsView.dart';
import 'package:kepler/views/explore/starsView.dart';
import 'package:kepler/views/settingsView.dart';

class PageController extends GetxController{

  final int initialIndex;
  PageController(this.initialIndex);
  int currentIndex;
  Widget pageView;

  @override
  void onInit() {
    currentIndex = initialIndex;
    pageView = _changeView(initialIndex);
  }

  Widget _changeView(int index) {
    switch (index) {
      case 0:
        return StarsView();
        break;
      case 1:
        return ChartsView();
        break;
      case 2:
        return SettingsView();
        break;
      default:
        return StarsView();
    }
  }

  void changePage(int index){
    this.currentIndex = index;
    pageView = _changeView(index);
    update();
  }
}

class Views extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PageController>(
      init: PageController(Get.arguments),
      builder:(_)=> Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _.currentIndex,
          selectedItemColor: Color(0xFFF69F0AE),
          selectedLabelStyle: TextStyle(color: Color(0xFFF69F0AE)),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.public), title: Text('Explore')),
            BottomNavigationBarItem(
                icon: Icon(Icons.show_chart), title: Text('Charts')),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), title: Text('Settings'))
          ],
          onTap: (int index) {
              _.changePage(index);
          },
        ),
        body: _.pageView,
      ),
    );
  }
}
