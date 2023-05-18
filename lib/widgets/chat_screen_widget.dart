import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({Key? key, required this.user}) : super(key: key);
  final ChatUser user;
  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    String time = "${date.hour}.${date.minute}";
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChattingScreen(user: widget.user,),
            ),
          );
        },
        child: Container(
          height: screenHeight * 0.07,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                width: 2,
                color: Color(0xFF771F98),
              ),),
          child: Padding(
            padding: const EdgeInsets.only(left: 17, top: 9, right: 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.user.name,
                      style: TextStyle(
                          color: Color(0xFF181818),
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    Spacer(),
                    Text(
                      time,
                      style: TextStyle(
                          color: Color(0xFF5C5C5C),
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.006,
                ),
                Text(widget.user.about)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
