import 'package:flutter/material.dart';
import 'package:moduler_route/moduler_route.dart';

import 'dao/dao.dart';
import 'modules/first_module.dart';
import 'modules/main_module.dart';
import 'modules/second_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dao = await DAO.instance();
  runApp(MyApp(dao));
}

class MyApp extends StatelessWidget with Moduler {
  MyApp(this._dao);

  final DAO _dao;

  String _user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initialRoute(() {
        if (!_dao.isAppRegistered) {
          return MainModule.routePaths.appRegistration;
        }

        if (!_dao.isUserLogged) {
          return MainModule.routePaths.login;
        }

        _user = _dao.user;

        return MainModule.routePaths.home;
      }),
      onGenerateRoute: routeTo,
      onUnknownRoute: unknownRoute,
    );
  }

  @override
  List<Module> get modules => [
        MainModule(_dao),
        FirstModule(_user),
        SecondModule(),
      ];

  @override
  List<Injector> get globalInjections => [
    Injector<DAO>(inject: (_) {
      return _dao;
    }),
  ];
}