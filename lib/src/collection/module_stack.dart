import 'dart:collection';

import '../module.dart';

class StackModule {
  final _modules = _Stack<Module>();

  Module get currentModule => _modules?.top();

  void push(Module module) => _modules.push(module);
}

class _Stack<T> {
  final ListQueue<T> _list = ListQueue();

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  void push(T e) => _list.addLast(e);
  
  T pop() => _list.removeLast();

  T top() => _list.isNotEmpty ? _list.last : null;
}