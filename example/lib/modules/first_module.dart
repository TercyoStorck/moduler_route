import 'package:example/bloc/first_module/first_module_bloc.dart';
import 'package:example/views/first_module/first_module_view.dart';
import 'package:moduler_route/moduler_route.dart';
import 'package:page_transition/page_transition.dart';

final String _modulePath = "first-module";

class FirstModule implements Module {
  static final routePaths = _Routes();

  FirstModule(this._user);

  final String _user;

  @override
  String get path => _modulePath;

  @override
  List<ModuleRoute> get routes => [
        ModuleRoute(
          path: routePaths._firstModuleView,
          builder: (_) {
            return FirstModuleView();
          },
        ),
      ];

  @override
  List<Injector> get injections => [
        Injector<FirstmoduleBloc>(inject: (_) {
          return FirstmoduleBloc(_user);
        }),
      ];
}

class _Routes {
  String _firstModuleView = "first-module-view";

  String get firstModuleView => "$_modulePath/$_firstModuleView";
}