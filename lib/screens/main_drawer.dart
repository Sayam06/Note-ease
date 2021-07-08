import 'package:flutter/material.dart';
import 'package:notes/screens/about_app_screen.dart';
import 'package:notes/screens/about_developer.dart';
import 'package:notes/screens/contact_dev_screen.dart';
import 'package:notes/screens/suggestions_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, Function tapHandler, var c) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 0.04 * c,
      ),
      child: ListTile(
        // leading:
        title: Text(
          title,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 0.058 * c,
          ),
        ),
        onTap: () {
          tapHandler();
        },
      ),
    );
  }

  const MainDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var c = MediaQuery.of(context).size.width;

    return Drawer(
      child: Container(
        padding: EdgeInsets.only(left: 0.00675 * c, right: 0.00675 * c),
        child: SafeArea(
                  child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 0.208 * c, top: 0.208 * c, bottom: 0.13 * c),
                height: 0.39 * c,
                child: Image.asset("assets/images/logo.png"),
              ),
              Container(
                margin: EdgeInsets.only(left: 0.052 * c, right: 0.052 * c, bottom: 0.039 * c),
                child: Divider(
                  color: Colors.black,
                  thickness: 0.0055 * c,
                ),
              ),
              Container(
                child: buildListTile("ABOUT APP", (){Navigator.of(context).pushNamed(AboutApp.routeName);}, c)
              ),
              Container(
                child: buildListTile("ABOUT DEVELOPER", (){Navigator.of(context).pushNamed(AboutDeveloper.routeName);}, c)
              ),
              Container(
                child: buildListTile("FEEDBACK", (){Navigator.of(context).pushNamed(SuggestionsScreen.routeName);}, c)
              ),
              Container(
                child: buildListTile("CONTACT DEV", (){Navigator.of(context).pushNamed(ContactDev.routeName);}, c)
              ),
              Container(
                margin: EdgeInsets.only(left: 0.052 * c, right: 0.052 * c),
                child: Divider(
                  color: Colors.black,
                  thickness: 0.0055 * c,
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}