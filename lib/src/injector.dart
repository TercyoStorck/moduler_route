import 'package:flutter/foundation.dart';

class Injector<T> {
  Injector({
    @required this.inject,
  });

  Type get type => T;

  final T Function(Object args) inject;
}
