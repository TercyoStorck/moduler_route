import 'dart:collection';

import '../module.dart';

class StackModule {
  final ListQueue<Module> _modules = ListQueue();

  Module top() => _modules.isNotEmpty ? _modules.last : null;

  void push(Module module) {
    if (_modules.any((item) => item.path == module.path)) {
      _modules.clear();
    }

    _modules.addLast(module);
  }

  Module pop() => _modules.removeLast();

  List<Type> get injectedTypes => _modules
      .map(
        (module) => module.injections
            .map(
              (injection) => injection.type,
            )
            .toList(),
      )
      .toList()
      .reduce(
        (l1, l2) => l1 + l2,
      );
}
