import 'package:example/bloc/main/login_bloc.dart';
import 'package:example/modules/main_module.dart';
import 'package:flutter/material.dart';
import 'package:moduler_route/moduler_route.dart';

class LoginView extends StatelessWidget {
  LoginView(this._registrationId);

  final String _registrationId;

  final _bloc = Inject.instance<LoginBloc>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("Registration id: $_registrationId"),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: _bloc.loginController,
                      decoration: InputDecoration(labelText: "User name"),
                    ),
                    RaisedButton(
                      onPressed: () {
                        _bloc.login();

                        Navigator.of(context)
                            .pushReplacementNamed(MainModule.routePaths.home);
                      },
                      child: Text("Login"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
}
