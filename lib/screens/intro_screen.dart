import 'package:flutter/material.dart';
import 'dart:async';

import 'package:notes/screens/home_screen.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart'; 


enum AniProps { width, height, color }

class IntroScreen extends StatelessWidget {

  final _tween = TimelineTween<AniProps>() 
    ..addScene(begin: 0.milliseconds, end: 1000.milliseconds)
        .animate(AniProps.width, tween: 0.0.tweenTo(1000.0))
    ..addScene(begin: 500.milliseconds, end: 1000.milliseconds)
        .animate(AniProps.height, tween: 0.0.tweenTo(1300.0))
    ..addScene(begin: 0.milliseconds, duration: 1.seconds)
        .animate(AniProps.color, tween: Colors.white.tweenTo(Color.fromRGBO(181,205,163, 1)));

  @override
  Widget build(BuildContext context) {
    var c = MediaQuery.of(context).size.width;

      Future.delayed(const Duration(milliseconds: 1050), () {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        });

    return Scaffold(
      body: Stack(
              children: [
                Container(
          child: PlayAnimation<TimelineValue<AniProps>>(
              tween: _tween, // Pass in tween
              duration: _tween.duration, // Obtain duration
              builder: (context, child, value) {
                return Container(
                  width: value.get(AniProps.width), // Get animated value for width
                  height: value.get(AniProps.height), // Get animated value for height
                  color: value.get(AniProps.color), // Get animated value for color
                );
              },
            ),
          ),
          Center(
                      child: Container(
            height: c * 0.52,
            margin: EdgeInsets.only(left: 0.13 * c) ,
            child: Image.asset("assets/images/logo.png")),
          )
              ] 
      ),
    );
  }
}

