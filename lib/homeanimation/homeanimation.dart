import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';


import '../homepage/homepage.dart';



class homeAnimation extends StatefulWidget {
  const homeAnimation({Key? key}) : super(key: key);

  @override
  State<homeAnimation> createState() => _homeAnimationState();
}

class _homeAnimationState extends State<homeAnimation> {
  bool _animationPlayed = false;

  @override
  void initState() {
    super.initState();
    if (!_animationPlayed) {
      Future.delayed(Duration(seconds: 3)).then((value) {
        setState(() {
          _animationPlayed = true;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => homepage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_animationPlayed) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => homepage()),
          );
        }
        return true;
      },
      child: Scaffold(
        body: _animationPlayed
            ? homepage()
            : Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: Lottie.asset("Animations/animation2.json"),
                ),
              ),
      ),
    );
  }
}