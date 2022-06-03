import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  const Bird({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 80,
      width: 80,
      child: Image.asset('assets/images/bird_without_background.png'),
    );
  }
}
