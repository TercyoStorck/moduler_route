import 'package:example/dao/dao.dart';

class AppRegistrationBloc {
  AppRegistrationBloc(this._dao);

  final DAO _dao;
  
  String registerApp() {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    _dao.registerApp(id);
    return id;
  }
}