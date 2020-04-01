import 'package:example/repository/repository.dart';
import 'package:moduler_route/moduler_route.dart';

class SecondModuleDetailBloc {
  SecondModuleDetailBloc() {
    print(_repository.instanceTime);
  }

  final _repository = Inject.get<Repository>();

  Future<String> repositoryInstanceTime() => Future.value(
        _repository.instanceTime.toString(),
      );
}
