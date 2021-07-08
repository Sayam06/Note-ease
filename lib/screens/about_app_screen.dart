import 'package:flutter/material.dart';
import 'package:notes/models/about_app.dart';

class AboutApp extends StatelessWidget {
   static const routeName = "/about-app";
  const AboutApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var c = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("About App", style: TextStyle(fontFamily: "Montserrat", color: Colors.black),),
        elevation: 0,
      ),
      body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
                      child: Container(
                        height: 1.5 * c,
              margin: EdgeInsets.only(
                  left: 0.09 * c,
                  right: 0.09 * c,
                  bottom: 0.15 * c,
                  top: 0.10 * c),
              padding: EdgeInsets.only(
                  top: 0.01 * c, bottom: 0.01 * c, right: 0.06 * c),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(0.0405 * c)),
                  border: Border.all(
                      color: Color.fromRGBO(181,205,163, 1),
                      width: 0.0108 * c)),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.only(left: 0.0405 * c),
                  child: Text(ABOUTAPP, style: TextStyle(fontSize: 0.0468 * c, fontFamily: "Montserrat", ),),
                ),
              ),
            ),
          ),
        ),
      );
  }
}