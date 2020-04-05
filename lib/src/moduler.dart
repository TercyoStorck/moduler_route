import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moduler_route/src/module_route.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:io' show Platform;

import 'collection/module_stack.dart';
import 'injector.dart';
import 'module.dart';
import 'moduler_route_observer.dart';
import 'route_transiction_type.dart';
import 'unknown_route.dart';

part 'inject.dart';

mixin Moduler {
  static final _modulesStack = StackModule();

  List<Module> get modules;
  List<Injector> get globalInjections;

  final ModulerRouteObserver modulerRouteObserver = ModulerRouteObserver(_modulesStack);

  Module _module(String path) {
    final splitedPath = path.split("/");
    final modulePath = splitedPath.length > 1 ? splitedPath[0] : path;

    final module = modules?.firstWhere(
      (module) => module?.path == modulePath,
      orElse: () => _modulesStack.top(),
    );

    return module;
  }

  ModuleRoute _route(String path, Module module) {
    if (path.endsWith("/")) {
      path = path.substring(0, path.length - 1);
    }

    return module?.routes?.firstWhere(
      (route) => route.path == path,
      orElse: () => module?.routes?.firstWhere(
          (route) => route.path == "/" && module.path == path, orElse: () {
        final splitedRoute = path.split("/")..removeAt(0);
        final routePath = splitedRoute.join("/");

        return module?.routes?.firstWhere(
          (route) => route.path == routePath,
          orElse: () => null,
        );
      }),
    );
  }

  void _manageInjections(Module module) {
    if (module != null && _modulesStack.top()?.path == module?.path) {
      return;
    }

    _modulesStack.push(module);

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
    Inject._injections.addAll(_modulesStack.top().injections);
  }

  String initialRoute(String Function() initialPath) => initialPath();

  Route routeTo(RouteSettings routeSettings) {
    final module = _module(routeSettings.name);
    final route = _route(routeSettings.name, module);

    if (route == null) {
      return _pageRoute(
        UnknownRoute(),
        null,
        "unknown",
        null,
      );
    }

    _manageInjections(module);

    Inject._parameter = routeSettings.arguments;

    final view = route.builder(routeSettings.arguments);
    final pageRoute = _pageRoute(
      view,
      route.transitionType,
      routeSettings.name,
      module.path,
    );

    return pageRoute;
  }

  Route unknownRoute(RouteSettings route) {
    return _pageRoute(
      UnknownRoute(),
      null,
      "unknown",
      null,
    );
  }

  PageRoute _pageRoute(
    Widget view,
    RouteTransitionType transitionType,
    String name,
    String modulePath,
  ) {
    final settings = RouteSettings(
      name: name,
      arguments: modulePath,
    );

    if (transitionType == null ||
        transitionType == RouteTransitionType.cupertino ||
        transitionType == RouteTransitionType.material) {
      if (transitionType == RouteTransitionType.cupertino ||
          transitionType == null && Platform.isIOS) {
        return CupertinoPageRoute(
          settings: settings,
          builder: (BuildContext context) => view,
        );
      }

      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => view,
      );
    }

    return PageTransition(
      settings: settings,
      child: view,
      type: transitionTypeConvertion[transitionType],
    );
  }
}
