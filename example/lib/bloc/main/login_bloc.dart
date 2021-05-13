import 'package:example/dao/dao.dart';
import 'package:flutter/material.dart';

class LoginBloc {
  final _loginController = TextEditingController();

  TextEditingController get loginController => _loginController;

  String login() {
    final user = _loginController.text;
    return "user";
  }
}