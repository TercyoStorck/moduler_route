import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';

class ModuleRoute {
  ModuleRoute({
    @required this.path,
    @required this.builder,
    this.transitionType,
  });

  final String path;
  final WidgetFunction builder;
  final PageTransitionType transitionType;
}

typedef WidgetFunction = Widget Function(Object args);