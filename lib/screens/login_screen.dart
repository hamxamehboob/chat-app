import 'dart:io';

import 'package:chat_app/helper/dialogs.dart';
import 'package:chat_app/screens/main_page.dart';
import 'package:chat_app/screens/sign_up_screen.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:chat_app/widgets/text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api/firebase_api.dart';
import '../widgets/google_button.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  final GlobalKey<FormState> _pwKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final TextEditingController _emailtextcontroller = TextEditingController();
  final TextEditingController _pwtextcontroller = TextEditingController();
  String errorMessage = '';
  @override
  void initState() {
    super.initState();
  }

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
                Padding(
                  padding: const EdgeInsets.only(top: 2, left: 23, right: 21),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _emailKey,
                    child: TextFormField(
                      controller: _emailtextcontroller,
                      validator: emailValidate,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: "Enter your Email Address"),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, left: 23, right: 21),
                  child: Form(
                    key: _pwKey,
                    child: TextFormField(
                        controller: _pwtextcontroller,
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
                const Padding(
                  padding: EdgeInsets.only(left: 200, right: 29),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
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
                            builder: (_) => const SignUp(),
                          ),
                        );
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.011,
                ),
                ActionButton(
                  label: 'login',
                  route: () {
                    validate();
                    login();
                  },
                ),
                SizedBox(
                  height: screenHeight * 0.05,
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
                        "Or login with",
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
    } else {
      return null;
    }
  }

  void login() async {
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
          .signInWithEmailAndPassword(
              email: _emailtextcontroller.text,
              password: _pwtextcontroller.text)
          .then((value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const MainPage(),
          ),
        );
      });

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmailDialog();
      } else if (e.code == 'wrong - password') {
        wrongPasswordDialog();
      }
    }
    setState(() {});
  }

  void wrongEmailDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Wrong Email"),
        );
      },
    );
  }

  void wrongPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Wrong Password"),
        );
      },
    );
  }

  _handleGoogleBtnClick() {
    Dialogs.showProgressBar(context);

    _signInWithGoogle().then((user) async {
      Navigator.pop(context);

      if (user != null) {
        if ((await APIs.userExists())) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const MainPage()));
        } else {
          await APIs.createUser().then((value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const MainPage()));
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
      Dialogs.showSnackBar(
          context, 'Something Went Wrong Check Internet Connection');
      return null;
    }
  }
}
