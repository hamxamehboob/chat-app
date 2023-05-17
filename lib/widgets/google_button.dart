import 'package:flutter/material.dart';
class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key, required this.route,}) : super(key: key);
  final GestureTapCallback route;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return  GestureDetector(onTap: route,
      child: Container(
        margin:
        const EdgeInsets.only(right: 50,left: 50),
        padding:
        const EdgeInsets.only(top: 8,bottom: 9,left: 30),
        decoration: BoxDecoration(
            color:  Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15)),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/images/google_icon.png",height: 20,),
            SizedBox(width: screenWidth * 0.13,),
            Text(
              "Google",
              style:  TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
