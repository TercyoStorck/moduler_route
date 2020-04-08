import 'package:flutter/foundation.dart';

class Injector<T> {
  Injector({
    @required this.inject,
  });

  Type get type => T;

  final T Function(Object args) inject;

  @override
  bool operator ==(other) {
    if (identical(this, other)) {
      return true;
    }

    if (runtimeType != other.runtimeType) {
      return false;
    }

    if (other is Injector) {
      return this.type == other.type;
    }

    return false;
  }

  @override
  int get hashCode => super.hashCode;
}
