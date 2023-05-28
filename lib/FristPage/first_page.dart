// ignore_for_file: non_constant_identifier_names

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';


import '../BestGradePage/best_score_page.dart';
import '../gamePage/home.dart';

// ignore: must_be_immutable
class FristPage extends StatefulWidget {
  late List<int> fb_bests;
  FristPage({Key? key, required this.fb_bests}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables

  @override
  State<FristPage> createState() => _FristPageState();
}

class _FristPageState extends State<FristPage> {
  @override
  void initState() {
    if (widget.fb_bests.isEmpty) {
      widget.fb_bests = [0,0,0];
    }
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('smb_stage_clear.wav').then((value) => FlameAudio.bgm.stop());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 110.0, 8.0, 0.0),
            child: Image.asset(
              'assets/images/bird_without_background.png',
              width: 380,
              height: 270,
            ),
          ),
          GestureDetector(
            onTap: () {
              FlameAudio.bgm.stop();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Home(hp_bests: widget.fb_bests)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(90.0, 400.0, 8.0, 0.0),
              child: Image.asset(
                'assets/images/play_without_background.png',
                width: 220,
                height: 200,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              FlameAudio.bgm.stop();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BestScore(
                          bsp_bests: widget.fb_bests,
                        )),
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(90.0, 550.0, 8.0, 0.0),
              child: Image.asset(
                'assets/images/Best_Score_without_background.png',
                width: 250,
                height: 250,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
