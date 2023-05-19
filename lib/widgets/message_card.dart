import 'package:flutter/material.dart';

import '../api/firebase_api.dart';
import '../models/message.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({Key? key, required this.message}) : super(key: key);
  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.message.fromId
        ? _userMessage()
        : _receiverMessage();
  }

  Widget _receiverMessage() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * .04,vertical: screenHeight * .01),
            padding: EdgeInsets.all(screenWidth * .04),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Color(0xFF771F98),
              ),
            ),
            child: Text(
              widget.message.msg,
              style: TextStyle(
                  color: Color(0xFF171717),
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _userMessage() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * .04,vertical: screenHeight * .01),
            padding: EdgeInsets.only(top:10,left: 11,right: 39,bottom: 10 ),
            decoration: BoxDecoration(
              color: Color(0xFF771F98),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Color(0xFF771F98),
              ),
            ),
            child: Text(
              widget.message.msg,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
