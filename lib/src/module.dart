import 'injector.dart';
import 'module_route.dart';

abstract class Module {

  //static Injector _injector;

  String get path;
  List<ModuleRoute> get routes;
  List<Injector> get injections;

  //static T injector() {}
  //Map<Type, Function> get factoryBuilder;
}



//typedef InjectorFunction = T Function<T>(Object args);