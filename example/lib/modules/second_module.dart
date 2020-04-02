import 'package:example/bloc/second_module/second_module_bloc.dart';
import 'package:example/bloc/second_module/second_module_detail_bloc.dart';
import 'package:example/repository/repository.dart';
import 'package:example/views/seconde_module/second_module_view.dart';
import 'package:example/views/seconde_module/second_module_view_detail.dart';
import 'package:moduler_route/moduler_route.dart';

final String _modulePath = "second-module";

class SecondModule extends Module {
  static final routePaths = _Routes();

  SecondModule();

  @override
  String get path => _modulePath;

  @override
  List<ModuleRoute> get routes => [
        ModuleRoute(
          path: routePaths._secondModuleView,
          builder: (_) => SecondmoduleView(),
        ),
        ModuleRoute(
          path: routePaths._secondModuleViewDetail,
          builder: (_) => SecondModuleViewDetail(),
        ),
      ];

  @override
  List<Injector> get injections => [
        Injector<Repository>(inject: (_) => Repository()),
        Injector<SecondModuleBloc>(inject: (_) => SecondModuleBloc()),
        Injector<SecondModuleDetailBloc>(
          inject: (_) => SecondModuleDetailBloc(),
        ),
      ];
}

class _Routes {
  String _secondModuleView = "/";
  String _secondModuleViewDetail = "second-module-view/detail";

  String get secondModuleView => "$_modulePath/";
  String get secondModuleViewDetail => "$_secondModuleViewDetail";
}
