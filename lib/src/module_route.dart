import 'package:flutter/widgets.dart';

import 'route_transition_type.dart';

class ModuleRoute {
  ModuleRoute({
    @required this.path,
    @required this.builder,
    this.transitionType,
  });

  final String path;
  final WidgetFunction builder;
  final RouteTransitionType transitionType;
}

typedef WidgetFunction = Widget Function(Object args);
