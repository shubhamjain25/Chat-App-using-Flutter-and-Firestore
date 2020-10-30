import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/rounded_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class RegistrationScreen extends StatefulWidget {
  static String id = '/registration';

  //static keyword is present so that when we call id from someplace else, we need not create the full RegistrationScreen object.
  // We can simply call RegistrationScreen.id to access the id without actually making the whole object.

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  bool isLoading = false;
  String email;
  String password;
  final _auth = FirebaseAuth.instance;

//  RoundBtn roundBtnRegistration = RoundBtn(
//    buttonColor: Colors.blueAccent,
//    buttonText: 'Register',
//    navigation: RegistrationScreen.id,
//  );

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
                  email = value;
                },
                decoration: kTextFieldDecorationRegistration.copyWith(
                  hintText: 'Enter your email id',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecorationRegistration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundBtn(
                  buttonColor: Colors.blueAccent,
                  buttonText: 'Register',
                  buttonPressed: () async {
                    setState(() {
                      isLoading=true;
                    });
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                      if(newUser!=null){
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        isLoading=false;
                      });
                    }
//                Navigator.pushNamed(context, RegistrationScreen.id);
                    catch (e) {
                      print(e);
                    }
                  }
//              navigation: RegistrationScreen.id,
                  ),
//            roundBtnRegistration,
            ],
          ),
        ),
      ),
    );
  }
}
