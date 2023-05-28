import 'dart:async';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import '../FristPage/first_page.dart';
import 'barriers.dart';
import 'bird.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  // ignore: non_constant_identifier_names
  late List<int> hp_bests;

  // ignore: non_constant_identifier_names
  Home({Key? key, required this.hp_bests}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  late int score = 0;
  late List<int> hpnbests = widget.hp_bests;

  // ignore: non_constant_identifier_names
  late int first_bestScore = hpnbests[hpnbests.length - 1];

  //late int temp1 = 0;

  // ignore: non_constant_identifier_names
  late int second_bestScore = 0;

  //late int temp2 = 0;
  // ignore: non_constant_identifier_names
  late int third_bestScore = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  static double barrierXone = 2;
  double barrierXtwo = barrierXone + 1.5;

  void jump() {
    setState(() {
      time = 0;
      score += 1;
      initialHeight = birdYaxis;
    });
    if (score >= first_bestScore) {
      // temp1 = first_bestScore;
      first_bestScore = score;
    }
  }

  // ignore: non_constant_identifier_names
  bool BirdIsDead() {
    if (birdYaxis > 1 || birdYaxis < -1) {
      return true;
    }

    return false;
  }

  void startGame() {
    gameHasStarted = true;
    score = 0;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
        setState(() {
          if (barrierXone < -1.1) {
            barrierXone += 2.2;
          } else {
            barrierXone -= 0.05;
          }
        });

        if (BirdIsDead()) {
          timer.cancel();
          // play oudio of game over one time
          FlameAudio.play('die.mp3', volume: 0.25);
          _showDialog();
        }

        setState(() {
          if (barrierXtwo < -1.1) {
            barrierXtwo += 2.2;
          } else {
            barrierXtwo -= 0.05;
          }
        });
      });
      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  void resetGame() {
    Navigator.pop(context);
    // start again from the first barrier
    setState(() {
      birdYaxis = 0;
      time = 0;
      height = 0;
      score = 0;
      initialHeight = birdYaxis;
      barrierXone = 2;
      barrierXtwo = barrierXone + 1.5;
      // best score
      if (first_bestScore == hpnbests[hpnbests.length - 1]) {
        // ignore: avoid_print
        print('same');
      } else {
        hpnbests.add(first_bestScore);
      }
    });
  }

  void backaction() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FristPage(fb_bests: hpnbests),
      ),
    );

    setState(() {
      if (first_bestScore == hpnbests[hpnbests.length - 1]) {
        // ignore: avoid_print
        print('same');
      } else {
        hpnbests.add(first_bestScore);
      }
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.black54,
              title: Center(
                child: Image.asset(
                  'assets/images/GameOver_without_backgound.png',
                  width: 190,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
                  child: GestureDetector(
                    onTap: resetGame,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.white,
                        child: const Text(
                          '   Start Again   ',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: backaction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 24.0,
                      color: Colors.yellow,
                    ),
                    label: const Text(''),
                  ),
                ),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    FlameAudio.bgm.initialize();
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          FlameAudio.play('flap.mp3');
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYaxis),
                    duration: const Duration(milliseconds: 0),
                    color: Colors.lightBlueAccent,
                    child: const Bird(),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barriers(
                      size: 200.0,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, -1.3),
                    duration: const Duration(milliseconds: 0),
                    child: const Barriers(
                      size: 200.0,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, 1.2),
                    duration: const Duration(milliseconds: 0),
                    child: const Barriers(
                      size: 150.0,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, -1.2),
                    duration: const Duration(milliseconds: 0),
                    child: const Barriers(
                      size: 250.0,
                    ),
                  ),
                  Container(
                    alignment: const Alignment(0, -0.99),
                    child: gameHasStarted
                        ? const Text("")
                        : Image.asset(
                            'assets/images/play_without_background.png',
                            height: 200,
                            width: 250),
                  ),
                ],
              ),
            ),
            Container(
              height: 10,
              color: Colors.amberAccent,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'SCORE',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'LuckiestGuy',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          score.toString(),
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'LuckiestGuy',
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'BEST',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'LuckiestGuy',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          first_bestScore.toString(),
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'LuckiestGuy',
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
