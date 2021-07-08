import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDeveloper extends StatelessWidget {
  static const routeName = "/about-developer";

  void customLaunch(command) async {
    await launch(command);
  }

  @override
  Widget build(BuildContext context) {

    var c = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("About Developer", style: TextStyle(fontFamily: "Montserrat", color: Colors.black),),
      ),
      body: SizedBox.expand(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Container(
              margin: EdgeInsets.only(top: 0.13 * c),
              height: 0.455 * c,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: Image.asset("assets/images/Sayam.jpeg", fit: BoxFit.fitHeight,),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 0.065 * c),
              child: Text("SAYAM SARKAR", style: TextStyle(fontFamily: "Montserrat", fontSize: 0.0728 * c, fontWeight: FontWeight.bold),),
            ),
            Container(
              margin: EdgeInsets.only(top: 0.036 * c),
              child: Text("First Year Student At\nVellore Institute of Technology,\nVellore", style: TextStyle(fontFamily: "Montserrat", fontSize: 0.0468 * c,), textAlign: TextAlign.center,),
            ),
            Container(
              margin: EdgeInsets.only(top: 0.052 * c),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [ GestureDetector(
                  onTap: () => customLaunch("https://www.linkedin.com/in/sayam-sarkar-60833b203/"),
                    child: Container(
                    margin: EdgeInsets.only(top: 0.050 * c),
                    height: 0.078 * c,
                    child: Image.asset("assets/images/LINKEDIN.png"),
                  ),
                ),
                GestureDetector(
                  onTap: () => customLaunch("https://github.com/Sayam06"),
                    child: Container(
                    margin: EdgeInsets.only(top: 0.050 * c),
                    height: 0.078 * c,
                    child: Image.asset("assets/images/github.png"),
                  ),
                ),
                ],
              ),
            )
          ]
        ),
      )
    );
  }
}