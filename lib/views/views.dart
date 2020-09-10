import 'package:flutter/material.dart';
import 'package:kepler/views/chartsView.dart';
import 'package:kepler/views/explore/starsView.dart';
import 'package:kepler/views/settingsView.dart';

class Views extends StatefulWidget {
  @override
  _ViewsState createState() => _ViewsState();
}

class _ViewsState extends State<Views> {
  int currentIndex = 0;
  ChartsView chartsView = ChartsView();
  StarsView starsView = StarsView();
  SettingsView settingsView = SettingsView();
  Widget _pageView = StarsView();

  @override
  Widget build(BuildContext context) {
    changeView(int index) {
      switch (index) {
        case 0:
          return starsView;
          break;
        case 1:
          return chartsView;
          break;
        case 2:
          return settingsView;
          break;
        default:
          return starsView;
          break;
      }
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
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
        onTap: (index) {
          setState(() {
            currentIndex = index;
            _pageView = changeView(index);
          });
        },
      ),
      body: _pageView,
    );
  }
}
