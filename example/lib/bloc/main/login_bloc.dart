import 'package:example/dao/dao.dart';
import 'package:flutter/material.dart';

class LoginBloc {
  LoginBloc(this._dao);

  final DAO _dao;

  final _loginController = TextEditingController();

  TextEditingController get loginController => _loginController;

  String login() {
    final user = _loginController.text;
    _dao.login(user);
    return user;
  }
}