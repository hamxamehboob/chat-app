import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../api/firebase_api.dart';
import '../models/message.dart';
import '../widgets/message_card.dart';

class ChattingScreen extends StatefulWidget {
  final ChatUser user;

  const ChattingScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  List<Message> _list = [];
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HomePage(),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: CircleAvatar(
              backgroundColor: Color(0xffE6E6E6),
              radius: 40,
              child: Icon(
                Icons.person,
                color: Color(0xffCCCCCC),
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Robert Fox",
                style: TextStyle(
                    color: Color(0xFF181818),
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              SizedBox(
                height: screenHeight * 0.005,
              ),
              Text(
                "Online",
                style: TextStyle(
                    color: Color(0xFF771F98),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          StreamBuilder(
            stream: APIs.getAllMessages(),
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
                  _list =
                      data?.map((e) => Message.fromJson(e.data())).toList() ??
                          [];

                  if (_list.isNotEmpty) {
                    return ListView.builder(
                        reverse: true,
                        itemCount: _list.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return MessageCard(message: _list[index]);
                        });
                  } else {
                    return const Center(
                      child:
                          Text('Say Hii! 👋', style: TextStyle(fontSize: 20)),
                    );
                  }
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.1,
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 2)],
                  color: Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  maxLines: 1000,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type Here...",
                    hintStyle: TextStyle(
                        color: Color(0xFF8D8D8D),
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                    suffixIcon: Icon(Icons.send),
                    suffixIconColor: Color(0xFF0771F98),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
