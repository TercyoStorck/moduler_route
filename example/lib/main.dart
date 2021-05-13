import 'package:flutter/material.dart';
import 'package:moduler_route/moduler_route.dart';

import 'dao/dao.dart';
import 'modules/first_module.dart';
import 'modules/main_module.dart';
import 'modules/second_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //final dao = await DAO.instance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget with Moduler {
  String _user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.amber),
        primarySwatch: Colors.blue,
      ),
      initialRoute: initialRoute(() {

        return MainModule.routePaths.home;
      }),
      onGenerateRoute: routeTo,
      onUnknownRoute: unknownRoute,
      navigatorObservers: [modulerRouteObserver],
    );
  }

  @override
  List<Module> get modules => [
        MainModule(),
        FirstModule(_user),
        SecondModule(),
      ];

  @override
  List<Injector> get globalInjections => [
  ];
}