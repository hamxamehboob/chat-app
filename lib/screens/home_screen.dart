
import 'package:chat_app/screens/setting_screen.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:chat_app/widgets/chat_screen_widget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../api/firebase_api.dart';
import '../models/chat_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChatUser> list = [];
  int _selectedIndex = 0;
  List<Widget> _screens = [
    SplashScreen(),
    SettingPage(),
  ];



  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          color: Color(0xff771F98),
          backgroundColor: Colors.white,
          items: <Widget>[
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
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 22, top: 36, right: 21, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(14)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          hintText: "Search",
                          hintStyle: TextStyle(color: Color(0xFF252525))),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Text(
                  "Chats",
                  style: TextStyle(
                      color: Color(0xFF771F98),
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: APIs.firestore.collection('Users').snapshots(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          case ConnectionState.active:
                          case ConnectionState.done:
                            final data = snapshot.data?.docs;
                            list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
                        }
                       if(list.isNotEmpty){
                         return ListView.builder(

                           shrinkWrap: true,
                           scrollDirection: Axis.vertical,
                           physics: BouncingScrollPhysics(),
                           itemCount: list.length,
                           itemBuilder: (BuildContext context, int index) {
                             return ChatWidget(user: list[index],);
                           },
                         );
                       }
                       else{
                         return Center(child: Text("No Messages Found"),);
                       }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  // void logout() async {
  //   await APIs.auth.signOut().then((value){
  //     await GoogleSignIN
  //   });
  //
  //
  //
  // }
}
