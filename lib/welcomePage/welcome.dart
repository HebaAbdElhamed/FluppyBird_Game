import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flame_audio/flame_audio.dart';
import '../FristPage/first_page.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    startTime();

    
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 32, 19, 214),
                Color.fromARGB(255, 3, 167, 255),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 110.0, 8.0, 0.0),
          child: Image.asset(
            'assets/images/bird_without_background.png',
            width: 380,
            height: 400,
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(95.0, 510.0, 8.0, 0.0),
          child: Text(
            'F l a p p y \n    B i r d',
            style: TextStyle(
              decoration: TextDecoration.none,
              //fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'LuckiestGuy',
              //fontSize: 40,
            ),
          ),
        ),
      ],
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 10);
    
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('world_clear.wav');
    return Timer(duration, route);
  }

  route() {
    var wbest = List<int>.empty();
    FlameAudio.bgm.stop();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => FristPage(
                  fb_bests: wbest,
                )));
  }
}
