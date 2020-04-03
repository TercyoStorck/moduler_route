import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:io' show Platform;

import 'injector.dart';
import 'module.dart';
import 'route_transiction_type.dart';
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

      if (routePath?.isEmpty != false) {
        routePath = "/";
      }

      if (modules?.any((module) => module?.path == modulePath) == true) {
        module = modules?.firstWhere(
          (module) => module?.path == modulePath,
        );
      }
    }

    if (module == null) {
      modulePath = fullPath[0];

      if (modules?.any((module) => module?.path == modulePath) == true) {
        module = modules?.firstWhere(
          (module) => module?.path == modulePath,
        );
      }

      routePath = routeSettings.name;
    }

    if (_currentModule?.module?.path != module?.path) {
      _currentModule.module = module;

      final globalTypes = this
          .globalInjections
          .map(
            (injector) => injector.type,
          )
          .toList();

      Inject._objects.removeWhere(
        (type, injector) => !globalTypes.contains(type),
      );
      Inject._injections.clear();
      Inject._injections.addAll(this.globalInjections);
      Inject._injections.addAll(_currentModule.module.injections);
    }

    final route = module?.routes?.firstWhere(
      (route) => route.path == routePath,
      orElse: () {
        return module?.routes?.firstWhere(
            (route) => route.path == "/" || route.path == "",
            orElse: () => null);
      },
    );

    if (route == null) {
      return _pageRoute(UnknownRoute(), null);
    }

    final view = route.builder(routeSettings.arguments);
    return _pageRoute(view, route.transitionType);
  }

  Route unknownRoute(RouteSettings route) {
    return _pageRoute(UnknownRoute(), null);
  }

  PageRoute _pageRoute(Widget view, RouteTransitionType transitionType) {
    if (transitionType == null ||
        transitionType == RouteTransitionType.cupertino ||
        transitionType == RouteTransitionType.material) {
      if (transitionType == RouteTransitionType.cupertino ||
          transitionType == null && Platform.isIOS) {
        return CupertinoPageRoute(
          builder: (BuildContext context) => view,
        );
      }

      return MaterialPageRoute(
        builder: (BuildContext context) => view,
      );
    }

    return PageTransition(
      child: view,
      type: transitionTypeConvertion[transitionType],
    );
  }
}

class _CurrentModule {
  Module module;
  bool get hasModule => this.module != null;
  void reset() => module = null;
}
