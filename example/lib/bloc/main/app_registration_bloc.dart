import 'package:example/dao/dao.dart';

class AppRegistrationBloc {
  
  String registerApp() {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    
    return id;
  }
}