import 'package:page_transition/page_transition.dart';

enum RouteTransitionType {
  fade,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  scale,
  rotate,
  size,
  rightToLeftWithFade,
  leftToRightWithFade,
  material,
  cupertino,
}

final transitionTypeConversion = {
  RouteTransitionType.fade: PageTransitionType.fade,
  RouteTransitionType.rightToLeft: PageTransitionType.rightToLeft,
  RouteTransitionType.leftToRight: PageTransitionType.leftToRight,
  RouteTransitionType.upToDown: PageTransitionType.upToDown,
  RouteTransitionType.downToUp: PageTransitionType.downToUp,
  RouteTransitionType.scale: PageTransitionType.scale,
  RouteTransitionType.rotate: PageTransitionType.rotate,
  RouteTransitionType.size: PageTransitionType.size,
  RouteTransitionType.rightToLeftWithFade:
      PageTransitionType.rightToLeftWithFade,
  RouteTransitionType.leftToRightWithFade:
      PageTransitionType.leftToRightWithFade,
};
