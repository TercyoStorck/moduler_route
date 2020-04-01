import 'package:example/bloc/second_module/second_module_detail_bloc.dart';
import 'package:example/repository/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moduler_route/moduler_route.dart';

main() {
  RepositoryMock _repository;
  SecondModuleDetailBloc _bloc;

  setUpAll(() {
    _repository = RepositoryMock();
    Inject.mock<Repository>(_repository);

    _bloc = SecondModuleDetailBloc();
  });

  test("testing injections mock", () async {
    final date = await _bloc.repositoryInstanceTime();

    expect(date, "1987-01-01 00:00:00.000");
  });
}

class RepositoryMock implements Repository {
  @override
  DateTime get instanceTime => DateTime(1987);
}
