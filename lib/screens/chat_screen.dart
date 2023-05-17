import 'package:chat_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class ChattingScreen extends StatelessWidget {
  const ChattingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(20)
              ),
              height: 100,

              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Type Here"
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
