import 'package:flutter/material.dart';

class UnknownRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xFF092535),
        body: Center(
          child: Image.asset("assets/404.jpg"),
        ),
      );
}
