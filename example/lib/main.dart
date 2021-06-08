import 'package:flutter/material.dart';
import 'package:moduler_route/moduler_route.dart';

import 'modules/first_module.dart';
import 'modules/main_module.dart';
import 'modules/second_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //final dao = await DAO.instance();
  runApp(
    MyApp(
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget with Moduler {
  static bool isAuthorized = false;
  //final isAuthorized;
  String? _user;

  /* MyApp({
    this.isAuthorized = false,
  }); */

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
  bool get enableAuthorize => true;
  @override
  bool get authorized => MyApp.isAuthorized;
  @override
  String get unauthorizedRedirectRoute => MainModule.routePaths.appRegistration;
}
