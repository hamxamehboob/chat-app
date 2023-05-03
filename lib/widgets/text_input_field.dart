import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: Container(
        padding: EdgeInsets.only(left: 21,right: 21),
        margin: EdgeInsets.only(left: 20, right: 21),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xFF6B6B6B), width: 2)),
        child: TextFormField(
          decoration: InputDecoration(border: InputBorder.none),
        ),
      ),
    );
  }
}
