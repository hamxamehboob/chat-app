import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/widgets/text_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final _controller = PageController();

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(top: 50, left: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Get Closer To",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.w600),
              ),
              const Text(
                "EveryOne",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: screenHeight * 0.009,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 98),
                child: Text(
                  "Helps you to contact everyone with just easy way",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 23),
                child: SizedBox(
                  height: 400,
                  child: PageView(
                    controller: _controller,
                    children: [
                      Image.asset("assets/images/Splash_image1.png"),
                      Image.asset("assets/images/Splash_image2.png"),
                      Image.asset("assets/images/Splash_image3.jpg"),
                      Image.asset("assets/images/Splash_image4.png"),
                    ],
                  ),
                ),
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: 4,
                  effect: const JumpingDotEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Color(0xFF771F98),
                      jumpScale: 2,
                      dotHeight: 15,
                      verticalOffset: 20),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              ActionButton(
                label: 'Get Started',
                route: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const Login(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
