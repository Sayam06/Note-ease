import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes/screens/home_screen.dart';

class SuccessfulResponse extends StatelessWidget {
  static const routeName = "/successful-screen";
  const SuccessfulResponse({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var c = MediaQuery.of(context).size.width;

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 0.208 * c,
            child: Image.asset("assets/images/tick.gif"),
          ),
          Container(
            margin: EdgeInsets.only(top: 0.052 * c, left: 0.052 * c, right: 0.052 * c),
            child:Text("Successfully sent! Taking you back to the home screen!", style: TextStyle(fontFamily: "Montserrat", fontSize: 0.065 * c,),
             textAlign: TextAlign.center,)
          )
        ]
      )
    );
  }
}