import 'package:example/repository/repository.dart';
import 'package:moduler_route/moduler_route.dart';

class SecondModuleBloc {
  final _repository = Inject.get<Repository>();
}