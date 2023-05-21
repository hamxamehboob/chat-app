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
                  builder: (_) => const HomePage(),
                ),
              );
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: ListTile(
            leading: const CircleAvatar(
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
                  widget.user.name,
                  style: const TextStyle(
                      color: Color(0xFF181818),
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                SizedBox(
                  height: screenHeight * 0.005,
                ),
                const Text(
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
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: APIs.getAllMessages(widget.user),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const SizedBox();
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;
                      // print('Data: ${jsonEncode(data![0].data())}');
                      _list = data
                              ?.map((e) => Message.fromJson(e.data()))
                              .toList() ??
                          [];

                      if (_list.isNotEmpty) {
                        return ListView.builder(
                            reverse: true,
                            itemCount: _list.length,
                            padding: EdgeInsets.only(top: screenHeight * .01),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return MessageCard(message: _list[index]);
                            });
                      } else {
                        return const Center(
                          child: Text('Say Hii! 👋',
                              style: TextStyle(fontSize: 20)),
                        );
                      }
                  }
                },
              ),
            ),
            _chatInput(),
          ],
        ));
  }

  // Widget _MessageTextField() {
  //   double screenHeight = MediaQuery.of(context).size.height;
  //   return Row(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(right: 60),
  //         child: Container(
  //           height: screenHeight * 0.1,
  //           decoration: BoxDecoration(
  //               boxShadow: [BoxShadow(blurRadius: 2)],
  //               color: Color(0xFFF8F8F8),
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(20),
  //                 topRight: Radius.circular(20),
  //               ),),
  //           child: Padding(
  //             padding: const EdgeInsets.only(
  //               left: 20,
  //             ),
  //             child: TextFormField(
  //               controller: _textController,
  //               textAlignVertical: TextAlignVertical.center,
  //               maxLines: 1000,
  //               keyboardType: TextInputType.multiline,
  //               decoration: InputDecoration(
  //                 border: InputBorder.none,
  //                 hintText: "Type Here...",
  //                 hintStyle: TextStyle(
  //                     color: Color(0xFF8D8D8D),
  //                     fontSize: 17,
  //                     fontWeight: FontWeight.w400),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //       IconButton(onPressed: (){}, icon: Icon(Icons.send),)
  //     ],
  //   );
  // }
  Widget _chatInput() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenHeight * .01, horizontal: screenWidth * .025),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  //emoji button

                  Expanded(
                    child: TextField(
                      controller: _textController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                          hintText: 'Type Something...',
                          hintStyle: TextStyle(color: Colors.blueAccent),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(width: screenWidth * .02),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                APIs.sendMessage(widget.user, _textController.text, Type.text);
                _textController.text = '';
              }
              // else {
              //     //simply send message
              //     APIs.sendMessage(
              //         widget.user, _textController.text,);
              //   }
            },
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: Colors.green,
            child: const Icon(Icons.send, color: Colors.white, size: 28),
          )
        ],
      ),
    );
  }
}
