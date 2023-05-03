import 'package:chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({Key? key, required this.label, }) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const Login(),
            ),
          );
        },
        child: Container(
          padding:
              const EdgeInsets.only(left: 90, right: 90, top: 8, bottom: 8),
          decoration: BoxDecoration(
              color: const Color(0xFF771F98),
              borderRadius: BorderRadius.circular(15)),
          child:  Text(
            label,
            style: const TextStyle(
                color: Color(0xFFF3F3F3),
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
