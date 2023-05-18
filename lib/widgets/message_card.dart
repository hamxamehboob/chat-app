import 'package:flutter/material.dart';

import '../api/firebase_api.dart';
import '../models/message.dart';
class MessageCard extends StatefulWidget {
  final Message message;
  const MessageCard({Key? key, required this.message}) : super(key: key);

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {

  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.message.fromId ? _userMessage() : _receiverMessage();
  }
  Widget _receiverMessage(){
    return Container(
      child: Text(widget.message.msg),
    );
  }
  Widget _userMessage(){
    return Container();
  }
}
