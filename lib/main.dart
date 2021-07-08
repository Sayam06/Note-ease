import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/screens/about_app_screen.dart';
import 'package:notes/screens/about_developer.dart';
import 'package:notes/screens/add_note_screen.dart';
import 'package:notes/screens/contact_dev_screen.dart';
import 'package:notes/screens/home_screen.dart';
import 'package:notes/screens/intro_screen.dart';
import 'package:notes/screens/successful_response_screen.dart';
import 'package:notes/screens/suggestions_screen.dart';
import 'package:notes/screens/view_note_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'in-COVID',
      // theme: ThemeData(
      //     primarySwatch: Colors.red,
      //     fontFamily: 'Montserrat',
      //     highlightColor: Colors.red),
      home: IntroScreen(),
      routes: {
      HomeScreen.routeName: (ctx) => HomeScreen(),
      AboutDeveloper.routeName: (ctx) => AboutDeveloper(),
      AddNote.routeName: (ctx) => AddNote(),
      ViewNote.routeName: (ctx) => ViewNote(),
      AboutApp.routeName: (ctx) => AboutApp(),
      SuggestionsScreen.routeName: (ctx) => SuggestionsScreen(),
      ContactDev.routeName: (ctx) => ContactDev(),
      SuccessfulResponse.routeName: (ctx) => SuccessfulResponse(),
      }
    );
  }
}
