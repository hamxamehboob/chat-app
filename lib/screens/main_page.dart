import 'package:chat_app/screens/home_page.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../api/firebase_api.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _page = 0;
  final GlobalKey _bottomNavigationKey = GlobalKey();

  Widget getSelectedWidget() {
    Widget widget;
    switch (_page) {
      case 0:
        widget = const HomePage();
        break;
      // case 1:
      //   widget = SettingPage(
      //     user: APIs.me,
      //   );
      //   break;
      default:
        widget = const HomePage();
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
          // Icon(
          //   Icons.chat,
          //   color: Colors.white,
          //   size: 30,
          // ),
          // Icon(
          //   color: Colors.white,
          //   Icons.settings,
          //   size: 30,
          // ),
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
