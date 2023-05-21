import 'package:chat_app/screens/home_page.dart';
import 'package:chat_app/screens/setting_screen.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget getSelectedWidget() {
    Widget widget;
    switch (_page) {
      case 0:
        widget = const HomePage();
        break;
      case 1:
        widget = const SettingPage();
        break;
      default:
        widget = const SettingPage();
        break;
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60,
        color: const Color(0xff771F98),
        backgroundColor: Colors.white,
        items: const <Widget>[
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.chat,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            color: Colors.white,
            Icons.settings,
            size: 30,
          ),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: getSelectedWidget(),
    );
  }
}
