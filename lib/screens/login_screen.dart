import 'package:chat_app/screens/splash_screen.dart';
import 'package:chat_app/widgets/text_button.dart';
import 'package:chat_app/widgets/text_input_field.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWeight = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 27, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SplashScreen(),
                    ),
                  );
                },
                child: Icon(
                  Icons.arrow_circle_left_outlined,
                  size: 30,
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, Welcome Back",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                      Text(
                          "Happy to see you again,to use your\naccount please login first.")
                    ],
                  ),
                  Expanded(
                      child:
                          Image.asset("assets/images/LoginScreen_image.png")),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Text(
                  "Email Address",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
              TextInputField(),
              SizedBox(
                height: screenHeight * 0.026,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Text(
                  "Password",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
              TextInputField(),
              SizedBox(height: screenHeight * 0.013,),
              Padding(
                padding: const EdgeInsets.only(left:200,right:29 ),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Color(0xFF993F3F),
                      fontWeight: FontWeight.w400,
                      fontSize: 13),
                ),
              ),
              SizedBox(height: screenHeight * 0.042,),
              ActionButton(label: 'Login',),
              SizedBox(height: screenHeight * 0.08,),
              Divider(
                color: Colors.black,thickness: 1,
                endIndent: screenWeight * 0.5 ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
