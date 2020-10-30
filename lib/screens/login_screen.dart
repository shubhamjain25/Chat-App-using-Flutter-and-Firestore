import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/rounded_buttons.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class LoginScreen extends StatefulWidget {

  static String id='/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

//  RoundBtn roundBtnLogin = RoundBtn(
//    buttonColor: Colors.lightBlueAccent,
//    buttonText: 'Login',
//    navigation: LoginScreen.id,
//  );

  String inputEmail;
  String inputPassword;
  final _auth=FirebaseAuth.instance;
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  inputEmail = value;
                },
                decoration: kTextFieldDecorationLogin.copyWith(
                  hintText: 'Enter your email id',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  inputPassword = value;
                },
                decoration: kTextFieldDecorationLogin.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundBtn(
                buttonColor: Colors.lightBlueAccent,
                buttonText: 'Login',
                buttonPressed: () async{
                  setState(() {
                    isLoading=true;
                  });
                  try {
                    final userDetails = await _auth.signInWithEmailAndPassword(email: inputEmail, password: inputPassword);
                    if(userDetails!=null){
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      isLoading=false;
                    });
                  }
                  catch(e){
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
