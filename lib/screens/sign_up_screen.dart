import 'dart:io';

import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:chat_app/widgets/text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api/firebase_api.dart';
import '../helper/dialogs.dart';
import '../widgets/google_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isObscure = true;
  final GlobalKey<FormState> _pwKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final TextEditingController _emailTeextController = TextEditingController();
  final TextEditingController _pwTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWeight = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(left: 27, top: 19),
          child: SingleChildScrollView(
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
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                    key: _nameKey,
                    child: TextFormField(
                      validator: nameValidate,
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
                      controller: _emailTeextController,
                      // autovalidateMode: AutovalidateMode.always,
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
                        controller: _pwTextController,
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
                  height: screenHeight * 0.032,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: screenWeight * 0.015,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          (context),
                          MaterialPageRoute(
                            builder: (_) => const login(),
                          ),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.011,
                ),
                ActionButton(
                    label: 'SignUp',
                    route: () {
                      validate();
                      signUp();
                    }),
                SizedBox(
                  height: screenHeight * 0.08,
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
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
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
                GoogleButton(
                  route: () {
                    _handleGoogleBtnClick();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validate() {
    if (_pwKey.currentState!.validate() ||
        _nameKey.currentState!.validate() ||
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
    } else if (value.length < 8) {
      return "Password must be at least 8 characters";
    } else {
      return null;
    }
  }

  String? nameValidate(value) {
    if (value.isEmpty) {
      return "Please enter a name";
    } else {
      return null;
    }
  }

  void signUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailTeextController.text,
              password: _pwTextController.text)
          .then(
            (value) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const HomePage(),
              ),
            ),
          )
          .onError(
            (error, stackTrace) => print("Error ${error.toString()}"),
          );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {}
  }

  _handleGoogleBtnClick() {
    Dialogs.showProgressBar(context);

    _signInWithGoogle().then((user) async {
      Navigator.pop(context);

      if (user != null) {
        if ((await APIs.userExists())) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomePage()));
        } else {
          await APIs.createUser().then((value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const HomePage()));
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      Dialogs.showSnackBar(context, 'Something Went Wrong (Check Internet!)');
      return null;
    }
  }
}
