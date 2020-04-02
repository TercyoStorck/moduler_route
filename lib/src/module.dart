import 'injector.dart';
import 'module_route.dart';

abstract class Module {
  String get path;
  List<ModuleRoute> get routes;
  List<Injector> get injections => [];
}