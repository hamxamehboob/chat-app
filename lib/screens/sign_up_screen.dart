import 'package:chat_app/screens/splash_screen.dart';
import 'package:chat_app/widgets/text_button.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isObscure = true;
  final GlobalKey<FormState> _pwKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWeight = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(left: 27, top: 19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SplashScreen(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.arrow_circle_left_outlined,
                  size: 30,
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Let's,Sign you up",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                      Text(
                          "Happy to see you again,to use your\naccount please login first.")
                    ],
                  ),
                  Expanded(
                    child: Image.asset(
                      "assets/images/LoginScreen_image.png",
                      height: screenHeight * 0.25,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2, left: 23, right: 21),
                child: Form(
                  // key: _emailKey,
                  child: TextFormField(
                    validator: emailValidate,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "Enter your Full Name"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 23, right: 21),
                child: Form(
                  key: _emailKey,
                  child: TextFormField(
                    validator: emailValidate,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "Enter your Email Address"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 23, right: 21),
                child: Form(
                  key: _pwKey,
                  child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "Enter your Password",
                        suffixIcon: IconButton(
                          color: const Color(0xFF771F98),
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
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
                      validator: pwValidate),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.013,
              ),
              ActionButton(
                label: 'SignUp',
                route: () {
                  validate();
                },
              ),
              SizedBox(
                height: screenHeight * 0.08,
              ),
              const Text(
                "Already Have an account?",
                style: TextStyle(
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45, right: 60),
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(color: Color(0xFF949494), thickness: 1),
                    ),
                    SizedBox(
                      width: screenWeight * 0.03,
                    ),
                    const Text(
                      "Or SignUp with",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: screenWeight * 0.03,
                    ),
                    const Expanded(
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

  void validate() {
    if (_pwKey.currentState!.validate() ||
        _emailKey.currentState!.validate()) {}
  }

  String? emailValidate(value) {
    if (value.isEmpty) {
      return "Please enter a email";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Enter Valid Email";
    } else {
      return null;
    }
  }

  String? pwValidate(value) {
    if (value.isEmpty) {
      return "Please enter a password";
    } else if (value.length < 6) {
      return "Password must be at least 8 characters";
    } else {
      return null;
    }
  }
}