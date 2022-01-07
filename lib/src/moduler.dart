import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moduler_route/src/module_route.dart';
import 'package:page_transition/page_transition.dart';
import 'package:collection/collection.dart';

import 'collection/module_stack.dart';
import 'injector.dart';
import 'module.dart';
import 'moduler_route_observer.dart';
import 'route_transition_type.dart';
import 'unknown_route.dart';

part 'inject.dart';

mixin Moduler {
  static final _modulesStack = StackModule();

  List<Module> get modules;
  List<Injector> get globalInjections => [];
  bool get enableAuthorize => false;
  bool get authorized => false;
  String get unauthorizedRedirectRoute => "";
  //bool get routeGuardEnabled => false;

  final ModulerRouteObserver modulerRouteObserver = ModulerRouteObserver(
    _modulesStack,
  );

  Module? _module(String path) {
    final dividedPath = path.split("/");
    final modulePath = dividedPath.length > 1 ? dividedPath[0] : path;

    final module = modules.firstWhereOrNull(
          (module) => module.path == modulePath,
        ) ??
        _modulesStack.top();

    return module;
  }

  ModuleRoute? _route(String path, Module? module) {
    if (path.endsWith("/")) {
      path = path.substring(0, path.length - 1);
    }

    final dividedRoute = path.split("/")..removeAt(0);
    final routePath = dividedRoute.join("/");

    return module?.routes.firstWhereOrNull(
          (route) => route.path == path,
        ) ??
        module?.routes.firstWhereOrNull(
          (route) => route.path == "/" && module.path == path,
        ) ??
        module?.routes.firstWhereOrNull(
          (route) => route.path == routePath,
        );
  }

  void _manageInjections(Module? module) {
    if (module != null && _modulesStack.top()?.path == module.path) {
      return;
    }

    _modulesStack.push(module!);

    final injectedTypes = this
        .globalInjections
        .map(
          (injector) => injector.type,
        )
        .toList()
          ..addAll(
            _modulesStack.injectedTypes,
          );

    Inject._objects.removeWhere(
      (type, injector) => !injectedTypes.contains(type),
    );

    Inject._injections.removeWhere(
      (injector) => !injectedTypes.contains(injector.type),
    );

    this.globalInjections.forEach((injector) {
      if (Inject._injections.any((i) => i == injector)) {
        return;
      }

      Inject._injections.add(injector);
    });

    Inject._injections.addAll(_modulesStack.top()!.injections);
  }

  String initialRoute(String Function() initialPath) => initialPath();

  Route routeTo(RouteSettings routeSettings) {
    Module? module = _module(routeSettings.name!);
    ModuleRoute? route = _route(routeSettings.name!, module);

    if (module == null || route == null) {
      return _pageRoute(
        UnknownRoute(routeName: routeSettings.name),
        null,
        "unknown",
        null,
      );
    }

    if (this.enableAuthorize && !this.authorized) {
      if (!module.allowAnonymous) {
        if (!route.allowAnonymous) {
          module = _module(this.unauthorizedRedirectRoute);
          route = _route(this.unauthorizedRedirectRoute, module);

          if (module == null || route == null) {
            return _pageRoute(
              UnknownRoute(routeName: this.unauthorizedRedirectRoute),
              null,
              "unknown",
              null,
            );
          }

          routeSettings = RouteSettings(
            name: this.unauthorizedRedirectRoute,
            arguments: module.path,
          );
        }
      }
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
      UnknownRoute(routeName: route.name),
      null,
      "unknown",
      null,
    );
  }

  PageRoute _pageRoute(
    Widget view,
    RouteTransitionType? transitionType,
    String? name,
    String? modulePath,
  ) {
    final settings = RouteSettings(
      name: name,
      arguments: modulePath,
    );

    if (kIsWeb) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (BuildContext context, a1, a2) => view,
        transitionDuration: Duration(seconds: 0),
      );
    }

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
      type: transitionTypeConversion[transitionType]!,
    );
  }
}
