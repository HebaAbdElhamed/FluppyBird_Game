import 'package:flutter/material.dart';

class Barriers extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final size;

  // ignore: use_key_in_widget_constructors
  const Barriers({this.size});

  @override
  Widget build(BuildContext context) {

    // Barriers style like super mario game and has top circle and bottom circle

    return Container(
      width: 100,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.green,
        border: Border(
          left: BorderSide(
            color: Colors.black,
            width: 10,
          ),
          right: BorderSide(
            color: Colors.black,
            width: 10,
          ),
        ),
      ),
    );




  }
}
