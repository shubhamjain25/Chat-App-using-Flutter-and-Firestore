import 'package:flutter/material.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/rounded_buttons.dart';

class WelcomeScreen extends StatefulWidget {
  static String id =
      '/'; // Static keyword is used so that we can use WelcomeScreen.id instead of WelcomeScreen().id

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

//  RoundBtn roundBtnLogin = RoundBtn(
//    buttonColor: Colors.lightBlueAccent,
//    buttonText: 'Login',
//    navigation: LoginScreen.id,
//  );
//  RoundBtn roundBtnRegistration = RoundBtn(
//    buttonColor: Colors.blueAccent,
//    buttonText: 'Register',
//    navigation: RegistrationScreen.id,
//  );

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    controller.forward();

    animation = ColorTween(begin: Colors.blueGrey[600], end: Colors.white)
        .animate(controller);

    controller.addListener(() {
      setState(() {
        // The value gets updated automatically no need for input just something to tell the screen that update the values.
      });
      print(animation.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 60,
                    ),
                  ),
                ),
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 300),
                  repeatForever: true,
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundBtn(
              buttonColor: Colors.blueAccent,
              buttonText: 'Registration',
              buttonPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
            RoundBtn(
              buttonColor: Colors.lightBlueAccent,
              buttonText: 'Login',
              buttonPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
