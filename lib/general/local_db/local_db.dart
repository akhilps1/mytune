import 'package:hive_flutter/hive_flutter.dart';

import 'package:mytune/general/serveices/get_object_id.dart';

abstract class LocalDbServeice<T> {
  Future<List<T>> get({required String localDbName});

  Future<void> insert(T model, {required String localDbName});

  Future<void> onDelete(T model, {required String localDbName});
  Future<void> clearAll({required String localDbName});
}

class LocalDb<T> implements LocalDbServeice<T> {
  // Private static instance variable to hold the singleton instance.
  static final Map<Type, dynamic> _instances = {};

  // Private constructor for the singleton class.
  LocalDb._internal();

  // Factory method to return the singleton instance with the correct type.
  factory LocalDb() {
    // Use the type of 'T' as the key to ensure one instance per type.
    final type = T;

    if (!_instances.containsKey(type)) {
      _instances[type] = LocalDb<T>._internal();
    }

    return _instances[type] as LocalDb<T>;
  }

  @override
  Future<List<T>> get({required String localDbName}) async {
    final data = await Hive.openBox<T>(localDbName);
    return data.values.toList();
  }

  @override
  Future<void> insert(model, {required String localDbName}) async {
    final data = await Hive.openBox<T>(localDbName);

    data.put(model, model);
  }

  @override
  Future<void> onDelete(model, {required String localDbName}) async {
    final data = await Hive.openBox<T>(localDbName);
    data.delete(model);
  }

  @override
  Future<void> clearAll({required String localDbName}) async {
    final data = await Hive.openBox<T>(localDbName);
    data.clear();
  }
}
