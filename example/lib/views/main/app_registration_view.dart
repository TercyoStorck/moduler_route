import 'package:example/bloc/main/app_registration_bloc.dart';
import 'package:example/modules/main_module.dart';
import 'package:flutter/material.dart';
import 'package:moduler_route/moduler_route.dart';

class AppRegistrationView extends StatelessWidget {
  final _bloc = Inject.get<AppRegistrationBloc>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("App registration"),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              final registrationId = _bloc.registerApp();
              
              Navigator.of(context).pushReplacementNamed(
                MainModule.routePaths.login,
                arguments: registrationId,
              );
            },
            child: Text("Register"),
          ),
        ),
      );
}
