import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flare_flutter/flare_actor.dart';
import 'package:notes/screens/successful_response_screen.dart';
import 'dart:io';

class SuggestionsScreen extends StatefulWidget {
  static const routeName = "/suggestions-screen";
  String animation = "idle";

  @override
  _SuggestionsScreenState createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {

  final nameController = TextEditingController();
  final feedbackController = TextEditingController();

  final descriptionFocusNode = FocusNode();
  final nameFocusNode = FocusNode();

  String notice = "";
  int visibility = 0;
  late bool internet;


  @override
  void initState() {
    nameFocusNode.addListener(() {
        if(nameFocusNode.hasFocus) {
        setState(() {
          widget.animation = "success";
        });
       } 
      });
    descriptionFocusNode.addListener(() {
      if(descriptionFocusNode.hasFocus) {
        setState(() {
          widget.animation = "test";
        });
      }
    });
  }  

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

  Future sendData(String name, String description) async {
    checkInternet();
    if(name.isEmpty) {
      name = "Anonymous";
    }
    if(description.isEmpty) {
      setState(() {
        notice = "Enter the description!";
        visibility = 1;
        widget.animation = "fail";
      });
      return ;
    }
    if(internet == false) {
      setState(() {
        notice = "Check your data connection :(";
        visibility = 1;
        widget.animation = "fail";
      });
      return ;
    }
    final String url = "https://calm-beyond-54614.herokuapp.com/post/feedback";
    final response = await http.post(Uri.parse(url), body: {
      "name": name,
      "feedback": description,
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
        title: Text("Feedback", style: TextStyle(fontFamily: "Montserrat", color: Colors.black),),
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
                height: 150,
                child: new FlareActor("assets/images/teddy_test.flr", animation: widget.animation,)
              ),
              Container(
                  padding: EdgeInsets.only(left: 0.027 * c, right: 0.027 * c),
                  margin: EdgeInsets.only(bottom: 0.054 * c),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(0.0405 * c)),
                      border: Border.all(
                          color: Color.fromRGBO(255, 170, 167, 1),
                          width: 0.0108 * c)),
                  child: TextField(
                    focusNode: nameFocusNode,
                    style: TextStyle(fontFamily: "Montserrat", fontSize: 0.0494 * c, fontWeight: FontWeight.bold),
                    controller: nameController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Enter Your Name", hintStyle: TextStyle(fontFamily: "Montserrat", fontSize: 0.0494 * c),),
                  ),
                ),
                Container(
                  height: 0.6 * c,
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
                      focusNode: descriptionFocusNode,
                      style: TextStyle(fontFamily: "Montserrat", fontSize: 0.0494 * c),
                      controller: feedbackController,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintMaxLines: 10,
                          hintText: "Roses are red, cold is the ice, I hope that you'll write something very, very nice :)",
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
                    sendData(nameController.text, feedbackController.text);
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
            ],
          ),
        ),
      ),
    );
  }
}