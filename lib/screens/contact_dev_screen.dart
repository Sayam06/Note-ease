import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes/screens/successful_response_screen.dart';
import 'dart:io';

class ContactDev extends StatefulWidget {
  static const routeName = "/contact-dev-screen";

  @override
  _ContactDevState createState() => _ContactDevState();
}

class _ContactDevState extends State<ContactDev> {
  final textController = TextEditingController();

  final contactController = TextEditingController();

  final nameController = TextEditingController();
  late bool internet;

  String notice = "";

  int visibility = 0;

   Future<dynamic> checkInternet() async {
    try {
  final result = await InternetAddress.lookup('amazon.in');
  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    print('connected');
    internet = true;
  } else {
    internet = false;
  }
} on SocketException catch (_) {
  print('not connected');
  internet = false;
}
  }

  Future sendData(String name, String email, String description) async {
    checkInternet();
    if(name.isEmpty) {
      setState(() {
        notice = "Please enter your name";
        visibility = 1;
      });
      return ;
    }
    if(email.isEmpty) {
      setState(() {
        notice = "Please enter your contact information";
        visibility = 1;
      });
      return ;
    } 
    if(description.isEmpty) {
      setState(() {
        notice = "Enter the description!";
        visibility = 1;
      });
      return ;
    }
    if(internet == false) {
      setState(() {
        notice = "Check your data connection :(";
        visibility = 1;
      });
      return ;
    }
    final String url = "https://calm-beyond-54614.herokuapp.com/post/contact";
    final response = await http.post(Uri.parse(url), body: {
      "name": name,
      "email": email,
      "description": description,
    });

    Navigator.of(context).pushReplacementNamed(SuccessfulResponse.routeName);
  }

  @override
  Widget build(BuildContext context) {
    checkInternet();

    var c = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("Contact Dev", style: TextStyle(fontFamily: "Montserrat", color: Colors.black),),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
              child: Container(
          margin: EdgeInsets.only(
              top: 0.07 * c,
                  left: 0.070 * c,
                  right: 0.070 * c,
                  bottom: 0.081 * c),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 0.027 * c, right: 0.027 * c),
                  margin: EdgeInsets.only(bottom: 0.054 * c),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(0.0405 * c)),
                      border: Border.all(
                          color: Color.fromRGBO(255, 171, 115, 1),
                          width: 0.0108 * c)),
                  child: TextField(
                    style: TextStyle(fontFamily: "Montserrat", fontSize: 0.0494 * c),
                    controller: nameController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Name", hintStyle: TextStyle(fontFamily: "Montserrat", fontSize: 0.0494 * c),),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 0.027 * c, right: 0.027 * c),
                  margin: EdgeInsets.only(bottom: 0.054 * c),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(0.0405 * c)),
                      border: Border.all(
                          color: Color.fromRGBO(255, 171, 115, 1),
                          width: 0.0108 * c)),
                  child: TextField(
                    style: TextStyle(fontFamily: "Montserrat", fontSize: 0.0494 * c),
                    controller: contactController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Email / Phone Number", hintStyle: TextStyle(fontFamily: "Montserrat", fontSize: 0.0494 * c),),
                  ),
                ),
              Container(
                    height: 1 * c,
                    padding: EdgeInsets.only(left: 0.027 * c, right: 0.027 * c),
                    margin: EdgeInsets.only(bottom: 0.054 * c),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(0.0405 * c)),
                        border: Border.all(
                            color: Color.fromRGBO(255, 171, 115, 1),
                            width: 0.0108 * c)),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: TextField(
                        style: TextStyle(fontFamily: "Montserrat", fontSize: 0.0494 * c),
                        controller: textController,
                        maxLines: null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintMaxLines: 10,
                            hintText: "Whatever you write here is going to reach the developer, once you press that submit button.",
                            hintStyle: TextStyle(fontFamily: "Montserrat", fontSize: 0.0494 * c),
                            contentPadding: EdgeInsets.only(top: 0.0405 * c)),
                      ),
                    ),
                  ),
                  Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 0.02,
                      blurRadius: 7,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    sendData(nameController.text, contactController.text, textController.text);
                  },
                  child: Container(
                    margin: EdgeInsets.all(0.0405 * c),
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(
                          fontSize: 0.052 * c, fontWeight: FontWeight.bold),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Color.fromRGBO(255, 130, 130, 1),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 0.026 * c),
                child: visibility == 1 ? Text(notice, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Montserrat"),) 
                : SizedBox(height: 1,)
              )
            ]
          ),
        ),
      ),
    );
  }
}