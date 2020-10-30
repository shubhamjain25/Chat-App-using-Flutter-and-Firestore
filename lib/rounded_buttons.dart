import 'package:flutter/material.dart';


class RoundBtn extends StatelessWidget {

  final Color buttonColor;
  final String buttonText;
  final Function buttonPressed;

  RoundBtn({this.buttonColor, this.buttonText, @required this.buttonPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: buttonPressed,
//          onPressed: (){
//            Navigator.pushNamed(context, navigation);
//          },
          minWidth: 200.0,
          height: 42.0,
          child : Text(
            buttonText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

//class RoundTextBtn extends StatelessWidget {
//
//  final Color buttonColor;
//  final String hintMessage;
//  final Function performFunction;
//
//  RoundTextBtn({this.buttonColor, this.hintMessage, this.performFunction});
//
//  @override
//  Widget build(BuildContext context) {
//    return TextField(
//      onChanged: performFunction(),
//      decoration: InputDecoration(
//        hintText: hintMessage,
//        contentPadding:
//        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//        border: OutlineInputBorder(
//          borderRadius: BorderRadius.all(Radius.circular(32.0)),
//        ),
//        enabledBorder: OutlineInputBorder(
//          borderSide: BorderSide(color: buttonColor, width: 1.0),
//          borderRadius: BorderRadius.all(Radius.circular(32.0)),
//        ),
//        focusedBorder: OutlineInputBorder(
//          borderSide: BorderSide(color: buttonColor, width: 2.0),
//          borderRadius: BorderRadius.all(Radius.circular(32.0)),
//        ),
//      ),
//    );
//  }
//}

