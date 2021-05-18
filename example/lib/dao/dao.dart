import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class DAO {
  DAO._(this._box);

  static Future<DAO> instance() async {
    final appDocumentDirectory = await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    final box = await Hive.openBox("MainBox");
    return DAO._(box);
  }

  final Box _box;

  final String _appRegisterKey = "AppRegister";
  final String _userKey = "UserKey";

  bool get isAppRegistered => _box.containsKey(_appRegisterKey);
  bool get isUserLogged => _box.containsKey(_userKey);

  String? get user => _box.get(_userKey);

  void registerApp(String id) => _box.put(_appRegisterKey, id);
  void login(String userName) => _box.put(_userKey, userName);

  void logoff() => _box.delete(_userKey);

  void clearAppState() {
    if (_box.containsKey(_userKey)) {
      _box.delete(_userKey);
    }

    if (_box.containsKey(_appRegisterKey)) {
      _box.delete(_appRegisterKey);
    }
  }

  dispose() {
    _box.close();
    Hive.close();
  }
}
