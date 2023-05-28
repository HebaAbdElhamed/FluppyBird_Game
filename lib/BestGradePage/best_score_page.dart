

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import '../FristPage/first_page.dart';

// ignore: must_be_immutable
class BestScore extends StatefulWidget {
  final List<int> bsp_bests;
  const BestScore({Key? key, required this.bsp_bests}) : super(key: key);

  @override
  State<BestScore> createState() => _BestScoreState();
}

class _BestScoreState extends State<BestScore> {
  //final List<int> entries = <int>[0, 0, 0];
  final List<int> colorCodes = <int>[200, 300, 400];
  @override
  Widget build(BuildContext context) {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('world_clear.wav');
    final List<int> entries = <int>[
        widget.bsp_bests[widget.bsp_bests.length-1],
        widget.bsp_bests[widget.bsp_bests.length-2],
        widget.bsp_bests[widget.bsp_bests.length-3]
      ];
    
    final List<String> named = <String>[' 1 st : ', ' 2 nd : ', ' 3 th : '];
    return GestureDetector(
      onTap: () {
        FlameAudio.bgm.stop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FristPage(
              fb_bests: widget.bsp_bests,
            ),
          ),
        );
      },
      child: Stack(
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FristPage(
                    fb_bests: widget.bsp_bests,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(70.0, 50.0, 8.0, 0.0),
              child: Image.asset(
                'assets/images/Best_Score_without_background.png',
                width: 350,
                height: 320,
              ),
            ),
          ),
          ListView.separated(
            padding: const EdgeInsets.fromLTRB(50.0, 270.0, 50.0, 0.0),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 120,
                color: Colors.blue[colorCodes[index]],
                child: Center(
                  child: Text(
                    named[index] + entries[index].toString() + ' ',
                    style: const TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontFamily: 'LuckiestGuy',
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ],
      ),
    );
  }
}
