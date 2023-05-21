import 'package:flutter/material.dart';

import '../api/firebase_api.dart';
import '../models/chat_user.dart';
import '../widgets/chat_screen_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChatUser> list = [];
  final List<ChatUser> _searchList = [];
  final bool _isSearching = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 22, top: 36, right: 21, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: Color(0xFF252525),
                    ),
                  ),
                  onChanged: (val) {
                    _searchList.clear();
                    for (var i in list) {
                      if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                          i.email.toLowerCase().contains(val.toLowerCase())) {
                        _searchList.add(i);
                      }
                      setState(() {
                        _searchList;
                      });
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            const Text(
              "Users",
              style: TextStyle(
                  color: Color(0xFF771F98),
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: APIs.getAllUser(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        list = data
                                ?.map((e) => ChatUser.fromJson(e.data()))
                                .toList() ??
                            [];
                    }
                    if (list.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount:
                            _isSearching ? _searchList.length : list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ChatWidget(
                            user:
                                _isSearching ? _searchList[index] : list[index],
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("No Messages Found"),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
