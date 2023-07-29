import 'package:hive_flutter/hive_flutter.dart';
import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/features/home/models/product_model.dart';
import 'package:mytune/general/app_details/app_details.dart';
import 'package:mytune/general/serveices/get_object_id.dart';

abstract class LocalDbServeice<T> {
  Future<List<T>> get();

  Future<void> insert(T model);

  Future<void> onDelete(T model);
}

class LocalDb<T extends ObjectWithId> implements LocalDbServeice<T> {
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
  Future<List<T>> get() async {
    final data = await Hive.openBox<T>(AppDetails.LOCAL_DB_NAME);
    return data.values.toList();
  }

  @override
  Future<void> insert(model) async {
    final data = await Hive.openBox<T>(AppDetails.LOCAL_DB_NAME);

    data.put(model.getId(), model);
  }

  @override
  Future<void> onDelete(model) async {
    final data = await Hive.openBox<T>(AppDetails.LOCAL_DB_NAME);
    data.delete(model.getId());
  }
}

void main(List<String> args) {}
