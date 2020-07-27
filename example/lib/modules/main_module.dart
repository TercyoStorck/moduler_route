import 'package:example/bloc/main/app_registration_bloc.dart';
import 'package:example/bloc/main/login_bloc.dart';
import 'package:example/dao/dao.dart';
import 'package:example/views/main/app_registration_view.dart';
import 'package:example/views/main/home_view.dart';
import 'package:example/views/main/login_view.dart';
import 'package:moduler_route/moduler_route.dart';

final String _modulePath = "main";

class MainModule extends Module {
  static final routePaths = _Routes();

  MainModule(this._dao);

  final DAO _dao;

  @override
  String get path => _modulePath;

  @override
  List<ModuleRoute> get routes => [
        ModuleRoute(
          path: routePaths._appRegistration,
          builder: (_) => AppRegistrationView(),
        ),
        ModuleRoute(
          path: routePaths._login,
          builder: (args) => LoginView(args as String),
        ),
        ModuleRoute(
          path: routePaths._home,
          builder: (_) => HomeView(_dao.user),
        ),
      ];

  @override
  List<Injector> get injections => [
        Injector<AppRegistrationBloc>(inject: (_) => AppRegistrationBloc(_dao)),
        Injector<LoginBloc>(inject: (_) => LoginBloc(_dao)),
      ];
}

class _Routes {
  String _appRegistration = "app-registration";
  String _login = "login";
  String _home = "home";

  String get appRegistration => "$_modulePath/$_appRegistration";
  String get login => "$_modulePath/$_login";
  String get home => "$_modulePath/$_home";
}
