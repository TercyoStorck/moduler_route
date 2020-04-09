# Moduler route

__Moduler route__ is a powerful route manager that works in a modular way that allows you to create an application with more independent and reusable functionality. And with an integrated dependency injection system, you will have fully decoupled modules.

## Moduler

`Moduler` is a mixin that will be inherited by your main widget and it's the heart of your modules. Here you'll informe your modules and global injections.

``` dart
void main() => runApp(MyApp());

class MyApp extends StatelessWidget with Moduler {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute(() {
        // Some rules to check the initial route
        return "moduler/initial-route"
      }),
      onGenerateRoute: routeTo,
      onUnknownRoute: unknownRoute,
      navigatorObservers: [modulerRouteObserver],
    );
  }

  @override
  List<Module> get modules => [];

  @override
  List<Injector> get globalInjections => [];
}
```
* `initialRoute(String Function())` a no async closure to check initial route
* `modules` list of your modules
* `globalInjections` all of your classes that you wanna get from any module

## Modules

The ideia behide moduler is separate your application in modules. To create a module do like code bellow.

``` dart
class ExampleModule extends Module {
  @override
  String get path => "module-name";

  @override
  List<ModuleRoute> get routes => [];

  @override
  List<Injector> get injections => [];
}
```
* `path` name of the __Module__
* `routes` all routes that belong to this module
* `injections` like __globalInjections__ of the __Moduler__, but only accessible to module routes

## Routes

To pass views to your module you must have to create a `ModuleRoute`.

``` dart
ModuleRoute(
  path: "route-name",
  builder: (arguments) => View(),
  transitionType: RouteTransitionType.material
);
```
* `path` name of the __ModuleRoute__. If the view is the "home" (first view) of module. You may call it `"/"`
* `builder` a closure where you return your view. __builder__ have a `Object` as argument and it is the parameter passed to your route
* `transitionType` __Moduler route__ uses [page_transition](https://pub.dev/packages/page_transition) to implement a lot of page transitions in addition to `CupertinoPageRoute` and `MaterialPageRoute`. So you have 12 page transitions

### Call route

You just user `Navigator` or any other navigation lib to navigate.

``` dart
Navigator.of(context).pushNamed(
  "module-name/route-name",
  arguments: "Passing parameters"
);
```
To navigate between modules/routes you have to follow some rules:
* Every time you'll navigate to a new module, you need to inform the module name. 
* If you have a route named `"/"` in a module and called `Navigator.of(context).pushNamed("module-name");` or `Navigator.of(context).pushNamed("module-name/");` it will always call that __ModuleRoute__
* If you already at navigating in a module, you don't need any more to pass a module name. Just pass the route name for navigate inside the module `Navigator.of(context).pushNamed("second-route-name");`

## Dependency Injection

How I said before _ Modular route _ have a powerful dependency injection system. First you have to inform to your __Module__ or __Moduler__ what class will be injected. for that use `Injector`.

``` dart
Injector<MyController>(
  inject: (arguments) => MyController(_user),
);
```
#### CAUTION!! You always have to pass the type to `Injector`.

__Injector__ have a closure that have an `Object` as parameter. The `arguments` is the same passed to `builder` closure of the __ModuleRoute__. And returns a class of the same type you have informed before.

To get the injected class you will use __Inject__

``` dart
final _controller = Inject.instance<MyController>();
```

__Inject__ have two static methods:
* `instance` return always a new instance of a object
* `get` return an existing instance. If the object is not instantiated, it'll be create

#### IMPORTANTE!! 

When uses `get`, the singleton will be alive only during navigation in a module. Unless it was injected on `globalInjections` in __Moduler__

## Mocking for unit test

__Inject__ have a special method to using in tests called `mock`. Just pass the mocked class with the type class.

``` dart
final controllerMock = MyControllerMock();
Inject.mock<MyController>(controllerMock);
```
___

If having any questions, see our example to better understanding! Or send us an e-mail :grin:

My spacial thanks to [Elton Morais](https://github.com/eltonmorais) for testing and improve some features