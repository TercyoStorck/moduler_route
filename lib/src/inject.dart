part of 'moduler.dart';

abstract class Inject {
  static Object? _parameter;
  static final List<Injector> _injections = [];
  static final Map<Type, dynamic> _objects = {};
  /// only for unit test purpose
  static final Map<Type, dynamic> _mocks = {};

  /// Return a new instance of an object. If it already instantiated than override for a new one.
  static T? instance<T>() {
    if (_mocks.containsKey(T)) {
      return _mocks.remove(T) as T?;
    }

    final injector = _injections
        .firstWhere(
          (injector) => injector.type == T,
        )
        .inject;

    final instance = injector(_parameter) as T;

    _parameter = null;

    return instance;
  }

  /// Return an instanced object
  static T? get<T>() {
    if (_mocks.containsKey(T)) {
      return _mocks.remove(T) as T?;
    }

    if (!_objects.containsKey(T)) {
      final instance = Inject.instance<T>();

      _objects.putIfAbsent(T, () => instance);

      return instance;
    }

    return _objects[T] as T?;
  }

  static void dispose<T>() => _objects.remove(T);

  static void reset() => _objects.clear();

  /// pass mocked instance to [instance]. And [<T>] the original type
  @visibleForTesting
  static void mock<T>(T instance) {
    _mocks.putIfAbsent(T, () => instance);
  }
}