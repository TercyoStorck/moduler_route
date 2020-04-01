import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:io' show Platform;

import 'injector.dart';
import 'module.dart';
import 'module_route.dart';
import 'unknown_route.dart';

part 'inject.dart';

mixin Moduler {
  List<Module> get modules;
  List<Injector> get globalInjections;

  final _currentModule = _CurrentModule();

  String initialRoute(String Function() initialPath) => initialPath();

  Route routeTo(RouteSettings routeSettings) {
    Inject._parameter = routeSettings.arguments;

    final fullPath = routeSettings.name.split("/");

    String modulePath;
    String routePath;
    Module module;

    if (fullPath.length > 1) {
      modulePath = fullPath[0];

      fullPath.removeAt(0);

      routePath = fullPath.join('/');

      module = modules?.firstWhere(
        (module) => module.path == modulePath,
      );
    }

    if (module == null) {
      ModuleRoute route;

      if (_currentModule.hasModule) {
        route = _currentModule.module.routes.firstWhere(
          (route) => route.path == routeSettings.name,
        );
      }

      if (route == null) {
        throw "Route not found";
      }
    }

    if (_currentModule?.module?.path != module.path) {
      _currentModule.module = module;

      final globalTypes = this.globalInjections.map((injector) => injector.type).toList();

      Inject._objects.removeWhere((type, injector) => !globalTypes.contains(type));
      Inject._injections.clear();
      Inject._injections.addAll(this.globalInjections);
      Inject._injections.addAll(_currentModule.module.injections);
    }

    final route = module?.routes?.firstWhere(
      (route) => route.path == routePath,
    );

    if (route == null) {
      throw "Route not found";
    }

    if (route.transitionType != null) {
      return PageTransition(
        child: route.builder(routeSettings.arguments),
        type: route.transitionType,
      );
    }

    if (Platform.isIOS) {
      return CupertinoPageRoute(
        builder: (BuildContext context) =>
            route.builder(routeSettings.arguments),
      );
    }

    return MaterialPageRoute(
      builder: (BuildContext context) => route.builder(routeSettings.arguments),
    );
  }

  Route unknownRoute(RouteSettings route) {
    return PageTransition(
      child: UnknownRoute(),
      type: PageTransitionType.fade,
    );
  }
}

class _CurrentModule {
  Module module;

  bool get hasModule => this.module != null;

  void reset() => module = null;
}
