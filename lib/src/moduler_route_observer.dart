import 'package:flutter/widgets.dart';

import 'collection/module_stack.dart';

class ModulerRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  ModulerRouteObserver(this._modulesStack);

  final StackModule _modulesStack;

  void _manageModules(Route<dynamic> route) {
    final modulePath = route.settings.arguments as String;

    while(_modulesStack.top().path != modulePath) {
      _modulesStack.pop();
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    
    if (newRoute is PageRoute) {
      _manageModules(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    
    if (previousRoute is PageRoute && route is PageRoute) {
      _manageModules(previousRoute);
    }
  }
}
