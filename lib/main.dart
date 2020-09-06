import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/views/homeView.dart';
import 'package:kepler/views/settingsView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  string.init();
  runApp(GetMaterialApp(
    title: 'Kepler',
    darkTheme: ThemeData(brightness: Brightness.dark),
    debugShowCheckedModeBanner: false,
    supportedLocales: string.supportedLocales(),
    home: Pages(
      list: [
        Home(),
        Settings(),
      ],
    ),
    builder: (context, child) {
      return ScrollConfiguration(
        behavior: RemoveGlow(),
        child: child,
      );
    },
  ));
}

//Remove Glow OverScroll effect behaviour
class RemoveGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class Pages extends StatefulWidget {
  final List<Widget> list;

  Pages({this.list});

  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: BouncingScrollPhysics(),
      children: widget.list,
    );
  }
}
