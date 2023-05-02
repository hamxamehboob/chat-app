import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Padding(
            padding: EdgeInsets.only(top: 88,left: 53),
            child: Text(
              "Get Closer To",
              style: TextStyle(
                  color: Colors.black, fontSize: 36, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 53),
            child: Text(
              "EveryOne",
              style: TextStyle(
                  color: Colors.black, fontSize: 36, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: screenheight*0.009,),
          Padding(
            padding: EdgeInsets.only(left: 23),
            child: Text(
              "Helps you to contact everyone with just easy way",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
