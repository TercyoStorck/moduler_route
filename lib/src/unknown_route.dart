import 'package:flutter/material.dart';

class UnknownRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xFF092535),
        body: Center(
          child: Text(
            "404\nRoute not found!",
            style: TextStyle(fontSize: 80, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      );
}
