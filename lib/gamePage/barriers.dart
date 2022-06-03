import 'package:flutter/material.dart';

class Barriers extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final size;

  // ignore: use_key_in_widget_constructors
  const Barriers({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.amber,
        border: Border.all(width: 10, color: Colors.brown),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
