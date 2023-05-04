import 'package:chat_app/screens/splash_screen.dart';
import 'package:chat_app/widgets/text_button.dart';
import 'package:chat_app/widgets/text_input_field.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWeight = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                    child: Image.asset("assets/images/LoginScreen_image.png"),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 21, right: 21),
                margin: EdgeInsets.only(left: 20, right: 21),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFF6B6B6B), width: 2),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your Email Address"),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Container(
                  padding: EdgeInsets.only(left: 21, right: 21, top: 3),
                  margin: EdgeInsets.only(left: 20, right: 21),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xFF6B6B6B), width: 2)),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your Password",
                      suffixIcon: IconButton(
                        color: Color(0xFF771F98),
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              _isObscure = !_isObscure;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.013,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 200, right: 29),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Color(0xFF993F3F),
                      fontWeight: FontWeight.w400,
                      fontSize: 13),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.042,
              ),
              ActionButton(
                label: 'Login',
              ),
              SizedBox(
                height: screenHeight * 0.08,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45, right: 60),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(color: Color(0xFF949494), thickness: 1),
                    ),
                    SizedBox(
                      width: screenWeight * 0.03,
                    ),
                    Text(
                      "Or Login with",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: screenWeight * 0.03,
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0xFF949494),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/google_icon.png"),
                  SizedBox(
                    width: screenWeight * 0.03,
                  ),
                  Image.asset("assets/images/iphone_icon.png"),
                  SizedBox(
                    width: screenWeight * 0.03,
                  ),
                  Image.asset("assets/images/fb_icon.png"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
